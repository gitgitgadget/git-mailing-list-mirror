Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E50120899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbdHBTtt (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:49:49 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36637 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbdHBTtq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:49:46 -0400
Received: by mail-pg0-f51.google.com with SMTP id v77so19417238pgb.3
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UV7/FE+146DWYOZpB96b322WO8O40974hwmzEDy16dA=;
        b=mE265bcOE/CL/7mhh+QKtlLtyFDJ/YD7/SH0pf3KUhTOvZ6hq1Gw3PTzom57RIkOGh
         mIN2xipH/BHJ2mREh+vissBTUPjpC0uIW45H80mpGvhqqIGdsUyo6qVSsGdTikjwWC+M
         zaz8stlHSUmVPjE0ZVheJfAvgxieJvD5BL7/kcCHH8aHOPul49ggKTquzVkXn/N1dfJy
         monTpVlI1CwlCxA/k+fP07VTbQ/osdSMK0zkL2aOjsUc+uORGOGlVEGl/cpE+fFqjY2C
         ACZ1FPd1OUrXX5ZK6zGjxl0CVuCUXDfRTOSOwQkO5dwgHncW+ijABDN5dScgmtx42zHP
         dbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UV7/FE+146DWYOZpB96b322WO8O40974hwmzEDy16dA=;
        b=COED7W8XXkLyuBy6J0X60n0BrBIhC2wakeFVdifSXozs3KhgX3En2bn2gCzfJSjlSq
         FFZ8E/lXFoqG6ndayBwMcn4IT319EpH3ibzz2x+QJIOSDidciGtvORRkaf9gmtS3Tpz7
         cCbVSf0EsDS9+aO91Hot1tMOUPABj9JDl8YW2mTITYl1YsyC3D9Acd7KyhN9KiXBls68
         K0QnMVnG5aWQxFMFQqZ5ZkV/6126MlHAwVWjnCAB59ATodSr5etd+mWlDp+iMjcMJVdn
         StxbyvS5dsIwi5bPgl8RuwC/XJQwbPNpPyM3iQa3vLbinIh//G4TFhiOBjYSKAb1X5JO
         tdiA==
X-Gm-Message-State: AIVw113Rmmw8vLKr3sVzKf7l2lA/oalbUv00590CzbUuyilZlwzP2Xtk
        zgOKWyAOLUHVqlbdM51/Lg==
X-Received: by 10.98.27.65 with SMTP id b62mr23771340pfb.258.1501703384611;
        Wed, 02 Aug 2017 12:49:44 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id e64sm63401460pfb.129.2017.08.02.12.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:49:43 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 10/10] grep: recurse in-process using 'struct repository'
Date:   Wed,  2 Aug 2017 12:49:23 -0700
Message-Id: <20170802194923.88239-11-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170802194923.88239-1-bmwill@google.com>
References: <20170718190527.78049-1-bmwill@google.com>
 <20170802194923.88239-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert grep to use 'struct repository' which enables recursing into
submodules to be handled in-process.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-grep.txt |   7 -
 builtin/grep.c             | 396 ++++++++++-----------------------------------
 cache.h                    |   1 -
 git.c                      |   2 +-
 grep.c                     |  13 --
 grep.h                     |   1 -
 setup.c                    |  12 +-
 7 files changed, 88 insertions(+), 344 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 5033483db..720c7850e 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -95,13 +95,6 @@ OPTIONS
 	<tree> option the prefix of all submodule output will be the name of
 	the parent project's <tree> object.
 
---parent-basename <basename>::
-	For internal use only.  In order to produce uniform output with the
-	--recurse-submodules option, this option can be used to provide the
-	basename of a parent's <tree> object to a submodule so the submodule
-	can prefix its output with the parent's name rather than the SHA1 of
-	the submodule.
-
 -a::
 --text::
 	Process binary files as if they were text.
