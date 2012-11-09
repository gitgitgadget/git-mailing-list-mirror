From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv3 1/4] Refactor print_state into get_state
Date: Fri,  9 Nov 2012 13:56:22 -0500
Message-ID: <1352487385-5929-2-git-send-email-hordp@cisco.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 09 19:57:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWtlE-0001mn-Ob
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 19:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab2KIS4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 13:56:45 -0500
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:32395 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab2KIS4o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 13:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2493; q=dns/txt; s=iport;
  t=1352487404; x=1353697004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Yur8lIvBpvLYF9J7SA8ysUSEZ7SdHzu6RcOBJeufxOI=;
  b=DMxQBAJiKo26ZyEiyvyDTCXj6nYJM3PCUJ0Nnp/53+MIhKv2lCO9ViGa
   H5IZqUkHRfDigXd7K+5hVsv0YmE1FjLyBOUVv4muo40V1BsJGZci3Z8v3
   o7XN56QmQtUwGapHKzqk0rhIOdcXF2ovM5+a6E7vgamhZPIHdJSZ/WaFT
   o=;
X-IronPort-AV: E=McAfee;i="5400,1158,6891"; a="140665326"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-7.cisco.com with ESMTP; 09 Nov 2012 18:56:44 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id qA9IudCD020062;
	Fri, 9 Nov 2012 18:56:43 GMT
X-Mailer: git-send-email 1.8.0.3.gde9c7d5.dirty
In-Reply-To: <1352487385-5929-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209238>

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
