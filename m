From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Portability patches vs 1.7.0.2 [4/6]
Date: Tue, 9 Mar 2010 16:11:32 +0000
Message-ID: <20100309161132.GE99172@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7LkOrbQMr4cezO2T"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 17:11:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np221-0007Na-80
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 17:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab0CIQLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 11:11:36 -0500
Received: from mail1.thewrittenword.com ([69.67.212.77]:56202 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab0CIQLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 11:11:34 -0500
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2010 11:11:33 EST
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 25CC05CCB
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 16:30:38 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 25CC05CCB
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 747AFD32
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 16:11:32 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 6EF13BAB2; Tue,  9 Mar 2010 16:11:32 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141827>


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

## Dynamic expressions in compound declarations are not portable

Unfortunately, there are still plenty of production systems with
vendor compilers that choke unless all compound declarations can be
determined statically at compile time, for example hpux10.20 (I can
provide a comprehensive list of our supported platforms that exhibit
this problem if necessary).

This patch simply breaks apart any compound declarations with dynamic
initialisation expressions, and moves the initialisation until after
the last declaration in the same block, in all the places necessary to
have the offending compilers accept the code.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)

--7LkOrbQMr4cezO2T
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="const-expr.patch"

Index: convert.c
===================================================================
--- convert.c.orig
+++ convert.c
@@ -249,7 +249,10 @@ static int filter_buffer(int fd, void *d
 	struct child_process child_process;
 	struct filter_params *params = (struct filter_params *)data;
 	int write_err, status;
-	const char *argv[] = { params->cmd, NULL };
+	const char *argv[2];
+
+	argv[0] = params->cmd;
+	argv[1] = NULL;
 
 	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
Index: remote.c
===================================================================
--- remote.c.orig
+++ remote.c
@@ -476,7 +476,7 @@ static void read_config(void)
 	unsigned char sha1[20];
 	const char *head_ref;
 	int flag;
-	if (default_remote_name) // did this already
+	if (default_remote_name) /* did this already */
 		return;
 	default_remote_name = xstrdup("origin");
 	current_branch = NULL;
@@ -657,9 +657,10 @@ static struct refspec *parse_refspec_int
 
 int valid_fetch_refspec(const char *fetch_refspec_str)
 {
-	const char *fetch_refspec[] = { fetch_refspec_str };
+	char *fetch_refspec[1];
 	struct refspec *refspec;
 
+	fetch_refspec[0] = fetch_refspec_str;
 	refspec = parse_refspec_internal(1, fetch_refspec, 1, 1);
 	free_refspecs(refspec, 1);
 	return !!refspec;
Index: unpack-trees.c
===================================================================
--- unpack-trees.c.orig
+++ unpack-trees.c
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
Index: daemon.c
===================================================================
--- daemon.c.orig
+++ daemon.c
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
+	char *argv[] = { "upload-pack", "--strict", "<timeout_buf>", ".", NULL };
+
+	argv[2] = timeout_buf;
 
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
 	return run_service_command(argv);
@@ -885,7 +886,7 @@ static int service_loop(int socknum, int
 		for (i = 0; i < socknum; i++) {
 			if (pfd[i].revents & POLLIN) {
 				struct sockaddr_storage ss;
-				unsigned int sslen = sizeof(ss);
+				size_t sslen = sizeof(ss);
 				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
Index: wt-status.c
===================================================================
--- wt-status.c.orig
+++ wt-status.c
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
+	const char *env[2] = { NULL, NULL };
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
Index: ll-merge.c
===================================================================
--- ll-merge.c.orig
+++ ll-merge.c
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
 
Index: builtin-commit.c
===================================================================
--- builtin-commit.c.orig
+++ builtin-commit.c
@@ -715,7 +715,8 @@ static int prepare_to_commit(const char 
 
 	if (use_editor) {
 		char index[PATH_MAX];
-		const char *env[2] = { index, NULL };
+		char *env[2];
+		env[0] =  index; env[1] = NULL;
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
 		if (launch_editor(git_path(commit_editmsg), NULL, env)) {
 			fprintf(stderr,
Index: builtin-remote.c
===================================================================
--- builtin-remote.c.orig
+++ builtin-remote.c
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
 
Index: builtin-blame.c
===================================================================
--- builtin-blame.c.orig
+++ builtin-blame.c
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
Index: builtin-cat-file.c
===================================================================
--- builtin-cat-file.c.orig
+++ builtin-cat-file.c
@@ -118,7 +118,10 @@ static int cat_one_file(int opt, const c
 
 		/* custom pretty-print here */
 		if (type == OBJ_TREE) {
-			const char *ls_args[3] = {"ls-tree", obj_name, NULL};
+			char *ls_args[3];
+			ls_args[0] =  "ls-tree";
+			ls_args[1] =  obj_name;
+			ls_args[2] = NULL;
 			return cmd_ls_tree(2, ls_args, NULL);
 		}
 
Index: refs.c
===================================================================
--- refs.c.orig
+++ refs.c
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
 
Index: builtin-pack-objects.c
===================================================================
--- builtin-pack-objects.c.orig
+++ builtin-pack-objects.c
@@ -1651,6 +1651,8 @@ static void ll_find_deltas(struct object
 				delta_search_threads);
 	p = xcalloc(delta_search_threads, sizeof(*p));
 
+	p = xmalloc(delta_search_threads * sizeof(struct thread_params));
+
 	/* Partition the work amongst work threads. */
 	for (i = 0; i < delta_search_threads; i++) {
 		unsigned sub_size = list_size / (delta_search_threads - i);
@@ -2085,6 +2087,8 @@ static void loosen_unused_packed_objects
 					die("unable to force loose object");
 		}
 	}
+
+	free(p);
 }
 
 static void get_object_list(int ac, const char **av)
Index: builtin-add.c
===================================================================
--- builtin-add.c.orig
+++ builtin-add.c
@@ -254,13 +254,15 @@ int interactive_add(int argc, const char
 static int edit_patch(int argc, const char **argv, const char *prefix)
 {
 	char *file = xstrdup(git_path("ADD_EDIT.patch"));
-	const char *apply_argv[] = { "apply", "--recount", "--cached",
-		file, NULL };
+	char *apply_argv[] = { "apply", "--recount", "--cached",
+		"<file>", NULL };
 	struct child_process child;
 	struct rev_info rev;
 	int out;
 	struct stat st;
 
+	apply_argv[3] = file;
+
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
 	if (read_cache() < 0)
Index: builtin-checkout.c
===================================================================
--- builtin-checkout.c.orig
+++ builtin-checkout.c
@@ -612,7 +612,8 @@ static int check_tracking_name(const cha
 
 static const char *unique_tracking_name(const char *name)
 {
-	struct tracking_name_data cb_data = { name, NULL, 1 };
+	struct tracking_name_data cb_data = { NULL, NULL, 1 };
+        cb_data.name = name;
 	for_each_ref(check_tracking_name, &cb_data);
 	if (cb_data.unique)
 		return cb_data.remote;
Index: builtin-fetch.c
===================================================================
--- builtin-fetch.c.orig
+++ builtin-fetch.c
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

--7LkOrbQMr4cezO2T--
