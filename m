Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MSGID_NOFQDN1,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 16289 invoked by uid 107); 14 Jun 2012 08:20:32 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Thu, 14 Jun 2012 04:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925Ab2FNIUW (ORCPT <rfc822;peff@peff.net>);
	Thu, 14 Jun 2012 04:20:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48929 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753056Ab2FNIUU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 04:20:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5E8B2JU023608
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 10:11:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sf5Hr-0006X7-VI; Thu, 14 Jun 2012 10:20:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sf5Hr-0007rJ-Sg; Thu, 14 Jun 2012 10:20:15 +0200
From:	y@imag.fr
To:	git@vger.kernel.org, gitster@pobox.com
Cc:	Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] fixup! 8e00b48 don't allocate struct wt_status_state dynamically
Date:	Thu, 14 Jun 2012 10:20:13 +0200
Message-Id: <1339662014-30173-1-git-send-email-y>
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <7vk3zag6jg.fsf@alter.siamese.dyndns.org>
References: <7vk3zag6jg.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 14 Jun 2012 10:11:02 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: q5E8B2JU023608
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check:	1340266263.03484@aWzg1QdnAlaPtmfLH7aaog
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Matthieu Moy <Matthieu.Moy@imag.fr>

The common

void function() {
	struct wt_status_state *state = calloc(...);
	...
	free(state);
}

is essentially a less efficient, and more error prone way of allocating a
variable on the stack (plus, the calloc should have been a xcalloc).
Replace it with an on-stack variable.

While we're there, also replace the individual initializations of fields
with memset(..., 0, ...).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

(BTW, I didn't find a way to have both --autosquash-compliant and
meaningfull titles)

 wt-status.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ed28b4f..e65716d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -932,49 +932,42 @@ static void show_bisect_in_progress(struct wt_status *s,
 static void wt_status_print_state(struct wt_status *s)
 {
 	const char *state_color = color(WT_STATUS_IN_PROGRESS, s);
-	struct wt_status_state *state = calloc(1, sizeof(*state));
+	struct wt_status_state state;
 	struct stat st;
 
-	state->merge_in_progress = 0;
-	state->am_in_progress = 0;
-	state->am_empty_patch = 0;
-	state->rebase_in_progress = 0;
-	state->rebase_interactive_in_progress = 0;
-	state->cherry_pick_in_progress = 0;
-	state->bisect_in_progress = 0;
+	memset(&state, 0, sizeof(state));
 
 	if (!stat(git_path("MERGE_HEAD"), &st)) {
-		state->merge_in_progress = 1;
+		state.merge_in_progress = 1;
 	} else if (!stat(git_path("rebase-apply"), &st)) {
 		if (!stat(git_path("rebase-apply/applying"), &st)) {
-			state->am_in_progress = 1;
+			state.am_in_progress = 1;
 			if (!stat(git_path("rebase-apply/patch"), &st) && !st.st_size)
-				state->am_empty_patch = 1;
+				state.am_empty_patch = 1;
 		} else {
-			state->rebase_in_progress = 1;
+			state.rebase_in_progress = 1;
 		}
 	} else if (!stat(git_path("rebase-merge"), &st)) {
 		if (!stat(git_path("rebase-merge/interactive"), &st))
-			state->rebase_interactive_in_progress = 1;
+			state.rebase_interactive_in_progress = 1;
 		else
-			state->rebase_in_progress = 1;
+			state.rebase_in_progress = 1;
 	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st)) {
-		state->cherry_pick_in_progress = 1;
+		state.cherry_pick_in_progress = 1;
 	}
 	if (!stat(git_path("BISECT_LOG"), &st))
-		state->bisect_in_progress = 1;
-
-	if (state->merge_in_progress)
-		show_merge_in_progress(s, state, state_color);
-	else if (state->am_in_progress)
-		show_am_in_progress(s, state, state_color);
-	else if (state->rebase_in_progress || state->rebase_interactive_in_progress)
-		show_rebase_in_progress(s, state, state_color);
-	else if (state->cherry_pick_in_progress)
-		show_cherry_pick_in_progress(s, state, state_color);
-	if (state->bisect_in_progress)
-		show_bisect_in_progress(s, state, state_color);
-	free(state);
+		state.bisect_in_progress = 1;
+
+	if (state.merge_in_progress)
+		show_merge_in_progress(s, &state, state_color);
+	else if (state.am_in_progress)
+		show_am_in_progress(s, &state, state_color);
+	else if (state.rebase_in_progress || state.rebase_interactive_in_progress)
+		show_rebase_in_progress(s, &state, state_color);
+	else if (state.cherry_pick_in_progress)
+		show_cherry_pick_in_progress(s, &state, state_color);
+	if (state.bisect_in_progress)
+		show_bisect_in_progress(s, &state, state_color);
 }
 
 void wt_status_print(struct wt_status *s)
-- 
1.7.11.rc0.57.g84a04c7

