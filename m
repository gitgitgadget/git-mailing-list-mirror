From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3] git status: Show detailed dirty status of submodules in
 long format
Date: Mon, 08 Mar 2010 13:53:19 +0100
Message-ID: <4B94F33F.2010208@web.de>
References: <4B90EB19.2070300@web.de> <7vtyssadtx.fsf@alter.siamese.dyndns.org> <4B9406A5.2090300@web.de> <7vvdd7yzzb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 13:53:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NocSh-0006NJ-1j
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 13:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab0CHMxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 07:53:23 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:53303 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab0CHMxW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 07:53:22 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0AEA0142DC265;
	Mon,  8 Mar 2010 13:53:20 +0100 (CET)
Received: from [80.128.106.67] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NocSV-0002HX-00; Mon, 08 Mar 2010 13:53:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <7vvdd7yzzb.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18b6sQ537dCc7QsrJoOOKhczQQssMqRiJkwhA0k
	uy/C7h4n9wZ6pgFbUrAg+fq1HHq7nPQ0JahKbCv+J7XubhRbJZ
	ep2uYjoOhswzuaV7KD9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141764>

Since 1.7.0 there are three reasons a submodule is considered modified
against the work tree: It contains new commits, modified content or
untracked content. Lets show all reasons in the long format of git status,
so the user can better asses the nature of the modification. This change
does not affect the short and porcelain formats.

Two new members are added to "struct wt_status_change_data" to store the
information gathered by run_diff_files(). wt-status.c uses the new flag
DIFF_OPT_DIRTY_SUBMODULES to tell diff-lib.c it wants to get detailed
dirty information about submodules.

A hint line for submodules is printed in the dirty header when dirty
submodules are present.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Changes since v2:
- Optimized handling of separator in output
- Added format string to color_fprintf()


 diff-lib.c                  |    6 ++++--
 diff.h                      |    1 +
 t/t7506-status-submodule.sh |    6 +++---
 wt-status.c                 |   43 ++++++++++++++++++++++++++++++++++++-------
 wt-status.h                 |    2 ++
 5 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 15ca7cd..63f8fcc 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -180,7 +180,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		changed = ce_match_stat(ce, &st, ce_option);
 		if (S_ISGITLINK(ce->ce_mode)
 		    && !DIFF_OPT_TST(&revs->diffopt, IGNORE_SUBMODULES)
-		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH))) {
+		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH)
+		        || DIFF_OPT_TST(&revs->diffopt, DIRTY_SUBMODULES))) {
 			dirty_submodule = is_submodule_modified(ce->name);
 			if (dirty_submodule)
 				changed = 1;
@@ -243,7 +244,8 @@ static int get_stat_data(struct cache_entry *ce,
 		changed = ce_match_stat(ce, &st, 0);
 		if (S_ISGITLINK(ce->ce_mode)
 		    && !DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)
-		    && (!changed || (diffopt->output_format & DIFF_FORMAT_PATCH))) {
+		    && (!changed || (diffopt->output_format & DIFF_FORMAT_PATCH)
+		        || DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES))) {
 			*dirty_submodule = is_submodule_modified(ce->name);
 			if (*dirty_submodule)
 				changed = 1;
diff --git a/diff.h b/diff.h
index 2ef3341..95ed7f8 100644
--- a/diff.h
+++ b/diff.h
@@ -69,6 +69,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
 #define DIFF_OPT_DIFF_FROM_CONTENTS  (1 << 22)
 #define DIFF_OPT_SUBMODULE_LOG       (1 << 23)
+#define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)

 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 253c334..1c8d32a 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -34,7 +34,7 @@ test_expect_success 'status with modified file in submodule' '
 	(cd sub && git reset --hard) &&
 	echo "changed" >sub/foo &&
 	git status >output &&
-	grep "modified:   sub" output
+	grep "modified:   sub (new commits, modified content)" output
 '

 test_expect_success 'status with modified file in submodule (porcelain)' '
@@ -49,7 +49,7 @@ test_expect_success 'status with modified file in submodule (porcelain)' '
 test_expect_success 'status with added file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
-	grep "modified:   sub" output
+	grep "modified:   sub (new commits, modified content)" output
 '

 test_expect_success 'status with added file in submodule (porcelain)' '
@@ -64,7 +64,7 @@ test_expect_success 'status with untracked file in submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	grep "modified:   sub" output
+	grep "modified:   sub (new commits, untracked content)" output
 '

 test_expect_success 'status with untracked file in submodule (porcelain)' '
diff --git a/wt-status.c b/wt-status.c
index 5807fc3..e0e915e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -78,7 +78,8 @@ static void wt_status_print_cached_header(struct wt_status *s)
 }

 static void wt_status_print_dirty_header(struct wt_status *s,
-					 int has_deleted)
+					 int has_deleted,
+					 int has_dirty_submodules)
 {
 	const char *c = color(WT_STATUS_HEADER, s);

@@ -90,6 +91,8 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 	else
 		color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" to update what will be committed)");
 	color_fprintf_ln(s->fp, c, "#   (use \"git checkout -- <file>...\" to discard changes in working directory)");
