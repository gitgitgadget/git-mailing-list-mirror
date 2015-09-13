From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 4/8] branch: move 'current' check down to the presentation layer
Date: Sun, 13 Sep 2015 21:05:52 +0530
Message-ID: <1442158552-21552-1-git-send-email-Karthik.188@gmail.com>
References: <1442129035-31386-5-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 17:35:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb9Jp-000477-79
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 17:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbbIMPfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 11:35:45 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35528 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbbIMPfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 11:35:45 -0400
Received: by pacfv12 with SMTP id fv12so121533403pac.2
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WgjVgvL5AHsPLlhE+o+1JaurRaaeqK0XOmyIHeCt9f8=;
        b=HnNHzxNNW5OJ6gUMDt/3xe1rQOxJtaW7M5GZEF9xYUUFAJFLYzzmKAenBB7LfnCuN4
         Py3owqP1KaWOKQ4upfnGK8IvZ8TxNOO/Cjwi5P8gMICu4YteYfp0QWfWFiLifuVhwWHW
         PSrey8kkBKePogU4D3U9R9kOBVLcXrX9LBKCOlTv1b6wn/YChQB8bWwXJloc7fJ9GYNV
         oJw2+cwkp6obR4O1QKatfOumjzZ4sEEDxjYp6daUwz1TbmRpshX0afpWJFCzD1nvBKmC
         5HfGnYBl+ZjUXXO9yT5dodKQzi9FEfSFOjNhndkiaIxOPotxzOvICzsgHiKL2KsmgixC
         Q22w==
X-Received: by 10.68.203.42 with SMTP id kn10mr23755978pbc.43.1442158544529;
        Sun, 13 Sep 2015 08:35:44 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ob4sm11032171pbb.40.2015.09.13.08.35.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Sep 2015 08:35:44 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442129035-31386-5-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277785>

We check if given ref is the current branch in print_ref_list(). Move
this check to print_ref_item() where it is checked right before
printing. This enables a smooth transition to using ref-filter APIs,
as we can later replace the current check while printing to just check
for FILTER_REFS_DETACHED instead.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Change the commit message to explain the need for this patch.

 builtin/branch.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6ba7a3f..4d9e4d0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -534,9 +534,10 @@ static char *get_head_description(void)
 }
 
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
-			   int abbrev, int current, const char *remote_prefix)
+			   int abbrev, int detached, const char *remote_prefix)
 {
 	char c;
+	int current = 0;
 	int color;
 	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
 	const char *prefix = "";
@@ -548,15 +549,18 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 
 	switch (item->kind) {
 	case REF_LOCAL_BRANCH:
-		color = BRANCH_COLOR_LOCAL;
+		if (!detached && !strcmp(item->name, head))
+			current = 1;
+		else
+			color = BRANCH_COLOR_LOCAL;
 		break;
 	case REF_REMOTE_BRANCH:
 		color = BRANCH_COLOR_REMOTE;
 		prefix = remote_prefix;
 		break;
 	case REF_DETACHED_HEAD:
-		color = BRANCH_COLOR_CURRENT;
 		desc = to_free = get_head_description();
+		current = 1;
 		break;
 	default:
 		color = BRANCH_COLOR_PLAIN;
@@ -685,21 +689,17 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	index = ref_list.index;
 
 	/* Print detached HEAD before sorting and printing the rest */
-	if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
-	    !strcmp(ref_list.list[index - 1].name, head)) {
+	if (detached) {
 		print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
-			       1, remote_prefix);
+			       detached, remote_prefix);
 		index -= 1;
 	}
 
 	qsort(ref_list.list, index, sizeof(struct ref_item), ref_cmp);
 
-	for (i = 0; i < index; i++) {
-		int current = !detached && (ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
-			!strcmp(ref_list.list[i].name, head);
+	for (i = 0; i < index; i++)
 		print_ref_item(&ref_list.list[i], maxwidth, verbose,
-			       abbrev, current, remote_prefix);
-	}
+			       abbrev, detached, remote_prefix);
 
 	free_ref_list(&ref_list);
 
-- 
2.5.1
