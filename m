From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 097/104] Fix checkout of large files to network shares on Windows XP
Date: Wed, 26 May 2010 18:01:07 +1200
Message-ID: <1274853674-18521-97-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9lj-0004ff-Bt
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934066Ab0EZGGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 02:06:48 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49309 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933952Ab0EZGG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 430EC338D7;
	Wed, 26 May 2010 18:02:09 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ua7ozjFOCWei; Wed, 26 May 2010 18:02:04 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 3D764338E2;
	Wed, 26 May 2010 18:01:39 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147763>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
index 7c2ab64..0e3e743 100644
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
1.7.1.rc2.333.gb2668
