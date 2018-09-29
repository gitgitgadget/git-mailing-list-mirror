Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE9D1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 18:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeI3BZQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:25:16 -0400
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:54337 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbeI3BZO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:25:14 -0400
Received: from fed1rmimpo210.cox.net ([68.230.241.161])
          by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180929185541.DFGK4225.fed1rmfepo102.cox.net@fed1rmimpo210.cox.net>
          for <git@vger.kernel.org>; Sat, 29 Sep 2018 14:55:41 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo210.cox.net with cox
        id hWvg1y00259yGBo01WvgPq; Sat, 29 Sep 2018 14:55:40 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090206.5BAFCAAC.003E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=Xd09M7x5 c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10 a=5rxgeBVgAAAA:8
 a=vZxbLtyPAAAA:8 a=kviXuzpPAAAA:8 a=sUB6SAAZ1j8wgdlQ-SEA:9
 a=PwKx63F5tFurRwaNxrlG:22 a=YIznc7gRMHvxYRuyG5Sm:22 a=qrIFiuKZe2vaD64auk6j:22
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id DD40229A00EE;
        Sat, 29 Sep 2018 11:55:39 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Git List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/1] roll wt_status_state into wt_status and populate in the collect phase
Date:   Sat, 29 Sep 2018 11:55:39 -0700
Message-Id: <20180929185539.4144-2-ischis2@cox.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180929185539.4144-1-ischis2@cox.net>
References: <xmqq4le9cvy6.fsf@gitster-ct.c.googlers.com>
 <20180929185539.4144-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Status variables were initialized in the collect phase and some
variables were later freed in the print functions.

A "struct wt_status" used to be sufficient for the output phase to
work.  It was designed to be filled in the collect phase and consumed
in the output phase, but over time some fields were added and output
phase started filling the fields.

A "struct wt_status_state" that was used in other codepaths turned out
to be useful in the "git status" output.  This is not tied to "struct
wt_status", so filling in the collect phase was not consistently
followed.

Move the status state structure variables into the status state
structure and populate them in the collect functions.

Create a new funciton to free the buffers that were being freed in the
print function.  Call this new function in commit.c where both the
collect and print functions were being called.

Based on a patch suggestion by Junio C Hamano. [1]

[1] https://public-inbox.org/git/xmqqr2i5ueg4.fsf@gitster-ct.c.googlers.com/

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 builtin/commit.c |   3 ++
 wt-status.c      | 134 +++++++++++++++++++++--------------------------
 wt-status.h      |  38 +++++++-------
 3 files changed, 82 insertions(+), 93 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d6efd996f8..c91af2fe38 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -508,6 +508,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 
 	wt_status_collect(s);
 	wt_status_print(s);
+	wt_status_collect_free_buffers(s);
 
 	return s->committable;
 }
@@ -1390,6 +1391,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		s.prefix = prefix;
 
 	wt_status_print(&s);
+	wt_status_collect_free_buffers(&s);
+
 	return 0;
 }
 
diff --git a/wt-status.c b/wt-status.c
index 1822e95f65..cc3e84b997 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -744,21 +744,25 @@ static int has_unmerged(struct wt_status *s)
 
 void wt_status_collect(struct wt_status *s)
 {
-	struct wt_status_state state;
 	wt_status_collect_changes_worktree(s);
-
 	if (s->is_initial)
 		wt_status_collect_changes_initial(s);
 	else
 		wt_status_collect_changes_index(s);
 	wt_status_collect_untracked(s);
 
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
-	if (state.merge_in_progress && !has_unmerged(s))
+	wt_status_get_state(&s->state, s->branch && !strcmp(s->branch, "HEAD"));
+	if (s->state.merge_in_progress && !has_unmerged(s))
 		s->committable = 1;
 }
 
+void wt_status_collect_free_buffers(struct wt_status *s)
+{
+	free(s->state.branch);
+	free(s->state.onto);
+	free(s->state.detached_from);
+}
+
 static void wt_longstatus_print_unmerged(struct wt_status *s)
 {
 	int shown_header = 0;
@@ -1087,8 +1091,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 }
 
 static void show_merge_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
