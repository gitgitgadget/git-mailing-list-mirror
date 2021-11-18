Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7962C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9360B61391
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhKRQxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57662 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhKRQww (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B8FB21FD56
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NT9sGEPBqM6vPhi/cHT8+cK9Bk+W5K3bs+clikvUBlU=;
        b=crafe2tKMZ4xmQfiHP9UD5/TwH5+MZeBrDpLDNjHBQOXtA/MyZvALAvMh4VsAKFIs1VAJF
        9rKU3L4NpJBNAvjCx3aMryM4IuCGQpYj7d+0tMRkfK8CSaHem/voR4EfiWfv+WvjaA94Fg
        jpnOKwQlvw0vBowquLYrmJ8vh+RrJow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NT9sGEPBqM6vPhi/cHT8+cK9Bk+W5K3bs+clikvUBlU=;
        b=tA88GC9bqRYsSneCk7YFLNa8MhbFu/AafqRo7GqNoKWA4yGu+QBS4wLpdfdUNx68rUM/Mm
        XylVjWwjf3EGh6Cg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id AF1A5A3BA3;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D20FA1F2CD0; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 27/27] bisect: Allow bisection debugging of approx_halfway()
Date:   Thu, 18 Nov 2021 17:49:40 +0100
Message-Id: <20211118164940.8818-28-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently approx_halfway() is shortcircuited when bisection debugging is
turned on. Allow possibility of printing all debug messages while
keeping approx_halfway() working by setting DEBUG_BISECT to 1. Disable
approx_halfway() only when BISECT_DEBUG is larger than 1. Also add a
debug message to approx_halfway() to dump info about commit it is
selecting.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4d2ba5dbd77e..60e8c32056ac 100644
--- a/bisect.c
+++ b/bisect.c
@@ -207,7 +207,7 @@ static inline int approx_halfway(struct commit_list *p, int nr)
 	 */
 	if (p->item->object.flags & TREESAME)
 		return 0;
-	if (DEBUG_BISECT)
+	if (DEBUG_BISECT > 1)
 		return 0;
 
 	if (!result_confidence) {
@@ -230,8 +230,11 @@ static inline int approx_halfway(struct commit_list *p, int nr)
 		diff = frac_to_fp(1, 16);
 	}
 	if (weight(p) > (FP_HALF - diff) * scale &&
-	    weight(p) < (FP_HALF + diff) * scale)
+	    weight(p) < (FP_HALF + diff) * scale) {
+		debug_bisect("found approx half: %lf diff %lf\n",
+			     fp_to_double(weight(p)), fp_to_double(diff));
 		return 1;
+	}
 	return 0;
 }
 
-- 
2.26.2

