From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: honor --trust-exit-code for builtin tools
Date: Fri, 14 Nov 2014 13:33:55 -0800
Message-ID: <1416000835-79274-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Adri Farr <14farresa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:34:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpOVC-0006dC-5i
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 22:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161969AbaKNVdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 16:33:54 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:50870 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161861AbaKNVdx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 16:33:53 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so1468894pad.10
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 13:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nbkGgZ9sby5+nMHYrS1dU4XhyRucgb8XveiLzg1Cfes=;
        b=e9AyNL8Y5FmDNxkPr0A6VC0PvJE3AuBvhbmgpAo+0EF0neyfL1pgmKWBXXajoDlnVs
         hoi3UxNev6W8SoBlqprllfOktcRVyqUqH3llqAGSyYlMjFTu6seBaKQbNpTgh6B0ZTiX
         VK3PepRhOcRJSheEWoAQwJtoNd+9+jUO+TjGuPv0MXdJCzpkVJ7OHd7giBZbfVtyBOCN
         QTr9YDEpdE+V3d1BVkMeoTaf2FsW6VtB8tN3LNjjj8vrqXeGyFLbZ88WZ2QphbMbygxL
         JakG3ME9GIoXvJsS68yHfxvwNeOxNRpAjNDC3dFhSaw3yfbye15jgGA6kVA8i/DaePwS
         v6PA==
X-Received: by 10.66.66.135 with SMTP id f7mr13110036pat.67.1416000833295;
        Fri, 14 Nov 2014 13:33:53 -0800 (PST)
Received: from lustrous.local.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by mx.google.com with ESMTPSA id w5sm28459629pds.25.2014.11.14.13.33.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Nov 2014 13:33:52 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc1.24.ge89f7ee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

run_merge_tool() was not setting $status, which prevented the
exit code for builtin tools from being forwarded to the caller.

Capture the exit status and add a test to guarantee the behavior.

Reported-by: Adria Farres <14farresa@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh | 1 +
 t/t7800-difftool.sh   | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index a40d3df..2b66351 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -221,6 +221,7 @@ run_merge_tool () {
 	else
 		run_diff_cmd "$1"
 	fi
+	status=$?
 	return $status
 }
 
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 69bde7a..ea35a02 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -86,6 +86,11 @@ test_expect_success PERL 'difftool forwards exit code with --trust-exit-code' '
 	test_must_fail git difftool -y --trust-exit-code -t error branch
 '
 
+test_expect_success PERL 'difftool forwards exit code with --trust-exit-code for built-ins' '
+	test_config difftool.vimdiff.path false &&
+	test_must_fail git difftool -y --trust-exit-code -t vimdiff branch
+'
+
 test_expect_success PERL 'difftool honors difftool.trustExitCode = true' '
 	test_config difftool.error.cmd false &&
 	test_config difftool.trustExitCode true &&
-- 
2.2.0.rc1.23.gf570943.dirty
