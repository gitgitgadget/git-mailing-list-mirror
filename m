Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411101F991
	for <e@80x24.org>; Wed,  2 Aug 2017 10:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbdHBKov (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 06:44:51 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:20384 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbdHBKou (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 06:44:50 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id cr8nd8nSUiSHacr8ydwins; Wed, 02 Aug 2017 11:44:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501670689; bh=5IkzOWBmAOsMTZeSnYdPnsHBExXyeqLfEdTQyUSVcPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=pylThXBt9CoBlEQ/5MTPpdtS1t8+wBFG1FtY/W0mg4SrfzuemxMix0YylTzJYI1Wh
         pqSFm3YML8Ob5DBVeWuLP/U4zNN7p+0/8mlK/hoR8kn7hA7RftdnygKD+8CNwnhNsH
         eGbzhSiPJMc+PasC2EGQ7TGrVuq+/+i1IJlvajRo=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=nN53kmj_4rbOlxUli4MA:9
 a=lg3XbccdkaWyW6yr:21 a=nMBdqodhwWIVy9En:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/6] am: remember --rerere-autoupdate setting
Date:   Wed,  2 Aug 2017 11:44:15 +0100
Message-Id: <20170802104420.12809-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170802104420.12809-1-phillip.wood@talktalk.net>
References: <20170802104420.12809-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfF6fWZIVaOiFSYBjC/Gxl8S6yJ08Rz3yIex//sDF/XiAdK07nMR4nmGMzAQKSfVLK5GHn4zInnyYx/VmLTVyvLVtZmytS3jgJbZ1ICgAGl2lfTIubPoD
 DtJDbypgZIfYFZehKKyPLBNbcMHLiwfR8zuyCOxExIOqIVoAXcGddVjwQWiFyS3YUGG89eyQalOpREROfTIV4q1vPk8TZG0AgAC0IaQYWfBN69aGzpZliIP/
 urQEJXngqoYPL/cRdR2gLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Save the rerere-autoupdate setting so that it is remembered after
stopping for the user to resolve conflicts.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

There are no new tests, but this code is exercised by the new rebase
tests in the next patch.

builtin/am.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index c973bd96dcb5d630d56e935733bfa4530ccd2872..6962d4db5ffceef3022b7f877a43c8833a839b31 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -431,6 +431,14 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "utf8", 1);
 	state->utf8 = !strcmp(sb.buf, "t");
 
+	if (file_exists(am_path(state, "rerere-autoupdate"))) {
+		read_state_file(&sb, state, "rerere-autoupdate", 1);
+		state->allow_rerere_autoupdate = strcmp(sb.buf, "t") ?
+			RERERE_NOAUTOUPDATE : RERERE_AUTOUPDATE;
+	} else {
+		state->allow_rerere_autoupdate = 0;
+	}
+
 	read_state_file(&sb, state, "keep", 1);
 	if (!strcmp(sb.buf, "t"))
 		state->keep = KEEP_TRUE;
@@ -1003,6 +1011,10 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	write_state_bool(state, "sign", state->signoff);
 	write_state_bool(state, "utf8", state->utf8);
 
+	if (state->allow_rerere_autoupdate)
+		write_state_bool(state, "rerere-autoupdate",
+			 state->allow_rerere_autoupdate == RERERE_AUTOUPDATE);
+
 	switch (state->keep) {
 	case KEEP_FALSE:
 		str = "f";
-- 
2.13.3

