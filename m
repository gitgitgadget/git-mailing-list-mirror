From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 3/5 maint] Fix checkout of large files to network shares on Windows XP
Date: Thu, 20 May 2010 20:57:53 +0200
Message-ID: <7b0bf230bfc68ff9590e78f42bb52f27b81ab6f5.1274380838.git.j6t@kdbg.org>
References: <cover.1274380838.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 20 21:01:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFAze-0008SX-5G
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 21:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab0ETTBF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 15:01:05 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:15356 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751895Ab0ETTBD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 15:01:03 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 066FC1001F;
	Thu, 20 May 2010 21:01:00 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E78B019F5F0;
	Thu, 20 May 2010 20:58:17 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.64.ga1799.dirty
In-Reply-To: <cover.1274380838.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147409>

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

Bigger writes to network drives on Windows XP fail.  Cap them at 31MB t=
o
allow them to succeed.  Callers need to be prepared for write() calls
that do less work than requested anyway.

On local drives, write() calls are translated to WriteFile() calls with
a cap of 64KB on Windows XP and 256KB on Vista.  Thus a cap of 31MB won=
't
affect the number of WriteFile() calls which do the actual work.  There=
's
still room for some other version of Windows to use a chunk size of 1MB
without increasing the number of system calls.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Again, I've used this patch in production with smaller repositories,
 and it worked flawlessly.

 compat/mingw.c       |   17 +++++++++++++++++
 compat/mingw.h       |    3 +++
 t/t5705-clone-2gb.sh |   12 +++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index f90a114..9a8e336 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -140,6 +140,23 @@ int mingw_open (const char *filename, int oflags, =
=2E..)
 	return fd;
 }
=20
+#undef write
+ssize_t mingw_write(int fd, const void *buf, size_t count)
+{
+	/*
+	 * While write() calls to a file on a local disk are translated
+	 * into WriteFile() calls with a maximum size of 64KB on Windows
+	 * XP and 256KB on Vista, no such cap is placed on writes to
+	 * files over the network on Windows XP.  Unfortunately, there
+	 * seems to be a limit of 32MB-28KB on X64 and 64MB-32KB on x86;
+	 * bigger writes fail on Windows XP.
+	 * So we cap to a nice 31MB here to avoid write failures over
+	 * the net without changing the number of WriteFile() calls in
+	 * the local case.
+	 */
+	return write(fd, buf, min(count, 31 * 1024 * 1024));
+}
+
 #undef fopen
 FILE *mingw_fopen (const char *filename, const char *otype)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index a6b8778..f465566 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -170,6 +170,9 @@ int link(const char *oldpath, const char *newpath);
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
=20
+ssize_t mingw_write(int fd, const void *buf, size_t count);
+#define write mingw_write
+
 FILE *mingw_fopen (const char *filename, const char *otype);
 #define fopen mingw_fopen
=20
diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
index adfaae8..8afbdd4 100755
--- a/t/t5705-clone-2gb.sh
+++ b/t/t5705-clone-2gb.sh
@@ -12,7 +12,7 @@ test_expect_success 'setup' '
=20
 	git config pack.compression 0 &&
 	git config pack.depth 0 &&
-	blobsize=3D$((20*1024*1024)) &&
+	blobsize=3D$((100*1024*1024)) &&
 	blobcount=3D$((2*1024*1024*1024/$blobsize+1)) &&
 	i=3D1 &&
 	(while test $i -le $blobcount
@@ -36,9 +36,15 @@ test_expect_success 'setup' '
=20
 '
=20
-test_expect_success 'clone' '
+test_expect_success 'clone - bare' '
=20
-	git clone --bare --no-hardlinks . clone
+	git clone --bare --no-hardlinks . clone-bare
+
+'
+
+test_expect_success 'clone - with worktree, file:// protocol' '
+
+	git clone file://. clone-wt
=20
 '
=20
--=20
1.7.1.64.ga1799.dirty
