From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: git status options feature suggestion
Date: Sat, 25 Oct 2008 18:47:27 -0700
Message-ID: <7vej246sb4.fsf@gitster.siamese.dyndns.org>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
 <20081009061136.GA24288@coredump.intra.peff.net>
 <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
 <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
 <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <48EE1F58.2060707@drmicha.warpmail.net>
 <20081012044900.GA27845@coredump.intra.peff.net>
 <7vwsgegvsh.fsf@gitster.siamese.dyndns.org>
 <20081012064512.GA32597@coredump.intra.peff.net>
 <7v1vymgrom.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 26 02:56:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KturK-0003uS-JX
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 02:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbYJZBrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 21:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbYJZBrs
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 21:47:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbYJZBrr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 21:47:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EEA5F74E4A;
	Sat, 25 Oct 2008 21:47:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CE5D574E49; Sat, 25 Oct 2008 21:47:34 -0400 (EDT)
In-Reply-To: <7v1vymgrom.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 12 Oct 2008 01:10:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 150F8970-A300-11DD-9D36-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99134>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I remember a long time ago you started on a parallel diff walker that
>> could diff the working tree, the index, and a tree at once. Do you
>> remember the issues with it?
>
> Sorry, I don't.
>
>> I think that would be the right tool here to show each file only once,
>> but with multiple status flags. Something like:
>>
>>   A M foo
>>
>> to show that "foo" has been added since the last commit, but there are
>> modifications in the working tree that have not yet been staged.
>
> One thing to keep in mind is what to do when you would want to detect
> renames.  The parallel walk would be Ok but between HEAD and index there
> could be renames involved, and at that point it would get quite tricky.
> Once the index is in-core, I think it hurts us much to walk HEAD vs index
> and index vs working tree in separate passes.
>
> I think it is perfectly fine to run the diff-index first, and keep the
> result from it in a string_list, and then run "diff-files" and annotate
> the string_list with the output from it.
>
> Something like...

Because I was bored thinking about what to talk about in Gittogether and
lacked enough concentration to do anything productive, I did this that:

 (1) introduces the "find and summarize changes in a single string list"
     infrastructure;

 (2) rewrites wt_status_print_{updated,changed} to use it; and

 (3) adds "git shortstatus" that does not take any parameter (so it is not
     about "preview of commit with the same paths arguments" anymore) to
     give the status in:

        XsssY PATH1 -> PATH2

    format, where X is the diff status between HEAD and the index, sss is the
    rename/copy score of the change (if X is rename or copy --- otherwise
    it is blank), Y is the diff status between the index and the worktree.  
    PATH1 is the path in the HEAD, and " -> PATH2" part is shown only when
    PATH1 corresponds to a different path in the index/worktree.

This was done primarily for fun and killing-time, so I won't be committing
it to my tree, but it seems to pass all the existing tests.

If you apply this patch with "git apply" (no --index) and then

        $ git mv COPYING RENAMING

then you would see:

        $ ./git-shortstatus
        M     Makefile
        R100  COPYING -> RENAMING
            M builtin-commit.c
            M builtin-revert.c
            M builtin.h
            M git.c
            M wt-status.c
            M wt-status.h        

It is very much welcomed if somebody wants to build on top of this.  A few
obvious things, aside from bikeshedding to drop the score value (which I
just did as a sanity check measure and for nothing else --- I won't feel
hurt if we lost that field from the output) and such are:

 * We can also rewrite wt_status_print_untracked() using the collected
   data by making the collector pay attention to untracked files quite
   easily;

 * I did not bouther touching wt_status_print_initial() but I think it
   should be straightforward to produce its output from the collected
   data, as the collector already knows how to handle the initial commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Makefile         |    1 +
 builtin-commit.c |   45 ++++++++++-
 builtin-revert.c |    1 +
 builtin.h        |    1 +
 git.c            |    1 +
 wt-status.c      |  240 +++++++++++++++++++++++++++++++++++++++++-------------
 wt-status.h      |    9 ++
 7 files changed, 239 insertions(+), 59 deletions(-)

