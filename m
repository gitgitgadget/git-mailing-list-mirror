From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v4] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 17:41:19 +0200
Message-ID: <1376926879-30846-1-git-send-email-prohaska@zib.de>
References: <1376900499-662-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 17:44:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBRcv-00033I-Sl
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 17:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830Ab3HSPoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Aug 2013 11:44:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:52742 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775Ab3HSPoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 11:44:12 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id r7JFffPs017200;
	Mon, 19 Aug 2013 17:41:46 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id r7JFfdli011753;
	Mon, 19 Aug 2013 17:41:40 +0200 (MEST)
X-Mailer: git-send-email 1.8.4.rc0.11.g35f5eaa
In-Reply-To: <1376900499-662-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232547>

Previously, filtering 2GB or more through an external filter (see test)
failed on Mac OS X 10.8.4 (12E55) for a 64-bit executable with:

    error: read from external filter cat failed
    error: cannot feed the input to external filter cat
    error: cat died of signal 13
    error: external filter cat failed 141
    error: external filter cat failed

The reason was that read() immediately returns with EINVAL if nbyte >=3D
2GB.  According to POSIX [1], if the value of nbyte passed to read() is
greater than SSIZE_MAX, the result is implementation-defined.  The writ=
e
function has the same restriction [2].  Since OS X still supports
running 32-bit executables, the 32-bit limit (SSIZE_MAX =3D INT_MAX
=3D 2GB - 1) seems to be also imposed on 64-bit executables under certa=
in
conditions.  For write, the problem has been addressed in a earlier
commit [6c642a].

The problem for read() is addressed in a similar way by introducing
a wrapper function in compat that always reads less than 2GB.  It is
very likely that the read() and write() wrappers are always used
together.  To avoid introducing another option, NEEDS_CLIPPED_WRITE is
changed to NEEDS_CLIPPED_IO and used to activate both wrappers.

To avoid expanding the read compat macro in constructs like
'vtbl->read(...)', 'read' is renamed to 'readfn' in two cases.  The
solution seems more robust than using '#undef read'.

Note that 'git add' exits with 0 even if it prints filtering errors to
stderr.  The test, therefore, checks stderr.  'git add' should probably
be changed (sometime in another commit) to exit with nonzero if
filtering fails.  The test could then be changed to use test_must_fail.

Thanks to the following people for their suggestions:

    Johannes Sixt <j6t@kdbg.org>
    John Keeping <john@keeping.me.uk>
    Jonathan Nieder <jrnieder@gmail.com>
    Kyle J. McKay <mackyle@gmail.com>
    Torsten B=C3=B6gershausen <tboegi@web.de>
    Eric Sunshine <sunshine@sunshineco.com>

