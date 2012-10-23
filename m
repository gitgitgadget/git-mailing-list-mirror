From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2] git-status: show short sequencer state
Date: Tue, 23 Oct 2012 16:02:54 -0400
Message-ID: <1351022574-27869-2-git-send-email-hordp@cisco.com>
References: <1351022574-27869-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Junio C Hamano <gitster@pobox.com>,
	konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 22:21:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQkyp-0008NB-P7
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 22:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903Ab2JWUV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 16:21:27 -0400
Received: from mtv-iport-3.cisco.com ([173.36.130.14]:22982 "EHLO
	mtv-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965006Ab2JWUND (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 16:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=13245; q=dns/txt;
  s=iport; t=1351023183; x=1352232783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uKK4Z8UmRSCrh84w3X2HdLIr6WRjc23xCzCaoCu1+U0=;
  b=UX9HUZt1QTnzcrrTIkWQJq7vRs/S/GVw48CV3Os/W7SzsfSNi2774Og8
   K9RKgwcNg81nS2hkAXZ7UF/DdFuGC8XjUeaIIRNX8Ps7tyU9Kj5xCr4O4
   Vb3I1GtZVwg49wrWiLYoE/eHRNYZ5Sl7opYtSXnLw80CNtLbpGdjvORVI
   U=;
X-IronPort-AV: E=Sophos;i="4.80,637,1344211200"; 
   d="scan'208";a="59524043"
Received: from mtv-core-1.cisco.com ([171.68.58.6])
  by mtv-iport-3.cisco.com with ESMTP; 23 Oct 2012 20:03:27 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by mtv-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id q9NK3FWH014242;
	Tue, 23 Oct 2012 20:03:26 GMT
X-Mailer: git-send-email 1.8.0.2.gc921d59.dirty
In-Reply-To: <1351022574-27869-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208242>

Recently git-status learned to display the state of the git
sequencer in long form to help the user remember an interrupted
command.  This information is also useful in short form to
humans and scripts, but no option is available to boil it down.

Teach git-status to report the sequencer state in short form
using a new --sequencer (-S) switch.  Output zero or more
simple state token strings indicating the deduced state of the
git sequencer.

Introduce a common function to determine the current sequencer
state so the regular status function and this short version can
share common code.

Add a substate to wt_status_state to track more detailed
information about a state, such as "conflicted" or "resolved".
Move the am_empty_patch flage out of wt_status_state and into
this new substate.

State token strings which may be emitted and their meanings:
    merge              a git-merge is in progress
    am                 a git-am is in progress
    rebase             a git-rebase is in progress
    rebase-interactive a git-rebase--interactive is in progress
    cherry-pick        a git-cherry-pick is in progress
    bisect             a git-bisect is in progress
    conflicted         there are unresolved conflicts
    resolved           conflicts have been resolved
    editing            interactive rebase stopped to edit a commit
    edited             interactive rebase edit has been edited
    splitting          interactive rebase, commit is being split

I also considered adding these tokens, but I decided it was not
appropriate since these changes are not sequencer-related.  But
it is possible I am being too short-sighted or have chosen the
switch name poorly.
    clean
    index
    modified
    untracked

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 Documentation/git-status.txt |  18 +++++++
 builtin/commit.c             |  12 ++++-
 wt-status.c                  | 125 +++++++++++++++++++++++++++++++++++--------
 wt-status.h                  |  14 ++++-
 4 files changed, 145 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 67e5f53..31ffabd 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -38,6 +38,24 @@ OPTIONS
 	across git versions and regardless of user configuration. See
 	below for details.
 
+-S::
+--sequence::
+	Show the git sequencer status. This shows zero or more tokens
+	describing the state of several git sequence operations. Each
+	token is separated by a newline.
++
+	merge              a merge is in progress
+	am                 an am is in progress
+	rebase             a rebase is in progress
+	rebase-interactive an interactive rebase is in progress
+	cherry-pick        a cherry-pick is in progress
+	bisect             a bisect is in progress
+	conflicted         there are unresolved conflicts
+	resolved           conflicts have been resolved
+	editing            interactive rebase stopped to edit a commit
+	edited             interactive rebase edit has been edited
+	splitting          interactive rebase, commit is being split
+
 -u[<mode>]::
 --untracked-files[=<mode>]::
 	Show untracked files.
diff --git a/builtin/commit.c b/builtin/commit.c
index a17a5df..9706ed9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -114,7 +114,8 @@ static struct strbuf message = STRBUF_INIT;
 static enum {
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
-	STATUS_FORMAT_PORCELAIN
+	STATUS_FORMAT_PORCELAIN,
+	STATUS_FORMAT_SEQUENCER
 } status_format = STATUS_FORMAT_LONG;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
@@ -454,6 +455,9 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(s);
 		break;
+	case STATUS_FORMAT_SEQUENCER:
+		wt_sequencer_print(s);
+		break;
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
 		break;
@@ -1156,6 +1160,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			    N_("show status concisely"), STATUS_FORMAT_SHORT),
 		OPT_BOOLEAN('b', "branch", &s.show_branch,
 			    N_("show branch information")),
+		OPT_SET_INT('S', "sequence", &status_format,
+				N_("show sequencer state"),
+				STATUS_FORMAT_SEQUENCER),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"),
 			    STATUS_FORMAT_PORCELAIN),