diff --git a/builtin/grep.c b/builtin/grep.c
index 7e79eb1a7..cd0e51f3c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -28,13 +28,7 @@ static char const * const grep_usage[] = {
 	NULL
 };
 
-static const char *super_prefix;
 static int recurse_submodules;
-static struct argv_array submodule_options = ARGV_ARRAY_INIT;
-static const char *parent_basename;
-
-static int grep_submodule_launch(struct grep_opt *opt,
-				 const struct grep_source *gs);
 
 #define GREP_NUM_THREADS_DEFAULT 8
 static int num_threads;
@@ -186,10 +180,7 @@ static void *run(void *arg)
 			break;
 
 		opt->output_priv = w;
-		if (w->source.type == GREP_SOURCE_SUBMODULE)
-			hit |= grep_submodule_launch(opt, &w->source);
-		else
-			hit |= grep_source(opt, &w->source);
+		hit |= grep_source(opt, &w->source);
 		grep_source_clear_data(&w->source);
 		work_done(w);
 	}
@@ -327,21 +318,13 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 {
 	struct strbuf pathbuf = STRBUF_INIT;
 
-	if (super_prefix) {
-		strbuf_add(&pathbuf, filename, tree_name_len);
-		strbuf_addstr(&pathbuf, super_prefix);
-		strbuf_addstr(&pathbuf, filename + tree_name_len);
+	if (opt->relative && opt->prefix_length) {
+		quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
+		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
 	} else {
 		strbuf_addstr(&pathbuf, filename);
 	}
 
-	if (opt->relative && opt->prefix_length) {
-		char *name = strbuf_detach(&pathbuf, NULL);
-		quote_path_relative(name + tree_name_len, opt->prefix, &pathbuf);
-		strbuf_insert(&pathbuf, 0, name, tree_name_len);
-		free(name);
-	}
-
 #ifndef NO_PTHREADS
 	if (num_threads) {
 		add_work(opt, GREP_SOURCE_OID, pathbuf.buf, path, oid);
@@ -366,15 +349,10 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	if (super_prefix)
-		strbuf_addstr(&buf, super_prefix);
-	strbuf_addstr(&buf, filename);
-
-	if (opt->relative && opt->prefix_length) {
-		char *name = strbuf_detach(&buf, NULL);
-		quote_path_relative(name, opt->prefix, &buf);
-		free(name);
-	}
+	if (opt->relative && opt->prefix_length)
+		quote_path_relative(filename, opt->prefix, &buf);
+	else
+		strbuf_addstr(&buf, filename);
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
@@ -421,284 +399,89 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 		exit(status);
 }
 
-static void compile_submodule_options(const struct grep_opt *opt,
-				      const char **argv,
-				      int cached, int untracked,
-				      int opt_exclude, int use_index,
-				      int pattern_type_arg)
-{
-	struct grep_pat *pattern;
-
-	if (recurse_submodules)
-		argv_array_push(&submodule_options, "--recurse-submodules");
-
-	if (cached)
-		argv_array_push(&submodule_options, "--cached");
-	if (!use_index)
-		argv_array_push(&submodule_options, "--no-index");
-	if (untracked)
-		argv_array_push(&submodule_options, "--untracked");
-	if (opt_exclude > 0)
-		argv_array_push(&submodule_options, "--exclude-standard");
-
-	if (opt->invert)
-		argv_array_push(&submodule_options, "-v");
-	if (opt->ignore_case)
-		argv_array_push(&submodule_options, "-i");
-	if (opt->word_regexp)
-		argv_array_push(&submodule_options, "-w");
-	switch (opt->binary) {
-	case GREP_BINARY_NOMATCH:
-		argv_array_push(&submodule_options, "-I");
-		break;
-	case GREP_BINARY_TEXT:
-		argv_array_push(&submodule_options, "-a");
-		break;
-	default:
-		break;
-	}
-	if (opt->allow_textconv)
-		argv_array_push(&submodule_options, "--textconv");
-	if (opt->max_depth != -1)
-		argv_array_pushf(&submodule_options, "--max-depth=%d",
-				 opt->max_depth);
-	if (opt->linenum)
-		argv_array_push(&submodule_options, "-n");
-	if (!opt->pathname)
-		argv_array_push(&submodule_options, "-h");
-	if (!opt->relative)
-		argv_array_push(&submodule_options, "--full-name");
-	if (opt->name_only)
-		argv_array_push(&submodule_options, "-l");
-	if (opt->unmatch_name_only)
-		argv_array_push(&submodule_options, "-L");
-	if (opt->null_following_name)
-		argv_array_push(&submodule_options, "-z");
-	if (opt->count)
-		argv_array_push(&submodule_options, "-c");
-	if (opt->file_break)
-		argv_array_push(&submodule_options, "--break");
-	if (opt->heading)
-		argv_array_push(&submodule_options, "--heading");
-	if (opt->pre_context)
-		argv_array_pushf(&submodule_options, "--before-context=%d",
-				 opt->pre_context);
-	if (opt->post_context)
-		argv_array_pushf(&submodule_options, "--after-context=%d",
-				 opt->post_context);
-	if (opt->funcname)
-		argv_array_push(&submodule_options, "-p");
-	if (opt->funcbody)
-		argv_array_push(&submodule_options, "-W");
-	if (opt->all_match)
-		argv_array_push(&submodule_options, "--all-match");
-	if (opt->debug)
-		argv_array_push(&submodule_options, "--debug");
-	if (opt->status_only)
-		argv_array_push(&submodule_options, "-q");
-
-	switch (pattern_type_arg) {
-	case GREP_PATTERN_TYPE_BRE:
-		argv_array_push(&submodule_options, "-G");
-		break;
-	case GREP_PATTERN_TYPE_ERE:
-		argv_array_push(&submodule_options, "-E");
-		break;
-	case GREP_PATTERN_TYPE_FIXED:
-		argv_array_push(&submodule_options, "-F");
-		break;
-	case GREP_PATTERN_TYPE_PCRE:
-		argv_array_push(&submodule_options, "-P");
-		break;
-	case GREP_PATTERN_TYPE_UNSPECIFIED:
-		break;
-	default:
-		die("BUG: Added a new grep pattern type without updating switch statement");
-	}
-
-	for (pattern = opt->pattern_list; pattern != NULL;
-	     pattern = pattern->next) {
-		switch (pattern->token) {
-		case GREP_PATTERN:
-			argv_array_pushf(&submodule_options, "-e%s",
-					 pattern->pattern);
-			break;
-		case GREP_AND:
-		case GREP_OPEN_PAREN:
-		case GREP_CLOSE_PAREN:
-		case GREP_NOT:
-		case GREP_OR:
-			argv_array_push(&submodule_options, pattern->pattern);
-			break;
-		/* BODY and HEAD are not used by git-grep */
-		case GREP_PATTERN_BODY:
-		case GREP_PATTERN_HEAD:
-			break;
-		}
-	}
-
-	/*
-	 * Limit number of threads for child process to use.
-	 * This is to prevent potential fork-bomb behavior of git-grep as each
-	 * submodule process has its own thread pool.
-	 */
-	argv_array_pushf(&submodule_options, "--threads=%d",
-			 DIV_ROUND_UP(num_threads, 2));
-
-	/* Add Pathspecs */
-	argv_array_push(&submodule_options, "--");
-	for (; *argv; argv++)
-		argv_array_push(&submodule_options, *argv);
-}
+static int grep_cache(struct grep_opt *opt, struct repository *repo,
+		      const struct pathspec *pathspec, int cached);
+static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
+		     struct tree_desc *tree, struct strbuf *base, int tn_len,
+		     int check_attr, struct repository *repo);
 
-/*
- * Launch child process to grep contents of a submodule
- */
-static int grep_submodule_launch(struct grep_opt *opt,
-				 const struct grep_source *gs)
+static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
+			  const struct pathspec *pathspec,
+			  const struct object_id *oid,
+			  const char *filename, const char *path)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	int status, i;
-	const char *end_of_base;
-	const char *name;
-	struct strbuf child_output = STRBUF_INIT;
-
-	end_of_base = strchr(gs->name, ':');
-	if (gs->identifier && end_of_base)
-		name = end_of_base + 1;
-	else
-		name = gs->name;
+	struct repository submodule;
+	int hit;
 