+	if (has_dirty_submodules)
+		color_fprintf_ln(s->fp, c, "#   (commit or discard the untracked or modified content in submodules)");
 	color_fprintf_ln(s->fp, c, "#");
 }

@@ -144,6 +147,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 	char *two_name;
 	const char *one, *two;
 	struct strbuf onebuf = STRBUF_INIT, twobuf = STRBUF_INIT;
+	struct strbuf extra = STRBUF_INIT;

 	one_name = two_name = it->string;
 	switch (change_type) {
@@ -153,6 +157,17 @@ static void wt_status_print_change_data(struct wt_status *s,
 			one_name = d->head_path;
 		break;
 	case WT_STATUS_CHANGED:
+		if (d->new_submodule_commits || d->dirty_submodule) {
+			strbuf_addstr(&extra, " (");
+			if (d->new_submodule_commits)
+				strbuf_addf(&extra, "new commits, ");
+			if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+				strbuf_addf(&extra, "modified content, ");
+			if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+				strbuf_addf(&extra, "untracked content, ");
+			strbuf_setlen(&extra, extra.len - 2);
+			strbuf_addch(&extra, ')');
+		}
 		status = d->worktree_status;
 		break;
 	}
@@ -189,6 +204,10 @@ static void wt_status_print_change_data(struct wt_status *s,
 	default:
 		die("bug: unhandled diff status %c", status);
 	}
+	if (extra.len) {
+		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "%s", extra.buf);
+		strbuf_release(&extra);
+	}
 	fprintf(s->fp, "\n");
 	strbuf_release(&onebuf);
 	strbuf_release(&twobuf);
@@ -218,6 +237,9 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		}
 		if (!d->worktree_status)
 			d->worktree_status = p->status;
+		d->dirty_submodule = p->two->dirty_submodule;
+		if (S_ISGITLINK(p->two->mode))
+			d->new_submodule_commits = !!hashcmp(p->one->sha1, p->two->sha1);
 	}
 }

@@ -281,6 +303,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.prune_data = s->pathspec;
@@ -418,33 +441,39 @@ static void wt_status_print_updated(struct wt_status *s)
  *  0 : no change
  *  1 : some change but no delete
  */
-static int wt_status_check_worktree_changes(struct wt_status *s)
+static int wt_status_check_worktree_changes(struct wt_status *s,
+					     int *dirty_submodules)
 {
 	int i;
 	int changes = 0;

+	*dirty_submodules = 0;
+
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		d = s->change.items[i].util;
 		if (!d->worktree_status ||
 		    d->worktree_status == DIFF_STATUS_UNMERGED)
 			continue;
-		changes = 1;
+		if (!changes)
+			changes = 1;
+		if (d->dirty_submodule)
+			*dirty_submodules = 1;
 		if (d->worktree_status == DIFF_STATUS_DELETED)
-			return -1;
+			changes = -1;
 	}
 	return changes;
 }

 static void wt_status_print_changed(struct wt_status *s)
 {
-	int i;
-	int worktree_changes = wt_status_check_worktree_changes(s);
+	int i, dirty_submodules;
+	int worktree_changes = wt_status_check_worktree_changes(s, &dirty_submodules);

 	if (!worktree_changes)
 		return;

-	wt_status_print_dirty_header(s, worktree_changes < 0);
+	wt_status_print_dirty_header(s, worktree_changes < 0, dirty_submodules);

 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
diff --git a/wt-status.h b/wt-status.h
index c60f40a..9120673 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -25,6 +25,8 @@ struct wt_status_change_data {
 	int index_status;
 	int stagemask;
 	char *head_path;
+	unsigned dirty_submodule       : 2;
+	unsigned new_submodule_commits : 1;
 };

 struct wt_status {
-- 
1.7.0.1.334.g76767.dirty
