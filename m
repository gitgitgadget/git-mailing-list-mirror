From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv3 2/4] wt-status: Teach sequencer advice to use get_state
Date: Fri,  9 Nov 2012 13:56:23 -0500
Message-ID: <1352487385-5929-3-git-send-email-hordp@cisco.com>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 19:57:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWtlF-0001mn-9K
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 19:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128Ab2KIS4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 13:56:49 -0500
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:28755 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab2KIS4t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 13:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3108; q=dns/txt; s=iport;
  t=1352487409; x=1353697009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=RpJaPP1I3hEIArY6msioWxCkFuuH4WfINCyyGyXhYUc=;
  b=F06kdhYtxEGSkl1xejGJWTqttn7LEgTiAeQVqvsoRkqUUxJEme4fXgxQ
   9MaW76bQLEf3PJ2vl/Obk+eP9AqfG6YUS8fBPdXEmDDDoAa676Ucc0YLF
   dhMUwlrzxYYKuNqisO5qyExLvqnBiXPv8ycfSunXf4qguXTq2GHu603zg
   c=;
X-IronPort-AV: E=McAfee;i="5400,1158,6891"; a="140667180"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-8.cisco.com with ESMTP; 09 Nov 2012 18:56:48 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id qA9IudCE020062;
	Fri, 9 Nov 2012 18:56:48 GMT
X-Mailer: git-send-email 1.8.0.3.gde9c7d5.dirty
In-Reply-To: <1352487385-5929-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209239>

wt_status_print_state retrieves some sequencer state information via
wt_status_get_state, but other state information it deduces on its
own.  Replace these "local knowledge" deductions with wt_status
variables so we can share more common code in the future.
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
