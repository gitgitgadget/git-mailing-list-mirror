Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A2CC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1536961A8A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhKRQxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57652 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbhKRQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 859551FD45
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W65rbHW4EMr3ZKytxyCaIqMLh0Jl147sHGJcLmPSvfo=;
        b=wwQuDisOo+5KHL3CIRMMWTXTQOqDGdsrWGIxl6/cwC1ZWktjxYOVVa9Xr+G9yve6Z80Jm8
        Eain+4Vx9YNirYPMiVtGwhfsRVODPlGO5flIEVHaEglpc1t0hu6U6xVDEhqcDhtx9NWDiV
        7/+VfjRTEeM8QHOU8s8PxlpQULDbALw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W65rbHW4EMr3ZKytxyCaIqMLh0Jl147sHGJcLmPSvfo=;
        b=uCeBJGeLzLmtsYCHuR/UJmVASFtlO9SjfNA1HWG0oFfqO5btDjGiEC8EjCcHTsfrrNgCHF
        drsUSt+ABYJtQPAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 78348A3B97;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A004D1F2CAE; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 14/27] bisect: Use void * for commit_weight
Date:   Thu, 18 Nov 2021 17:49:27 +0100
Message-Id: <20211118164940.8818-15-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For stochastic bisection we will need to store more information per
commit. Make commit_weight slab store void * instead of int * so that we
can reuse it for stochastic bisection as well.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index f87753d0c67c..7416a57db4e3 100644
--- a/bisect.c
+++ b/bisect.c
@@ -77,19 +77,25 @@ static void clear_distance(struct commit_list *list)
 	}
 }
 
-define_commit_slab(commit_weight, int *);
+define_commit_slab(commit_weight, void *);
 static struct commit_weight commit_weight;
 
 #define DEBUG_BISECT 0
 
+static inline int has_weight(struct commit_list *elem)
+{
+	return commit_weight.slab_size > 0 &&
+	       *commit_weight_at(&commit_weight, elem->item) != NULL;
+}
+
 static inline int weight(struct commit_list *elem)
 {
-	return **commit_weight_at(&commit_weight, elem->item);
+	return *(int *)*commit_weight_at(&commit_weight, elem->item);
 }
 
 static inline void weight_set(struct commit_list *elem, int weight)
 {
-	**commit_weight_at(&commit_weight, elem->item) = weight;
+	*(int *)*commit_weight_at(&commit_weight, elem->item) = weight;
 }
 
 static int count_interesting_parents(struct commit *commit, unsigned bisect_flags)
@@ -163,7 +169,7 @@ static void show_list(const char *debug, int counted, int nr,
 			(commit_flags & TREESAME) ? ' ' : 'T',
 			(commit_flags & UNINTERESTING) ? 'U' : ' ',
 			(commit_flags & COUNTED) ? 'C' : ' ');
-		if (*commit_weight_at(&commit_weight, p->item))
+		if (has_weight(p))
 			fprintf(stderr, "%3d", weight(p));
 		else
 			fprintf(stderr, "---");
-- 
2.26.2

