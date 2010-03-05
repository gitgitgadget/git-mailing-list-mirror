From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git status: Show detailed dirty status of submodules in long
 format
Date: Fri, 05 Mar 2010 12:29:29 +0100
Message-ID: <4B90EB19.2070300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 12:29:48 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnVj0-0003U6-47
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 12:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333Ab0CEL3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 06:29:40 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:47298 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071Ab0CEL3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 06:29:38 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7BF3014B2EBF9;
	Fri,  5 Mar 2010 12:29:31 +0100 (CET)
Received: from [80.128.84.197] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NnVij-0005yJ-00; Fri, 05 Mar 2010 12:29:30 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19yuDhwpnEJho/qmynsZ+j+9DpEjhLSEYvmnVAp
	lMFAUvu7xLGPn9i3ZER+h4O0U8IGlnGRUiUtwHhN4cy/ApGlvm
	67nqPBsL4/DRZkQvI3hw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141577>

Since 1.7.0 there a three reasons a submodule is considered modified
against the work tree: It contains new commits, modified content or
untracked content. Lets show all reasons in the long format of git status,
so the user can better asses the nature of the modification. This change
does not affect the short and porcelain formats.

Two new members are added to "struct wt_status_change_data" to store the
information gathered by run_diff_files(). wt-status.c uses the new flag
DIFF_FORMAT_SUBMODULES to tell diff-lib.c it wants to get detailed dirty
information about submodules.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


So here is the promised patch teaching "git status" to show explicit
dirtiness information for submodules. Instead of just showing a
submodule as modified, it prints the reason(s) why the submodule is
considered modified along with a new hint line (thanks to Sergio
Callegari for bringing that last one up):

# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#   (commit or discard the untracked or modified content in submodules)
#
#	modified:   sub (new commits, modified content, untracked content)

(Note: The part in behind the submodule name is not colored like
"modified:" and the name itself but like the header above for better
visibility)


I am not so proud of DIFF_FORMAT_DIRTY_SUBMODULES, the new flag i
introduced to tell run_diff_files() it should gather the information
needed even if we don't want patch output. It isn't a "format" per se,
but i couldn't come up with a better way to do this. Opinions?



 diff-lib.c                  |    6 ++++--
 diff.h                      |    1 +
 t/t7506-status-submodule.sh |    6 +++---
 t/t7508-status.sh           |   11 +++++++++++
 wt-status.c                 |   26 +++++++++++++++++++++++++-
 wt-status.h                 |    2 ++
 6 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 15ca7cd..e8b143d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -180,7 +180,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		changed = ce_match_stat(ce, &st, ce_option);
 		if (S_ISGITLINK(ce->ce_mode)
 		    && !DIFF_OPT_TST(&revs->diffopt, IGNORE_SUBMODULES)
-		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH))) {
+		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH)
+		        || (revs->diffopt.output_format & DIFF_FORMAT_DIRTY_SUBMODULES))) {
 			dirty_submodule = is_submodule_modified(ce->name);
 			if (dirty_submodule)
 				changed = 1;
@@ -243,7 +244,8 @@ static int get_stat_data(struct cache_entry *ce,
 		changed = ce_match_stat(ce, &st, 0);
 		if (S_ISGITLINK(ce->ce_mode)
 		    && !DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)
-		    && (!changed || (diffopt->output_format & DIFF_FORMAT_PATCH))) {
+		    && (!changed || (diffopt->output_format & DIFF_FORMAT_PATCH)
+		        || (diffopt->output_format & DIFF_FORMAT_DIRTY_SUBMODULES))) {
 			*dirty_submodule = is_submodule_modified(ce->name);
 			if (*dirty_submodule)
 				changed = 1;
diff --git a/diff.h b/diff.h
index 2ef3341..04fcde5 100644
--- a/diff.h
+++ b/diff.h
@@ -44,6 +44,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_FORMAT_NO_OUTPUT	0x0800

 #define DIFF_FORMAT_CALLBACK	0x1000
+#define DIFF_FORMAT_DIRTY_SUBMODULES	0x2000

 #define DIFF_OPT_RECURSIVE           (1 <<  0)
 #define DIFF_OPT_TREE_IN_RECURSIVE   (1 <<  1)
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
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 556d0fa..47b5672 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -47,6 +47,7 @@ cat >expect <<\EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
 #
 #	modified:   dir1/modified
 #
@@ -96,6 +97,7 @@ cat >expect <<EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
 #
 #	modified:   dir1/modified
 #
@@ -141,6 +143,7 @@ cat >expect <<EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
 #
 #	modified:   dir1/modified
 #
@@ -199,6 +202,7 @@ cat >expect <<EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
 #
 #	modified:   dir1/modified
 #
@@ -259,6 +263,7 @@ cat >expect <<\EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
 #
 #	modified:   modified
 #
@@ -331,6 +336,7 @@ cat >expect <<\EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
 #
 #	<RED>modified:   dir1/modified<RESET>
 #
@@ -434,6 +440,7 @@ cat >expect <<\EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
 #
 #	modified:   dir1/modified
 #
@@ -517,6 +524,7 @@ cat >expect <<EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
 #
 #	modified:   dir1/modified
 #
@@ -576,6 +584,7 @@ cat >expect <<EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
 #
 #	modified:   dir1/modified
 #
@@ -621,6 +630,7 @@ cat >expect <<EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
 #
 #	modified:   dir1/modified
 #
@@ -669,6 +679,7 @@ cat >expect <<EOF
 # Changed but not updated:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (commit or discard the untracked or modified content in submodules)
 #
 #	modified:   dir1/modified
 #
diff --git a/wt-status.c b/wt-status.c
index 5807fc3..a5fc16d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -90,6 +90,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 	else
 		color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" to update what will be committed)");
 	color_fprintf_ln(s->fp, c, "#   (use \"git checkout -- <file>...\" to discard changes in working directory)");
+	color_fprintf_ln(s->fp, c, "#   (commit or discard the untracked or modified content in submodules)");
 	color_fprintf_ln(s->fp, c, "#");
 }

