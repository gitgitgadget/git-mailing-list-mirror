From: "Peter Kuemmel" <syntheticpp@gmx.net>
Subject: Branch Title
Date: Sat, 1 Nov 2014 15:32:55 +0100
Message-ID: <trinity-e17125ce-b18f-4d48-bd98-afcb4224b80e-1414852375225@3capp-gmx-bs67>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 15:33:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkZju-0003xr-6H
	for gcvg-git-2@plane.gmane.org; Sat, 01 Nov 2014 15:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758343AbaKAOc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2014 10:32:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:61793 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756389AbaKAOc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2014 10:32:57 -0400
Received: from [92.225.152.65] by 3capp-gmx-bs67.server.lan (via HTTP); Sat,
 1 Nov 2014 15:32:55 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K0:1TYUe+bgrmU1irJZ+aFgGe10DGB/mXO2XBX9ik1WX2J
 Iw3pjDc7Ub87f+TeR/IMUaam5/ZwZq0HOl8q4qggtof1YbDiLZ
 EmcJRcQKOy2EBoszZ3p9MBFoakR1CRFxIVCVg7ztgVieuN0ba3
 xYcopV/4CA/5ngc7HVkgZcnwiJcu9nLLsP9xZRBtI4B4V3vVFF
 7WbqwQEy2230dq4ELwPRtqQ2KtrInRUPAn8RUrJytQxlbJh0yE
 2bm6fQ77jhjoeSdr2EzM07M7aPqBEFtT4DcmxIOqdb2AZEYaj0 NZgNq4=
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I would like to give a branch a "title" which is similar to the branch description
but should be pushable.

There was a discussion several years ago with the hint to extend
push to make it shareable:
http://git.661346.n2.nabble.com/push-branch-descriptions-tt7571217.html

I've patched buildin/branch.c for the local part, but how could the title be pushed,
and where should it be stored on the remote side?

Peter



Subject: [PATCH] branch.c: add option to edit/show the title of a branch

---
 branch.c         | 15 ++++++++++
 branch.h         |  5 ++++
 builtin/branch.c | 89 +++++++++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 88 insertions(+), 21 deletions(-)

diff --git a/branch.c b/branch.c
index 4bab55a..47380d8 100644
--- a/branch.c
+++ b/branch.c
@@ -155,6 +155,21 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
+int read_branch_title(struct strbuf *buf, const char *branch_name)
+{
+	char *v = NULL;
+	struct strbuf name = STRBUF_INIT;
+	strbuf_addf(&name, "branch.%s.title", branch_name);
+	if (git_config_get_string(name.buf, &v)) {
+		strbuf_release(&name);
+		return -1;
+	}
+	strbuf_addstr(buf, v);
+	free(v);
+	strbuf_release(&name);
+	return 0;
+}
+
 int validate_new_branchname(const char *name, struct strbuf *ref,
 			    int force, int attr_only)
 {
diff --git a/branch.h b/branch.h
index 64173ab..f1050ab 100644
--- a/branch.h
+++ b/branch.h
@@ -52,4 +52,9 @@ extern void install_branch_config(int flag, const char *local, const char *origi
  */
 extern int read_branch_desc(struct strbuf *, const char *branch_name);
 
+/*
+ * Read branch title
+ */
+extern int read_branch_title(struct strbuf *, const char *branch_name);
+
 #endif
diff --git a/builtin/branch.c b/builtin/branch.c
index 3b79c50..0680464 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -290,7 +290,7 @@ struct ref_item {
 
 struct ref_list {
 	struct rev_info revs;
-	int index, alloc, maxwidth, verbose, abbrev;
+	int index, alloc, maxwidth, verbose, showtitle, abbrev;
 	struct ref_item *list;
 	struct commit_list *with_commit;
 	int kinds;
@@ -511,7 +511,7 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 	strbuf_release(&subject);
 }
 
-static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
+static void print_ref_item(struct ref_item *item, int maxwidth, int verbose, int showtitle,
 			   int abbrev, int current, char *prefix)
 {
 	char c;
@@ -554,6 +554,15 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	else if (verbose)
 		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
 		add_verbose_info(&out, item, verbose, abbrev);
+	if (showtitle) {
+		struct strbuf title = STRBUF_INIT;
+		read_branch_title(&title, name.buf);
+		if (title.len > 0) {
+			strbuf_trim(&title);
+			strbuf_addf(&out, " \"%s\"", title.buf);
+		}
+		strbuf_release(&title);
+	}
 	if (column_active(colopts)) {
 		assert(!verbose && "--column and --verbose are incompatible");
 		string_list_append(&output, out.buf);
@@ -614,12 +623,12 @@ static void show_detached(struct ref_list *ref_list)
 		item.ignore = 0;
 		if (item.width > ref_list->maxwidth)
 			ref_list->maxwidth = item.width;
-		print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
+		print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_list->showtitle, ref_list->abbrev, 1, "");
 		free(item.name);
 	}
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
+static int print_ref_list(int kinds, int detached, int verbose, int showtitle, int abbrev, struct commit_list *with_commit, const char **pattern)
 {
 	int i;
 	struct append_ref_cb cb;
@@ -628,6 +637,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
 	ref_list.verbose = verbose;
+	ref_list.showtitle = showtitle;
 	ref_list.abbrev = abbrev;
 	ref_list.with_commit = with_commit;
 	if (merge_filter != NO_FILTER)
@@ -664,7 +674,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 		}
 		clear_commit_marks(filter, ALL_REV_FLAGS);
 
-		if (verbose)
+		if (verbose || showtitle)
 			ref_list.maxwidth = calc_maxwidth(&ref_list);
 	}
 
@@ -681,7 +691,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 		char *prefix = (kinds != REF_REMOTE_BRANCH &&
 				ref_list.list[i].kind == REF_REMOTE_BRANCH)
 				? "remotes/" : "";
-		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose,
+		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose, showtitle,
 			       abbrev, current, prefix);
 	}
 