-	prepare_submodule_repo_env(&cp.env_array);
-	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
+	if (!is_submodule_active(superproject, path))
+		return 0;
 
-	if (opt->relative && opt->prefix_length)
-		argv_array_pushf(&cp.env_array, "%s=%s",
-				 GIT_TOPLEVEL_PREFIX_ENVIRONMENT,
-				 opt->prefix);
+	if (repo_submodule_init(&submodule, superproject, path))
+		return 0;
 
-	/* Add super prefix */
-	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
-			 super_prefix ? super_prefix : "",
-			 name);
-	argv_array_push(&cp.args, "grep");
+	repo_read_gitmodules(&submodule);
 
 	/*
-	 * Add basename of parent project
-	 * When performing grep on a tree object the filename is prefixed
-	 * with the object's name: 'tree-name:filename'.  In order to
-	 * provide uniformity of output we want to pass the name of the
-	 * parent project's object name to the submodule so the submodule can
-	 * prefix its output with the parent's name and not its own OID.
+	 * NEEDSWORK: This adds the submodule's object directory to the list of
+	 * alternates for the single in-memory object store.  This has some bad
+	 * consequences for memory (processed objects will never be freed) and
+	 * performance (this increases the number of pack files git has to pay
+	 * attention to, to the sum of the number of pack files in all the
+	 * repositories processed so far).  This can be removed once the object
+	 * store is no longer global and instead is a member of the repository
+	 * object.
 	 */
