From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 14/56] t6022: New tests checking for unnecessary updates of files
Date: Thu, 11 Aug 2011 23:19:47 -0600
Message-ID: <1313126429-17368-15-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBP-0004nj-0O
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab1HLFVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:10 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40974 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab1HLFVC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:02 -0400
Received: by mail-yx0-f174.google.com with SMTP id 19so1756068yxj.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zfHWmvLW++ArmVYOd1xjSJ+RztieWV9dWnI7BMdkAms=;
        b=W0cN+LWYaDBpd/QHhc752rN7V+Zidv2ahpVYCPYdS1zduhnDPwI4Pjz3mxjdH5f19o
         ewgcEr5/3soobAAcIoo6prsppO8EO7P89/eVqpMwDCrItEH+22OBPSCNF+xMskoKQam0
         ovRUu/9fOB3sLvFFwXgf/eAEiVp6817xM1I2g=
Received: by 10.43.49.73 with SMTP id uz9mr527284icb.435.1313126461838;
        Thu, 11 Aug 2011 22:21:01 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.59
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179174>

This testcase was part of en/merge-recursive that was reverted in 6db4105
(Revert "Merge branch 'en/merge-recursive'" 2011-05-19).  While the other
changes in that series caused unfortunate breakage, this testcase is still
useful; reinstate it.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 t/t6022-merge-rename.sh |   63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 1d1b32e..11c5c60 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -610,4 +610,67 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	! test -f original
 '
 
+test_expect_success 'setup avoid unnecessary update, normal rename' '
+	git reset --hard &&
+	git checkout --orphan avoid-unnecessary-update-1 &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >original &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git mv original rename &&
+	echo 11 >>rename &&
+	git add -u &&
+	git commit -m "Renamed and modified" &&
+
+	git checkout -b merge-branch-1 HEAD~1 &&
+	echo "random content" >random-file &&
+	git add -A &&
+	git commit -m "Random, unrelated changes"
+'
+
+test_expect_failure 'avoid unnecessary update, normal rename' '
+	git checkout -q avoid-unnecessary-update-1^0 &&
+	test-chmtime =1000000000 rename &&
+	test-chmtime -v +0 rename >expect &&
+	git merge merge-branch-1 &&
+	test-chmtime -v +0 rename >actual &&
+	test_cmp expect actual # "rename" should have stayed intact
+'
+
+test_expect_success 'setup to test avoiding unnecessary update, with D/F conflict' '
+	git reset --hard &&
+	git checkout --orphan avoid-unnecessary-update-2 &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	mkdir df &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >df/file &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git mv df/file temp &&
+	rm -rf df &&
+	git mv temp df &&
+	echo 11 >>df &&
+	git add -u &&
+	git commit -m "Renamed and modified" &&
+
+	git checkout -b merge-branch-2 HEAD~1 &&
+	>unrelated-change &&
+	git add unrelated-change &&
+	git commit -m "Only unrelated changes"
+'
+
+test_expect_failure 'avoid unnecessary update, with D/F conflict' '
+	git checkout -q avoid-unnecessary-update-2^0 &&
+	test-chmtime =1000000000 df &&
+	test-chmtime -v +0 df >expect &&
+	git merge merge-branch-2 &&
+	test-chmtime -v +0 df >actual &&
+	test_cmp expect actual # "df" should have stayed intact
+'
+
 test_done
-- 
1.7.6.100.gac5c1
