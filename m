From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2 3/3] git-status: show short sequencer state
Date: Mon, 29 Oct 2012 19:31:53 -0400
Message-ID: <1351553513-20385-4-git-send-email-hordp@cisco.com>
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
X-From: git-owner@vger.kernel.org Tue Oct 30 00:32:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSyp3-00006U-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 00:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761322Ab2J2Xc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 19:32:29 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:29515 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761302Ab2J2Xc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 19:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=7480; q=dns/txt; s=iport;
  t=1351553547; x=1352763147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TRvTYaWtc1kR8xwzMvt3TUqmVLLS60FAIYH7BjpYOIg=;
  b=YH2npPZkTddGXVl+mn2j19LgzukE0NpNa+iHLWKwmduJKgfwHH6oSNx8
   W3HLHjHajaKm/iiTQTiF5SH4/E8P/Rty2aRG3doLJM3Mv4c5Hkeg1a8W1
   EkehFZrTK1cabjSIUYDwCNiDOxzVblUEHn+gN4+nf+TxKdM72WqKhlBW/
   k=;
X-IronPort-AV: E=Sophos;i="4.80,675,1344211200"; 
   d="scan'208";a="136659742"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by rcdn-iport-7.cisco.com with ESMTP; 29 Oct 2012 23:32:26 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core2-4.cisco.com (8.14.5/8.14.5) with ESMTP id q9TNWEaU022087;
	Mon, 29 Oct 2012 23:32:26 GMT
X-Mailer: git-send-email 1.8.0.3.gde9c7d5.dirty
In-Reply-To: <1351553513-20385-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208659>

Teach git-status to report the sequencer state in short form
using a new --sequencer (-S) switch.  Output zero or more
simple state token strings indicating the deduced state of the
git sequencer.

Sequencer state info tokens are displayed in "short"
form.  'git status --short -S' will show the normal short
status including the sequencer tokens.  'git status -S'
without --short will show only the new sequencer information
tokens in whatever the requested format is.

State token strings which may be emitted and their meanings:
    merge              a merge is in progress
    am                 an am is in progress
    am-is-empty        the am patch is empty
    rebase             a rebase is in progress
    rebase-interactive an interactive rebase is in progress
    cherry-pick        a cherry-pick is in progress
    bisect             a bisect is in progress
    conflicted         there are unresolved conflicts
    commit-pending     a commit operation is waiting to be completed
    splitting          interactive rebase, commit is being split

I also considered adding these tokens, but I decided it was not
appropriate since these changes are not sequencer-related.  But
it is possible I am being too short-sighted or have chosen the
switch name poorly.
    changed-index  Changes exist in the index
    changed-files  Changes exist in the working directory
    untracked      New files exist in the working directory

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 Documentation/git-status.txt | 16 ++++++++++++++++
 builtin/commit.c             | 14 ++++++++++++++
 wt-status.c                  | 35 +++++++++++++++++++++++++++++++++++
 wt-status.h                  |  7 +++++++
 4 files changed, 72 insertions(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 67e5f53..7a699f1 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -38,6 +38,22 @@ OPTIONS
 	across git versions and regardless of user configuration. See
 	below for details.
 
+-S::
+--sequence::
+	Show the git sequencer status. This shows zero or more strings
+	describing the state of the git sequencer.
++
+	merge              a merge is in progress
+	am                 an am is in progress
+	am-is-empty        the am patch is empty
+	rebase             a rebase is in progress
+	rebase-interactive an interactive rebase is in progress
+	cherry-pick        a cherry-pick is in progress
+	bisect             a bisect is in progress
+	conflicted         there are unresolved conflicts
+	commit-pending     a commit operation is waiting to be completed
+	splitting          interactive rebase, commit is being split
+
 -u[<mode>]::
 --untracked-files[=<mode>]::
 	Show untracked files.
diff --git a/builtin/commit.c b/builtin/commit.c
index a17a5df..bf16cc6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1060,6 +1060,11 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (s->null_termination && status_format == STATUS_FORMAT_LONG)
 		status_format = STATUS_FORMAT_PORCELAIN;
+	if (s->show_sequencer && status_format != STATUS_FORMAT_SHORT) {
+		s->show_sequencer = SHOW_SEQUENCER_ONLY;
+		if (status_format == STATUS_FORMAT_LONG)
+			status_format = STATUS_FORMAT_SHORT;
+	}
 	if (status_format != STATUS_FORMAT_LONG)
 		dry_run = 1;
 
@@ -1156,6 +1161,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			    N_("show status concisely"), STATUS_FORMAT_SHORT),
 		OPT_BOOLEAN('b', "branch", &s.show_branch,
 			    N_("show branch information")),
