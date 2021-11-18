Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970CBC4321E
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB5C61B3B
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhKRQxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57660 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbhKRQww (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9031D1FD49
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIqWaPCbKytzaGTVJNjidUkwwHYS84r6kQkbTNQcunk=;
        b=oNmRhFvvV/H83bDIZVDP/9K8RSu2C2v2RNtep3boyjJbVj4GGu4IxineU6HOy9oNPmg+gx
        f8HZU3N2zUfHQ1R1dQTDYiTHaXGaUW8DC1yryyQ8Drx8r3OrKZOaZeDrwpgTAuWUUF9c23
        JwCyhMStOzAaMFMRWymHZZx2QNcA0pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIqWaPCbKytzaGTVJNjidUkwwHYS84r6kQkbTNQcunk=;
        b=1bVhhqge//3KfGc2TGYK3ePA1QXALtz8OvkoNiy33hNwBoCJZkHOjxA2uGEeT5DtcWVwH4
        1AgoOIwDLk62wRCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 81535A3B9D;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C5ADE1F2CC4; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 24/27] bisect: Stop bisection when we are confident about bad commit
Date:   Thu, 18 Nov 2021 17:49:37 +0100
Message-Id: <20211118164940.8818-25-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we found a commit that has high enough probability of being bad,
stop bisection and report it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 12b027b86e75..7da74778d780 100644
--- a/bisect.c
+++ b/bisect.c
@@ -624,7 +624,7 @@ static int sw_rev_bmp_cmp(const void *data, const struct hashmap_entry *ap,
  * Compute for each commit a probability it is the bad one given tests
  * performed so far.
  */
-static void compute_commit_weights(struct commit_list *list)
+static struct commit_list *compute_commit_weights(struct commit_list *list)
 {
 	struct commit_list *p;
 	struct hashmap reach_map;
@@ -714,9 +714,14 @@ static void compute_commit_weights(struct commit_list *list)
 		found_entry = hashmap_get_entry(&reach_map, &entry, entry, NULL);
 		pweight->node_weight =
 			found_entry->cluster_p_bad / found_entry->count;
+		/* Found node we are confident enough is bad? */
+		if (pweight->node_weight >= result_confidence)
+			break;
 	}
 
 	hashmap_clear_and_free(&reach_map, struct sw_rev_bmp_hash_entry, entry);
+
+	return p;
 }
 
 void find_bisection(struct commit_list **commit_list, int *reaches,
@@ -758,14 +763,21 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	if (result_confidence)
 		compute_tested_descendants(list);
 	list = reverse_list(list);
-	if (result_confidence)
-		compute_commit_weights(list);
+	if (result_confidence) {
+		best = compute_commit_weights(list);
+		/* Found commit we are confident is bad? Stop bisection... */
+		if (best) {
+			oidcpy(current_bad_oid, &best->item->object.oid);
+			goto found_best;
+		}
+	}
 	show_list("bisection 2 sorted", 0, nr, list);
 
 	/* Do the real work of finding bisection commit. */
 	best = do_find_bisection(list, nr, bisect_flags);
 	if (best) {
 		if (!(bisect_flags & FIND_BISECTION_ALL)) {
+found_best:
 			list->item = best->item;
 			free_commit_list(list->next);
 			best = list;
-- 
2.26.2

