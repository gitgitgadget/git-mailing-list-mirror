From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 02/15] const-expr.patch
Date: Tue, 16 Mar 2010 05:42:22 +0000
Message-ID: <20100316054306.167331000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:54:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPjN-00038F-LB
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065Ab0CPFxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:35 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:54293 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757488Ab0CPFw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:57 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 4D57D5CC6
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:02:28 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 4D57D5CC6
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 56C7CDE5;
	Tue, 16 Mar 2010 05:43:06 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 4C2BA11D4D5; Tue, 16 Mar 2010 05:43:06 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=const-expr.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142314>

Unfortunately, there are still plenty of production systems with
vendor compilers that choke unless all compound declarations can be
determined statically at compile time, for example hpux10.20 (I can
provide a comprehensive list of our supported platforms that exhibit
this problem if necessary).

This patch simply breaks apart any compound declarations with dynamic
initialisation expressions, and moves the initialisation until after
the last declaration in the same block, in all the places necessary to
have the offending compilers accept the code.
---
 builtin-add.c      |    4 +++-
 builtin-blame.c    |   10 ++++++----
 builtin-cat-file.c |    4 +++-
 builtin-checkout.c |    3 ++-
 builtin-commit.c   |    3 ++-
 builtin-fetch.c    |    6 ++++--
 builtin-remote.c   |    9 ++++++---
 convert.c          |    4 +++-
 daemon.c           |   19 ++++++++++---------
 ll-merge.c         |   14 +++++++-------
 refs.c             |    6 +++++-
 remote.c           |    3 +--
 unpack-trees.c     |    4 +++-
 wt-status.c        |   23 ++++++++++++-----------
 14 files changed, 67 insertions(+), 45 deletions(-)

