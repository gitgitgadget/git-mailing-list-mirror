From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v5 1/2] xread, xwrite: Limit size of IO, fixing IO of 2GB and more on Mac OS X
Date: Tue, 20 Aug 2013 08:43:54 +0200
Message-ID: <1376981035-23284-2-git-send-email-prohaska@zib.de>
References: <1376926879-30846-1-git-send-email-prohaska@zib.de>
 <1376981035-23284-1-git-send-email-prohaska@zib.de>
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
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 20 08:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBfh9-0003wj-T7
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 08:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387Ab3HTGpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Aug 2013 02:45:33 -0400
Received: from mailer.zib.de ([130.73.108.11]:64071 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab3HTGpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 02:45:30 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id r7K6iNrF002545;
	Tue, 20 Aug 2013 08:44:28 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id r7K6i4jq029237;
	Tue, 20 Aug 2013 08:44:22 +0200 (MEST)
X-Mailer: git-send-email 1.8.4.rc0.11.g35f5eaa
In-Reply-To: <1376981035-23284-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232583>

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
conditions.  For write, the problem has been addressed earlier [6c642a]=
=2E

This commit addresses the problem for read() and write() by limiting
size of IO chunks unconditionally on all platforms in xread() and
xwrite().  Large chunks only cause problems, like triggering the OS
X bug or causing latencies when killing the process.  Reasonably sized
smaller chunks have no negative impact on performance.

The compat wrapper clipped_write() introduced earlier [6c642a] is not
needed anymore.  It will be reverted in a separate commit.  The new tes=
t
catches read and write problems.

Note that 'git add' exits with 0 even if it prints filtering errors to
stderr.  The test, therefore, checks stderr.  'git add' should probably
be changed (sometime in another commit) to exit with nonzero if
filtering fails.  The test could then be changed to use test_must_fail.

Thanks to the following people for suggestions and testing:

    Johannes Sixt <j6t@kdbg.org>
    John Keeping <john@keeping.me.uk>
    Jonathan Nieder <jrnieder@gmail.com>
    Kyle J. McKay <mackyle@gmail.com>
    Linus Torvalds <torvalds@linux-foundation.org>
    Torsten B=C3=B6gershausen <tboegi@web.de>

[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/read.html
[2] http://pubs.opengroup.org/onlinepubs/009695399/functions/write.html

[6c642a] commit 6c642a878688adf46b226903858b53e2d31ac5c3
    compate/clipped-write.c: large write(2) fails on Mac OS X/XNU

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t0021-conversion.sh | 14 ++++++++++++++
 wrapper.c             | 12 ++++++++++++
 2 files changed, 26 insertions(+)

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
diff --git a/wrapper.c b/wrapper.c
index 6a015de..97e3cf7 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -131,6 +131,14 @@ void *xcalloc(size_t nmemb, size_t size)
 }
=20
 /*
+ * Limit size of IO chunks, because huge chunks only cause pain.  OS X=
 64-bit
+ * buggy, returning EINVAL if len >=3D INT_MAX; and even in the absens=
e of bugs,
+ * large chunks can result in bad latencies when you decide to kill th=
e
+ * process.
+ */
+#define MAX_IO_SIZE (8*1024*1024)
+
+/*
  * xread() is the same a read(), but it automatically restarts read()
  * operations with a recoverable error (EAGAIN and EINTR). xread()
  * DOES NOT GUARANTEE that "len" bytes is read even if the data is ava=
ilable.
@@ -138,6 +146,8 @@ void *xcalloc(size_t nmemb, size_t size)
 ssize_t xread(int fd, void *buf, size_t len)
 {
 	ssize_t nr;
+	if (len > MAX_IO_SIZE)
+	    len =3D MAX_IO_SIZE;
 	while (1) {
 		nr =3D read(fd, buf, len);
 		if ((nr < 0) && (errno =3D=3D EAGAIN || errno =3D=3D EINTR))
@@ -154,6 +164,8 @@ ssize_t xread(int fd, void *buf, size_t len)
 ssize_t xwrite(int fd, const void *buf, size_t len)
 {
 	ssize_t nr;
+	if (len > MAX_IO_SIZE)
+	    len =3D MAX_IO_SIZE;
 	while (1) {
 		nr =3D write(fd, buf, len);
 		if ((nr < 0) && (errno =3D=3D EAGAIN || errno =3D=3D EINTR))
--=20
1.8.4.rc3.5.g4f480ff
