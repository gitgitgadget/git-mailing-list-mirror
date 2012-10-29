From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2 2/3] wt-status: More state retrieval abstraction
Date: Mon, 29 Oct 2012 19:31:52 -0400
Message-ID: <1351553513-20385-3-git-send-email-hordp@cisco.com>
References: <CABURp0qBRvZQvnBbOraQ7c7DRg8v0TjnY+MOGYaWnWwjCqi23Q@mail.gmail.com>
 <1351553513-20385-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 00:32:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSyov-0008Ny-NG
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 00:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761321Ab2J2Xc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 19:32:27 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:54290 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761029Ab2J2XcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 19:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3110; q=dns/txt; s=iport;
  t=1351553545; x=1352763145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xdMG8Y5Y4papeZSbwoKpV0pSmIDn+VsOs+xaRq2Itrg=;
  b=MVABv7YQTeL6guMEaKIsUPZKXGXiMXGsXjbT4+4QcTN+Q8yBTtgEkobp
   escv8xlh4QrI3HBAU2OCSFplJxMDuhY37zyq8XLxCEClUYqgMJE0+KZtv
   12DEYi7RdO6HyayzcnaV1pcWFAEW3KbIGZcy9Y1pljetGGjv3LdQMtrZO
   o=;
X-IronPort-AV: E=Sophos;i="4.80,675,1344211200"; 
   d="scan'208";a="133659706"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by rcdn-iport-9.cisco.com with ESMTP; 29 Oct 2012 23:32:25 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core2-4.cisco.com (8.14.5/8.14.5) with ESMTP id q9TNWEaT022087;
	Mon, 29 Oct 2012 23:32:24 GMT
X-Mailer: git-send-email 1.8.0.3.gde9c7d5.dirty
In-Reply-To: <1351553513-20385-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208658>

wt_status_print_state retrieves some sequencer state
information via wt_status_get_state, but other state
information it deduces on its own.  Replaces these
"local knowledge" deductions with wt_status variables
so we can share more common code in the future.
---
 wt-status.c | 16 +++++++++-------
 wt-status.h |  3 +++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 760f52b..a888120 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -781,7 +781,7 @@ static void show_merge_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
 {
-	if (has_unmerged(s)) {
+	if (state->has_unmerged) {
 		status_printf_ln(s, color, _("You have unmerged paths."));
 		if (advice_status_hints)
 			status_printf_ln(s, color,
@@ -867,9 +867,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
 {
-	struct stat st;
-
-	if (has_unmerged(s)) {
+	if (state->has_unmerged) {
 		status_printf_ln(s, color, _("You are currently rebasing."));
 		if (advice_status_hints) {
 			status_printf_ln(s, color,
@@ -879,12 +877,12 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --abort\" to check out the original branch)"));
 		}
-	} else if (state->rebase_in_progress || !stat(git_path("MERGE_MSG"), &st)) {
+	} else if (state->rebase_in_progress || state->commit_is_pending) {
 		status_printf_ln(s, color, _("You are currently rebasing."));
 		if (advice_status_hints)
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
-	} else if (split_commit_in_progress(s)) {
+	} else if (state->split_in_progress) {
 		status_printf_ln(s, color, _("You are currently splitting a commit during a rebase."));
 		if (advice_status_hints)
 			status_printf_ln(s, color,
@@ -907,7 +905,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 {
 	status_printf_ln(s, color, _("You are currently cherry-picking."));
 	if (advice_status_hints) {
-		if (has_unmerged(s))
+		if (state->has_unmerged)
 			status_printf_ln(s, color,
 				_("  (fix conflicts and run \"git commit\")"));
 		else
@@ -955,6 +953,10 @@ static void wt_status_get_state(struct wt_status *s , struct wt_status_state *st
 	}
 	if (!stat(git_path("BISECT_LOG"), &st))
 		state->bisect_in_progress = 1;
+
+	state->has_unmerged = has_unmerged(s);
+	state->split_in_progress = split_commit_in_progress(s);
+	state->commit_is_pending = !stat(git_path("MERGE_MSG"), &st);
 }
 
 static void wt_status_print_state(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index 236b41f..0b866a2 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -79,6 +79,9 @@ struct wt_status_state {
 	int rebase_interactive_in_progress;
 	int cherry_pick_in_progress;
 	int bisect_in_progress;
+	int split_in_progress;
+	int has_unmerged;
+	int commit_is_pending;
 };
 
 void wt_status_prepare(struct wt_status *s);
-- 
1.8.0.3.gde9c7d5.dirty
