From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] ref-filter: fallback on alphabetical comparison
Date: Sat, 24 Oct 2015 20:12:50 +0530
Message-ID: <1445697770-29331-1-git-send-email-Karthik.188@gmail.com>
References: <562B3807.2030203@kdbg.org>
Cc: j6t@kdbg.org, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 16:43:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq02H-0004Tu-Ew
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 16:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbbJXOmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 10:42:39 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34210 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbJXOmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 10:42:38 -0400
Received: by padhk11 with SMTP id hk11so144104497pad.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iq/Dza7mQg7BC8OJ6VDNV8JtIj58EtB/un4A5Z6NUss=;
        b=qf66kfxHnHp5JKneNvAyQSS50gTPHKY/DEye61clECIXvGm46qW8PfgyR3O39RfO4M
         MNX3wxyT1Oesres4i4sm588UBwCboBSfnl1FVqzEIcx53t7m+Wgw0AbxZ4gnfZplrvY7
         22sL6DF+J8g0hJKWY7QXIrNjF4YhysR6q7lfikOap2JZPNbOi0rvkE9Gsn6tY18rN0Vb
         M4TufPCxq39+v1fUhMapwYiBhxzbdJT/2TsVRVeaX/epk99paSFll+qEvwtG5f9BdLYM
         xDV96KEiK86oleo8ZP4JyPqpT40JX0QfBdKXCn896LD83GT+LDbW2lgrSizAkRkeepkG
         rvcA==
X-Received: by 10.68.107.65 with SMTP id ha1mr11528331pbb.143.1445697756792;
        Sat, 24 Oct 2015 07:42:36 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id zi1sm24590779pbc.10.2015.10.24.07.42.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Oct 2015 07:42:36 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <562B3807.2030203@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280122>

In ref-filter.c the comparison of refs while sorting is handled by
cmp_ref_sorting() function. When sorting as per numerical values
(e.g. --sort=objectsize) there is no fallback comparison when both refs
hold the same value. This can cause unexpected results as pointed out
by Johannes Sixt ($gmane/280117).

Hence, fallback to alphabetical comparison based on the refname whenever
the other criterion is equal. Fix the test in t3203 in this regard.

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