@@ -761,36 +771,40 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 }
 
 static const char edit_description[] = "BRANCH_DESCRIPTION";
+static const char edit_title[] = "BRANCH_TITLE";
 
-static int edit_branch_description(const char *branch_name)
+static int edit_branch_description(const char *branch_name, int desc)
 {
 	FILE *fp;
 	int status;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf name = STRBUF_INIT;
 
-	read_branch_desc(&buf, branch_name);
+	if (desc)
+		read_branch_desc(&buf, branch_name);
+	else
+		read_branch_title(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
 	strbuf_commented_addf(&buf,
-		    "Please edit the description for the branch\n"
+		    "Please edit the %s for the branch\n"
 		    "  %s\n"
 		    "Lines starting with '%c' will be stripped.\n",
-		    branch_name, comment_line_char);
-	fp = fopen(git_path(edit_description), "w");
+		    (desc?"description":"title"), branch_name, comment_line_char);
+	fp = fopen(git_path(desc?edit_description:edit_title), "w");
 	if ((fwrite(buf.buf, 1, buf.len, fp) < buf.len) || fclose(fp)) {
 		strbuf_release(&buf);
-		return error(_("could not write branch description template: %s"),
-			     strerror(errno));
+		return error(_("could not write branch %s template: %s"),
+			     (desc?"description":"title"), strerror(errno));
 	}
 	strbuf_reset(&buf);
-	if (launch_editor(git_path(edit_description), &buf, NULL)) {
+	if (launch_editor(git_path(desc?edit_description:edit_title), &buf, NULL)) {
 		strbuf_release(&buf);
 		return -1;
 	}
 	stripspace(&buf, 1);
 
-	strbuf_addf(&name, "branch.%s.description", branch_name);
+	strbuf_addf(&name, "branch.%s.%s", branch_name, (desc?"description":"title"));
 	status = git_config_set(name.buf, buf.len ? buf.buf : NULL);
 	strbuf_release(&name);
 	strbuf_release(&buf);
@@ -801,8 +815,8 @@ static int edit_branch_description(const char *branch_name)
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0, list = 0;
-	int verbose = 0, abbrev = -1, detached = 0;
-	int reflog = 0, edit_description = 0;
+	int verbose = 0, showtitle = 0, abbrev = -1, detached = 0;
+	int reflog = 0, edit_description = 0, edit_title = 0;
 	int quiet = 0, unset_upstream = 0;
 	const char *new_upstream = NULL;
 	enum branch_track track;
@@ -813,6 +827,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(N_("Generic options")),
 		OPT__VERBOSE(&verbose,
 			N_("show hash and subject, give twice for upstream branch")),
+		OPT_BOOL('s', "title", &showtitle,
+			 N_("show title of branches if available")),
 		OPT__QUIET(&quiet, N_("suppress informational messages")),
 		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
 			BRANCH_TRACK_EXPLICIT),
@@ -848,6 +864,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_BOOL('e', "edit-title", &edit_title,
+			 N_("edit the title for the branch")),
 		OPT__FORCE(&force_create, N_("force creation (when already exists)")),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
@@ -885,7 +903,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
+	if (!delete && !rename && !edit_description && !edit_title && 
+				!new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
 	if (with_commit || merge_filter != NO_FILTER)
@@ -898,7 +917,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (abbrev == -1)
 		abbrev = DEFAULT_ABBREV;
 	finalize_colopts(&colopts, -1);
-	if (verbose) {
+	if (verbose || showtitle) {
 		if (explicitly_enable_column(colopts))
 			die(_("--column and --verbose are incompatible"));
 		colopts = 0;
@@ -909,7 +928,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("branch name required"));
 		return delete_branches(argc, argv, delete > 1, kinds, quiet);
 	} else if (list) {
-		int ret = print_ref_list(kinds, detached, verbose, abbrev,
+		int ret = print_ref_list(kinds, detached, verbose, showtitle, abbrev,
 					 with_commit, argv);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
@@ -941,7 +960,35 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		}
 		strbuf_release(&branch_ref);
 
-		if (edit_branch_description(branch_name))
+		if (edit_branch_description(branch_name, 1))
+			return 1;
+	} else if (edit_title) {
+		const char *branch_name;
+		struct strbuf branch_ref = STRBUF_INIT;
+
+		if (!argc) {
+			if (detached)
+				die(_("Cannot give title to detached HEAD"));
+			branch_name = head;
+		} else if (argc == 1)
+			branch_name = argv[0];
+		else
+			die(_("cannot edit title of more than one branch"));
+
+		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
+		if (!ref_exists(branch_ref.buf)) {
+			strbuf_release(&branch_ref);
+
+			if (!argc)
+				return error(_("No commit on branch '%s' yet."),
+					     branch_name);
+			else
+				return error(_("No branch named '%s'."),
+					     branch_name);
+		}
+		strbuf_release(&branch_ref);
+
+		if (edit_branch_description(branch_name, 0))
 			return 1;
 	} else if (rename) {
 		if (!argc)
-- 
1.9.1
