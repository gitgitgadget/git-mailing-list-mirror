Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75536C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 15:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiHLPqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiHLPqb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 11:46:31 -0400
X-Greylist: delayed 463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Aug 2022 08:46:27 PDT
Received: from mailproxy02.manitu.net (mailproxy02.manitu.net [217.11.48.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05C086892
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 08:46:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a6c:a600:73d0:988f:9799:9957])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy02.manitu.net (Postfix) with ESMTPSA id 4C125C0646;
        Fri, 12 Aug 2022 17:38:41 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC/PATCH] sequencer: do not translate reflog messages
Date:   Fri, 12 Aug 2022 17:38:40 +0200
Message-Id: <b8ab40b2b0e3e5d762b414329ad2f4552f935d28.1660318162.git.git@grubix.eu>
X-Mailer: git-send-email 2.37.1.671.g27f8e4a42a
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
The patch also changes `action_name()` not to translate the names. This
makes no difference for `rebase: fast-forward` (I don't quite grok why
so far) but in any case, the callers mark the result of `action_name()`
(or do not mark it) so that the result itself should not be translated.
The full test suite passes either way.

RFC for my lack of full grasp of the relevant code paths.

 sequencer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5f22b7cd37..b456489590 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -395,11 +395,11 @@ static const char *action_name(const struct replay_opts *opts)
 {
 	switch (opts->action) {
 	case REPLAY_REVERT:
-		return N_("revert");
+		return "revert";
 	case REPLAY_PICK:
-		return N_("cherry-pick");
+		return "cherry-pick";
 	case REPLAY_INTERACTIVE_REBASE:
-		return N_("rebase");
+		return "rebase";
 	}
 	die(_("unknown action: %d"), opts->action);
 }
@@ -575,7 +575,7 @@ static int fast_forward_to(struct repository *r,
 	if (checkout_fast_forward(r, from, to, 1))
 		return -1; /* the callee should have complained already */
 
-	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
+	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-- 
2.37.1.671.g27f8e4a42a

