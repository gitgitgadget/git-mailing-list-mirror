From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2 1/3] Refactor print_state into get_state
Date: Mon, 29 Oct 2012 19:31:51 -0400
Message-ID: <1351553513-20385-2-git-send-email-hordp@cisco.com>
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
	id 1TSyov-0008Ny-7c
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 00:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761295Ab2J2XcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 19:32:21 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:32416 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761248Ab2J2XcU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 19:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2493; q=dns/txt; s=iport;
  t=1351553540; x=1352763140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Yur8lIvBpvLYF9J7SA8ysUSEZ7SdHzu6RcOBJeufxOI=;
  b=SFbxrzhXBtcPROCsmSLlywRyKMzZpmqa4R1fGF0+crTb0jlGIP5DNJCO
   PBTkaVj7y2GJIoqiIhdM+yBQ7qwUtnwZ6RHbY8KRO4ZWUMkG1nUrHrE9X
   Cw/AVSnW1FOWcBO2TqqmZ8xFewF8hrmaLpKUrOLXx+eEx5NfguQCRH0US
   0=;
X-IronPort-AV: E=Sophos;i="4.80,675,1344211200"; 
   d="scan'208";a="136660363"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by rcdn-iport-8.cisco.com with ESMTP; 29 Oct 2012 23:32:19 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core2-4.cisco.com (8.14.5/8.14.5) with ESMTP id q9TNWEaS022087;
	Mon, 29 Oct 2012 23:32:19 GMT
X-Mailer: git-send-email 1.8.0.3.gde9c7d5.dirty
In-Reply-To: <1351553513-20385-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208657>

Recently git-status learned to display the state of the git
sequencer in long form to help the user remember an interrupted
command.  This information is useful to other callers who do
not want it printed in the same way.

Split the new print_state function into separate get_state and
print_state functions so others can get this state info and
share common code.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 wt-status.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 2a9658b..760f52b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -928,34 +928,41 @@ static void show_bisect_in_progress(struct wt_status *s,
 	wt_status_print_trailer(s);
 }
 
-static void wt_status_print_state(struct wt_status *s)
+static void wt_status_get_state(struct wt_status *s , struct wt_status_state *state)
 {
-	const char *state_color = color(WT_STATUS_HEADER, s);
-	struct wt_status_state state;
 	struct stat st;
 
-	memset(&state, 0, sizeof(state));
+	memset(state, 0, sizeof(*state));
 
+	/* Determine sequencer activity */
 	if (!stat(git_path("MERGE_HEAD"), &st)) {
-		state.merge_in_progress = 1;
+		state->merge_in_progress = 1;
 	} else if (!stat(git_path("rebase-apply"), &st)) {
 		if (!stat(git_path("rebase-apply/applying"), &st)) {
-			state.am_in_progress = 1;
+			state->am_in_progress = 1;
 			if (!stat(git_path("rebase-apply/patch"), &st) && !st.st_size)
-				state.am_empty_patch = 1;
+				state->am_empty_patch = 1;
 		} else {
-			state.rebase_in_progress = 1;
+			state->rebase_in_progress = 1;
 		}
 	} else if (!stat(git_path("rebase-merge"), &st)) {
 		if (!stat(git_path("rebase-merge/interactive"), &st))
-			state.rebase_interactive_in_progress = 1;
+			state->rebase_interactive_in_progress = 1;
 		else
-			state.rebase_in_progress = 1;
+			state->rebase_in_progress = 1;
 	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st)) {
-		state.cherry_pick_in_progress = 1;
+		state->cherry_pick_in_progress = 1;
 	}
 	if (!stat(git_path("BISECT_LOG"), &st))
-		state.bisect_in_progress = 1;
+		state->bisect_in_progress = 1;
+}
+
+static void wt_status_print_state(struct wt_status *s)
+{
+	const char *state_color = color(WT_STATUS_HEADER, s);
+	struct wt_status_state state;
+
+	wt_status_get_state(s, &state);
 
 	if (state.merge_in_progress)
 		show_merge_in_progress(s, &state, state_color);
-- 
1.8.0.3.gde9c7d5.dirty
