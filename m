Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860A6C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F0861391
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhKRQxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57642 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhKRQwv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 930C61FD4D
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09c+ekA3hGnIdR0LKBMZyVTqnxiznpUf73U5DAnWRHg=;
        b=knl3yL72Ub7eSTEMrgfp7fnGpS6IzO3K7uu+nX295R41cmse3BkA5GDXQW9c0n+l9op61B
        hUwXGWRVFGxC4yCdkYddT/bBgQfB1cbZIjc33GTh6GIxBWqXoHTSGURooRnM8VDSnDOHTO
        V25SeS2LxLZJIZMKiTrGByxX4VAJBqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09c+ekA3hGnIdR0LKBMZyVTqnxiznpUf73U5DAnWRHg=;
        b=Y8JCOUULlpvrx7r/X0gGhEeO6Qxjo/4sQg7JKWHBOiP+lcISyCWcrXzs0RJrzgG+KddwP3
        QLeT4dFhhKWYs4AA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 83B16A3B9E;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CA1B51F2CC8; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 25/27] bisect: Report commit with the highest probability
Date:   Thu, 18 Nov 2021 17:49:38 +0100
Message-Id: <20211118164940.8818-26-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For stochastic bisection it does not make sense to report number of
commits to investigate (since we always consider all). What we can do
though is to report the highest probability some commit has of being
bad. That also indicates how far we are from the end of bisection as
once the probability reaches desired result confidence bisection stops.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c           | 56 +++++++++++++++++++++++++++++++++-------------
 bisect.h           |  4 +++-
 builtin/rev-list.c |  6 +++--
 3 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/bisect.c b/bisect.c
index 7da74778d780..6ed740106795 100644
--- a/bisect.c
+++ b/bisect.c
@@ -724,7 +724,25 @@ static struct commit_list *compute_commit_weights(struct commit_list *list)
 	return p;
 }
 
-void find_bisection(struct commit_list **commit_list, int *reaches,
+static fpnum_t heaviest_commit(struct commit_list *list)
+{
+	fpnum_t best_weight = 0;
+	struct commit_list *p;
+
+	for (p = list; p; p = p->next) {
+		struct st_weight *pweight;
+
+		if (p->item->object.flags & TREESAME)
+			continue;
+
+		pweight = *commit_weight_at(&commit_weight, p->item);
+		if (pweight->node_weight > best_weight)
+			best_weight = pweight->node_weight;
+	}
+	return best_weight;
+}
+
+void find_bisection(struct commit_list **commit_list, fpnum_t *reaches,
 		    int *all, unsigned bisect_flags)
 {
 	int nr, on_list;
@@ -770,6 +788,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 			oidcpy(current_bad_oid, &best->item->object.oid);
 			goto found_best;
 		}
+		*reaches = heaviest_commit(list);
 	}
 	show_list("bisection 2 sorted", 0, nr, list);
 
@@ -783,7 +802,8 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 			best = list;
 			best->next = NULL;
 		}
-		*reaches = fp_to_int(weight(best) * (nr / weight_scale(nr)));
+		if (!result_confidence)
+			*reaches = weight(best) / nr;
 	}
 	free(weights);
 	*commit_list = best;
@@ -1457,7 +1477,8 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
-	int reaches = 0, all = 0, nr, steps;
+	int all = 0, nr, steps;
+	fpnum_t reaches = 0;
 	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
 	char *steps_msg;
@@ -1536,19 +1557,24 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		return BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
 	}
 
-	nr = all - reaches - 1;
-	steps = estimate_bisect_steps(all);
+	if (!result_confidence) {
+		nr = all - fp_to_int(reaches * all) - 1;
+		steps = estimate_bisect_steps(all);
 
-	steps_msg = xstrfmt(Q_("(roughly %d step)", "(roughly %d steps)",
-		  steps), steps);
-	/*
-	 * TRANSLATORS: the last %s will be replaced with "(roughly %d
-	 * steps)" translation.
-	 */
-	printf(Q_("Bisecting: %d revision left to test after this %s\n",
-		  "Bisecting: %d revisions left to test after this %s\n",
-		  nr), nr, steps_msg);
-	free(steps_msg);
+		steps_msg = xstrfmt(Q_("(roughly %d step)", "(roughly %d steps)",
+			  steps), steps);
+		/*
+		 * TRANSLATORS: the last %s will be replaced with "(roughly %d
+		 * steps)" translation.
+		 */
+		printf(Q_("Bisecting: %d revision left to test after this %s\n",
+			  "Bisecting: %d revisions left to test after this %s\n",
+			  nr), nr, steps_msg);
+		free(steps_msg);
+	} else {
+		printf(_("Bisecting: most probable commit has probability %lf\n"),
+			fp_to_double(reaches));
+	}
 	/* Clean up objects used, as they will be reused. */
 	repo_clear_commit_marks(r, ALL_REV_FLAGS);
 
diff --git a/bisect.h b/bisect.h
index ec24ac2d7ee9..d0a805b05041 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,6 +1,8 @@
 #ifndef BISECT_H
 #define BISECT_H
 
+#include "fixedpoint.h"
+
 struct commit_list;
 struct repository;
 
@@ -11,7 +13,7 @@ struct repository;
  * Otherwise, it will be either all non-SAMETREE commits or the single
  * best commit, as chosen by `find_all`.
  */
-void find_bisection(struct commit_list **list, int *reaches, int *all,
+void find_bisection(struct commit_list **list, fpnum_t *reaches, int *all,
 		    unsigned bisect_flags);
 
 struct commit_list *filter_skipped(struct commit_list *list,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 36cb909ebaa5..c98ac9e91688 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -702,7 +702,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		mark_edges_uninteresting(&revs, show_edge, 0);
 
 	if (bisect_list) {
-		int reaches, all;
+		int all;
+		fpnum_t reaches;
 		unsigned bisect_flags = 0;
 
 		if (bisect_find_all)
@@ -714,7 +715,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 
 		if (bisect_show_vars)
-			return show_bisect_vars(&info, reaches, all);
+			return show_bisect_vars(&info, fp_to_int(reaches * all),
+						all);
 	}
 
 	if (filter_provided_objects) {
-- 
2.26.2