-				const char *color)
+				   const char *color)
 {
 	if (has_unmerged(s)) {
 		status_printf_ln(s, color, _("You have unmerged paths."));
@@ -1109,16 +1112,15 @@ static void show_merge_in_progress(struct wt_status *s,
 }
 
 static void show_am_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
 				const char *color)
 {
 	status_printf_ln(s, color,
 		_("You are in the middle of an am session."));
-	if (state->am_empty_patch)
+	if (s->state.am_empty_patch)
 		status_printf_ln(s, color,
 			_("The current patch is empty."));
 	if (s->hints) {
-		if (!state->am_empty_patch)
+		if (!s->state.am_empty_patch)
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git am --continue\")"));
 		status_printf_ln(s, color,
@@ -1242,10 +1244,9 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 }
 
 static void show_rebase_information(struct wt_status *s,
-					struct wt_status_state *state,
-					const char *color)
+				    const char *color)
 {
-	if (state->rebase_interactive_in_progress) {
+	if (s->state.rebase_interactive_in_progress) {
 		int i;
 		int nr_lines_to_show = 2;
 
@@ -1296,28 +1297,26 @@ static void show_rebase_information(struct wt_status *s,
 }
 
 static void print_rebase_state(struct wt_status *s,
-				struct wt_status_state *state,
-				const char *color)
+			       const char *color)
 {
-	if (state->branch)
+	if (s->state.branch)
 		status_printf_ln(s, color,
 				 _("You are currently rebasing branch '%s' on '%s'."),
-				 state->branch,
-				 state->onto);
+				 s->state.branch,
+				 s->state.onto);
 	else
 		status_printf_ln(s, color,
 				 _("You are currently rebasing."));
 }
 
 static void show_rebase_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
-				const char *color)
+				    const char *color)
 {
 	struct stat st;
 
-	show_rebase_information(s, state, color);
+	show_rebase_information(s, color);
 	if (has_unmerged(s)) {
-		print_rebase_state(s, state, color);
+		print_rebase_state(s, color);
 		if (s->hints) {
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git rebase --continue\")"));
@@ -1326,17 +1325,18 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --abort\" to check out the original branch)"));
 		}
-	} else if (state->rebase_in_progress || !stat(git_path_merge_msg(the_repository), &st)) {
-		print_rebase_state(s, state, color);
+	} else if (s->state.rebase_in_progress ||
+		   !stat(git_path_merge_msg(the_repository), &st)) {
+		print_rebase_state(s, color);
 		if (s->hints)
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
 	} else if (split_commit_in_progress(s)) {
-		if (state->branch)
+		if (s->state.branch)
 			status_printf_ln(s, color,
 					 _("You are currently splitting a commit while rebasing branch '%s' on '%s'."),
-					 state->branch,
-					 state->onto);
+					 s->state.branch,
+					 s->state.onto);
 		else
 			status_printf_ln(s, color,
 					 _("You are currently splitting a commit during a rebase."));
@@ -1344,11 +1344,11 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
 	} else {
-		if (state->branch)
+		if (s->state.branch)
 			status_printf_ln(s, color,
 					 _("You are currently editing a commit while rebasing branch '%s' on '%s'."),
-					 state->branch,
-					 state->onto);
+					 s->state.branch,
+					 s->state.onto);
 		else
 			status_printf_ln(s, color,
 					 _("You are currently editing a commit during a rebase."));
@@ -1363,11 +1363,10 @@ static void show_rebase_in_progress(struct wt_status *s,
 }
 
 static void show_cherry_pick_in_progress(struct wt_status *s,
-					struct wt_status_state *state,
-					const char *color)
+					 const char *color)
 {
 	status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
-			find_unique_abbrev(&state->cherry_pick_head_oid, DEFAULT_ABBREV));
+			find_unique_abbrev(&s->state.cherry_pick_head_oid, DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1382,11 +1381,10 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 }
 
 static void show_revert_in_progress(struct wt_status *s,
-					struct wt_status_state *state,
-					const char *color)
+				    const char *color)
 {
 	status_printf_ln(s, color, _("You are currently reverting commit %s."),
-			 find_unique_abbrev(&state->revert_head_oid, DEFAULT_ABBREV));
+			 find_unique_abbrev(&s->state.revert_head_oid, DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1401,13 +1399,12 @@ static void show_revert_in_progress(struct wt_status *s,
 }
 
 static void show_bisect_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
-				const char *color)
+				    const char *color)
 {
-	if (state->branch)
+	if (s->state.branch)
 		status_printf_ln(s, color,
 				 _("You are currently bisecting, started from branch '%s'."),
-				 state->branch);
+				 s->state.branch);
 	else
 		status_printf_ln(s, color,
 				 _("You are currently bisecting."));
@@ -1581,48 +1578,45 @@ void wt_status_get_state(struct wt_status_state *state,
 		wt_status_get_detached_from(state);
 }
 
-static void wt_longstatus_print_state(struct wt_status *s,
-				      struct wt_status_state *state)
+static void wt_longstatus_print_state(struct wt_status *s)
 {
 	const char *state_color = color(WT_STATUS_HEADER, s);
+	struct wt_status_state *state = &s->state;
+
 	if (state->merge_in_progress)
-		show_merge_in_progress(s, state, state_color);
+		show_merge_in_progress(s, state_color);
 	else if (state->am_in_progress)
-		show_am_in_progress(s, state, state_color);
+		show_am_in_progress(s, state_color);
 	else if (state->rebase_in_progress || state->rebase_interactive_in_progress)
-		show_rebase_in_progress(s, state, state_color);
+		show_rebase_in_progress(s, state_color);
 	else if (state->cherry_pick_in_progress)
-		show_cherry_pick_in_progress(s, state, state_color);
+		show_cherry_pick_in_progress(s, state_color);
 	else if (state->revert_in_progress)
-		show_revert_in_progress(s, state, state_color);
+		show_revert_in_progress(s, state_color);
 	if (state->bisect_in_progress)
-		show_bisect_in_progress(s, state, state_color);
+		show_bisect_in_progress(s, state_color);
 }
 
 static void wt_longstatus_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
