Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06687C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E337C6138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhKRQxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57650 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhKRQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 84EA61FD42
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0l7Hqf9Tv6e3Szo71Wu9BxNjeHulm4d9oBijOO6mBR8=;
        b=zOeyqKOo2kpqzS0/eo9ofa05R+BhMtT9jBt7AD0UcDXAqkPtKl9gzAyKqItzGdosD9ymwJ
        juY8rwNjt3qe0FJZ4GH9r7zXZLWeFTOUj2+yTJnPbIIzjyyLFYt5KoEqBAmVQjn8to49IC
        HzxkS4t8/YvsUnawlVCOFlMU38y+EqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0l7Hqf9Tv6e3Szo71Wu9BxNjeHulm4d9oBijOO6mBR8=;
        b=zCwtoCHlbE7onffFvG6eZ/3susGflw964GTYPRlf0ye9YpG8G9YEv3IDPCi4a2uoFC1VQR
        EsVnqro+2MDCHcBg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 79D30A3B98;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A882D1F2CB3; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 16/27] bisect: Separate commit list reversal
Date:   Thu, 18 Nov 2021 17:49:29 +0100
Message-Id: <20211118164940.8818-17-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Item list reversal is part of code counting number of list items
changing tree. Move it into the separate function and do the reversal
after counting. The stochastic bisection will need to do more operations
after the counting but before reversing the list.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index 675e8d433760..8dc1eb7f9d82 100644
--- a/bisect.c
+++ b/bisect.c
@@ -398,11 +398,24 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		return best_bisection_sorted(list, nr);
 }
 
+
+static struct commit_list *reverse_list(struct commit_list *list)
+{
+	struct commit_list *p, *next, *last = NULL;
+
+	for (p = list; p; p = next) {
+		next = p->next;
+		p->next = last;
+		last = p;
+	}
+	return last;
+}
+
 void find_bisection(struct commit_list **commit_list, int *reaches,
 		    int *all, unsigned bisect_flags)
 {
 	int nr, on_list;
-	struct commit_list *list, *p, *best, *next, *last;
+	struct commit_list *list, *p, *best, *next, **pnext;
 	int *weights;
 
 	init_commit_weight(&commit_weight);
@@ -410,25 +423,25 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 
 	/*
 	 * Count the number of total and tree-changing items on the
-	 * list, while reversing the list.
+	 * list and trim uninteresting items from the list.
 	 */
-	for (nr = on_list = 0, last = NULL, p = *commit_list;
-	     p;
-	     p = next) {
+	list = *commit_list;
+	pnext = &list;
+	for (nr = on_list = 0, p = list; p; p = next) {
 		unsigned commit_flags = p->item->object.flags;
 
 		next = p->next;
 		if (commit_flags & UNINTERESTING) {
+			*pnext = next;
 			free(p);
 			continue;
 		}
-		p->next = last;
-		last = p;
+		pnext = &p->next;
 		if (!(commit_flags & TREESAME))
 			nr++;
 		on_list++;
 	}
-	list = last;
+	list = reverse_list(list);
 	show_list("bisection 2 sorted", 0, nr, list);
 
 	*all = nr;
-- 
2.26.2

