From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v2] diff-no-index: exit(1) if 'diff --quiet <repo file> <external file>' finds changes
Date: Fri, 15 Jun 2012 16:06:47 -0400
Message-ID: <1339790807-28346-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Fri Jun 15 22:07:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfcne-0005ag-CW
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 22:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab2FOUHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 16:07:10 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56216 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab2FOUHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 16:07:08 -0400
Received: by gglu4 with SMTP id u4so2679971ggl.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7vTwtiYaf1282sHt0OczuupSBhpbIXhY5IzkQAvMqKs=;
        b=jqbi61y9eB70HKIbUrUGA5GyaTvVIWdpgVvmWmPQpmQFUkJnf2WCY8EKNyQbEL8rf+
         j/UuPbj4rghSNatMBU2m9CLzk+Qna/MdJM072rFoZsKGa+DDzGcX8arVR56AbMQE6G/H
         WwtiUH/QXW38b1RoEKdkPlCBT7Jk7fxIDTLop1buAgTDuz7aoV+L2EdZMS757fr+reRA
         ORpyaPfM1NfMheM/TAcs4FDCpTq3mVWII5Kwyt991rHwDL3wFQyj8owCMbNev7FxAIle
         T39XFsUVSOlVj6AX4HZ8ruUuCOwBYUyE6yvkp71fp/w7tL3/bqxKXDhu+cX8EWglZMnK
         4THw==
Received: by 10.50.170.69 with SMTP id ak5mr3203111igc.47.1339790827849;
        Fri, 15 Jun 2012 13:07:07 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id gs4sm3424286igc.1.2012.06.15.13.07.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 13:07:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc3.6.g894ec42.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200088>

When running 'git diff --quiet <file1> <file2>', if file1 or file2
is outside the repository, it will exit(0) even if the files differ.
It should exit(1) when they differ.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Changes in v2:
  - Implemented the fix in diff-no-index.c as suggested by Junio
    Hamano.  The previous version affected the performance of all
    diff commands that used the '--quiet' option by forcing the
    code through the expensive (and in this case unneccesary)
    'diff_flush_patch' code path.
  - Updated the test to use 'test_expect_code' as suggested by
    Jeff King.


 diff-no-index.c       | 3 ++-
 t/t4035-diff-quiet.sh | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index f0b0010..b935d2a 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -273,5 +273,6 @@ void diff_no_index(struct rev_info *revs,
 	 * The return code for --no-index imitates diff(1):
 	 * 0 = no changes, 1 = changes, else error
 	 */
-	exit(revs->diffopt.found_changes);
+	int result = diff_result_code(&revs->diffopt, 0);
+	exit(result);
 }
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index cdb9202..0b83235 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -76,4 +77,8 @@ test_expect_success 'git diff-index --cached HEAD' '
 	}
 '
 
+test_expect_success 'git diff <tracked file> <file outside repo>' '
+	test_expect_code 1 git diff --quiet c /dev/null
+'
+
 test_done
-- 
1.7.11.rc3.6.g894ec42.dirty
