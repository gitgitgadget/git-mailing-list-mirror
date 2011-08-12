From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 15/56] t6022: Add testcase for merging a renamed file with a simple change
Date: Thu, 11 Aug 2011 23:19:48 -0600
Message-ID: <1313126429-17368-16-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkDB-0005ix-NZ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab1HLFVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47301 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab1HLFVG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:06 -0400
Received: by gwaa12 with SMTP id a12so1770592gwa.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ANBXAVIEVwOGC6ldtBhZ+HqKnhEN70H78uHBqreCqU4=;
        b=CceIc//GZi3knxxrPRqabC6XYsWOebBlsk+1FoOIFA8fzSgyH0Q6EobhiUWCQnvb0J
         teQacW9QRCgDMtZSvO7dyA7JDa8WEWGzHdQhGLLJQgBmeb+7rkSBjero4YyH1+NSDk0r
         W6l43+nRLSNtDJb6EV30sEWzy+UCN4qFb2Rss=
Received: by 10.42.88.205 with SMTP id d13mr528479icm.154.1313126465262;
        Thu, 11 Aug 2011 22:21:05 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.01
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179215>

This is a testcase that was broken by b2c8c0a (merge-recursive: When we
detect we can skip an update, actually skip it 2011-02-28) and fixed by
6db4105 (Revert "Merge branch 'en/merge-recursive'" 2011-05-19).  Include
this testcase to ensure we don't regress it again.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1: Check that the result of the merge is actually
  correct; had I done that in v1, I would have caught the bug that
  Junio found the hard way.

 t/t6022-merge-rename.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 11c5c60..6ff4bd2 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -673,4 +673,31 @@ test_expect_failure 'avoid unnecessary update, with D/F conflict' '
 	test_cmp expect actual # "df" should have stayed intact
 '
 
+test_expect_success 'setup merge of rename + small change' '
+	git reset --hard &&
+	git checkout --orphan rename-plus-small-change &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	echo ORIGINAL >file &&
+	git add file &&
+
+	test_tick &&
+	git commit -m Initial &&
+	git checkout -b rename_branch &&
+	git mv file renamed_file &&
+	git commit -m Rename &&
+	git checkout rename-plus-small-change &&
+	echo NEW-VERSION >file &&
+	git commit -a -m Reformat
+'
+
+test_expect_success 'merge rename + small change' '
+	git merge rename_branch &&
+
+	test 1 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+	test $(git rev-parse HEAD:renamed_file) = $(git rev-parse HEAD~1:file)
+'
+
 test_done
-- 
1.7.6.100.gac5c1