-	if (gs->identifier && end_of_base)
-		argv_array_pushf(&cp.args, "--parent-basename=%.*s",
-				 (int) (end_of_base - gs->name),
-				 gs->name);
+	add_to_alternates_memory(submodule.objectdir);
 
-	/* Add options */
-	for (i = 0; i < submodule_options.argc; i++) {
-		/*
-		 * If there is a tree identifier for the submodule, add the
-		 * rev after adding the submodule options but before the
-		 * pathspecs.  To do this we listen for the '--' and insert the
-		 * oid before pushing the '--' onto the child process argv
-		 * array.
-		 */
-		if (gs->identifier &&
-		    !strcmp("--", submodule_options.argv[i])) {
-			argv_array_push(&cp.args, oid_to_hex(gs->identifier));
-		}
+	if (oid) {
+		struct object *object;
+		struct tree_desc tree;
+		void *data;
+		unsigned long size;
+		struct strbuf base = STRBUF_INIT;
 
-		argv_array_push(&cp.args, submodule_options.argv[i]);
-	}
+		object = parse_object_or_die(oid, oid_to_hex(oid));
 
-	cp.git_cmd = 1;
-	cp.dir = gs->path;
+		grep_read_lock();
+		data = read_object_with_reference(object->oid.hash, tree_type,
+						  &size, NULL);
+		grep_read_unlock();
 
-	/*
-	 * Capture output to output buffer and check the return code from the
-	 * child process.  A '0' indicates a hit, a '1' indicates no hit and
-	 * anything else is an error.
-	 */
-	status = capture_command(&cp, &child_output, 0);
-	if (status && (status != 1)) {
-		/* flush the buffer */
-		write_or_die(1, child_output.buf, child_output.len);
-		die("process for submodule '%s' failed with exit code: %d",
-		    gs->name, status);
-	}
+		if (!data)
+			die(_("unable to read tree (%s)"), oid_to_hex(&object->oid));
 
-	opt->output(opt, child_output.buf, child_output.len);
-	strbuf_release(&child_output);
-	/* invert the return code to make a hit equal to 1 */
-	return !status;
-}
+		strbuf_addstr(&base, filename);
+		strbuf_addch(&base, '/');
 
