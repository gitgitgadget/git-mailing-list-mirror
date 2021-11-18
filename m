Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABF7C4332F
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318C761B3E
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhKRQxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57654 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbhKRQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 895DD1FD48
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sw4ZcsUC4u3YijjcSItb1VeXU9oNyBhEvya1p7Z44Lw=;
        b=IdpIRG8Q/I9FrWqgSC28VMccvU4cB9Ub0T/LIOmZAO3mzpGxaPmMTxcNpIytbCwIlM3WuX
        pCn/I/AQhV6Y8FR2qgzCH05tvZTclgx1K0tnvgVXAYgraNf8z0XpEvyaM136Mv+K0GDlw3
        +xbAIxbNZps/Sedti4wo2k5IXd/2kZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sw4ZcsUC4u3YijjcSItb1VeXU9oNyBhEvya1p7Z44Lw=;
        b=TGE7cyrqWkktC8zGv8WkajDub12OYNUoGk3ez4TLF2w8tuoMzv3L9yRAR98EfAgzRBe+q8
        Yyu5dOJ1RWBzGcDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 7E93FA3B9A;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AC95A1F2CB4; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 17/27] bisect: Allow more complex commit weights
Date:   Thu, 18 Nov 2021 17:49:30 +0100
Message-Id: <20211118164940.8818-18-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For stochastic bisection we will need to keep more information for each
commit than plain int. Factor out initialization of commit weight
storage into a separate function so that stochastic bisection can more
easily alter it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index 8dc1eb7f9d82..dd2f6b68ae3d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -280,19 +280,17 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  * or positive distance.
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
-					     int nr, int *weights,
-					     unsigned bisect_flags)
+					     int nr, unsigned bisect_flags)
 {
-	int n, counted;
+	int counted;
 	struct commit_list *p;
 
 	counted = 0;
 
-	for (n = 0, p = list; p; p = p->next) {
+	for (p = list; p; p = p->next) {
 		struct commit *commit = p->item;
 		unsigned commit_flags = commit->object.flags;
 
-		*commit_weight_at(&commit_weight, p->item) = &weights[n++];
 		switch (count_interesting_parents(commit, bisect_flags)) {
 		case 0:
 			if (!(commit_flags & TREESAME)) {
@@ -398,6 +396,20 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		return best_bisection_sorted(list, nr);
 }
 
+static void *setup_commit_weight_array(struct commit_list *list, int nodes)
+{
+	int entry_size = sizeof(int);
+	void *array;
+	struct commit_list *p;
+	int n;
+
+	array = xcalloc(nodes, entry_size);
+	for (n = 0, p = list; p; p = p->next, n++) {
+		*commit_weight_at(&commit_weight, p->item) =
+						array + n * entry_size;
+	}
+	return array;
+}
 
 static struct commit_list *reverse_list(struct commit_list *list)
 {
@@ -416,7 +428,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 {
 	int nr, on_list;
 	struct commit_list *list, *p, *best, *next, **pnext;
-	int *weights;
+	void *weights;
 
 	init_commit_weight(&commit_weight);
 	show_list("bisection 2 entry", 0, 0, *commit_list);
@@ -441,14 +453,14 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 			nr++;
 		on_list++;
 	}
+	weights = setup_commit_weight_array(list, on_list);
 	list = reverse_list(list);
 	show_list("bisection 2 sorted", 0, nr, list);
 
 	*all = nr;
-	CALLOC_ARRAY(weights, on_list);
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, bisect_flags);
+	best = do_find_bisection(list, nr, bisect_flags);
 	if (best) {
 		if (!(bisect_flags & FIND_BISECTION_ALL)) {
 			list->item = best->item;
-- 
2.26.2