+		OPT_SET_INT('S', "sequencer", &s.show_sequencer,
+				N_("show sequencer state information"), SHOW_SEQUENCER_YES),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"),
 			    STATUS_FORMAT_PORCELAIN),
@@ -1188,6 +1195,11 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	if (s.null_termination && status_format == STATUS_FORMAT_LONG)
 		status_format = STATUS_FORMAT_PORCELAIN;
+	if (s.show_sequencer && status_format != STATUS_FORMAT_SHORT) {
+		s.show_sequencer = SHOW_SEQUENCER_ONLY;
+		if (status_format == STATUS_FORMAT_LONG)
+			status_format = STATUS_FORMAT_SHORT;
+	}
 
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
@@ -1384,6 +1396,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
 		OPT_BOOLEAN(0, "branch", &s.show_branch, N_("show branch information")),
+		OPT_SET_INT(0, "sequencer", &s.show_sequencer,
+			    N_("show sequencer state information"), SHOW_SEQUENCER_YES),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"), STATUS_FORMAT_PORCELAIN),
 		OPT_BOOLEAN('z', "null", &s.null_termination,
diff --git a/wt-status.c b/wt-status.c
index a888120..aee9745 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1201,6 +1201,34 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
 
+static void wt_print_token(struct wt_status *s, const char * token_color, const char *token, int active)
+{
+	if (active) {
+		color_fprintf(s->fp, token_color, "## %s", token);
+		fputc(s->null_termination ? '\0' : '\n', s->fp);
+	}
+}
+
+static void wt_sequencer_print(struct wt_status *s)
+{
+	struct wt_status_state state;
+	const char *header_color = color(WT_STATUS_HEADER, s);
+
+	wt_status_get_state(s, &state);
+
+	wt_print_token(s, header_color, "merge", state.merge_in_progress);
+	wt_print_token(s, header_color, "am", state.am_in_progress);
+	wt_print_token(s, header_color, "rebase", state.rebase_in_progress);
+	wt_print_token(s, header_color, "rebase-interactive", state.rebase_interactive_in_progress);
+	wt_print_token(s, header_color, "cherry-pick", state.cherry_pick_in_progress);
+	wt_print_token(s, header_color, "bisect", state.bisect_in_progress);
+	wt_print_token(s, header_color, "am-empty", state.am_empty_patch);
+
+	wt_print_token(s, header_color, "conflicted", state.has_unmerged);
+	wt_print_token(s, header_color, "commit-pending", state.commit_is_pending);
+	wt_print_token(s, header_color, "splitting", state.split_in_progress);
+}
+
 void wt_shortstatus_print(struct wt_status *s)
 {
 	int i;
@@ -1208,6 +1236,13 @@ void wt_shortstatus_print(struct wt_status *s)
 	if (s->show_branch)
 		wt_shortstatus_print_tracking(s);
 
+	if (s->show_sequencer)
+	{
+		wt_sequencer_print(s);
+		if (s->show_sequencer == SHOW_SEQUENCER_ONLY)
+			return;
+	}
+
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
diff --git a/wt-status.h b/wt-status.h
index 0b866a2..df4b36d 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -24,6 +24,12 @@ enum untracked_status_type {
 	SHOW_ALL_UNTRACKED_FILES
 };
 
+enum sequencer_status_type {
+	SHOW_SEQUENCER_NO=0,
+	SHOW_SEQUENCER_YES,
+	SHOW_SEQUENCER_ONLY
+};
+
 /* from where does this commit originate */
 enum commit_whence {
 	FROM_COMMIT,     /* normal */
@@ -59,6 +65,7 @@ struct wt_status {
 	unsigned colopts;
 	int null_termination;
 	int show_branch;
+	enum sequencer_status_type show_sequencer;
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
-- 
1.8.0.3.gde9c7d5.dirty
