From: Timo Sirainen <tss@iki.fi>
Subject: [PATCH 1/3] Added generic string handling code.
Date: Sun, 20 May 2007 05:24:29 +0300
Message-ID: <1179627869.32181.1284.camel@hurina>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LeJ445qUcAqY1Er+ZtpJ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 04:58:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpbcP-0004ge-TN
	for gcvg-git@gmane.org; Sun, 20 May 2007 04:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274AbXETC5r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 22:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758850AbXETC5r
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 22:57:47 -0400
Received: from dovecot.org ([213.157.71.38]:34753 "EHLO dovecot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758274AbXETC5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 22:57:46 -0400
X-Greylist: delayed 1996 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 May 2007 22:57:46 EDT
Received: from [192.168.10.2] (82-203-162-146.dsl.gohome.fi [82.203.162.146])
	by dovecot.org (Postfix) with ESMTP id 4CA71F0AF9
	for <git@vger.kernel.org>; Sun, 20 May 2007 05:24:29 +0300 (EEST)
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47791>


--=-LeJ445qUcAqY1Er+ZtpJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Aren't you already tired of using the crappy string handling functions
that libc provides? I see a lot of really ugly code in git that exists
just because this.

I also see a lot of potential buffer overflows because either no
overflow checking is done, or it's done wrong. Perhaps it doesn't matter
now if you're manually inspecting each patch before feeding to git, but
I fear that in future someone's automated git handler will be
responsible for getting malicious code added into Linux, just because of
a simple buffer overflow that could have been easily avoided.

So here's my try on starting with something simple. Unlike almost all
other string handling libraries, it doesn't allocate the memory
dynamically. This makes it really easy to convert existing code to use
it. I'm including some example changes in the other patches. Besides
making the code safer, it can also make it faster, especially those
strcat() replacements.

I'm aware of strbuf.[ch], but I wasn't sure if I should have merged this
code with it or what. It had this "eof" field which I think makes it
more like a "file reader string" and not a "string buffer". So I just
added new str.[ch] files.

---
 Makefile |    4 ++--
 str.c    |   40 ++++++++++++++++++++++++++++++++++++++++
 str.h    |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 str.c
 create mode 100644 str.h

diff --git a/Makefile b/Makefile
index 29243c6..f61ad50 100644
--- a/Makefile
+++ b/Makefile
@@ -294,7 +294,7 @@ XDIFF_LIB=3Dxdiff/lib.a
 LIB_H =3D \
 	archive.h blob.h cache.h commit.h csum-file.h delta.h grep.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.=
h \
-	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
+	run-command.h strbuf.h str.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h mailmap.h
=20
@@ -312,7 +312,7 @@ LIB_OBJS =3D \
 	object.o pack-check.o pack-write.o patch-delta.o path.o pkt-line.o \
 	sideband.o reachable.o reflog-walk.o \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
-	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
+	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o str.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
diff --git a/str.c b/str.c
new file mode 100644
index 0000000..d46e7f4
--- /dev/null
+++ b/str.c
@@ -0,0 +1,40 @@
+#include "str.h"
+
+void _str_append(struct string *str, const char *cstr)
+{
+	unsigned int avail =3D str->size - str->len;
+	unsigned int len =3D strlen(cstr);
+
+	if (len >=3D avail) {
+		len =3D avail - 1;
+		str->overflowed =3D 1;
+	}
+	memcpy(str->buf + str->len, cstr, len);
+	str->len +=3D len;
+	str->buf[str->len] =3D '\0';
+}
+
+void _str_printfa(struct string *str, const char *fmt, ...)
+{
+	unsigned int avail =3D str->size - str->len;
+	va_list va;
+	int ret;
+
+	va_start(va, fmt);
+	ret =3D vsnprintf(str->buf + str->len, avail, fmt, va);
+	if (ret < avail)
+		str->len +=3D ret;
+	else {
+		str->len +=3D avail - 1;
+		str->overflowed =3D 1;
+	}
+	va_end(va);
+}
+
+void _str_truncate(struct string *str, unsigned int len)
+{
+	if (len >=3D str->size)
+		len =3D str->size - 1;
+	str->len =3D len;
+	str->buf[len] =3D '\0';
+}
diff --git a/str.h b/str.h
new file mode 100644
index 0000000..99d3215
--- /dev/null
+++ b/str.h
@@ -0,0 +1,32 @@
+#ifndef STR_H
+#define STR_H
+
+#include "git-compat-util.h"
+
+struct string {
+	unsigned int size;
+	unsigned int len:31;
+	unsigned int overflowed:1;
+	char buf[];
+};
+
+#define stringbuf(name, size) \
+	union { \
+	  struct string string; \
+	  char string_buf[sizeof(struct string) + (size) + 1]; \
+	} name =3D { { (size)+1, 0, 0 } }
+
+extern void _str_append(struct string *str, const char *cstr);
+extern void _str_printfa(struct string *str, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+extern void _str_truncate(struct string *str, unsigned int len);
+
+#define str_append(str, cstr) _str_append(&(str).string, cstr)
+#define str_printfa(str, fmt, ...) _str_printfa(&(str).string, fmt, __VA_A=
RGS__)
+#define str_truncate(str, len) _str_truncate(&(str).string, len)
+
+#define str_c(str) ((str).string.buf)
+#define str_len(str) ((str).string.len)
+#define str_overflowed(str) ((str).string.overflowed)
+
+#endif
--=20
1.5.1.4



--=-LeJ445qUcAqY1Er+ZtpJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGT7FdyUhSUUBViskRAhv0AKCbU4H4hplAhP2SO8chUr/tXyUloQCdExa8
kDTNTckYBUr4ozsjJY90ajo=
=Ht3K
-----END PGP SIGNATURE-----

--=-LeJ445qUcAqY1Er+ZtpJ--
