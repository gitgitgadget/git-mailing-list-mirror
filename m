Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A0FC433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDA961A8A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhKRQxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57642 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhKRQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7C1911FD3D
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0xoVlPsVNNDIwvOw/PW3D9wabAqSlx7T7hqMqsMcyQ=;
        b=H2764KhGu/8HGUyXi0HkOeZwbqMVAHHS1R6oQAp/x+k4nDzrCiQ8twd6EXedpfjrcP8gq7
        dHEUShG/69eZT2sQlBG3pHRDTdsOpZKltm7vITKTaDBR21Bi8Yidj132wPp2xcHHiJ/t0t
        Z2BCUNrSxvf2Uu/CztCmuZJz3Bwkzzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0xoVlPsVNNDIwvOw/PW3D9wabAqSlx7T7hqMqsMcyQ=;
        b=itoawXYHSUfsYcnefNVy53jJn4S6tDp2QE74Dx0umXskk9/GBUf5ua6NICY8fNefAMjQFd
        0TCe+DPBtB2dMdBg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 63C6FA3B92;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 963591F2CAA; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 11/27] bisect: Fix bisection debugging
Date:   Thu, 18 Nov 2021 17:49:24 +0100
Message-Id: <20211118164940.8818-12-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

show_list() dumps commit weights associated with each commit. Thus it
needs commit_weight slab already initialized. Move initialization of
commit_weight slab before the first show_list() call.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 888949fba6b5..ab264b8ca879 100644
--- a/bisect.c
+++ b/bisect.c
@@ -395,8 +395,8 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	struct commit_list *list, *p, *best, *next, *last;
 	int *weights;
 
-	show_list("bisection 2 entry", 0, 0, *commit_list);
 	init_commit_weight(&commit_weight);
+	show_list("bisection 2 entry", 0, 0, *commit_list);
 
 	/*
 	 * Count the number of total and tree-changing items on the
-- 
2.26.2