diff --git c/Makefile w/Makefile
index d6f3695..36afaa3 100644
--- c/Makefile
+++ w/Makefile
@@ -316,6 +316,7 @@ BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
 BUILT_INS += git-show$X
+BUILT_INS += git-shortstatus$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
 
diff --git c/builtin-commit.c w/builtin-commit.c
index 93ca496..99c6409 100644
--- c/builtin-commit.c
+++ w/builtin-commit.c
@@ -14,6 +14,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "revision.h"
+#include "string-list.h"
 #include "wt-status.h"
 #include "run-command.h"
 #include "refs.h"
@@ -21,7 +22,6 @@
 #include "strbuf.h"
 #include "utf8.h"
 #include "parse-options.h"
-#include "string-list.h"
 #include "rerere.h"
 #include "unpack-trees.h"
 
@@ -856,6 +856,49 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	return argc;
 }
 
+int cmd_shortstatus(int argc, const char **argv, const char *prefix)
+{
+	struct wt_status s;
+	int i;
+
+	read_cache();
+	refresh_cache(REFRESH_QUIET);
+	wt_status_prepare(&s);
+	wt_status_collect_changes(&s);
+	for (i = 0; i < s.change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+		char pfx[1 + 3 + 1 + 1];
+
+		it = &(s.change.items[i]);
+		d = it->util;
+		switch (d->index_status) {
+		case DIFF_STATUS_COPIED:
+		case DIFF_STATUS_RENAMED:
+			sprintf(pfx, "%c%3d",
+				d->index_status,
+				(int)(d->index_score * 100 / MAX_SCORE));
+			break;
+		case 0:
+			memcpy(pfx, "    ", 4);
+			break;
+		default:
+			sprintf(pfx, "%c   ", d->index_status);
+			break;
+		}
+		if (!d->worktree_status)
+			pfx[4] = ' ';
+		else
+			pfx[4] = d->worktree_status;
+		pfx[5] = '\0';
+		printf("%s ", pfx);
+		if (d->head_path)
+			printf("%s -> ", d->head_path);
+		printf("%s\n", it->string);
+	}
+	return 0;
+}
+
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	const char *index_file;
diff --git c/builtin-revert.c w/builtin-revert.c
index 4725540..060453f 100644
--- c/builtin-revert.c
+++ w/builtin-revert.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "commit.h"
 #include "tag.h"
+#include "string-list.h"
 #include "wt-status.h"
 #include "run-command.h"
 #include "exec_cmd.h"
diff --git c/builtin.h w/builtin.h
index 1495cf6..f054fc7 100644
--- c/builtin.h
+++ w/builtin.h
@@ -94,6 +94,7 @@ extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
+extern int cmd_shortstatus(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
diff --git c/git.c w/git.c
index 89feb0b..55e6cc9 100644
--- c/git.c
+++ w/git.c
@@ -342,6 +342,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
 		{ "shortlog", cmd_shortlog, USE_PAGER },
+		{ "shortstatus", cmd_shortstatus, RUN_SETUP | NEED_WORK_TREE },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
diff --git c/wt-status.c w/wt-status.c
index c3a9cab..3d2287b 100644
--- c/wt-status.c
+++ w/wt-status.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "string-list.h"
 #include "wt-status.h"
 #include "color.h"
 #include "object.h"
@@ -56,6 +57,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
+	s->change.strdup_strings = 1;
 }
 
 static void wt_status_print_cached_header(struct wt_status *s)
@@ -98,18 +100,22 @@ static void wt_status_print_trailer(struct wt_status *s)
 
 #define quote_path quote_path_relative
 
