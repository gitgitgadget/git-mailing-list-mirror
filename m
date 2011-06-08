From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 14/48] t6022: New tests checking for unnecessary updates of files
Date: Wed,  8 Jun 2011 01:30:44 -0600
Message-ID: <1307518278-23814-15-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEs-0006q0-6Y
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab1FHHbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:31:33 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49887 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab1FHH3X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:23 -0400
Received: by pvg12 with SMTP id 12so118724pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=y4BiRtmH4yuZ9T8pU67megNu08Lj7xREsdxDxoWKLRE=;
        b=CXqvhaIsnuy7hpqfEJlJAnFMxfFGdSdUysjQ+cQk6NaQnFMwb5id0V5vLGSFsDw9XQ
         QPc5LCTUAl/+Q1V9lyIyuPm4nwXDo5NJqnvsyd7wFZNHDkKfPm93/JIVH5eF1jjxWA9e
         9DGtbTQbOba1E0hNZJRKOkMVzSJkgOC8xZQpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GHjq12lio47mwLjg282gUqPamCaNkCnP/MWGGkkvbX46B5jXAIBA0zgbfJqHP/OlZk
         HJA9x/P4bHA9xt6iuaTDCNfQ1YEMniZUBcze6DxF/Y3CLmZqAsb426p4vTsKwtcVWPNV
         jF81V6VuWt31Y0HOThn98GNqOXLlQdUi9CfG0=
Received: by 10.143.27.23 with SMTP id e23mr220915wfj.274.1307518163006;
        Wed, 08 Jun 2011 00:29:23 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.20
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175327>

This testcase was part of en/merge-recursive that was reverted in 6db4105
(Revert "Merge branch 'en/merge-recursive'" 2011-05-19).  While the other
changes in that series caused unfortunate breakage, this testcase is still
useful; reinstate it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
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
1.7.6.rc0.62.g2d69f
