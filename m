Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C731F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 13:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934973AbcIFNNG (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 09:13:06 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:32827 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932893AbcIFNNG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2016 09:13:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1475A20299;
        Tue,  6 Sep 2016 09:13:05 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 06 Sep 2016 09:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-sasl-enc:x-sasl-enc; s=mesmtp; bh=pDIxvZBqjpXzBB8YpbZ5J61Nboo
        =; b=JwhMGBMU/Wv5S5k2961rCJRyPOgULRF58EYVoXdP/qh1Y6ZqvXO7gMBTRuE
        bUwAjRX7cvSCrOp1hlROXvPxFgWOxY2gGTmnRKPdmnvk38QYMilGpWc1xUQxcq+C
        nnJH365Q/fcqdlbTCkaQWOFKYqZB24kAgjIPp4D+GpoLht9c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=pDIx
        vZBqjpXzBB8YpbZ5J61Nboo=; b=GcrS8F2Sf09rBNw6kavhQ7sT32WvoiG+JGmO
        q8xFcIRhPDRRq+Bh71Gjk8KI1BgzWXmweQWRXJKKToAoBN8FfOw73t5hUvqD3Hza
        aGSViKRezkWQz8z0I7k77Ze7o15fIbMlVUaBl6jZ+7Bd0NCCyDwtYzlB1C7i15CO
        ZBx81O8=
X-Sasl-enc: nK1I3whEUHdWjxNkM8BdVB1SU7kRgF6InlVXp1XFDIu+ 1473167584
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8908CCC021;
        Tue,  6 Sep 2016 09:13:04 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gpg-interface: reflect stderr to stderr
Date:   Tue,  6 Sep 2016 15:13:03 +0200
Message-Id: <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.10.0.rc2.333.g8ef2d05
In-Reply-To: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

efee955 ("gpg-interface: check gpg signature creation status",
2016-06-17) used stderr to capture gpg's status output, which is the
only reliable way for status checks. As a side effect, stderr was not
shown to the user any more.

In case of a gpg error, reflect the whole captured buffer to stderr.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
A full blown approach would use --status-fd=4 or such rather than hijacking stderr.
This would require an extension of pipe_command() etc. to handle yet another fd.

 gpg-interface.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 8672eda..cf35bca 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -173,9 +173,12 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	sigchain_pop(SIGPIPE);
 
 	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
-	strbuf_release(&gpg_status);
-	if (ret)
+	if (ret) {
+		fputs(gpg_status.buf, stderr);
+		strbuf_release(&gpg_status);
 		return error(_("gpg failed to sign the data"));
+	}
+	strbuf_release(&gpg_status);
 
 	/* Strip CR from the line endings, in case we are on Windows. */
 	for (i = j = bottom; i < signature->len; i++)
-- 
2.10.0.rc2.333.g8ef2d05

