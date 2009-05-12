From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [RFC 1/8] UTF helpers
Date: Wed, 13 May 2009 00:50:24 +0200
Message-ID: <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 00:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M40oH-0000Sx-ED
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 00:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbZELWuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 18:50:39 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbZELWui
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 18:50:38 -0400
Received: from mail.dewire.com ([83.140.172.130]:19380 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbZELWuh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 18:50:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7E9BE145A592;
	Wed, 13 May 2009 00:50:35 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y+mHb3A9Jkmv; Wed, 13 May 2009 00:50:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 89994145A58A;
	Wed, 13 May 2009 00:50:32 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118961>

---
 Makefile          |    8 ++-
 git-compat-util.h |    1 +
 git.c             |    9 +++
 t/test-lib.sh     |    4 +-
 test-utf.c        |   61 ++++++++++++++++
 utf.c             |  207 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 utf.h             |   27 +++++++
 7 files changed, 313 insertions(+), 4 deletions(-)
 create mode 100644 test-utf.c
 create mode 100644 utf.c
 create mode 100644 utf.h

diff --git a/Makefile b/Makefile
index 2d62efb..2d71f01 100644
--- a/Makefile
+++ b/Makefile
@@ -259,7 +259,7 @@ LIB_OBJS =3D \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o sideband.o \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
-	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
+	tag.o tree.o utf.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o grep.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
@@ -564,6 +564,9 @@ ifdef NO_ACCURATE_DIFF
 endif
=20
 # Shell quote (do not use $(call) to accommodate ancient setups);
+ALL_CFLAGS +=3D -DUTF8INTERNAL=3D1
+ALL_CFLAGS +=3D -DDEBUG=3D1
+#ALL_CFLAGS +=3D -DTEST=3D1
=20
 SHA1_HEADER_SQ =3D $(subst ','\'',$(SHA1_HEADER))
=20
@@ -811,6 +814,9 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
=20
+test-utf$X: test-utf.c ctype.o utf.o usage.o
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) test-utf.c utf.c ctype.o usa=
ge.o
+
 test-date$X: test-date.c date.o ctype.o
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) test-date.c date.o ctype.o
=20
diff --git a/git-compat-util.h b/git-compat-util.h
index 0272d04..f83352b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -25,6 +25,7 @@
 #include <netinet/in.h>
 #include <sys/types.h>
 #include <dirent.h>
