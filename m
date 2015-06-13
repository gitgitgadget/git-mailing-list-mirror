From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] Makefile / racy-git.txt: clarify USE_NSEC prerequisites
Date: Sat, 13 Jun 2015 22:40:06 +0200
Message-ID: <557C9526.6080000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 22:40:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3sE0-0004Co-5P
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 22:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbbFMUkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 16:40:06 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35755 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbFMUkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 16:40:04 -0400
Received: by wgbhy7 with SMTP id hy7so10450300wgb.2
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 13:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=hbq+zJnF8wP32rlc5bZAckILwc0+mlVV2yMvWom7Jik=;
        b=tRV3iFq05oFjxIuf4mEDFihyvdgwxgnYimam1FcORQM/pyzq4Oa+YUsqvdxbMZTCOQ
         YE3NzYnlMNhkGDL4Mz8s2JDf00VcDwRkrPfJbc4G4mIx0sCxpsCcnywqnqxB/z308vaM
         zQGcErrxIAMBZ17U1wIZVMfxMaGKq+4r2AVpSp7/1eBuVGooDrMwYne9DD5pDcfItZX5
         GvcDKQPGTI6Vi3g3dNwLxo7ODNP2IYp/Yy6uQiCzLq3bKv02pdp96TJdiGQY7CCrRYGM
         /cvcCwHjKVCYiIeQQzU83oHmSx+6Phy8MRGyDGNBut95SPoKPF4yRq0sF0EKLTxGhGhd
         xolA==
X-Received: by 10.194.121.100 with SMTP id lj4mr18720733wjb.104.1434228003171;
        Sat, 13 Jun 2015 13:40:03 -0700 (PDT)
Received: from [10.1.116.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id k2sm8665961wix.4.2015.06.13.13.40.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jun 2015 13:40:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271589>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
Enabling nanosecond file times was recently discussed on the libgit2 project, so
I thought its time to fix the nanosecond issue on Linux. Don't know yet if the
patch will be accepted (and in which kernel version).

Considering that nanosecond file times are still broken for some file systems, it
may be desirable to make this a config option in addition to the compile-time
setting? I.e. only use sub-second file times for up-to-date checks if the config
option is enabled, so that it can be turned off on file systems with flaky
timestamps.

 Documentation/technical/racy-git.txt | 8 ++++++--
 Makefile                             | 9 +++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index 242a044..89ca173 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -42,12 +42,16 @@ compared, but this is not enabled by default because this member
 is not stable on network filesystems.  With `USE_NSEC`
 compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
 members are also compared, but this is not enabled by default
-because in-core timestamps can have finer granularity than
+because on Linux, in-core timestamps can have finer granularity than
 on-disk timestamps, resulting in meaningless changes when an
 inode is evicted from the inode cache.  See commit 8ce13b0
 of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
 ([PATCH] Sync in core time granularity with filesystems,
-2005-01-04).
+2005-01-04). This patch is included in kernel 2.6.11 and newer, but
+only fixes the issue for file systems with exactly 1 ns or 1 s
+resolution. Other file systems are still broken in current Linux
+kernels (e.g. CEPH, CIFS, NTFS, UDF), see
+https://lkml.org/lkml/2015/6/9/714
 
 Racy Git
 --------
diff --git a/Makefile b/Makefile
index 54ec511..46d181a 100644
--- a/Makefile
+++ b/Makefile
@@ -217,10 +217,11 @@ all::
 # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
 #
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
-# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
-# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
-# randomly break unless your underlying filesystem supports those sub-second
-# times (my ext3 doesn't).
+# and ctimes. Note that you need recent glibc (at least 2.2.4) for this. On
+# Linux, kernel 2.6.11 or newer is required for reliable sub-second file times
+# on file systems with exactly 1 ns or 1 s resolution. If you intend to use Git
+# on other file systems (e.g. CEPH, CIFS, NTFS, UDF), don't enable USE_NSEC. See
+# Documentation/technical/racy-git.txt for details.
 #
 # Define USE_ST_TIMESPEC if your "struct stat" uses "st_ctimespec" instead of
 # "st_ctim"
-- 
2.4.3.windows.1.1.g87477f9
