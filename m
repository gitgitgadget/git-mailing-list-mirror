From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv3 3/4] git-status: show short sequencer state
Date: Fri,  9 Nov 2012 13:56:24 -0500
Message-ID: <1352487385-5929-4-git-send-email-hordp@cisco.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 09 19:57:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWtlN-0001tk-Jk
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 19:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265Ab2KIS4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 13:56:52 -0500
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:42879 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848Ab2KIS4u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 13:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=7534; q=dns/txt; s=iport;
  t=1352487410; x=1353697010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=y8+1rNnB9uYd/a0DiEY9d+hhm0fM3YwqlvGoGKEl9aU=;
  b=f6PG9FxrNQ+9ONdmOa/iIiEvRY45muU+tbnVcL3Hn5CWA7xJr8JePibY
   IrvE46yTGTOUCOTgz1Lheus2tqYw2/3OQ1V0Kpgg+Lh58WOmGbH+Pmje4
   nBGpC7GHuXORTgCFjJvpLSyZhjp/tIqKtG+WMBO+3RNMx/SzubnCVJ3KV
   0=;
X-IronPort-AV: E=McAfee;i="5400,1158,6891"; a="140645408"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-2.cisco.com with ESMTP; 09 Nov 2012 18:56:49 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id qA9IudCF020062;
	Fri, 9 Nov 2012 18:56:49 GMT
X-Mailer: git-send-email 1.8.0.3.gde9c7d5.dirty
In-Reply-To: <1352487385-5929-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209240>

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
 Documentation/git-status.txt | 20 ++++++++++++++++++++
 builtin/commit.c             | 14 ++++++++++++++
 wt-status.c                  | 34 ++++++++++++++++++++++++++++++++++
 wt-status.h                  |  7 +++++++
 4 files changed, 75 insertions(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 67e5f53..bdacf08 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -38,6 +38,26 @@ OPTIONS
 	across git versions and regardless of user configuration. See
 	below for details.
 
+-S::
+--sequence::
+	Show the git sequencer status. This shows zero or more words
+	describing the state of the git sequencer. If --short is also
+	given, the words are shown at the beginning of the short-format
+	display after the one-line branch information, if present.  If
+	--short is not given, then only the sequencer words are shown
+	with no other status information.
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
index a888120..71da1fb 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1201,6 +1201,33 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
 
+static void wt_print_token(struct wt_status *s, const char *token, int active)
+{
+	if (active) {
+		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## %s", prefix, token);
+		fputc(s->null_termination ? '\0' : '\n', s->fp);
+	}
+}
+
+static void wt_sequencer_print(struct wt_status *s)
+{
+	struct wt_status_state state;
+
+	wt_status_get_state(s, &state);
+
+	wt_print_token(s, "merge", state.merge_in_progress);
+	wt_print_token(s, "am", state.am_in_progress);
+	wt_print_token(s, "rebase", state.rebase_in_progress);
+	wt_print_token(s, "rebase-interactive", state.rebase_interactive_in_progress);
+	wt_print_token(s, "cherry-pick", state.cherry_pick_in_progress);
+	wt_print_token(s, "bisect", state.bisect_in_progress);
+	wt_print_token(s, "am-empty", state.am_empty_patch);
+
+	wt_print_token(s, "conflicted", state.has_unmerged);
+	wt_print_token(s, "commit-pending", state.commit_is_pending);
+	wt_print_token(s, "splitting", state.split_in_progress);
+}
+
 void wt_shortstatus_print(struct wt_status *s)
 {
 	int i;
@@ -1208,6 +1235,13 @@ void wt_shortstatus_print(struct wt_status *s)
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
