From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 51/56] t6022: Add testcase for spurious "refusing to lose untracked" messages
Date: Thu, 11 Aug 2011 23:20:24 -0600
Message-ID: <1313126429-17368-52-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkD8-0005ix-QB
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511Ab1HLFWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:50 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:48310 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab1HLFW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:26 -0400
Received: by yie30 with SMTP id 30so1773997yie.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lsPA7WA+QMxF7WzXhrSyBZzrPtp9Ve4Qxv7BRmngJMs=;
        b=jh4RSbDPZ2fZ8yxuDMEWNlmrfvSBBWg/ot3TETzcFOYu0VCJx+g75iRtrO2qj35mJO
         GHU2jlu+eyUd0Wd5edqX8r2mDTO5aOZBV8xBsoZLrSJJjFDmzht63UDAZYBLW/wDenXf
         sCrVZ7C3oN3I5zUDwigqVhrypi4Rm2f60M+IE=
Received: by 10.42.152.70 with SMTP id h6mr549087icw.119.1313126545409;
        Thu, 11 Aug 2011 22:22:25 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.23
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179209>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Completely new patch (about a problem that existed previous to v1, but which
I hadn't noticed).

 t/t6022-merge-rename.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 74dcf20..0fd2b0a 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -767,4 +767,30 @@ test_expect_success 'merge rename into master has correct extended markers' '
 	test_cmp expected renamed_file
 '
 
+test_expect_success 'setup spurious "refusing to lose untracked" message' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	> irrelevant_file &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n" >original_file &&
+	git add irrelevant_file original_file &&
+	git commit -mA &&
+
+	git checkout -b rename &&
+	git mv original_file renamed_file &&
+	git commit -mB &&
+
+	git checkout master &&
+	git rm original_file &&
+	git commit -mC
+'
+
+test_expect_failure 'no spurious "refusing to lose untracked" message' '
+	git checkout master^0 &&
+	test_must_fail git merge rename^0 2>errors.txt &&
+	! grep "refusing to lose untracked file" errors.txt
+'
+
 test_done
-- 
1.7.6.100.gac5c1