Index: b/convert.c
===================================================================
--- a/convert.c
+++ b/convert.c
@@ -249,7 +249,9 @@ static int filter_buffer(int in, int out
 	struct child_process child_process;
 	struct filter_params *params = (struct filter_params *)data;
 	int write_err, status;
-	const char *argv[] = { params->cmd, NULL };
+	const char *argv[] = { NULL, NULL };
+
+	argv[0] = params->cmd;
 
 	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
Index: b/remote.c
===================================================================
--- a/remote.c
+++ b/remote.c
@@ -657,10 +657,9 @@ static struct refspec *parse_refspec_int
 
 int valid_fetch_refspec(const char *fetch_refspec_str)
 {
-	const char *fetch_refspec[] = { fetch_refspec_str };
 	struct refspec *refspec;
 
-	refspec = parse_refspec_internal(1, fetch_refspec, 1, 1);
+	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
 	free_refspecs(refspec, 1);
 	return !!refspec;
 }
Index: b/unpack-trees.c
===================================================================
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -287,9 +287,11 @@ static void add_same_unmerged(struct cac
 static int unpack_index_entry(struct cache_entry *ce,
 			      struct unpack_trees_options *o)
 {
-	struct cache_entry *src[5] = { ce, NULL, };
+	struct cache_entry *src[5] = { NULL, NULL };
 	int ret;
 
+	src[0] = ce;
+
 	mark_ce_used(ce, o);
 	if (ce_stage(ce)) {
 		if (o->skip_unmerged) {
Index: b/daemon.c
===================================================================
--- a/daemon.c
+++ b/daemon.c
@@ -141,15 +141,14 @@ static char *path_ok(char *directory)
 	}
 	else if (interpolated_path && saw_extended_args) {
 		struct strbuf expanded_path = STRBUF_INIT;
-		struct strbuf_expand_dict_entry dict[] = {
-			{ "H", hostname },
-			{ "CH", canon_hostname },
-			{ "IP", ip_address },
-			{ "P", tcp_port },
-			{ "D", directory },
-			{ NULL }
-		};
+		struct strbuf_expand_dict_entry dict[6];
 
+		dict[0].placeholder = "H"; dict[0].value = hostname;
+		dict[1].placeholder = "CH"; dict[1].value = canon_hostname;
+		dict[2].placeholder = "IP"; dict[2].value = ip_address;
+		dict[3].placeholder = "P"; dict[3].value = tcp_port;
+		dict[4].placeholder = "D"; dict[4].value = directory;
+		dict[5].placeholder = NULL; dict[5].value = NULL;
 		if (*dir != '/') {
 			/* Allow only absolute */
 			logerror("'%s': Non-absolute path denied (interpolated-path active)", dir);
@@ -343,7 +342,9 @@ static int upload_pack(void)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
-	const char *argv[] = { "upload-pack", "--strict", timeout_buf, ".", NULL };
+	const char *argv[] = { "upload-pack", "--strict", NULL, ".", NULL };
+
+	argv[2] = timeout_buf;
 
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
 	return run_service_command(argv);
Index: b/wt-status.c
===================================================================
--- a/wt-status.c
+++ b/wt-status.c
@@ -464,17 +464,18 @@ static void wt_status_print_submodule_su
 	struct child_process sm_summary;
 	char summary_limit[64];
 	char index[PATH_MAX];
-	const char *env[] = { index, NULL };
-	const char *argv[] = {
-		"submodule",
-		"summary",
-		uncommitted ? "--files" : "--cached",
-		"--for-status",
-		"--summary-limit",
-		summary_limit,
-		uncommitted ? NULL : (s->amend ? "HEAD^" : "HEAD"),
-		NULL
-	};
+	const char *env[] = { NULL, NULL };
+	const char *argv[8];
+
+	env[0] =	index;
+	argv[0] =	"submodule";
+	argv[1] =	"summary";
+	argv[2] =	uncommitted ? "--files" : "--cached";
+	argv[3] =	"--for-status";
+	argv[4] =	"--summary-limit";
+	argv[5] =	summary_limit;
+	argv[6] =	uncommitted ? NULL : (s->amend ? "HEAD^" : "HEAD");
+	argv[7] =	NULL;
 
 	sprintf(summary_limit, "%d", s->submodule_summary);
 	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);
Index: b/ll-merge.c
===================================================================
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -172,17 +172,17 @@ static int ll_ext_merge(const struct ll_
 {
 	char temp[4][50];
 	struct strbuf cmd = STRBUF_INIT;
-	struct strbuf_expand_dict_entry dict[] = {
-		{ "O", temp[0] },
-		{ "A", temp[1] },
-		{ "B", temp[2] },
-		{ "L", temp[3] },
-		{ NULL }
-	};
+	struct strbuf_expand_dict_entry dict[5];
 	const char *args[] = { NULL, NULL };
 	int status, fd, i;
 	struct stat st;
 
+	dict[0].placeholder = "O"; dict[0].value = temp[0];
+	dict[1].placeholder = "A"; dict[1].value = temp[1];
+	dict[2].placeholder = "B"; dict[2].value = temp[2];
+	dict[3].placeholder = "L"; dict[3].value = temp[3];
+	dict[3].placeholder = NULL; dict[3].value = NULL;
+
 	if (fn->cmdline == NULL)
 		die("custom merge driver %s lacks command line.", fn->name);
 
Index: b/builtin-commit.c
===================================================================
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -715,7 +715,8 @@ static int prepare_to_commit(const char 
 
 	if (use_editor) {
 		char index[PATH_MAX];
-		const char *env[2] = { index, NULL };
+		const char *env[] = { NULL, NULL };
+		env[0] =  index;
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
 		if (launch_editor(git_path(commit_editmsg), NULL, env)) {
 			fprintf(stderr,
Index: b/builtin-remote.c
===================================================================
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -705,11 +705,14 @@ static int rm(int argc, const char **arg
 	struct known_remotes known_remotes = { NULL, NULL };
 	struct string_list branches = { NULL, 0, 0, 1 };
 	struct string_list skipped = { NULL, 0, 0, 1 };
-	struct branches_for_remote cb_data = {
-		NULL, &branches, &skipped, &known_remotes
-	};
+	struct branches_for_remote cb_data;
 	int i, result;
 
+	memset(&cb_data,0,sizeof(cb_data));
+	cb_data.branches = &branches;
+	cb_data.skipped = &skipped;
+	cb_data.keep = &known_remotes;
+
 	if (argc != 2)
 		usage_with_options(builtin_remote_rm_usage, options);
 
Index: b/builtin-blame.c
===================================================================
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -733,10 +733,11 @@ static int pass_blame_to_parent(struct s
 {
 	int last_in_target;
 	mmfile_t file_p, file_o;
-	struct blame_chunk_cb_data d = { sb, target, parent, 0, 0 };
+	struct blame_chunk_cb_data d;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
-
+	memset(&d,0,sizeof(d));
+	d.sb = sb; d.target = target; d.parent=parent;
 	last_in_target = find_last_in_target(sb, target);
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
@@ -875,10 +876,11 @@ static void find_copy_in_blob(struct sco
 	const char *cp;
 	int cnt;
 	mmfile_t file_o;
-	struct handle_split_cb_data d = { sb, ent, parent, split, 0, 0 };
+	struct handle_split_cb_data d;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
-
+	memset(&d,0,sizeof(d));
+	d.sb = sb; d.ent = ent; d.parent = parent; d.split = split;
 	/*
 	 * Prepare mmfile that contains only the lines in ent.
 	 */
Index: b/builtin-cat-file.c
===================================================================
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -118,7 +118,9 @@ static int cat_one_file(int opt, const c
 
 		/* custom pretty-print here */
 		if (type == OBJ_TREE) {
-			const char *ls_args[3] = {"ls-tree", obj_name, NULL};
+			const char *ls_args[3] = { NULL, NULL, NULL };
+			ls_args[0] =  "ls-tree";
+			ls_args[1] =  obj_name;
 			return cmd_ls_tree(2, ls_args, NULL);
 		}
 
Index: b/refs.c
===================================================================
--- a/refs.c
+++ b/refs.c
@@ -311,7 +311,11 @@ static int warn_if_dangling_symref(const
 
 void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 {
-	struct warn_if_dangling_data data = { fp, refname, msg_fmt };
+	struct warn_if_dangling_data data;
+
+	data.fp = fp;
+	data.refname = refname;
+	data.msg_fmt = msg_fmt;
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
Index: b/builtin-add.c
===================================================================
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -255,12 +255,14 @@ static int edit_patch(int argc, const ch
 {
 	char *file = xstrdup(git_path("ADD_EDIT.patch"));
 	const char *apply_argv[] = { "apply", "--recount", "--cached",
-		file, NULL };
+		NULL, NULL };
 	struct child_process child;
 	struct rev_info rev;
 	int out;
 	struct stat st;
 
+	apply_argv[3] = file;
+
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
 	if (read_cache() < 0)
Index: b/builtin-checkout.c
===================================================================
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -612,7 +612,8 @@ static int check_tracking_name(const cha
 
 static const char *unique_tracking_name(const char *name)
 {
-	struct tracking_name_data cb_data = { name, NULL, 1 };
+	struct tracking_name_data cb_data = { NULL, NULL, 1 };
+	cb_data.name = name;
 	for_each_ref(check_tracking_name, &cb_data);
 	if (cb_data.unique)
 		return cb_data.remote;
Index: b/builtin-fetch.c
===================================================================
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -573,9 +573,10 @@ static void find_non_local_tags(struct t
 {
 	struct string_list existing_refs = { NULL, 0, 0, 0 };
 	struct string_list remote_refs = { NULL, 0, 0, 0 };
-	struct tag_data data = {head, tail};
+	struct tag_data data;
 	const struct ref *ref;
 	struct string_list_item *item = NULL;
+	data.head = head; data.tail = tail;
 
 	for_each_ref(add_existing, &existing_refs);
 	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
@@ -768,7 +769,8 @@ static int get_remote_group(const char *
 static int add_remote_or_group(const char *name, struct string_list *list)
 {
 	int prev_nr = list->nr;
-	struct remote_group_data g = { name, list };
+	struct remote_group_data g;
+	g.name = name; g.list = list;
 
 	git_config(get_remote_group, &g);
 	if (list->nr == prev_nr) {

-- 
Gary V. Vaughan (gary@thewrittenword.com)