-/*
- * Prep grep structures for a submodule grep
- * oid: the oid of the submodule or NULL if using the working tree
- * filename: name of the submodule including tree name of parent
- * path: location of the submodule
- */
-static int grep_submodule(struct grep_opt *opt, const struct object_id *oid,
-			  const char *filename, const char *path)
-{
-	if (!is_submodule_active(the_repository, path))
-		return 0;
-	if (!is_submodule_populated_gently(path, NULL)) {
-		/*
-		 * If searching history, check for the presence of the
-		 * submodule's gitdir before skipping the submodule.
-		 */
-		if (oid) {
-			const struct submodule *sub =
-					submodule_from_path(null_sha1, path);
-			if (sub)
-				path = git_path("modules/%s", sub->name);
-
-			if (!(is_directory(path) && is_git_directory(path)))
-				return 0;
-		} else {
-			return 0;
-		}
+		init_tree_desc(&tree, data, size);
+		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
+				object->type == OBJ_COMMIT, &submodule);
+		strbuf_release(&base);
+		free(data);
+	} else {
+		hit = grep_cache(opt, &submodule, pathspec, 1);
 	}
 
-#ifndef NO_PTHREADS
-	if (num_threads) {
-		add_work(opt, GREP_SOURCE_SUBMODULE, filename, path, oid);
-		return 0;
-	} else
-#endif
-	{
-		struct grep_source gs;
-		int hit;
-
-		grep_source_init(&gs, GREP_SOURCE_SUBMODULE,
-				 filename, path, oid);
-		hit = grep_submodule_launch(opt, &gs);
-
-		grep_source_clear(&gs);
-		return hit;
-	}
+	repo_clear(&submodule);
+	return hit;
 }
 
-static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
-		      int cached)
+static int grep_cache(struct grep_opt *opt, struct repository *repo,
+		      const struct pathspec *pathspec, int cached)
 {
 	int hit = 0;
 	int nr;
 	struct strbuf name = STRBUF_INIT;
 	int name_base_len = 0;
-	if (super_prefix) {
-		name_base_len = strlen(super_prefix);
-		strbuf_addstr(&name, super_prefix);
+	if (repo->submodule_prefix) {
+		name_base_len = strlen(repo->submodule_prefix);
+		strbuf_addstr(&name, repo->submodule_prefix);
 	}
 
-	read_cache();
+	repo_read_index(repo);
 
-	for (nr = 0; nr < active_nr; nr++) {
-		const struct cache_entry *ce = active_cache[nr];
+	for (nr = 0; nr < repo->index->cache_nr; nr++) {
+		const struct cache_entry *ce = repo->index->cache[nr];
 		strbuf_setlen(&name, name_base_len);
 		strbuf_addstr(&name, ce->name);
 
@@ -715,14 +498,14 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
 			    ce_skip_worktree(ce)) {
 				if (ce_stage(ce) || ce_intent_to_add(ce))
 					continue;
-				hit |= grep_oid(opt, &ce->oid, ce->name,
-						 0, ce->name);
+				hit |= grep_oid(opt, &ce->oid, name.buf,
+						 0, name.buf);
 			} else {
-				hit |= grep_file(opt, ce->name);
+				hit |= grep_file(opt, name.buf);
 			}
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
 			   submodule_path_match(pathspec, name.buf, NULL)) {
-			hit |= grep_submodule(opt, NULL, ce->name, ce->name);
+			hit |= grep_submodule(opt, repo, pathspec, NULL, ce->name, ce->name);
 		} else {
 			continue;
 		}
@@ -730,8 +513,8 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (ce_stage(ce)) {
 			do {
 				nr++;
-			} while (nr < active_nr &&
-				 !strcmp(ce->name, active_cache[nr]->name));
+			} while (nr < repo->index->cache_nr &&
+				 !strcmp(ce->name, repo->index->cache[nr]->name));
 			nr--; /* compensate for loop control */
 		}
 		if (hit && opt->status_only)
@@ -744,7 +527,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
 
 static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
-		     int check_attr)
+		     int check_attr, struct repository *repo)
 {
 	int hit = 0;
 	enum interesting match = entry_not_interesting;
@@ -752,8 +535,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 	int old_baselen = base->len;
 	struct strbuf name = STRBUF_INIT;
 	int name_base_len = 0;
-	if (super_prefix) {
-		strbuf_addstr(&name, super_prefix);
+	if (repo->submodule_prefix) {
+		strbuf_addstr(&name, repo->submodule_prefix);
 		name_base_len = name.len;
 	}
 
@@ -791,11 +574,11 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			strbuf_addch(base, '/');
 			init_tree_desc(&sub, data, size);
 			hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
-					 check_attr);
+					 check_attr, repo);
 			free(data);
 		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
