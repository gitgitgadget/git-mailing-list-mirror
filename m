Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA28E207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046270AbdDWViD (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:38:03 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37430 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046194AbdDWVgi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:36:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 769FC280E0;
        Sun, 23 Apr 2017 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983343;
        bh=sLx4lrzrjT/44jONwHHhS5n/1/hDjS2rj1FcHXt1CkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZNZsfYCeKka/xIWTPrWQuK4aACoc/bhSbKMaURimihuLtMRBgAfXUEJ36uK+N3qz
         DYUr/ZQFmN/Qf4IC5XCDFXIF7eUGZCRDkSzvZFwmySPwvXXl8iQooO6Td7vHzzET9G
         FBjcjIAGA6oM4dUOIK7wPZoXkP8UXiikiwKib7w7fC3TBA1dJZWKxxgyHYfs1Yq+Od
         DWyE4YO3wSuAKo47ooAT/0jdA0ql0S/HVIr8oYPGDVbVqKjvWGuWlZC5v4NDxIi8Rf
         F1eZpuRID0T9FRSAcVChTEp0s3vRbs/TkZCT69ArtDAmsoYUixakmiZPP1xCbCag0S
         blshoXdkZwnW22+7w7qzjpPvATRWu9Zdezff5qJ6fRPW6uXIAugUk58dLfmDCzk96P
         WO9OxY4joE2U944nDb6CxlauXD/oZ4p9AFtTMc0hmlpuaRhbbkWmmGMLoFzET8BqHq
         eek+V2iO5a+fA+r2aGapAgocLnuj32D9j0FN+ELcy6J3C1ZB/fV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 51/53] sequencer: convert do_recursive_merge to struct object_id
Date:   Sun, 23 Apr 2017 21:34:51 +0000
Message-Id: <20170423213453.253425-52-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This conversion is required to convert parse_tree_indirect.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index dfa44afa7..ed48c4c29 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -426,7 +426,7 @@ void append_conflicts_hint(struct strbuf *msgbuf)
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
 			      const char *base_label, const char *next_label,
-			      unsigned char *head, struct strbuf *msgbuf,
+			      struct object_id *head, struct strbuf *msgbuf,
 			      struct replay_opts *opts)
 {
 	struct merge_options o;
@@ -446,7 +446,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	if (is_rebase_i(opts))
 		o.buffer_output = 2;
 
-	head_tree = parse_tree_indirect(head);
+	head_tree = parse_tree_indirect(head->hash);
 	next_tree = next ? next->tree : empty_tree();
 	base_tree = base ? base->tree : empty_tree();
 
@@ -1081,7 +1081,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		res = -1;
 	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
-					 head.hash, &msgbuf, opts);
+					 &head, &msgbuf, opts);
 		if (res < 0)
 			return res;
 		res |= write_message(msgbuf.buf, msgbuf.len,
