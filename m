From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2] Makefile / racy-git.txt: clarify USE_NSEC prerequisites
Date: Wed, 01 Jul 2015 21:10:52 +0200
Message-ID: <55943B3C.9050200@gmail.com>
References: <557C9526.6080000@gmail.com> <xmqqr3pdltqu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:11:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZANPT-00007x-9H
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 21:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbbGATK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 15:10:58 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34876 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbbGATKz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 15:10:55 -0400
Received: by wiga1 with SMTP id a1so133962210wig.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wqaSPFdcsFUybY7y1PgsIOm+2RrbLgLOvPurMiPVG3s=;
        b=r3kXlDDr/fFZHRLSmqPtU3kAs2hk3SCI3/ntCyRviHMZNmq2chZS11GZGiLqFcSBgU
         xJ7q8+73vpe3iVH7NKJcUGywqOZv2vLO4zr/Em1TkMV/EJixa1iFEm7cM8CJRCsYQMKE
         U7Vv+16/78SOigS0b4b7IzqRF5xLb9LWFiS5ber8bzq19NAlvkaIux2yLdwejO29DpBE
         LDMH2hciyXYjzyOFBKQDKxNKW+zz/ITOyTei+Kb28bjzj/eiRyo4H+ZKZYcCD5ql1+sR
         w/MM8xzZoRsrfP7MKoIYQVAVM9jl1v0FXEKtGzIYN+x0gp/egW6UET2DG39B/BkxElcX
         newA==
X-Received: by 10.194.82.167 with SMTP id j7mr51972287wjy.123.1435777854408;
        Wed, 01 Jul 2015 12:10:54 -0700 (PDT)
Received: from [10.1.116.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id b5sm4763791wic.3.2015.07.01.12.10.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2015 12:10:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqr3pdltqu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273189>

Signed-off-by: Karsten Blees <blees@dcon.de>
---

...just changed wording as you suggested.

 Documentation/technical/racy-git.txt | 8 ++++++--
 Makefile                             | 9 +++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index 242a044..4a8be4d 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -41,13 +41,17 @@ With a `USE_STDEV` compile-time option, `st_dev` is also
 compared, but this is not enabled by default because this member
 is not stable on network filesystems.  With `USE_NSEC`
 compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
-members are also compared, but this is not enabled by default
+members are also compared. On Linux, this is not enabled by default
 because in-core timestamps can have finer granularity than
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
