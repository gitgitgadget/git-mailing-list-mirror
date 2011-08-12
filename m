From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 53/56] t6022: Additional tests checking for unnecessary updates of files
Date: Thu, 11 Aug 2011 23:20:26 -0600
Message-ID: <1313126429-17368-54-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkD8-0005ix-7i
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503Ab1HLFWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:45 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:37921 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438Ab1HLFW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:29 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so837450iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pqY0CFYSOvTgJ5U8ztnt45OicDNYJSJhmQnEAMfnjwA=;
        b=Zq+m3N5eLasfy3r184m64FPFsn0IlqadXosOJNM0X6HSySWx1kV+RYtwe+LEWKL33v
         rtmX5ktIcIkIQNplK3/UtFmik5waMJeOLnF+oifQCKJPgblEUy+JiIedqJfsUr2ruSPZ
         uxKQNf/+D7RTgnAfFxuAbilslNb5lrWWVJ6VI=
Received: by 10.231.224.23 with SMTP id im23mr1139219ibb.35.1313126548997;
        Thu, 11 Aug 2011 22:22:28 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.27
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179206>

I stumbled across a case, this one not involving a content merge, where
git currently rewrites a file unnecessarily.  A quick audit uncovered two
additional situations (also not involving content merges) with the same
problem.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Completely new patch (about a problem that existed previous to v1, but which
I hadn't noticed).

 t/t6022-merge-rename.sh |   91 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 8f75762..c2993fc 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -673,6 +673,97 @@ test_expect_success 'avoid unnecessary update, with D/F conflict' '
 	test_cmp expect actual # "df" should have stayed intact
 '
 
+test_expect_success 'setup avoid unnecessary update, dir->(file,nothing)' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	>irrelevant &&
+	mkdir df &&
+	>df/file &&
+	git add -A &&
+	git commit -mA &&
+
+	git checkout -b side
+	git rm -rf df &&
+	git commit -mB &&
+
+	git checkout master &&
+	git rm -rf df &&
+	echo bla >df &&
+	git add -A &&
+	git commit -m "Add a newfile"
+'
+
+test_expect_failure 'avoid unnecessary update, dir->(file,nothing)' '
+	git checkout -q master^0 &&
+	test-chmtime =1000000000 df &&
+	test-chmtime -v +0 df >expect &&
+	git merge side &&
+	test-chmtime -v +0 df >actual &&
+	test_cmp expect actual # "df" should have stayed intact
+'
+
+test_expect_success 'setup avoid unnecessary update, modify/delete' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	>irrelevant &&
+	>file &&
+	git add -A &&
+	git commit -mA &&
+
+	git checkout -b side
+	git rm -f file &&
+	git commit -m "Delete file" &&
+
+	git checkout master &&
+	echo bla >file &&
+	git add -A &&
+	git commit -m "Modify file"
+'
+
+test_expect_failure 'avoid unnecessary update, modify/delete' '
+	git checkout -q master^0 &&
+	test-chmtime =1000000000 file &&
+	test-chmtime -v +0 file >expect &&
+	test_must_fail git merge side &&
+	test-chmtime -v +0 file >actual &&
+	test_cmp expect actual # "file" should have stayed intact
+'
+
+test_expect_success 'setup avoid unnecessary update, rename/add-dest' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n" >file &&
+	git add -A &&
+	git commit -mA &&
+
+	git checkout -b side
+	cp file newfile &&
+	git add -A &&
+	git commit -m "Add file copy" &&
+
+	git checkout master &&
+	git mv file newfile &&
+	git commit -m "Rename file"
+'
+
+test_expect_failure 'avoid unnecessary update, rename/add-dest' '
+	git checkout -q master^0 &&
+	test-chmtime =1000000000 newfile &&
+	test-chmtime -v +0 newfile >expect &&
+	git merge side &&
+	test-chmtime -v +0 newfile >actual &&
+	test_cmp expect actual # "file" should have stayed intact
+'
+
 test_expect_success 'setup merge of rename + small change' '
 	git reset --hard &&
 	git checkout --orphan rename-plus-small-change &&
-- 
1.7.6.100.gac5c1
