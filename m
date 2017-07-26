Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E573120899
	for <e@80x24.org>; Wed, 26 Jul 2017 10:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbdGZK1l (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 06:27:41 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:15482 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdGZK1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 06:27:40 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id aJXGd63uhZtcPaJXWd3j2I; Wed, 26 Jul 2017 11:27:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501064859; bh=ZIc3otd0EJ8F5Ek77YeepPFdzzBhBJBoyzvXY0/BHG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=StcHV5sNCziO5V/IImx8qmbyIXZaNcwO/MsZKGBz299aiKqJPzzH6T9W5RHZ3oZBj
         141sDGZy0sLV9a7LjWUiSNN+kizUEYqW96Bp5xt9ajxVExk84pa+6oPkHOM6Fc6WBs
         rgVzUMfDXZhT2GpajRVqLfYekl24mhQvvs5zngec=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=QqEc5h6d c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=Vhf1OWbMW8mthwVbdR0A:9
 a=91LYUdq4JGXBUgOX:21 a=3DAUHYATGIe0lcSQ:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 3/5] Unify rebase amend message when HEAD has changed
Date:   Wed, 26 Jul 2017 11:27:18 +0100
Message-Id: <20170726102720.15274-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170726102720.15274-1-phillip.wood@talktalk.net>
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHJp2uKygfPZYpv/Bt8nlB0sXQvCxsCuCTwZmPSt+0MHSnUoeKJp3w/H+bmzZws11Hy5Y4sSyK7sNf7/V54oOIC/MSfz+S/xc5ck5vCX7xBlwbhWgnaz
 xUdotXfxitJYpy8ZM1oHUTjYlxjsenaiNG2qkDSifJaK0BuA2czdan4cuQ4VcJ8EuoiaNMr1OhoNoMRBDYj6xSU+pPhnvvqFACO1tEnEBtVcacBVErNGJ6mS
 rzNY/ZuzOQtRp4rVa1Dxr/mtOmPuobj64bWhHtmnJs4WYRvAbJpdSXP/Oc26ZSih
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If rebase --interactive is unable to commit staged changes because
HEAD has changed since rebase stopped the user gets different messages
depending on whether they specified --autostage or not. Update the
messages in the other code paths to match the --autostage one.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

The change from error() to fprintf() is to keep the messages consistent,
maybe the messages in the shell script should be prefixed with
'error:' instead.

 git-rebase--interactive.sh | 10 ++++++----
 sequencer.c                | 22 +++++++++++++++++-----
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8140c88839b4f3a86f53faaaa2ba4433ecc7f58b..e1845e940b8de05b10b011d8167917a60a7c00b9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1164,10 +1164,12 @@ $(unstaged_advice)"
 			die "$(gettext "Error trying to find the author identity to amend commit")"
 		if test -n "$amend_head"
 		then
-			test -n "$amend_ok" ||
-			die "$(gettext "\
-You have uncommitted changes in your working tree. Please commit them
-first and then run 'git rebase --continue' again.")"
+			test -n "$amend_ok" || {
+				gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
+				die "$(gettext "\
+Unable to commit changes as HEAD has changed since git rebase stopped.")
+$(staged_advice)"
+			}
 			do_with_author git commit --amend --no-verify -F "$msg" -e \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die "$(gettext "Could not commit staged changes.")"
diff --git a/sequencer.c b/sequencer.c
index 3010faf86398697469e903318a35421d911acb23..2722d36781e5c47ee81eb3359aa6178042430e68 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2214,12 +2214,24 @@ static int commit_staged_changes(struct replay_opts *opts)
 		if (get_sha1_hex(rev.buf, to_amend))
 			return error(_("invalid contents: '%s'"),
 				rebase_path_amend());
-		if (hashcmp(head, to_amend))
-			return error(_("\nYou have uncommitted changes in your "
-				       "working tree. Please, commit them\n"
-				       "first and then run 'git rebase "
-				       "--continue' again."));
+		if (hashcmp(head, to_amend)) {
+			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
+			fprintf(stderr, _(
+"Unable to commit changes as HEAD has changed since git rebase stopped.\n"
+"If you wish to squash the changes into the last commit, run:\n"
+"\n"
+"  git commit --amend %s\n"
+"\n"
+"If they are meant to go into a new commit, run:\n"
+"\n"
+"  git commit %s\n"
+"\n"
+"In both cases, once you're done, continue with:\n"
+"\n"
+"  git rebase --continue\n"), gpg_opt, gpg_opt);
+			return -1;
+		}
 		strbuf_release(&rev);
 		flags |= AMEND_MSG;
 	}
-- 
2.13.3

