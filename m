From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2] ref-filter: fallback on alphabetical comparison
Date: Sun, 25 Oct 2015 21:59:00 +0530
Message-ID: <1445790540-22764-1-git-send-email-Karthik.188@gmail.com>
Cc: j6t@kdbg.org, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 17:28:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqOAA-00059H-7O
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 17:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbbJYQ2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 12:28:50 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35926 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbbJYQ2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 12:28:49 -0400
Received: by pacfv9 with SMTP id fv9so170732720pac.3
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=X9Rh6ds7GQFseN3shsTMIqvG8qj7uuku0MywZBj2moU=;
        b=mtKuQBXwS3pg37hQ261NZ0s6vM797ajDX8sy8UHgIZq9G2Tn02+nHAxnFbeNpQi9Mj
         ZblNXXX6ZU5JqtahkosPky4uwrDKLE5vUpFh885oKRbqUD4J4SMosgKxaUeqUgd6Px2i
         +ISp7zGdiGUukU62GSUqWtsqjWORE0dylQe/mBEvf/IZlxiXvqG5fcrEFs/uUrh3Cmzk
         VkFOpe7GNqFa1tkZOVo7T5gvHpq3aAbagH5rJ512RpU1vs4oSZVb5BOFwAcOI3AeNXS9
         BSG9Q1ycu0XrPt3DO7qtlalEV86K8jNKPdeqqalJArDH0qpzp2LcZ3KzROtSlrD5v1mv
         t4Ow==
X-Received: by 10.66.151.138 with SMTP id uq10mr17271034pab.22.1445790528772;
        Sun, 25 Oct 2015 09:28:48 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id yg2sm29272256pbb.79.2015.10.25.09.28.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Oct 2015 09:28:48 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280157>

In ref-filter.c the comparison of refs while sorting is handled by
cmp_ref_sorting() function. When sorting as per numerical values
(e.g. --sort=objectsize) there is no fallback comparison when both
refs hold the same value. This can cause unexpected results (i.e. the
order of listting refs with equal values cannot be pre-determined) as
pointed out by Johannes Sixt ($gmane/280117).

Hence, fallback to alphabetical comparison based on the refname
whenever the other criterion is equal. Fix the test in t3203 in this
regard.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c             | 2 +-
 t/t3203-branch-output.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 046e73b..7b33cb8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1698,7 +1698,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 		if (va->ul < vb->ul)
 			cmp = -1;
 		else if (va->ul == vb->ul)
-			cmp = 0;
+			cmp = strcmp(a->refname, b->refname);
 		else
 			cmp = 1;
 	}
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index f77971c..9f2d482 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -158,8 +158,8 @@ EOF
 
 test_expect_success 'git branch `--sort` option' '
 	cat >expect <<-\EOF &&
-	  branch-two
 	* (HEAD detached from fromtag)
+	  branch-two
 	  branch-one
 	  master
 	EOF
-- 
2.6.2
