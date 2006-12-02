X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Lars Hjemli <hjemli@gmail.com>
Subject: [RFC/PATCH] runstatus: restructure visual appearance
Date: Sat,  2 Dec 2006 20:37:05 +0100
Message-ID: <11650882251452-git-send-email-hjemli@gmail.com>
NNTP-Posting-Date: Sat, 2 Dec 2006 19:47:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g1210
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33035>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqap5-0006da-Ti for gcvg-git@gmane.org; Sat, 02 Dec
 2006 20:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162507AbWLBTqx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 14:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759482AbWLBTqx
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 14:46:53 -0500
Received: from mail45.e.nsc.no ([193.213.115.45]:38053 "EHLO
 mail45.e.nsc.no") by vger.kernel.org with ESMTP id S1759477AbWLBTqv (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 14:46:51 -0500
Received: from localhost.localdomain (ti231210a080-2784.bb.online.no
 [80.213.122.226]) by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id
 kB2JkmxD003353 for <git@vger.kernel.org>; Sat, 2 Dec 2006 20:46:49 +0100
 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Modify the output from runstatus so that all modified files are shown
in the same list, prefixed with a state symbol (A/C/D/M/R/T/X/U) and
possibly a state modifier (+/-).

The '+' indicates that the working copy has been changed since the file
was added to the index, while the '-' indicates that the file hasn't
been added to the index at all.

If either '+' or '-' is displayed for any of the modified files, then a
big warning is printed, informing the user that she might want to run
'git commit -a' or 'git add file'.

Experienced users who find this warning annoying, can turn if off with
'git repo-config status.showwarning 0'.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>

---

This is a rather subjective 'improvement', but I think it makes the commit 
message easier to comprehend and I hope that goes for both new and 
experienced users.

Btw: the warning message somewhat implies that 'git add' can be used to add 
changed content to the index, even for files already added. So I obviously 
liked the patch Nicolas Pitre sendt earlier today...


 Documentation/git-runstatus.txt |   28 +++
 wt-status.c                     |  384 +++++++++++++++++++++++----------------
 wt-status.h                     |    1 +
 3 files changed, 260 insertions(+), 153 deletions(-)

diff --git a/Documentation/git-runstatus.txt b/Documentation/git-runstatus.txt
index 89d7b92..cc6ed92 100644
--- a/Documentation/git-runstatus.txt
+++ b/Documentation/git-runstatus.txt
@@ -53,6 +53,34 @@ OUTPUT
 The output from this command is designed to be used as a commit
 template comments, and all the output lines are prefixed with '#'.
 
+EXAMPLES
+--------
+
++
+--------
+$ git runstatus
+#
+# On branch refs/heads/runstatus
+#
+# Modified files
+#   M  Documentation/git-runstatus.txt
+#   M+ wt-status.c
+#
+# WARNING:
+#   If you want to commit all of your changes, you need to run
+#   'git commit -a' (or 'git add file...' for selected files).
+#
+$ git add wt-status.c
+$ git runstatus
+#
+# On branch refs/heads/runstatus
+#
+# Modified files
+#   M  Documentation/git-runstatus.txt
+#   M  wt-status.c
+#
+--------
++
 
 Author
 ------
diff --git a/wt-status.c b/wt-status.c
index de1be5b..db0c945 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,11 +9,20 @@
 #include "diffcore.h"
 
 int wt_status_use_color = 0;
+int wt_status_warn = 1;
+
+struct fileinfo{
+	int status;
+	char *one, *two;
+	struct fileinfo *next;
+};
+
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
 	"\033[32m", /* WT_STATUS_UPDATED: green */
 	"\033[31m", /* WT_STATUS_CHANGED: red */
-	"\033[31m", /* WT_STATUS_UNTRACKED: red */
+	"",         /* WT_STATUS_UNTRACKED: normal */
+	"\033[31m", /* WT_STATUS_WARNING: red */
 };
 
 static int parse_status_slot(const char *var, int offset)
@@ -43,7 +52,6 @@ void wt_status_prepare(struct wt_status *s)
 
 	head = resolve_ref("HEAD", sha1, 0, NULL);
 	s->branch = head ? xstrdup(head) : NULL;
-
 	s->reference = "HEAD";
 	s->amend = 0;
 	s->verbose = 0;
@@ -51,17 +59,15 @@ void wt_status_prepare(struct wt_status *s)
 	s->untracked = 0;
 }
 
