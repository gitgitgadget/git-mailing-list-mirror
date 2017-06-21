Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B232420401
	for <e@80x24.org>; Wed, 21 Jun 2017 14:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbdFUOE6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 10:04:58 -0400
Received: from [192.252.130.194] ([192.252.130.194]:12662 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750999AbdFUOEz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 10:04:55 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jun 2017 10:04:55 EDT
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 8EE9B60456;
        Wed, 21 Jun 2017 09:57:37 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Chris Packham <judge.packham@gmail.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCHv2 (resend)] Tweak help auto-correct phrasing.
Date:   Wed, 21 Jun 2017 09:57:38 -0400
Message-Id: <20170621135738.27948-1-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.13.1.388.g69e6b9b4f.dirty
In-Reply-To: <3164ca01-9b54-3c9b-96d8-182c9fbbceb9@xiplink.com>
References: <3164ca01-9b54-3c9b-96d8-182c9fbbceb9@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When auto-correct is enabled, an invalid git command prints a warning and
a continuation message, which differs depending on whether or not
help.autoCorrect is positive or negative.

With help.autoCorrect = 15:

   WARNING: You called a Git command named 'lgo', which does not exist.
   Continuing under the assumption that you meant 'log'
   in 1.5 seconds automatically...

With help.autoCorrect < 0:

   WARNING: You called a Git command named 'lgo', which does not exist.
   Continuing under the assumption that you meant 'log'

The continuation message's phrasing is awkward.  This commit cleans it up.
As a bonus, we now use full-sentence strings which make translation easier.

With help.autoCorrect = 15:

   WARNING: You called a Git command named 'lgo', which does not exist.
   Continuing in 1.5 seconds, assuming that you meant 'log'.

With help.autoCorrect < 0:

   WARNING: You called a Git command named 'lgo', which does not exist.
   Continuing under the assumption that you meant 'log'.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

So here's the patch again.

		M.

 help.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/help.c b/help.c
index f637fc800..69966c174 100644
--- a/help.c
+++ b/help.c
@@ -356,12 +356,18 @@ const char *help_unknown_cmd(const char *cmd)
 		clean_cmdnames(&main_cmds);
 		fprintf_ln(stderr,
 			   _("WARNING: You called a Git command named '%s', "
-			     "which does not exist.\n"
-			     "Continuing under the assumption that you meant '%s'"),
-			cmd, assumed);
-		if (autocorrect > 0) {
-			fprintf_ln(stderr, _("in %0.1f seconds automatically..."),
-				(float)autocorrect/10.0);
+			     "which does not exist."),
+			   cmd);
+		if (autocorrect < 0)
+			fprintf_ln(stderr,
+				   _("Continuing under the assumption that "
+				     "you meant '%s'."),
+				   assumed);
+		else {
+			fprintf_ln(stderr,
+				   _("Continuing in %0.1f seconds, "
+				     "assuming that you meant '%s'."),
+				   (float)autocorrect/10.0, assumed);
 			sleep_millisec(autocorrect * 100);
 		}
 		return assumed;
-- 
2.13.1.388.g69e6b9b4f.dirty