[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/read.html
[2] http://pubs.opengroup.org/onlinepubs/009695399/functions/write.html

[6c642a] 6c642a878688adf46b226903858b53e2d31ac5c3
    compate/clipped-write.c: large write(2) fails on Mac OS X/XNU

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile                                 | 10 +++++-----
 builtin/var.c                            | 10 +++++-----
 compat/{clipped-write.c =3D> clipped-io.c} | 11 ++++++++++-
 config.mak.uname                         |  2 +-
 git-compat-util.h                        |  5 ++++-
 streaming.c                              |  4 ++--
 t/t0021-conversion.sh                    | 14 ++++++++++++++
 7 files changed, 41 insertions(+), 15 deletions(-)
 rename compat/{clipped-write.c =3D> clipped-io.c} (53%)

diff --git a/Makefile b/Makefile
index 3588ca1..f54134d 100644
--- a/Makefile
+++ b/Makefile
@@ -69,8 +69,8 @@ all::
 # Define NO_MSGFMT_EXTENDED_OPTIONS if your implementation of msgfmt
 # doesn't support GNU extensions like --check and --statistics
 #
-# Define NEEDS_CLIPPED_WRITE if your write(2) cannot write more than
-# INT_MAX bytes at once (e.g. MacOS X).
+# Define NEEDS_CLIPPED_IO if your read(2) and/or write(2) cannot handl=
e more
+# than INT_MAX bytes at once (e.g. Mac OS X).
 #
 # Define HAVE_PATHS_H if you have paths.h and want to use the default =
PATH
 # it specifies.
@@ -1493,9 +1493,9 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
 	MSGFMT +=3D --check --statistics
 endif
=20
-ifdef NEEDS_CLIPPED_WRITE
-	BASIC_CFLAGS +=3D -DNEEDS_CLIPPED_WRITE
-	COMPAT_OBJS +=3D compat/clipped-write.o
+ifdef NEEDS_CLIPPED_IO
+	BASIC_CFLAGS +=3D -DNEEDS_CLIPPED_IO
+	COMPAT_OBJS +=3D compat/clipped-io.o
 endif
=20
 ifneq (,$(XDL_FAST_HASH))
diff --git a/builtin/var.c b/builtin/var.c
index aedbb53..06f8459 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -28,7 +28,7 @@ static const char *pager(int flag)
=20
 struct git_var {
 	const char *name;
-	const char *(*read)(int);
+	const char *(*readfn)(int);
 };
 static struct git_var git_vars[] =3D {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
@@ -43,8 +43,8 @@ static void list_vars(void)
 	struct git_var *ptr;
 	const char *val;
=20
-	for (ptr =3D git_vars; ptr->read; ptr++)
-		if ((val =3D ptr->read(0)))
+	for (ptr =3D git_vars; ptr->readfn; ptr++)
+		if ((val =3D ptr->readfn(0)))
 			printf("%s=3D%s\n", ptr->name, val);
 }
=20
@@ -53,9 +53,9 @@ static const char *read_var(const char *var)
 	struct git_var *ptr;
 	const char *val;
 	val =3D NULL;
-	for (ptr =3D git_vars; ptr->read; ptr++) {
+	for (ptr =3D git_vars; ptr->readfn; ptr++) {
 		if (strcmp(var, ptr->name) =3D=3D 0) {
-			val =3D ptr->read(IDENT_STRICT);
+			val =3D ptr->readfn(IDENT_STRICT);
 			break;
 		}
 	}
diff --git a/compat/clipped-write.c b/compat/clipped-io.c
similarity index 53%
rename from compat/clipped-write.c
rename to compat/clipped-io.c
index b8f98ff..ec3232a 100644
--- a/compat/clipped-write.c
+++ b/compat/clipped-io.c
@@ -1,10 +1,19 @@
 #include "../git-compat-util.h"
+#undef read
 #undef write
=20
 /*
- * Version of write that will write at most INT_MAX bytes.
+ * Versions of read() and write() that limit nbyte to INT_MAX.
  * Workaround a xnu bug on Mac OS X
  */
+
+ssize_t clipped_read(int fd, void *buf, size_t nbyte)
+{
+	if (nbyte > INT_MAX)
+		nbyte =3D INT_MAX;
+	return read(fd, buf, nbyte);
+}
+
 ssize_t clipped_write(int fildes, const void *buf, size_t nbyte)
 {
 	if (nbyte > INT_MAX)
diff --git a/config.mak.uname b/config.mak.uname
index b27f51d..fb39726 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -95,7 +95,7 @@ ifeq ($(uname_S),Darwin)
 	NO_MEMMEM =3D YesPlease
 	USE_ST_TIMESPEC =3D YesPlease
 	HAVE_DEV_TTY =3D YesPlease
-	NEEDS_CLIPPED_WRITE =3D YesPlease
+	NEEDS_CLIPPED_IO =3D YesPlease
 	COMPAT_OBJS +=3D compat/precompose_utf8.o
 	BASIC_CFLAGS +=3D -DPRECOMPOSE_UNICODE
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 115cb1d..4a875cb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -185,7 +185,10 @@ typedef unsigned long uintptr_t;
 #define probe_utf8_pathname_composition(a,b)
 #endif
=20
-#ifdef NEEDS_CLIPPED_WRITE
+#ifdef NEEDS_CLIPPED_IO
+ssize_t clipped_read(int fd, void *buf, size_t nbyte);
+#define read(x,y,z) clipped_read((x),(y),(z))
+
 ssize_t clipped_write(int fildes, const void *buf, size_t nbyte);
 #define write(x,y,z) clipped_write((x),(y),(z))
 #endif
diff --git a/streaming.c b/streaming.c
index debe904..2ac3047 100644
--- a/streaming.c
+++ b/streaming.c
@@ -20,7 +20,7 @@ typedef ssize_t (*read_istream_fn)(struct git_istream=
 *, char *, size_t);
=20
 struct stream_vtbl {
 	close_istream_fn close;
-	read_istream_fn read;
+	read_istream_fn readfn;
 };
=20
 #define open_method_decl(name) \
@@ -101,7 +101,7 @@ int close_istream(struct git_istream *st)
=20
 ssize_t read_istream(struct git_istream *st, void *buf, size_t sz)
 {
-	return st->vtbl->read(st, buf, sz);
+	return st->vtbl->readfn(st, buf, sz);
 }
=20
 static enum input_source istream_source(const unsigned char *sha1,
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index e50f0f7..b92e6cb 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -190,4 +190,18 @@ test_expect_success 'required filter clean failure=
' '
 	test_must_fail git add test.fc
 '
=20
+test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
+
+test_expect_success EXPENSIVE 'filter large file' '
+	git config filter.largefile.smudge cat &&
+	git config filter.largefile.clean cat &&
+	for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
+	echo "2GB filter=3Dlargefile" >.gitattributes &&
+	git add 2GB 2>err &&
+	! test -s err &&
+	rm -f 2GB &&
+	git checkout -- 2GB 2>err &&
+	! test -s err
+'
+
 test_done
--=20
1.8.4.rc3.5.g4f480ff