-static void wt_status_print_header(const char *main, const char *sub)
+static void wt_status_print_trailer(void)
 {
-	const char *c = color(WT_STATUS_HEADER);
-	color_printf_ln(c, "# %s:", main);
-	color_printf_ln(c, "#   (%s)", sub);
-	color_printf_ln(c, "#");
+	color_printf_ln(color(WT_STATUS_HEADER), "#");
 }
 
-static void wt_status_print_trailer(void)
+static void wt_status_print_header(const char *main)
 {
-	color_printf_ln(color(WT_STATUS_HEADER), "#");
+	wt_status_print_trailer();
+	color_printf_ln(color(WT_STATUS_HEADER), "# %s", main);
 }
 
 static const char *quote_crlf(const char *in, char *buf, size_t sz)
@@ -70,6 +76,9 @@ static const char *quote_crlf(const char *in, char *buf, size_t sz)
 	char *out;
 	const char *ret = in;
 
+	if (!in)
+		return ret;
+
 	for (scan = in, out = buf; *scan; scan++) {
 		int ch = *scan;
 		int quoted;
@@ -93,133 +102,13 @@ static const char *quote_crlf(const char *in, char *buf, size_t sz)
 	return ret;
 }
 
-static void wt_status_print_filepair(int t, struct diff_filepair *p)
-{
-	const char *c = color(t);
-	const char *one, *two;
-	char onebuf[PATH_MAX], twobuf[PATH_MAX];
-
-	one = quote_crlf(p->one->path, onebuf, sizeof(onebuf));
-	two = quote_crlf(p->two->path, twobuf, sizeof(twobuf));
-
-	color_printf(color(WT_STATUS_HEADER), "#\t");
-	switch (p->status) {
-	case DIFF_STATUS_ADDED:
-		color_printf(c, "new file:   %s", one);
-		break;
-	case DIFF_STATUS_COPIED:
-		color_printf(c, "copied:     %s -> %s", one, two);
-		break;
-	case DIFF_STATUS_DELETED:
-		color_printf(c, "deleted:    %s", one);
-		break;
-	case DIFF_STATUS_MODIFIED:
-		color_printf(c, "modified:   %s", one);
-		break;
-	case DIFF_STATUS_RENAMED:
-		color_printf(c, "renamed:    %s -> %s", one, two);
-		break;
-	case DIFF_STATUS_TYPE_CHANGED:
-		color_printf(c, "typechange: %s", one);
-		break;
-	case DIFF_STATUS_UNKNOWN:
-		color_printf(c, "unknown:    %s", one);
-		break;
-	case DIFF_STATUS_UNMERGED:
-		color_printf(c, "unmerged:   %s", one);
-		break;
-	default:
-		die("bug: unhandled diff status %c", p->status);
-	}
-	printf("\n");
-}
-
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
-			wt_status_print_header("Updated but not checked in",
-					"will commit");
-			s->commitable = 1;
-			shown_header = 1;
-		}
-		wt_status_print_filepair(WT_STATUS_UPDATED, q->queue[i]);
-	}
-	if (shown_header)
-		wt_status_print_trailer();
-}
-
-static void wt_status_print_changed_cb(struct diff_queue_struct *q,
-                        struct diff_options *options,
-                        void *data)
-{
-	int i;
-	if (q->nr)
-		wt_status_print_header("Changed but not updated",
-				"use git-update-index to mark for commit");
-	for (i = 0; i < q->nr; i++)
-		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
-	if (q->nr)
-		wt_status_print_trailer();
-}
-
-void wt_status_print_initial(struct wt_status *s)
-{
-	int i;
-	char buf[PATH_MAX];
-
-	read_cache();
-	if (active_nr) {
-		s->commitable = 1;
-		wt_status_print_header("Updated but not checked in",
-				"will commit");
-	}
-	for (i = 0; i < active_nr; i++) {
-		color_printf(color(WT_STATUS_HEADER), "#\t");
-		color_printf_ln(color(WT_STATUS_UPDATED), "new file: %s",
-				quote_crlf(active_cache[i]->name,
-					   buf, sizeof(buf)));
-	}
-	if (active_nr)
-		wt_status_print_trailer();
-}
-
-static void wt_status_print_updated(struct wt_status *s)
-{
-	struct rev_info rev;
-	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, s->reference);
-	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = wt_status_print_updated_cb;
-	rev.diffopt.format_callback_data = s;
-	rev.diffopt.detect_rename = 1;
-	run_diff_index(&rev, 1);
-}
-
-static void wt_status_print_changed(struct wt_status *s)
-{
-	struct rev_info rev;
-	init_revisions(&rev, "");
-	setup_revisions(0, NULL, &rev, NULL);
-	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = wt_status_print_changed_cb;
-	rev.diffopt.format_callback_data = s;
-	run_diff_files(&rev, 0);
-}
-
-static void wt_status_print_untracked(const struct wt_status *s)
+static int wt_status_print_untracked(const struct wt_status *s)
 {
 	struct dir_struct dir;
 	const char *x;
 	int i;
 	int shown_header = 0;
+	int ret = 0;
 
 	memset(&dir, 0, sizeof(dir));
 
@@ -249,14 +138,15 @@ static void wt_status_print_untracked(const struct wt_status *s)
 				continue;
 		}
 		if (!shown_header) {
-			wt_status_print_header("Untracked files",
-				"use \"git add\" to add to commit");
+			wt_status_print_header("Untracked files:");
 			shown_header = 1;
 		}