@@ -1216,6 +1223,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s);
 		break;
+	case STATUS_FORMAT_SEQUENCER:
+		wt_sequencer_print(&s);
+		break;
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
 		s.ignore_submodule_arg = ignore_submodule_arg;
diff --git a/wt-status.c b/wt-status.c
index 2a9658b..81d91e3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -781,7 +781,7 @@ static void show_merge_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
 {
-	if (has_unmerged(s)) {
+	if (state->substate == WT_SUBSTATE_CONFLICTED) {
 		status_printf_ln(s, color, _("You have unmerged paths."));
 		if (advice_status_hints)
 			status_printf_ln(s, color,
@@ -802,11 +802,11 @@ static void show_am_in_progress(struct wt_status *s,
 {
 	status_printf_ln(s, color,
 		_("You are in the middle of an am session."));
-	if (state->am_empty_patch)
+	if (state->substate == WT_SUBSTATE_AM_EMPTY)
 		status_printf_ln(s, color,
 			_("The current patch is empty."));
 	if (advice_status_hints) {
-		if (!state->am_empty_patch)
+		if (state->substate == WT_SUBSTATE_CONFLICTED)
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git am --resolved\")"));
 		status_printf_ln(s, color,
@@ -867,9 +867,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
 {
-	struct stat st;
-
-	if (has_unmerged(s)) {
+	if (state->substate == WT_SUBSTATE_CONFLICTED) {
 		status_printf_ln(s, color, _("You are currently rebasing."));
 		if (advice_status_hints) {
 			status_printf_ln(s, color,
@@ -879,19 +877,19 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --abort\" to check out the original branch)"));
 		}
-	} else if (state->rebase_in_progress || !stat(git_path("MERGE_MSG"), &st)) {
+	} else if (state->substate == WT_SUBSTATE_RESOLVED) {
 		status_printf_ln(s, color, _("You are currently rebasing."));
 		if (advice_status_hints)
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
-	} else if (split_commit_in_progress(s)) {
+	} else if (state->substate == WT_SUBSTATE_SPLITTING) {
 		status_printf_ln(s, color, _("You are currently splitting a commit during a rebase."));
 		if (advice_status_hints)
 			status_printf_ln(s, color,
 				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
 	} else {
 		status_printf_ln(s, color, _("You are currently editing a commit during a rebase."));
-		if (advice_status_hints && !s->amend) {
+		if (advice_status_hints && state->substate == WT_SUBSTATE_EDITING) {
 			status_printf_ln(s, color,
 				_("  (use \"git commit --amend\" to amend the current commit)"));
 			status_printf_ln(s, color,
@@ -907,7 +905,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 {
 	status_printf_ln(s, color, _("You are currently cherry-picking."));
 	if (advice_status_hints) {
-		if (has_unmerged(s))
+		if (state->substate == WT_SUBSTATE_CONFLICTED)
 			status_printf_ln(s, color,
 				_("  (fix conflicts and run \"git commit\")"));
 		else
@@ -928,34 +926,68 @@ static void show_bisect_in_progress(struct wt_status *s,
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
 
+	// Determine main sequencer activity
 	if (!stat(git_path("MERGE_HEAD"), &st)) {
-		state.merge_in_progress = 1;
+		state->merge_in_progress = 1;
 	} else if (!stat(git_path("rebase-apply"), &st)) {
 		if (!stat(git_path("rebase-apply/applying"), &st)) {
-			state.am_in_progress = 1;
+			state->am_in_progress = 1;
 			if (!stat(git_path("rebase-apply/patch"), &st) && !st.st_size)
-				state.am_empty_patch = 1;
+				state->substate = WT_SUBSTATE_AM_EMPTY;
+			else
+				state->substate = WT_SUBSTATE_CONFLICTED;
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
+
+	// Check for unmerged files
+	if (state->rebase_in_progress || state->rebase_interactive_in_progress ||
+			state->cherry_pick_in_progress || state->merge_in_progress) {
+		if (has_unmerged(s)) {
+			state->substate = WT_SUBSTATE_CONFLICTED;
+		} else {
+			state->substate = WT_SUBSTATE_RESOLVED;
+		}
+	}
+
+	// Interactive Rebase is more nuanced
+	if (state->rebase_interactive_in_progress && state->substate != WT_SUBSTATE_CONFLICTED) {
+		if (!stat(git_path("MERGE_MSG"), &st)) {
+			state->substate = WT_SUBSTATE_RESOLVED;
+		} else if (split_commit_in_progress(s)) {
+			state->substate = WT_SUBSTATE_SPLITTING;
+		} else {
+			if (s->amend) {
+				state->substate = WT_SUBSTATE_EDITED;
+			} else {
+				state->substate = WT_SUBSTATE_EDITING;
+			}
+		}
+	}
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
@@ -1192,6 +1224,55 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
 
+static void wt_print_token(struct wt_status *s, const char *token)
+{
+	fprintf(s->fp, "%s", token);
+	fputc(s->null_termination ? '\0' : '\n', s->fp);
+}
+
+void wt_sequencer_print(struct wt_status *s)
+{
+	struct wt_status_state state;
+
+	wt_status_get_state(s, &state);
+
+	if (state.merge_in_progress)
+		wt_print_token(s, "merge");
+	if (state.am_in_progress)
+		wt_print_token(s, "am");
+	if (state.rebase_in_progress)
+		wt_print_token(s, "rebase");
+	if (state.rebase_interactive_in_progress)
+		wt_print_token(s, "rebase-interactive");
+	if (state.cherry_pick_in_progress)
+		wt_print_token(s, "cherry-pick");
+	if (state.bisect_in_progress)
+		wt_print_token(s, "bisect");
+
+	switch (state.substate) {
+	case WT_SUBSTATE_NOMINAL:
+		break;
+	case WT_SUBSTATE_CONFLICTED:
+		wt_print_token(s, "conflicted");
+		break;
+	case WT_SUBSTATE_RESOLVED:
+		wt_print_token(s, "resolved");
+		break;
+	case WT_SUBSTATE_EDITED:
+		wt_print_token(s, "edited");
+		break;
+	case WT_SUBSTATE_EDITING:
+		wt_print_token(s, "editing");
+		break;
+	case WT_SUBSTATE_SPLITTING:
+		wt_print_token(s, "splitting");
+		break;
+	case WT_SUBSTATE_AM_EMPTY:
+		wt_print_token(s, "am-empty");
+		break;
+	}
+}
+
 void wt_shortstatus_print(struct wt_status *s)
 {
 	int i;
diff --git a/wt-status.h b/wt-status.h
index 236b41f..900889c 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -59,6 +59,7 @@ struct wt_status {
 	unsigned colopts;
 	int null_termination;
 	int show_branch;
+	int show_sequencer;
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
@@ -71,14 +72,24 @@ struct wt_status {
 	struct string_list ignored;
 };
 
+enum wt_status_substate {
+	WT_SUBSTATE_NOMINAL = 0,
+	WT_SUBSTATE_CONFLICTED,
+	WT_SUBSTATE_RESOLVED,
+	WT_SUBSTATE_SPLITTING,
+	WT_SUBSTATE_EDITING,
+	WT_SUBSTATE_EDITED,
+	WT_SUBSTATE_AM_EMPTY,
+};
+
 struct wt_status_state {
 	int merge_in_progress;
 	int am_in_progress;
-	int am_empty_patch;
 	int rebase_in_progress;
 	int rebase_interactive_in_progress;
 	int cherry_pick_in_progress;
 	int bisect_in_progress;
+	enum wt_status_substate substate;
 };
 
 void wt_status_prepare(struct wt_status *s);
@@ -86,6 +97,7 @@ void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 
 void wt_shortstatus_print(struct wt_status *s);
+void wt_sequencer_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
 
 void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...)
-- 
1.8.0.2.gc921d59.dirty