@@ -144,6 +145,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 	char *two_name;
 	const char *one, *two;
 	struct strbuf onebuf = STRBUF_INIT, twobuf = STRBUF_INIT;
+	struct strbuf extra = STRBUF_INIT;

 	one_name = two_name = it->string;
 	switch (change_type) {
@@ -153,6 +155,21 @@ static void wt_status_print_change_data(struct wt_status *s,
 			one_name = d->head_path;
 		break;
 	case WT_STATUS_CHANGED:
+		if (d->new_submodule_commits || d->dirty_submodule) {
+			const char *sep = "";
+			strbuf_addstr(&extra, " (");
+			if (d->new_submodule_commits) {
+				strbuf_addf(&extra, "new commits");
+				sep = ", ";
+			}
+			if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
+				strbuf_addf(&extra, "%smodified content", sep);
+				sep = ", ";
+			}
+			if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+				strbuf_addf(&extra, "%suntracked content",sep);
+			strbuf_addch(&extra, ')');
+		}
 		status = d->worktree_status;
 		break;
 	}
@@ -189,6 +206,10 @@ static void wt_status_print_change_data(struct wt_status *s,
 	default:
 		die("bug: unhandled diff status %c", status);
 	}
+	if (extra.len) {
+		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), extra.buf);
+		strbuf_release(&extra);
+	}
 	fprintf(s->fp, "\n");
 	strbuf_release(&onebuf);
 	strbuf_release(&twobuf);
@@ -218,6 +239,9 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		}
 		if (!d->worktree_status)
 			d->worktree_status = p->status;
+		d->dirty_submodule = p->two->dirty_submodule;
+		if (S_ISGITLINK(p->two->mode))
+			d->new_submodule_commits = !!hashcmp(p->one->sha1, p->two->sha1);
 	}
 }

@@ -280,7 +304,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)

 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
-	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK | DIFF_FORMAT_DIRTY_SUBMODULES;
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.prune_data = s->pathspec;
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
1.7.0.1.326.gc367c.dirty