-		color_printf(color(WT_STATUS_HEADER), "#\t");
+		color_printf(color(WT_STATUS_HEADER), "#   ");
 		color_printf_ln(color(WT_STATUS_UNTRACKED), "%.*s",
 				ent->len, ent->name);
+		ret++;
 	}
+	return ret;
 }
 
 static void wt_status_print_verbose(struct wt_status *s)
@@ -269,30 +159,215 @@ static void wt_status_print_verbose(struct wt_status *s)
 	run_diff_index(&rev, 1);
 }
 
-void wt_status_print(struct wt_status *s)
+static void wt_status_copy_cb(struct diff_queue_struct *q,
+			      struct diff_options *options,
+			      void *data)
+{
+	struct fileinfo *p, *t = (struct fileinfo *)data;
+	int i;
+
+	for(i=0; i<q->nr; i++){
+		if (q->queue[i]->status=='U')
+			continue;
+		p = xmalloc(sizeof(*p));
+		p->status = q->queue[i]->status;
+		p->one = xstrdup(q->queue[i]->one->path);
+		p->two = xstrdup(q->queue[i]->two->path);
+		t = t->next = p;
+	}
+	t->next = NULL;
+}
+
+static void wt_status_find_indexed(struct fileinfo *head)
+{
+	struct fileinfo *t = head, *p;
+	int i;
+
+	read_cache();
+        for (i = 0; i < active_nr; i++) {
+		p = xmalloc(sizeof(*p));
+		p->status = DIFF_STATUS_ADDED;
+		p->one = xstrdup(active_cache[i]->name);
+		p->two = NULL;
+		t = t->next = p;
+        }
+	t->next = NULL;
+}
+
+static void wt_status_find_staged(struct wt_status *s, void *q)
+{
+	struct rev_info rev;
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, s->reference);
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = wt_status_copy_cb;
+	rev.diffopt.format_callback_data = q;
+	rev.diffopt.detect_rename = 1;
+	run_diff_index(&rev, 1);
+}
+
+static void wt_status_find_unstaged(struct wt_status *s, void *q)
 {
-	if (s->branch && strcmp(s->branch, "refs/heads/master"))
-		color_printf_ln(color(WT_STATUS_HEADER),
-			"# On branch %s", s->branch);
-
-	if (s->is_initial) {
-		color_printf_ln(color(WT_STATUS_HEADER), "#");
-		color_printf_ln(color(WT_STATUS_HEADER), "# Initial commit");
-		color_printf_ln(color(WT_STATUS_HEADER), "#");
-		wt_status_print_initial(s);
+	struct rev_info rev;
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, NULL);
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = wt_status_copy_cb;
+	rev.diffopt.format_callback_data = q;
+	run_diff_files(&rev, 0);
+}
+
+
+static void wt_status_print_warning()
+{
+	static const char w1[] =
+		"If you want to commit all of your changes, you need to run";
+	static const char w2[] =
+		"'git commit -a' (or 'git add file...' for selected files)";
+
+	wt_status_print_header("WARNING:");
+	color_printf(color(WT_STATUS_HEADER), "#   ");
+	color_printf_ln(color(WT_STATUS_WARNING), w1);
+	color_printf(color(WT_STATUS_HEADER), "#   ");
+	color_printf_ln(color(WT_STATUS_WARNING), w2);
+}
+
+static int wt_status_print_one(int staged, int unstaged, const char *one,
+			const char *two)
+{
+	char mode[3] = "??";
+	const char *c;
+	int ret = 0;
+	char onebuf[PATH_MAX], twobuf[PATH_MAX];
+
+	one = quote_crlf(one, onebuf, sizeof(onebuf));
+	two = quote_crlf(two, twobuf, sizeof(twobuf));
+
+	if (staged!=0 && unstaged==0) {
+		mode[0] = staged;
+		mode[1] = ' ';
+	} else if (staged==0 && unstaged!=0) {
+		mode[0] = unstaged;
+		mode[1] = '-';
+		ret = 1;
+	} else {
+		mode[0] = staged;
+		mode[1] = '+';
+		ret = 2;
 	}
-	else {
-		wt_status_print_updated(s);
-		discard_cache();
+	printf("#   ");
+	if (mode[1]==' ')
+		c = color(WT_STATUS_UPDATED);
+	else
+		c = color(WT_STATUS_CHANGED);
+
+	if (mode[0]==DIFF_STATUS_COPIED || mode[0]==DIFF_STATUS_RENAMED)
+		color_printf_ln(c, "%s %s -> %s", mode, one, two);
+	else
+		color_printf_ln(c, "%s %s", mode, one);
+	return ret;
+}
+
+static void wt_status_free_list(struct fileinfo *p)
+{
+	struct fileinfo *t = p->next;
+
+	while (t){
+	        p = t;
+		t = t->next;
+		free(p->one);
+		free(p->two);
+		free(p);
 	}
+}
+
+static int wt_status_print_tracked(struct wt_status *status)
+{
+	struct fileinfo staged, unstaged, *s, *u;
+	int warn = 0;
+	int ret = 0;
+
+	staged.next = unstaged.next = NULL;
+
+	if (status->is_initial)
+		wt_status_find_indexed(&staged);
+	else
+		wt_status_find_staged(status, &staged);
+
+	wt_status_find_unstaged(status, &unstaged);
 
-	wt_status_print_changed(s);
-	wt_status_print_untracked(s);
+	s = staged.next;
+	u = unstaged.next;
+
+	if (!s && !u)
+		return ret;
+
+	wt_status_print_header("Modified files:");
+	while(s || u) {
+		if (!s) {
+			warn |= wt_status_print_one(0, u->status, u->one,
+						    u->two);
+			u = u->next;
+		} else if (!u) {
+			warn |= wt_status_print_one(s->status, 0, s->one,
+						    s->two);
+			s = s->next;
+		} else {
+			int i = strcmp(s->one, u->one);
+			if (i<0) {
+				warn |= wt_status_print_one(s->status, 0,
+							    s->one, s->two);
+				s = s->next;
+			} else if (i>0) {
+				warn |= wt_status_print_one(0, u->status,
+							    u->one, u->two);
+				u = u->next;
+			} else {
+				warn |= wt_status_print_one(s->status,
+							    u->status, s->one,
+							    s->two);
+				s = s->next;
+				u = u->next;
+			}
+		}
+		ret++;
+	}
 
-	if (s->verbose && !s->is_initial)
-		wt_status_print_verbose(s);
-	if (!s->commitable)
-		printf("%s\n", s->amend ? "# No changes" : "nothing to commit");
+	/* if warn==0 or warn==2, something is staged for commit */
+	status->commitable = (warn != 1);
+
+	if (warn && wt_status_warn)
+		wt_status_print_warning();
+	wt_status_free_list(&staged);
+	wt_status_free_list(&unstaged);
+	return ret;
+}
+
+void wt_status_print(struct wt_status *status)
+{
+	int cnt;
+
+	if (status->branch && strcmp(status->branch, "refs/heads/master")){
+		wt_status_print_trailer();
+		color_printf_ln(color(WT_STATUS_HEADER), "# On branch %s",
+				status->branch);
+	}
+
+	if (status->is_initial)
+		wt_status_print_header("Initial commit");
+
+	cnt = wt_status_print_tracked(status);
+	cnt += wt_status_print_untracked(status);
+
+	if (cnt)
+		wt_status_print_trailer();
+
+	if (status->verbose && !status->is_initial)
+		wt_status_print_verbose(status);
+
+	if (!status->commitable)
+		printf("%s\n",
+		       status->amend ? "# No changes" : "nothing to commit");
 }
 
 int git_status_config(const char *k, const char *v)
@@ -305,5 +380,8 @@ int git_status_config(const char *k, const char *v)
 		int slot = parse_status_slot(k, 13);
 		color_parse(v, k, wt_status_colors[slot]);
 	}
+	if (!strcmp(k, "status.showwarning"))
+		wt_status_warn = git_config_bool(k, v);
+
 	return git_default_config(k, v);
 }
diff --git a/wt-status.h b/wt-status.h
index 0a5a5b7..b8337ee 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -6,6 +6,7 @@ enum color_wt_status {
 	WT_STATUS_UPDATED,
 	WT_STATUS_CHANGED,
 	WT_STATUS_UNTRACKED,
+	WT_STATUS_WARNING
 };
 
 struct wt_status {
-- 
1.4.4.1.g1210