+#include "utf.h"
=20
 /* On most systems <limits.h> would have given us this, but
  * not on some systems (e.g. GNU/Hurd).
diff --git a/git.c b/git.c
index 6475847..bd4e726 100644
--- a/git.c
+++ b/git.c
@@ -272,6 +272,15 @@ static void handle_internal_command(int argc, cons=
t char **argv, char **envp)
 	};
 	int i;
=20
+#ifdef DEBUG
+	if (debug()) {
+		fprintf(stderr,"GIT-");
+		for (i =3D 1; i<argc; ++i)
+			fprintf(stderr,"%s",argv[i]);
+		fprintf(stderr,"\n");
+	}
+#endif
+
 	/* Turn "git cmd --help" into "git help cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
 		argv[1] =3D argv[0];
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 07cb706..e8aefd8 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -4,11 +4,9 @@
 #
=20
 # For repeatability, reset the environment to known value.
-LANG=3DC
-LC_ALL=3DC
 PAGER=3Dcat
 TZ=3DUTC
-export LANG LC_ALL PAGER TZ
+export PAGER TZ
 EDITOR=3D:
 VISUAL=3D:
 unset AUTHOR_DATE
diff --git a/test-utf.c b/test-utf.c
new file mode 100644
index 0000000..133eea0
--- /dev/null
+++ b/test-utf.c
@@ -0,0 +1,61 @@
+#include <stdio.h>
+#include <time.h>
+#include <assert.h>
+
+#include "cache.h"
+#include "utf.h"
+
+int main(int argc, char **argv)
+{
+	int i;
+
+#if 0
+	for (i =3D 1; i < argc; i++) {
+		char result1[100];
+		char result2[100];
+
+		utfcpy(result1, argv[i], strlen(argv[i])+1);
+		localcpy(result2, result1, strlen(result1)+1);
+
+		printf("%s -> %s -> %s\n", argv[i], result1, result2);
+	}
+	return 0;
+#endif
+
+#define test(name) case __LINE__: current_name=3Dname; n++; printf("Te=
sting case #%d: %s\n", n, current_name);
+#define end_test break;
+#define begin_suite() char *current_name=3D0; int n=3D1; for (i=3D0; i=
<1000; ++i) { switch(i) {=20
+#define concats(a,b) #a #b
+
+#undef strcmp
+#define assertStringEquals(a,b) assert(#a #b && strcmp(a,b)=3D=3D0)
+#define assertIntEquals(a,b) assert(#a #b && (a)=3D=3D(b))
+
+#define end_suite() }}
+
+	begin_suite();
+
+	test("utfcpy") {
+	  char result[100];
+	  utfcpy(result,"=C4ndrad",7);
+	  assertStringEquals(result,"\303\204ndrad");
+	} end_test;
+
+	test("utflen") {
+	  int result=3Dutflen("=C4ndrad",7);
+	  assertIntEquals(result,8);
+	} end_test;
+
+	test("localcpy") {
+	  char result[100];
+	  localcpy(result,"\303\204ndrad",8);
+	  assertStringEquals(result,"=C4ndrad");
+	} end_test;
+
+	test("locallen") {
+	  int result=3Dlocallen("\303\204ndrad",8);
+	  assertIntEquals(result,7);
+	} end_test;
+
+	end_suite();
+}
diff --git a/utf.c b/utf.c
new file mode 100644
index 0000000..eb430b2
--- /dev/null
+++ b/utf.c
@@ -0,0 +1,207 @@
+#undef UTF8INTERNAL
+
+#include <langinfo.h>
+#include <iconv.h>
+#include "cache.h"
+#include <locale.h>
+#include <stdarg.h>
+
+static iconv_t local_to_utf8 =3D (iconv_t)-1;
+static iconv_t utf8_to_local =3D (iconv_t)-1;
+static iconv_t utf8_to_utf8 =3D (iconv_t)-1;
+static int same =3D 0;
+
+#if TEST
+#define die printf
+#endif
+
+static void	initlocale()
+{
+#ifndef NO_ICONV
+	if (!same && local_to_utf8 =3D=3D (iconv_t)-1) {
+		setlocale(LC_CTYPE, "");
+		char *local_encoding =3D nl_langinfo(CODESET);
+#ifdef DEBUG
+		if (debug()) fprintf(stderr,"encoding=3D%s\n", local_encoding);
+#endif
+		if (strcmp(local_encoding,"UTF-8") =3D=3D 0) {
+			same =3D 1;
+			return;
+		}
+		local_to_utf8 =3D iconv_open("UTF-8",  local_encoding);
+		if (local_to_utf8 =3D=3D (iconv_t)-1) {
+			die("cannot setup locale conversion from %s: %s", local_encoding, s=
trerror(errno));
+		}
+#ifdef DEBUG
+		if (debug()) fprintf(stderr,"utf8_to_local =3D iconv_open(%s,UTF-8)\=
n",local_encoding);
+#endif
+		utf8_to_local =3D iconv_open(local_encoding,  "UTF-8");
+		if (utf8_to_local =3D=3D (iconv_t)-1) {
+			die("cannot setup locale conversion from %s: %s", local_encoding, s=
trerror(errno));
+		}
+
+		utf8_to_utf8 =3D iconv_open("UTF-8","UTF-8");
+		if (utf8_to_utf8 =3D=3D (iconv_t)-1) {
+			die("cannot setup locale conversion from UTF-8 to UTF-8: %s",strerr=
or(errno));
+		}
+	}
+#endif
+}
+
+int maybe_utf8(const char *local, size_t len)
+{
+  char *self =3D xcalloc(1,len+1);
+  char *selfp =3D self;
+  size_t outlen =3D len+1;
+  int ret =3D iconv(utf8_to_utf8, (char**)&local, &len, &selfp, &outle=
n);
+  free(self);
+  P(("maybelocal: %0.*s %s\n", len, local, ret!=3D-1 ? "yes" : "no"));
+  return ret !=3D -1;
+}
+
+size_t utflen(const char *local, size_t locallen)
+{
+#ifndef NO_ICONV
+	initlocale();
+	if (same) {
+		return locallen;
+	}
+	if (maybe_utf8(local, locallen))
+		return locallen;
+
+	size_t outlen=3Dlocallen*6;
+	char *outbuf=3Dxcalloc(outlen,1);
+	char *out=3Doutbuf;
+	iconv(local_to_utf8, NULL, NULL, NULL, NULL);
+	const char *vlocal =3D local;
+	size_t vlocallen =3D locallen;
+	if (iconv(local_to_utf8,  (char**)&vlocal,  &vlocallen,  &out,  &outl=
en) =3D=3D -1) {
+#if TEST
+		perror("failed");
+#endif
+		free(outbuf);
+		return locallen;
+	}
+	*out =3D 0;
+	free(outbuf);
+	return locallen*6 - outlen;
+#else
+	return locallen;
+#endif
+}
+
+/* Copy and transform */
+void utfcpy(char *to_utf, char *from_local, size_t localsize)
+{
+#ifdef DEBUG
+	char *a=3Dto_utf,*b=3Dfrom_local;
+#endif
+#ifndef NO_ICONV
+	initlocale();
+	if (same) {
+		memcpy(to_utf, from_local, localsize);
+		return;
+	}
+	if (maybe_utf8(from_local, localsize)) {
+		memcpy(to_utf, from_local, localsize);
+		return;
+	}
+
+	size_t outlen=3Dlocalsize*6;
+	iconv(local_to_utf8, NULL, NULL, NULL, NULL);
+	char *vfrom_local =3D from_local;
+	char *vto_utf =3D to_utf;
+	size_t vlocalsize =3D localsize;
+	if (iconv(local_to_utf8,  &vfrom_local,  &vlocalsize,  &vto_utf,  &ou=
tlen) =3D=3D -1) {
+		fprintf(stderr,"Failed to convert %0.*s to UTF\n", localsize, from_l=
ocal);
+		memcpy(to_utf,  from_local,  localsize);
+	}
+#else
+	memcpy(to_utf, from_local, localsize);
+#endif
+#ifdef DEBUG
+	if (debug()) fprintf(stderr,"%0.*s ->UTF %0.*s\n", localsize, b, loca=
lsize*6 - outlen, a);
+#endif
+}
+
+size_t locallen(const char *utf, size_t utflen)
+{
+#ifndef NO_ICONV
+	initlocale();
+	if (same) {
+		return utflen;
+	}
+	char *outbuf=3Dxcalloc(utflen*4,1); /* ??, can we be more specific? *=
/
+	char *out=3Doutbuf;
+	size_t outlen=3Dutflen*4;
+	iconv(utf8_to_local, NULL, NULL, NULL, NULL);
+	char *vutf =3D utf;
+	size_t vutflen =3D utflen;
+	if (iconv(utf8_to_local,  (char**)&vutf,  &vutflen,  &out,  &outlen) =
=3D=3D -1) {
+#ifdef DEBUG
+		perror("failed");
+#endif
+		free(outbuf);
+		return utflen;
+	}
+	*out =3D 0;
+	free(outbuf);
+	return utflen*4 - outlen; =09
+#else
+	return utflen;
+#endif
+}
+
+void localcpy(char *tolocal, char *fromutf, size_t utflen)
+{
+#ifdef DEBUG
+	char *a=3Dtolocal,*b=3Dfromutf;
+#endif
+	initlocale();
+	if (same) {
+		memcpy(tolocal, fromutf, utflen);
+		return;
+	}
+#ifndef NO_ICONV
+	iconv(utf8_to_local,  NULL,  NULL,  NULL,  NULL);
+	size_t outlen=3Dutflen*4;
+	char *vfromutf =3D fromutf;
+	char *vtolocal =3D tolocal;
+	size_t vutflen =3D utflen;
+	if (iconv(utf8_to_local,  &vfromutf,  &vutflen,  &vtolocal,  &outlen)=
 =3D=3D -1) {
+		fprintf(stderr,"Failed to convert %0.*s to LOCAL\n", utflen, fromutf=
);
+		memcpy(tolocal, fromutf, utflen);
+	}
+#else
+	memcpy(tolocale, fromutf, utflen);
+#endif=09
+#ifdef DEBUG
+	if (debug()) fprintf(stderr,"%0.*s ->LOCAL %0.*s\n", utflen, b, utfle=
n*4-outlen, a);
+#endif
+}
+
+int PP(const char *fmt,...)
+{
+  va_list va;
+  va_start(va,fmt);
+  int ret=3Dvfprintf(stderr,fmt,va);
+  va_end(va);
+  return ret;
+}
+
+int debugf=3D-1;
+
+int debug()
+{
+	if (debugf =3D=3D -1) {
+		char *f =3D getenv("DEBUG");
+		if (!f) {
+			debugf =3D 0;
+		} else if (f[0] !=3D 0) {
+			debugf =3D 1;
+		} else
+			debugf =3D 0;
+	}
+	return debugf =3D=3D 1;
+}
+
diff --git a/utf.h b/utf.h
new file mode 100644
index 0000000..c6c6224
--- /dev/null
+++ b/utf.h
@@ -0,0 +1,27 @@
+#ifndef UTF_H
+#define UTF_H 1
+
+/** The number of octets 'local' would occupy encoded as utf8.
+ *  The input format is assumed to be local
+ */
+extern size_t utflen(const char *local,size_t locallen);
+extern size_t locallen(const char *utf,size_t utflen);
+
+/* Copy and transform */
+extern void utfcpy(char *toutf,char *fromlocal,size_t localen);
+
+/* Copy and transform */
+extern void localcpy(char *tolocal,char *fromutf,size_t utflen);
+
+#ifdef DEBUG
+#define D(x) do { if (debug()) fprintf(stderr,"%s:%d:%s\n",__FILE__,__=
LINE__,x); } while(0)
+#define P(x) do { if (debug()) { fprintf(stderr,"%s:%d:",__FILE__,__LI=
NE__); PP x; } } while(0)
+int PP(const char *fmt,...);
+int debug();
+
+#else
+#define D(x)
+#define P(x)
+#endif
+
+#endif
--=20
1.6.3.dirty