-static void wt_status_print_filepair(struct wt_status *s,
-				     int t, struct diff_filepair *p)
+static void wt_status_print_change_data(struct wt_status *s,
+					int t,
+					int status,
+					char *one_name,
+					char *two_name,
+					int score)
 {
 	const char *c = color(t);
 	const char *one, *two;
 	struct strbuf onebuf = STRBUF_INIT, twobuf = STRBUF_INIT;
 
-	one = quote_path(p->one->path, -1, &onebuf, s->prefix);
-	two = quote_path(p->two->path, -1, &twobuf, s->prefix);
+	one = quote_path(one_name, -1, &onebuf, s->prefix);
+	two = quote_path(two_name, -1, &twobuf, s->prefix);
 
 	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
-	switch (p->status) {
+	switch (status) {
 	case DIFF_STATUS_ADDED:
 		color_fprintf(s->fp, c, "new file:   %s", one);
 		break;
@@ -135,56 +141,13 @@ static void wt_status_print_filepair(struct wt_status *s,
 		color_fprintf(s->fp, c, "unmerged:   %s", one);
 		break;
 	default:
-		die("bug: unhandled diff status %c", p->status);
+		die("bug: unhandled diff status %c", status);
 	}
 	fprintf(s->fp, "\n");
 	strbuf_release(&onebuf);
 	strbuf_release(&twobuf);
 }
 
-static void wt_status_print_updated_cb(struct diff_queue_struct *q,
-		struct diff_options *options,
-		void *data)
-{
-	struct wt_status *s = data;
-	int shown_header = 0;
-	int i;
-	for (i = 0; i < q->nr; i++) {
-		if (q->queue[i]->status == 'U')
-			continue;
-		if (!shown_header) {
-			wt_status_print_cached_header(s);
-			s->commitable = 1;
-			shown_header = 1;
-		}
-		wt_status_print_filepair(s, WT_STATUS_UPDATED, q->queue[i]);
-	}
-	if (shown_header)
-		wt_status_print_trailer(s);
-}
-
-static void wt_status_print_changed_cb(struct diff_queue_struct *q,
-                        struct diff_options *options,
-                        void *data)
-{
-	struct wt_status *s = data;
-	int i;
-	if (q->nr) {
-		int has_deleted = 0;
-		s->workdir_dirty = 1;
-		for (i = 0; i < q->nr; i++)
-			if (q->queue[i]->status == DIFF_STATUS_DELETED) {
-				has_deleted = 1;
-				break;
-			}
-		wt_status_print_dirty_header(s, has_deleted);
-	}
-	for (i = 0; i < q->nr; i++)
-		wt_status_print_filepair(s, WT_STATUS_CHANGED, q->queue[i]);
-	if (q->nr)
-		wt_status_print_trailer(s);
-}
-
 static void wt_status_print_initial(struct wt_status *s)
 {
 	int i;
@@ -205,13 +168,80 @@ static void wt_status_print_initial(struct wt_status *s)
 	strbuf_release(&buf);
 }
 
-static void wt_status_print_updated(struct wt_status *s)
+static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
+{
+	struct wt_status *s = data;
+	int i;
+
+	if (!q->nr)
+		return;
+	s->workdir_dirty = 1;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p;
+		struct string_list_item *it;
+		struct wt_status_change_data *d;
+
+		p = q->queue[i];
+
+		d = xcalloc(1, sizeof(*d));
+		d->worktree_status = p->status;
+		it = string_list_insert(p->one->path, &s->change);
+		it->util = d;
+	}
+}
+
+static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
+{
+	struct wt_status *s = data;
+	int i;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p;
+		struct string_list_item *it;
+		struct wt_status_change_data *d;
+
+		p = q->queue[i];
+		it = string_list_insert(p->two->path, &s->change);
+		d = it->util;
+		if (!d) {
+			d = xcalloc(1, sizeof(*d));
+			it->util = d;
+		}
+		d->index_status = p->status;
+		switch (p->status) {
+		case DIFF_STATUS_COPIED:
+		case DIFF_STATUS_RENAMED:
+			d->head_path = xstrdup(p->one->path);
+			d->index_score = p->score;
+			break;
+		}
+	}
+}
+
+static void wt_status_collect_changes_worktree(struct wt_status *s)
+{
+	struct rev_info rev;
+
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, NULL);
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = wt_status_collect_changed_cb;
+	rev.diffopt.format_callback_data = s;
+	run_diff_files(&rev, 0);
+}
+
+static void wt_status_collect_changes_index(struct wt_status *s)
 {
 	struct rev_info rev;
+
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = wt_status_print_updated_cb;
+	rev.diffopt.format_callback = wt_status_collect_updated_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 200;
@@ -219,15 +249,107 @@ static void wt_status_print_updated(struct wt_status *s)
 	run_diff_index(&rev, 1);
 }
 