-	struct wt_status_state state;
-
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state,
-			    s->branch && !strcmp(s->branch, "HEAD"));
 
 	if (s->branch) {
 		const char *on_what = _("On branch ");
 		const char *branch_name = s->branch;
 		if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color = color(WT_STATUS_NOBRANCH, s);
-			if (state.rebase_in_progress || state.rebase_interactive_in_progress) {
-				if (state.rebase_interactive_in_progress)
+			if (s->state.rebase_in_progress ||
+			    s->state.rebase_interactive_in_progress) {
+				if (s->state.rebase_interactive_in_progress)
 					on_what = _("interactive rebase in progress; onto ");
 				else
 					on_what = _("rebase in progress; onto ");
-				branch_name = state.onto;
-			} else if (state.detached_from) {
-				branch_name = state.detached_from;
-				if (state.detached_at)
+				branch_name = s->state.onto;
+			} else if (s->state.detached_from) {
+				branch_name = s->state.detached_from;
+				if (s->state.detached_at)
 					on_what = _("HEAD detached at ");
 				else
 					on_what = _("HEAD detached from ");
@@ -1639,10 +1633,7 @@ static void wt_longstatus_print(struct wt_status *s)
 			wt_longstatus_print_tracking(s);
 	}
 
-	wt_longstatus_print_state(s, &state);
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
+	wt_longstatus_print_state(s);
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
@@ -1946,13 +1937,9 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 	struct branch *branch;
 	const char *base;
 	const char *branch_name;
-	struct wt_status_state state;
 	int ab_info, nr_ahead, nr_behind;
 	char eol = s->null_termination ? '\0' : '\n';
 
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
-
 	fprintf(s->fp, "# branch.oid %s%c",
 			(s->is_initial ? "(initial)" : sha1_to_hex(s->sha1_commit)),
 			eol);
@@ -1963,10 +1950,11 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		if (!strcmp(s->branch, "HEAD")) {
 			fprintf(s->fp, "# branch.head %s%c", "(detached)", eol);
 
-			if (state.rebase_in_progress || state.rebase_interactive_in_progress)
-				branch_name = state.onto;
-			else if (state.detached_from)
-				branch_name = state.detached_from;
+			if (s->state.rebase_in_progress ||
+			    s->state.rebase_interactive_in_progress)
+				branch_name = s->state.onto;
+			else if (s->state.detached_from)
+				branch_name = s->state.detached_from;
 			else
 				branch_name = "";
 		} else {
@@ -2000,10 +1988,6 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 			}
 		}
 	}
-
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
 }
 
 /*
diff --git a/wt-status.h b/wt-status.h
index 937b2c3521..1fcf93afbf 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -64,6 +64,24 @@ enum wt_status_format {
 	STATUS_FORMAT_UNSPECIFIED
 };
 
+struct wt_status_state {
+	int merge_in_progress;
+	int am_in_progress;
+	int am_empty_patch;
+	int rebase_in_progress;
+	int rebase_interactive_in_progress;
+	int cherry_pick_in_progress;
+	int bisect_in_progress;
+	int revert_in_progress;
+	int detached_at;
+	char *branch;
+	char *onto;
+	char *detached_from;
+	struct object_id detached_oid;
+	struct object_id revert_head_oid;
+	struct object_id cherry_pick_head_oid;
+};
+
 struct wt_status {
 	int is_initial;
 	char *branch;
@@ -93,6 +111,7 @@ struct wt_status {
 	int rename_score;
 	int rename_limit;
 	enum wt_status_format status_format;
+	struct wt_status_state state;
 	unsigned char sha1_commit[GIT_MAX_RAWSZ]; /* when not Initial */
 
 	/* These are computed during processing of the individual sections */
@@ -107,29 +126,12 @@ struct wt_status {
 	uint32_t untracked_in_ms;
 };
 
-struct wt_status_state {
-	int merge_in_progress;
-	int am_in_progress;
-	int am_empty_patch;
-	int rebase_in_progress;
-	int rebase_interactive_in_progress;
-	int cherry_pick_in_progress;
-	int bisect_in_progress;
-	int revert_in_progress;
-	int detached_at;
-	char *branch;
-	char *onto;
-	char *detached_from;
-	struct object_id detached_oid;
-	struct object_id revert_head_oid;
-	struct object_id cherry_pick_head_oid;
-};
-
 size_t wt_status_locate_end(const char *s, size_t len);
 void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
+void wt_status_collect_free_buffers(struct wt_status *s);
 void wt_status_get_state(struct wt_status_state *state, int get_detached_from);
 int wt_status_check_rebase(const struct worktree *wt,
 			   struct wt_status_state *state);
-- 
2.19.0

