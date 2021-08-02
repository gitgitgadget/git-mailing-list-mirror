Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD07C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC96610A8
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhHBRAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:00:48 -0400
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:63860 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhHBRAr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Aug 2021 13:00:47 -0400
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B56E034321D;
        Mon,  2 Aug 2021 17:00:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (100-96-17-210.trex-nlb.outbound.svc.cluster.local [100.96.17.210])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BCE0834311E;
        Mon,  2 Aug 2021 17:00:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.17.210 (trex/6.3.3);
        Mon, 02 Aug 2021 17:00:30 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Coil-Illegal: 7c743dea60dab45a_1627923620497_2507938047
X-MC-Loop-Signature: 1627923620497:2026378103
X-MC-Ingress-Time: 1627923620496
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTP id 84DB4806B8;
        Mon,  2 Aug 2021 10:00:18 -0700 (PDT)
Received: from corey.lan (unknown [98.113.183.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTPSA id 747A0806B4;
        Mon,  2 Aug 2021 10:00:17 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a13
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, novalis@novalis.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v2 3/3] diff --submodule=diff: Don't print failure message twice
Date:   Mon,  2 Aug 2021 13:00:04 -0400
Message-Id: <20210802170004.4103535-3-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
In-Reply-To: <20210802170004.4103535-1-dturner@twosigma.com>
References: <20210802170004.4103535-1-dturner@twosigma.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we fail to start a diff command inside a submodule, immediately
exit the routine rather than trying to finish the command and printing
a second message.

Signed-off-by: David Turner <dturner@twosigma.com>
---
 submodule.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index d13d103975..2e98e840af 100644
--- a/submodule.c
+++ b/submodule.c
@@ -720,8 +720,10 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		strvec_push(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT "=.");
 	}
 
-	if (start_command(&cp))
+	if (start_command(&cp)) {
 		diff_emit_submodule_error(o, "(diff failed)\n");
+		goto done;
+	}
 
 	while (strbuf_getwholeline_fd(&sb, cp.out, '\n') != EOF)
 		diff_emit_submodule_pipethrough(o, sb.buf, sb.len);
-- 
2.11.GIT

