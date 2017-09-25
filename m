Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300A520281
	for <e@80x24.org>; Mon, 25 Sep 2017 10:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934562AbdIYKL2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 06:11:28 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:55487 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933254AbdIYKLM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 06:11:12 -0400
Received: from lindisfarne.localdomain ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id wQLndvDfQbjdZwQM2dIVIT; Mon, 25 Sep 2017 11:11:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1506334271; bh=jM4vjP/GCEm+9kM5DIdFColXBzozFlV3oXVGckpvdoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=oxVjJcceT18nDbL/TvPT0rEN/PcAGx0KreihB5FHxIt1BIHOb+tLM2kvWA5Q+3DI5
         UYjauXOGOAQapVXvKiC2/h0RWfaJvA1Qlg4ChY6sGsyJI7/KWlEgaj3btdoanmozSY
         /CoC6m8sMyr0rA16FsF9C0TvDR+4yk1kF36oS7RI=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=evINK-nbAAAA:8 a=1t1SZKGulBb1P22x9lcA:9
 a=QIIWfnGowwY90MVa:21 a=I3sJyM1zcK1xxs81:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 3/8] sequencer: refactor update_head()
Date:   Mon, 25 Sep 2017 11:10:36 +0100
Message-Id: <20170925101041.18344-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfIWqKAlxHRWCWcZm7WHZ8F0sx+eFim2jzqPb1II80KIh4EruqYkJafJcAk4ILrbMdpBMP8RlkH3wnnTcFc7piNDOFy5b/hDm2GSv/1OkQPHSe5QFHQff
 3EwllEH2LmI/KrfzuGluuTsLaFFhpJxkHjQVysz2Am9sdYRYJKlEo9494R3Di4FAZLx8v7BEz25vQpE3cnAk97C8Cl5XlShPbnET1RReL727gTYbIbwXFGNJ
 5rzfDwIZpHKgVGiFCj/PkqTQZpByxV0AQZSu7wZqHOA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The previous commit was a mechanical translation of the code from
builtin/commit.c. Now that it uses its own strbuf for the reflog
message it can be simplified slightly.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 917ad4a16216b30adb2c2c9650217926d8db8ba7..1795a4df2a0021b2419d941c6083e49cd6647314 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -759,8 +759,9 @@ int update_head(const struct commit *old_head, const struct object_id *new_head,
 	int ret = 0;
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
-	if (!reflog_msg)
-		reflog_msg="";
+	if (reflog_msg)
+		strbuf_addstr(&sb, reflog_msg);
+	strbuf_addstr(&sb, ": ");
 
 	nl = strchr(msg->buf, '\n');
 	if (nl) {
@@ -769,8 +770,6 @@ int update_head(const struct commit *old_head, const struct object_id *new_head,
 		strbuf_addbuf(&sb, msg);
 		strbuf_addch(&sb, '\n');
 	}
-	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
-	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
 	transaction = ref_transaction_begin(err);
 	if (!transaction ||
-- 
2.14.1