+static void wt_status_collect_changes_initial(struct wt_status *s)
+{
+	int i;
+
+	for (i = 0; i < active_nr; i++) {
+		struct string_list_item *it;
+		struct wt_status_change_data *d;
+
+		it = string_list_insert(active_cache[i]->name, &s->change);
+		d = it->util;
+		if (!d) {
+			d = xcalloc(1, sizeof(*d));
+			it->util = d;
+		}
+		d->index_status = DIFF_STATUS_ADDED;
+	}
+}
+
+void wt_status_collect_changes(struct wt_status *s)
+{
+	wt_status_collect_changes_worktree(s);
+
+	if (s->is_initial)
+		wt_status_collect_changes_initial(s);
+	else
+		wt_status_collect_changes_index(s);
+}
+
+static void wt_status_print_updated(struct wt_status *s)
+{
+	int shown_header = 0;
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (!d->index_status)
+			continue;
+		if (!shown_header) {
+			wt_status_print_cached_header(s);
+			s->commitable = 1;
+			shown_header = 1;
+		}
+		wt_status_print_change_data(s, WT_STATUS_UPDATED,
+					    d->index_status,
+					    d->head_path ? d->head_path : it->string,
+					    it->string,
+					    d->index_score);
+	}
+	if (shown_header)
+		wt_status_print_trailer(s);
+}
+
+/*
+ * -1 : has delete
+ *  0 : no change
+ *  1 : some change but no delete
+ */
+static int wt_status_check_worktree_changes(struct wt_status *s)
+{
+	int i;
+	int changes = 0;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		d = s->change.items[i].util;
+		if (!d->worktree_status)
+			continue;
+		changes = 1;
+		if (d->worktree_status == DIFF_STATUS_DELETED)
+			return -1;
+	}
+	return changes;
+}
+
 static void wt_status_print_changed(struct wt_status *s)
 {
-	struct rev_info rev;
-	init_revisions(&rev, "");
-	setup_revisions(0, NULL, &rev, NULL);
-	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = wt_status_print_changed_cb;
-	rev.diffopt.format_callback_data = s;
-	run_diff_files(&rev, 0);
+	int i;
+	int worktree_changes = wt_status_check_worktree_changes(s);
+
+	if (!worktree_changes)
+		return;
+
+	wt_status_print_dirty_header(s, worktree_changes < 0);
+	
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (!d->worktree_status)
+			continue;
+		wt_status_print_change_data(s, WT_STATUS_CHANGED,
+					    d->worktree_status,
+					    it->string,
+					    it->string,
+					    0);
+	}
+	wt_status_print_trailer(s);
 }
 
 static void wt_status_print_submodule_summary(struct wt_status *s)
@@ -347,6 +469,8 @@ void wt_status_print(struct wt_status *s)
 			wt_status_print_tracking(s);
 	}
 
+	wt_status_collect_changes(s);
+
 	if (s->is_initial) {
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "# Initial commit");
diff --git c/wt-status.h w/wt-status.h
index 78add09..00508c3 100644
--- c/wt-status.h
+++ w/wt-status.h
@@ -18,6 +18,13 @@ enum untracked_status_type {
 };
 extern enum untracked_status_type show_untracked_files;
 
+struct wt_status_change_data {
+	int worktree_status;
+	int index_status;
+	int index_score;
+	char *head_path;
+};
+
 struct wt_status {
 	int is_initial;
 	char *branch;
@@ -33,6 +40,7 @@ struct wt_status {
 	const char *index_file;
 	FILE *fp;
 	const char *prefix;
+	struct string_list change;
 };
 
 int git_status_config(const char *var, const char *value, void *cb);
@@ -40,5 +48,6 @@ extern int wt_status_use_color;
 extern int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
+void wt_status_collect_changes(struct wt_status *s);
 
 #endif /* STATUS_H */