-			hit |= grep_submodule(opt, entry.oid, base->buf,
-					      base->buf + tn_len);
+			hit |= grep_submodule(opt, repo, pathspec, entry.oid,
+					      base->buf, base->buf + tn_len);
 		}
 
 		strbuf_setlen(base, old_baselen);
@@ -809,7 +592,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
-		       struct object *obj, const char *name, const char *path)
+		       struct object *obj, const char *name, const char *path,
+		       struct repository *repo)
 {
 	if (obj->type == OBJ_BLOB)
 		return grep_oid(opt, &obj->oid, name, 0, path);
@@ -828,10 +612,6 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(&obj->oid));
 
-		/* Use parent's name as base when recursing submodules */
-		if (recurse_submodules && parent_basename)
-			name = parent_basename;
-
 		len = name ? strlen(name) : 0;
 		strbuf_init(&base, PATH_MAX + len + 1);
 		if (len) {
@@ -840,7 +620,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		}
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
-				obj->type == OBJ_COMMIT);
+				obj->type == OBJ_COMMIT, repo);
 		strbuf_release(&base);
 		free(data);
 		return hit;
@@ -849,6 +629,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
+			struct repository *repo,
 			const struct object_array *list)
 {
 	unsigned int i;
@@ -864,7 +645,8 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 			submodule_free();
 			gitmodules_config_sha1(real_obj->oid.hash);
 		}
-		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].path)) {
+		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].path,
+				repo)) {
 			hit = 1;
 			if (opt->status_only)
 				break;
@@ -1005,9 +787,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    N_("ignore files specified via '.gitignore'"), 1),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
 			 N_("recursively search in each submodule")),
-		OPT_STRING(0, "parent-basename", &parent_basename,
-			   N_("basename"),
-			   N_("prepend parent project's basename to output")),
 		OPT_GROUP(""),
 		OPT_BOOL('v', "invert-match", &opt.invert,
 			N_("show non-matching lines")),
@@ -1112,7 +891,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	init_grep_defaults();
 	git_config(grep_cmd_config, NULL);
 	grep_init(&opt, prefix);
