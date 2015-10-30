From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4] ref-filter: fallback on alphabetical comparison
Date: Fri, 30 Oct 2015 14:15:28 +0530
Message-ID: <1446194728-7944-1-git-send-email-Karthik.188@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 30 09:45:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zs5JL-0007RE-G1
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 09:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbbJ3IpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 04:45:15 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36708 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758910AbbJ3IpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 04:45:12 -0400
Received: by pacfv9 with SMTP id fv9so71102074pac.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=csHh61d53ZCCGHRQE/EHTmC0OD4LrbR+YBkSNXBsF6M=;
        b=wn17IzadIiRhzEukbYwS+AqOHGSLwZJ8CcBgbzgAPsvutovDW/Rfhj1DhqjyS3M4yG
         BxiVVhk0jRgbu6kV9KBeE+Zr7Wa8zX234RsvfGyAvrOVhFyg2rQcq73tbhOolrvJhkBN
         A/NLQ4D3c2jPokggB3/J200gWWc9aLkNiEw+7zCTVErGwHadiqXkTt0bSs/RYBXERdvC
         OJuOHdeo46t9rL2LRO+qhTyVnVPxbIqaue35JuGJQIP7ZGQElbSkAPJMKP3eBZXeAopC
         96pWUoaBaW310ph2V2kRRV5QmVvlj7mxe19pnKK3ZGg9IeZepWHuq240D7xVjzQFHvmJ
         ydIw==
X-Received: by 10.66.172.144 with SMTP id bc16mr7199719pac.114.1446194711722;
        Fri, 30 Oct 2015 01:45:11 -0700 (PDT)
Received: from ashley.localdomain ([106.51.135.86])
        by smtp.gmail.com with ESMTPSA id t9sm6781564pbs.17.2015.10.30.01.45.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 01:45:11 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280481>

In ref-filter.c the comparison of refs while sorting is handled by
cmp_ref_sorting() function. When sorting as per numerical values
(e.g. --sort=objectsize) there is no fallback comparison when both
refs hold the same value. This can cause unexpected results (i.e. the
order of listing refs with equal values cannot be pre-determined) as
pointed out by Johannes Sixt ($gmane/280117).

Hence, fallback to alphabetical comparison based on the refname
whenever the other criterion is equal.

A test in t3203 was expecting that branch-two sorts before HEAD, which
happened to be how qsort(3) on Linux sorted the array, but (1) that
outcome was not even guaranteed, and (2) once we start breaking ties
with the refname, "HEAD" should sort before "branch-two" so the
original expectation was inconsistent with the criterion we now use.

Update it to match the new world order, which we can now depend on
being stable.

Helped-by: Junio C Hamano <gitster@pobox.com>
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
