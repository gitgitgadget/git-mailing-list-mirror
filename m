From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3] ref-filter: fallback on alphabetical comparison
Date: Wed, 28 Oct 2015 00:30:56 +0530
Message-ID: <1445972456-5621-1-git-send-email-Karthik.188@gmail.com>
Cc: j6t@kdbg.org, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 20:00:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr9UF-00044m-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 20:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbbJ0TAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 15:00:43 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35771 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964950AbbJ0TAm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 15:00:42 -0400
Received: by pasz6 with SMTP id z6so230257290pas.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uwKxq8NUQQrKtTL8TGZzURWDK/ifN+Rc3+ahWQ7fYaI=;
        b=STITO9/IEIDiKuLec+pqBqGD/XHMCwfgb1Q0Gzt4kNtFYZdAxsGESxOn+mCi9t/A0S
         GW+E+AP/JdbPDUrd6/iBTB1v/NDp0QdqRZp7onDn+xgCYtWvpKTYYHRnV2Fo83yluoMJ
         3l4bJwxvfvU9Mp2fAJ1vqmd0WJcBYcRDpqv79XKT5/NOkxbZO65IcdDHjRQyqEtA0cNj
         i9P370w2hu+jPLvDB1BW6mMZdkGWBYCwWQTsXt6RV0BNrFqo2z4vmHCEB2xdT5KRVURx
         sEnVZnwxtesySPYYqgwg/f0nbFJuIQqqKt+NPXWDEonYFQjIinvfQs0iwwe4mctZTAsn
         AyTg==
X-Received: by 10.68.110.65 with SMTP id hy1mr29713722pbb.147.1445972442205;
        Tue, 27 Oct 2015 12:00:42 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id in6sm16292030pbd.86.2015.10.27.12.00.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 12:00:41 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280289>

In ref-filter.c the comparison of refs while sorting is handled by
cmp_ref_sorting() function. When sorting as per numerical values
(e.g. --sort=objectsize) there is no fallback comparison when both
refs hold the same value. This can cause unexpected results (i.e. the
order of listing refs with equal values cannot be pre-determined) as
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