-	super_prefix = get_super_prefix();
 
 	/*
 	 * If there is no -- then the paths must exist in the working
@@ -1272,9 +1050,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (recurse_submodules) {
 		gitmodules_config();
-		compile_submodule_options(&opt, argv + i, cached, untracked,
-					  opt_exclude, use_index,
-					  pattern_type_arg);
 	}
 
 	if (show_in_pager && (cached || list.nr))
@@ -1318,11 +1093,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (!cached)
 			setup_work_tree();
 
-		hit = grep_cache(&opt, &pathspec, cached);
+		hit = grep_cache(&opt, the_repository, &pathspec, cached);
 	} else {
 		if (cached)
 			die(_("both --cached and trees are given."));
-		hit = grep_objects(&opt, &pathspec, &list);
+
+		hit = grep_objects(&opt, &pathspec, the_repository, &list);
 	}
 
 	if (num_threads)
diff --git a/cache.h b/cache.h
index d59f767e2..c221434b2 100644
--- a/cache.h
+++ b/cache.h
@@ -417,7 +417,6 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
 #define GIT_SUPER_PREFIX_ENVIRONMENT "GIT_INTERNAL_SUPER_PREFIX"
-#define GIT_TOPLEVEL_PREFIX_ENVIRONMENT "GIT_INTERNAL_TOPLEVEL_PREFIX"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
diff --git a/git.c b/git.c
index 489aab4d8..9dd9aead6 100644
--- a/git.c
+++ b/git.c
@@ -392,7 +392,7 @@ static struct cmd_struct commands[] = {
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id },
-	{ "grep", cmd_grep, RUN_SETUP_GENTLY | SUPPORT_SUPER_PREFIX },
+	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
diff --git a/grep.c b/grep.c
index 2efec0e18..45acd333b 100644
--- a/grep.c
+++ b/grep.c
@@ -1927,16 +1927,6 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 	case GREP_SOURCE_FILE:
 		gs->identifier = xstrdup(identifier);
 		break;
-	case GREP_SOURCE_SUBMODULE:
-		if (!identifier) {
-			gs->identifier = NULL;
-			break;
-		}
-		/*
-		 * FALL THROUGH
-		 * If the identifier is non-NULL (in the submodule case) it
-		 * will be a SHA1 that needs to be copied.
-		 */
 	case GREP_SOURCE_OID:
 		gs->identifier = oiddup(identifier);
 		break;
@@ -1959,7 +1949,6 @@ void grep_source_clear_data(struct grep_source *gs)
 	switch (gs->type) {
 	case GREP_SOURCE_FILE:
 	case GREP_SOURCE_OID:
-	case GREP_SOURCE_SUBMODULE:
 		FREE_AND_NULL(gs->buf);
 		gs->size = 0;
 		break;
@@ -2030,8 +2019,6 @@ static int grep_source_load(struct grep_source *gs)
 		return grep_source_load_oid(gs);
 	case GREP_SOURCE_BUF:
 		return gs->buf ? 0 : -1;
-	case GREP_SOURCE_SUBMODULE:
-		break;
 	}
 	die("BUG: invalid grep_source type to load");
 }
diff --git a/grep.h b/grep.h
index 0c091e510..52aecfab6 100644
--- a/grep.h
+++ b/grep.h
@@ -193,7 +193,6 @@ struct grep_source {
 		GREP_SOURCE_OID,
 		GREP_SOURCE_FILE,
 		GREP_SOURCE_BUF,
-		GREP_SOURCE_SUBMODULE,
 	} type;
 	void *identifier;
 
diff --git a/setup.c b/setup.c
index 860507e1f..23950173f 100644
--- a/setup.c
+++ b/setup.c
@@ -1027,7 +1027,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT;
-	const char *prefix, *env_prefix;
+	const char *prefix;
 
 	/*
 	 * We may have read an incomplete configuration before
@@ -1085,16 +1085,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die("BUG: unhandled setup_git_directory_1() result");
 	}
 
-	/*
-	 * NEEDSWORK: This was a hack in order to get ls-files and grep to have
-	 * properly formated output when recursing submodules.  Once ls-files
-	 * and grep have been changed to perform this recursing in-process this
-	 * needs to be removed.
-	 */
-	env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
-	if (env_prefix)
-		prefix = env_prefix;
-
 	if (prefix)
 		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
 	else
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

