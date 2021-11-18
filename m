Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E71AC433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D676138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhKRQxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57658 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbhKRQwv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 892A21FD47
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CmTeXKzEcBZ8PzGmGR3A4u4FUjCs0iU+tEspYPRBzk=;
        b=hmjOp1BarurO5N2iahXFVve7utCqRrAE35YHh4hiYzLYquHqKh9nrEFyubrZjex++fYyTK
        5jhtnkX4PA6QRJ1JjffJ2ic676+Za6ck3+RqkKAXD74euC2V49NXZnl9GmlWGYG4XuKZnz
        0el/rlbRkI7vpACF/Dl/PdKcrYVwA/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CmTeXKzEcBZ8PzGmGR3A4u4FUjCs0iU+tEspYPRBzk=;
        b=9dq6pNbBr/hYMQyiEzFdPG/ycgyXnEMgLXFFXv4LXQGSEqEFa6Nu8UaRIhK5eMqqYMr2+O
        oRCcQqHf6ZkMxlBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 7E975A3B9B;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AF8C51F2CB5; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 18/27] bisect: Terminate early if there are no eligible commits
Date:   Thu, 18 Nov 2021 17:49:31 +0100
Message-Id: <20211118164940.8818-19-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If there are no commits that can be valid bisection point, just
terminate search for bisection point early. Firstly, it just wastes
time, secondly with more complex computations for stochastic bisection
we would have to deal with this special corner-case unnecessarily.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index dd2f6b68ae3d..3a26255e8650 100644
--- a/bisect.c
+++ b/bisect.c
@@ -453,12 +453,15 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 			nr++;
 		on_list++;
 	}
+	*all = nr;
+	if (!nr) {
+		*reaches = 0;
+		goto out_weights;
+	}
 	weights = setup_commit_weight_array(list, on_list);
 	list = reverse_list(list);
 	show_list("bisection 2 sorted", 0, nr, list);
 
-	*all = nr;
-
 	/* Do the real work of finding bisection commit. */
 	best = do_find_bisection(list, nr, bisect_flags);
 	if (best) {
@@ -472,6 +475,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	}
 	free(weights);
 	*commit_list = best;
+out_weights:
 	clear_commit_weight(&commit_weight);
 }
 
-- 
2.26.2

