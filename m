Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FB2C28B2B
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 13:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbiHRNOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244971AbiHRNNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 09:13:47 -0400
Received: from mailproxy01.manitu.net (mailproxy01.manitu.net [217.11.48.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4E0B1BA1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:13:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a5d:5400:e242:9824:2cff:8bd5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy01.manitu.net (Postfix) with ESMTPSA id C30E912600A4;
        Thu, 18 Aug 2022 15:13:30 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/4] sequencer: do not translate reflog messages
Date:   Thu, 18 Aug 2022 15:13:26 +0200
Message-Id: <ea6c65c254bb08b20ea6c4d81200b847755b555c.1660828108.git.git@grubix.eu>
X-Mailer: git-send-email 2.37.2.596.g72ccb331cf
In-Reply-To: <cover.1660828108.git.git@grubix.eu>
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr> <cover.1660828108.git.git@grubix.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Traditionally, reflog messages were never translated, in particular not
on storage.

Due to the switch of more parts of git to the sequencer, old changes in
the sequencer code may lead to recent changes in git's behaviour. E.g.:
c28cbc5ea6 ("sequencer: mark action_name() for translation", 2016-10-21)
marked several uses of `action_name()` for translation. Recently, this
lead to a partially translated reflog:

`rebase: fast-forward` is translated (e.g. in de to `Rebase: Vorspulen`)
whereas other reflog entries such as `rebase (pick):` remain
untranslated as they should be.

Change the relevant line in the sequencer so that this reflog entry
remains untranslated, as well.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 5f22b7cd37..51d75dfbe1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -575,7 +575,7 @@ static int fast_forward_to(struct repository *r,
 	if (checkout_fast_forward(r, from, to, 1))
 		return -1; /* the callee should have complained already */
 
-	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
+	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-- 
2.37.2.596.g72ccb331cf

