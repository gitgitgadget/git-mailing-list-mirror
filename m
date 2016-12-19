Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1DB1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762421AbcLSRBj (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:01:39 -0500
Received: from [192.252.130.194] ([192.252.130.194]:5691 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1762460AbcLSRBi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:01:38 -0500
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 949C9602E7;
        Mon, 19 Dec 2016 12:01:37 -0500 (EST)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Chris Packham <judge.packham@gmail.com>,
        Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Tweak help auto-correct phrasing.
Date:   Mon, 19 Dec 2016 12:01:37 -0500
Message-Id: <20161219170137.5507-1-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.11.0.dirty
In-Reply-To: <CAFOYHZDnpzdYq9j4-xGSdKZQX9deLBpZZhz209qV7cCtq537SA@mail.gmail.com>
References: <CAFOYHZDnpzdYq9j4-xGSdKZQX9deLBpZZhz209qV7cCtq537SA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

On 2016-12-18 07:48 PM, Chris Packham wrote:
>
> This feature already exists (although it's not interactive). See
> help.autoCorrect in the git-config man page. "git config
> help.autoCorrect -1" should to the trick.

Awesome, I was unaware of this feature.  Thanks!

I found the message it prints a bit awkward, so here's a patch to fix it up.

Instead of:

   WARNING: You called a Git command named 'lgo', which does not exist.
   Continuing under the assumption that you meant 'log'
   in 1.5 seconds automatically...

it's now:

   WARNING: You called a Git command named 'lgo', which does not exist.
   Continuing in 1.5 seconds under the assumption that you meant 'log'.

		M.

 help.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/help.c b/help.c
index 53e2a67e00..55350c0673 100644
--- a/help.c
+++ b/help.c
@@ -381,12 +381,18 @@ const char *help_unknown_cmd(const char *cmd)
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
+				   _("Continuing in %0.1f seconds under the "
+				     "assumption that you meant '%s'."),
+				   (float)autocorrect/10.0, assumed);
 			sleep_millisec(autocorrect * 100);
 		}
 		return assumed;
-- 
2.11.0.dirty

