From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] rename git_path() to git_path_unsafe()
Date: Wed, 16 Nov 2011 02:07:16 -0600
Message-ID: <20111116080716.GE13706@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
 <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 <20111116075955.GB13706@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 09:07:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQaWn-00062X-ID
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 09:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab1KPIHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 03:07:24 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51783 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab1KPIHW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 03:07:22 -0500
Received: by iage36 with SMTP id e36so252099iag.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 00:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=w9XhxplYdQQys2GD2gF201x22uLyg6RZOXH8oIsT1PQ=;
        b=tpV8xkXU85k8MKRYoAeK0lmt4Zc82Jt+3fntF91mcHgM6svTrByQH24VhxYpzddHO1
         ZNW3nn7ppPaptGCZZDojr18U/mkGm4LwvfgPE5aLhQI3WWpDFAmoKMIDWAVJUoO72ws2
         GfdHhKUC+Pu/x1YpsimWpoGO6dGAmcHvRMTQ4=
Received: by 10.42.147.72 with SMTP id m8mr31307117icv.56.1321430841697;
        Wed, 16 Nov 2011 00:07:21 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id e2sm41330403ibe.0.2011.11.16.00.07.20
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 00:07:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111116075955.GB13706@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185524>

git_path() stores its result to one of a rotating collection of four
static buffers.  If more than 4 git_path() results are in play, the
result can be a little unpleasant, as each call clobbers the return
value from previous calls.

Therefore callers should be careful not to assign the return value
from git_path() to a long-lived variable.  Rename the function to
git_path_unsafe() as a reminder.

Mechanics: This patch only makes three kinds of changes:

 1) changing git_path(foo) to git_path_unsafe(foo)
 2) changing xstrdup(git_path(foo)) to git_pathdup(foo)
 3) rewrapping lines that were made longer by (1)

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/technical/api-string-list.txt |    5 +-
 attr.c                                      |    2 +-
 bisect.c                                    |    8 ++--
 branch.c                                    |   12 +++---
 builtin/add.c                               |    2 +-
 builtin/commit.c                            |   57 ++++++++++++++-------------
 builtin/config.c                            |    4 +-
 builtin/fetch-pack.c                        |    4 +-
 builtin/fetch.c                             |    5 +-
 builtin/fsck.c                              |    2 +-
 builtin/init-db.c                           |   12 +++---
 builtin/merge.c                             |   32 +++++++-------
 builtin/notes.c                             |    2 +-
 builtin/remote.c                            |    6 +-
 builtin/reset.c                             |    2 +-
 builtin/revert.c                            |   18 ++++----
 cache.h                                     |    3 +-
 contrib/examples/builtin-fetch--tool.c      |    4 +-
 dir.c                                       |    2 +-
 fast-import.c                               |    2 +-
 http-backend.c                              |    2 +-
 notes-merge.c                               |   22 ++++++-----
 pack-refs.c                                 |    6 +-
 path.c                                      |    2 +-
 refs.c                                      |   51 +++++++++++++-----------
 remote.c                                    |    4 +-
 rerere.c                                    |   12 +++---
 run-command.c                               |    4 +-
 sequencer.c                                 |    6 +-
 server-info.c                               |    2 +-
 sha1_file.c                                 |    4 +-
 shallow.c                                   |    2 +-
 transport.c                                 |    4 +-
 unpack-trees.c                              |    2 +-
 34 files changed, 160 insertions(+), 147 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index ce24eb96..446a51ab 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -13,8 +13,9 @@ The caller:
 
 . Initializes the members. You might want to set the flag `strdup_strings`
   if the strings should be strdup()ed. For example, this is necessary
-  when you add something like git_path("..."), since that function returns
-  a static buffer that will change with the next call to git_path().
+  when you add something like git_path_unsafe("..."), since that function
+  returns a static buffer that will change with the next call to
+  git_path_unsafe().
 +
 If you need something advanced, you can manually malloc() the `items`
 member (you need this if you add things later) and you should set the
diff --git a/attr.c b/attr.c
index 76b079f0..afdd6d24 100644
--- a/attr.c
+++ b/attr.c
@@ -529,7 +529,7 @@ static void bootstrap_attr_stack(void)
 			debug_push(elem);
 		}
 
-		elem = read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
+		elem = read_attr_from_file(git_path_unsafe(INFOATTRIBUTES_FILE), 1);
 		if (!elem)
 			elem = xcalloc(1, sizeof(*elem));
 		elem->origin = NULL;
diff --git a/bisect.c b/bisect.c
index 6e186e29..315d22e6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -422,7 +422,7 @@ static int read_bisect_refs(void)
 static void read_bisect_paths(struct argv_array *array)
 {
 	struct strbuf str = STRBUF_INIT;
-	const char *filename = git_path("BISECT_NAMES");
+	const char *filename = git_path_unsafe("BISECT_NAMES");
 	FILE *fp = fopen(filename, "r");
 
 	if (!fp)
@@ -643,7 +643,7 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 
 static int is_expected_rev(const unsigned char *sha1)
 {
-	const char *filename = git_path("BISECT_EXPECTED_REV");
+	const char *filename = git_path_unsafe("BISECT_EXPECTED_REV");
 	struct stat st;
 	struct strbuf str = STRBUF_INIT;
 	FILE *fp;
@@ -668,7 +668,7 @@ static int is_expected_rev(const unsigned char *sha1)
 static void mark_expected_rev(char *bisect_rev_hex)
 {
 	int len = strlen(bisect_rev_hex);
-	const char *filename = git_path("BISECT_EXPECTED_REV");
+	const char *filename = git_path_unsafe("BISECT_EXPECTED_REV");
 	int fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 
 	if (fd < 0)
@@ -833,7 +833,7 @@ static int check_ancestors(const char *prefix)
  */
 static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 {
-	const char *filename = git_path("BISECT_ANCESTORS_OK");
+	const char *filename = git_path_unsafe("BISECT_ANCESTORS_OK");
 	struct stat st;
 	int fd;
 
diff --git a/branch.c b/branch.c
index d8098762..5a3faa10 100644
--- a/branch.c
+++ b/branch.c
@@ -240,11 +240,11 @@ void create_branch(const char *head,
 
 void remove_branch_state(void)
 {
-	unlink(git_path("CHERRY_PICK_HEAD"));
-	unlink(git_path("MERGE_HEAD"));
-	unlink(git_path("MERGE_RR"));
-	unlink(git_path("MERGE_MSG"));
-	unlink(git_path("MERGE_MODE"));
-	unlink(git_path("SQUASH_MSG"));
+	unlink(git_path_unsafe("CHERRY_PICK_HEAD"));
+	unlink(git_path_unsafe("MERGE_HEAD"));
+	unlink(git_path_unsafe("MERGE_RR"));
+	unlink(git_path_unsafe("MERGE_MSG"));
+	unlink(git_path_unsafe("MERGE_MODE"));
+	unlink(git_path_unsafe("SQUASH_MSG"));
 	remove_sequencer_state(0);
 }
diff --git a/builtin/add.c b/builtin/add.c
index c59b0c98..0aabb61d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -259,7 +259,7 @@ int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 
 static int edit_patch(int argc, const char **argv, const char *prefix)
 {
-	char *file = xstrdup(git_path("ADD_EDIT.patch"));
+	char *file = git_pathdup("ADD_EDIT.patch");
 	const char *apply_argv[] = { "apply", "--recount", "--cached",
 		NULL, NULL };
 	struct child_process child;
diff --git a/builtin/commit.c b/builtin/commit.c
index c46f2d18..e9aa5e75 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -178,9 +178,9 @@ static struct option builtin_commit_options[] = {
 
 static void determine_whence(struct wt_status *s)
 {
-	if (file_exists(git_path("MERGE_HEAD")))
+	if (file_exists(git_path_unsafe("MERGE_HEAD")))
 		whence = FROM_MERGE;
-	else if (file_exists(git_path("CHERRY_PICK_HEAD")))
+	else if (file_exists(git_path_unsafe("CHERRY_PICK_HEAD")))
 		whence = FROM_CHERRY_PICK;
 	else
 		whence = FROM_COMMIT;
@@ -465,8 +465,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		die(_("unable to write new_index file"));
 
 	fd = hold_lock_file_for_update(&false_lock,
-				       git_path("next-index-%"PRIuMAX,
-						(uintmax_t) getpid()),
+				       git_path_unsafe("next-index-%"PRIuMAX,
+							(uintmax_t) getpid()),
 				       LOCK_DIE_ON_ERROR);
 
 	create_base_index(current_head);
@@ -691,12 +691,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		format_commit_message(commit, "fixup! %s\n\n",
 				      &sb, &ctx);
 		hook_arg1 = "message";
-	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
+	} else if (!stat(git_path_unsafe("MERGE_MSG"), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path_unsafe("MERGE_MSG"), 0) < 0)
 			die_errno(_("could not read MERGE_MSG"));
 		hook_arg1 = "merge";
-	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
+	} else if (!stat(git_path_unsafe("SQUASH_MSG"), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path_unsafe("SQUASH_MSG"), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
 		hook_arg1 = "squash";
 	} else if (template_file) {
@@ -727,9 +727,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg2 = "";
 	}
 
-	s->fp = fopen(git_path(commit_editmsg), "w");
+	s->fp = fopen(git_path_unsafe(commit_editmsg), "w");
 	if (s->fp == NULL)
-		die_errno(_("could not open '%s'"), git_path(commit_editmsg));
+		die_errno(_("could not open '%s'"),
+			  git_path_unsafe(commit_editmsg));
 
 	if (clean_message_contents)
 		stripspace(&sb, 0);
@@ -773,7 +774,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				"and try again.\n"
 				""),
 				whence_s(),
-				git_path(whence == FROM_MERGE
+				git_path_unsafe(whence == FROM_MERGE
 					 ? "MERGE_HEAD"
 					 : "CHERRY_PICK_HEAD"));
 
@@ -870,8 +871,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (run_hook(index_file, "prepare-commit-msg",
-		     git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
+	if (run_hook(index_file,
+		     "prepare-commit-msg", git_path_unsafe(commit_editmsg),
+		     hook_arg1, hook_arg2, NULL))
 		return 0;
 
 	if (use_editor) {
@@ -879,7 +881,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		const char *env[2] = { NULL };
 		env[0] =  index;
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		if (launch_editor(git_path(commit_editmsg), NULL, env)) {
+		if (launch_editor(git_path_unsafe(commit_editmsg), NULL, env)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
@@ -887,7 +889,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_hook(index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
+	    run_hook(index_file,
+		     "commit-msg", git_path_unsafe(commit_editmsg), NULL)) {
 		return 0;
 	}
 
@@ -1347,10 +1350,10 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 	int code;
 	size_t n;
 
-	if (access(git_path(post_rewrite_hook), X_OK) < 0)
+	if (access(git_path_unsafe(post_rewrite_hook), X_OK) < 0)
 		return 0;
 
-	argv[0] = git_path(post_rewrite_hook);
+	argv[0] = git_path_unsafe(post_rewrite_hook);
 	argv[1] = "amend";
 	argv[2] = NULL;
 
@@ -1431,10 +1434,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
 		pptr = &commit_list_insert(current_head, pptr)->next;
-		fp = fopen(git_path("MERGE_HEAD"), "r");
+		fp = fopen(git_path_unsafe("MERGE_HEAD"), "r");
 		if (fp == NULL)
 			die_errno(_("could not open '%s' for reading"),
-				  git_path("MERGE_HEAD"));
+				  git_path_unsafe("MERGE_HEAD"));
 		while (strbuf_getline(&m, fp, '\n') != EOF) {
 			unsigned char sha1[20];
 			if (get_sha1_hex(m.buf, sha1) < 0)
@@ -1444,8 +1447,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		}
 		fclose(fp);
 		strbuf_release(&m);
-		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
-			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
+		if (!stat(git_path_unsafe("MERGE_MODE"), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path_unsafe("MERGE_MODE"), 0) < 0)
 				die_errno(_("could not read MERGE_MODE"));
 			if (!strcmp(sb.buf, "no-ff"))
 				allow_fast_forward = 0;
@@ -1462,7 +1465,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	/* Finally, get the commit message */
 	strbuf_reset(&sb);
-	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
+	if (strbuf_read_file(&sb, git_path_unsafe(commit_editmsg), 0) < 0) {
 		int saved_errno = errno;
 		rollback_index_files();
 		die(_("could not read commit message: %s"), strerror(saved_errno));
@@ -1513,11 +1516,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die(_("cannot update HEAD ref"));
 	}
 
-	unlink(git_path("CHERRY_PICK_HEAD"));
-	unlink(git_path("MERGE_HEAD"));
-	unlink(git_path("MERGE_MSG"));
-	unlink(git_path("MERGE_MODE"));
-	unlink(git_path("SQUASH_MSG"));
+	unlink(git_path_unsafe("CHERRY_PICK_HEAD"));
+	unlink(git_path_unsafe("MERGE_HEAD"));
+	unlink(git_path_unsafe("MERGE_MSG"));
+	unlink(git_path_unsafe("MERGE_MODE"));
+	unlink(git_path_unsafe("SQUASH_MSG"));
 
 	if (commit_index_files())
 		die (_("Repository has been updated, but unable to write\n"
diff --git a/builtin/config.c b/builtin/config.c
index 0315ad76..407d7ca8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -434,8 +434,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			die("not in a git directory");
 		git_config(git_default_config, NULL);
 		launch_editor(config_exclusive_filename ?
-			      config_exclusive_filename : git_path("config"),
-			      NULL, NULL);
+			      config_exclusive_filename :
+			      git_path_unsafe("config"), NULL, NULL);
 	}
 	else if (actions == ACTION_SET) {
 		int ret;
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c6bc8eb0..f8d0954c 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1026,7 +1026,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 	if (&args != my_args)
 		memcpy(&args, my_args, sizeof(args));
 	if (args.depth > 0) {
-		if (stat(git_path("shallow"), &st))
+		if (stat(git_path_unsafe("shallow"), &st))
 			st.st_mtime = 0;
 	}
 
@@ -1041,7 +1041,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 	if (args.depth > 0) {
 		struct cache_time mtime;
 		struct strbuf sb = STRBUF_INIT;
-		char *shallow = git_path("shallow");
+		char *shallow = git_path_unsafe("shallow");
 		int fd;
 
 		mtime.sec = st.st_mtime;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 91731b90..ccbe63c7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -367,7 +367,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
-	char *url, *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
+	char *url;
+	char *filename = dry_run ? "/dev/null" : git_path_unsafe("FETCH_HEAD");
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -647,7 +648,7 @@ static void check_not_current_branch(struct ref *ref_map)
 
 static int truncate_fetch_head(void)
 {
-	char *filename = git_path("FETCH_HEAD");
+	char *filename = git_path_unsafe("FETCH_HEAD");
 	FILE *fp = fopen(filename, "w");
 
 	if (!fp)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index df1a88b5..f8429f55 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -215,7 +215,7 @@ static void check_unreachable_object(struct object *obj)
 		printf("dangling %s %s\n", typename(obj->type),
 		       sha1_to_hex(obj->sha1));
 		if (write_lost_and_found) {
-			char *filename = git_path("lost-found/%s/%s",
+			char *filename = git_path_unsafe("lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
 				sha1_to_hex(obj->sha1));
 			FILE *f;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index d07554c8..7ae89f85 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -198,9 +198,9 @@ static int create_default_files(const char *template_path)
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	safe_create_dir(git_path("refs"), 1);
-	safe_create_dir(git_path("refs/heads"), 1);
-	safe_create_dir(git_path("refs/tags"), 1);
+	safe_create_dir(git_path_unsafe("refs"), 1);
+	safe_create_dir(git_path_unsafe("refs/heads"), 1);
+	safe_create_dir(git_path_unsafe("refs/tags"), 1);
 
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
@@ -224,9 +224,9 @@ static int create_default_files(const char *template_path)
 	 */
 	if (shared_repository) {
 		adjust_shared_perm(get_git_dir());
-		adjust_shared_perm(git_path("refs"));
-		adjust_shared_perm(git_path("refs/heads"));
-		adjust_shared_perm(git_path("refs/tags"));
+		adjust_shared_perm(git_path_unsafe("refs"));
+		adjust_shared_perm(git_path_unsafe("refs/heads"));
+		adjust_shared_perm(git_path_unsafe("refs/tags"));
 	}
 
 	/*
diff --git a/builtin/merge.c b/builtin/merge.c
index 2870a6af..3e75c30b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -213,9 +213,9 @@ static struct option builtin_merge_options[] = {
 /* Cleans up metadata that is uninteresting after a succeeded merge. */
 static void drop_save(void)
 {
-	unlink(git_path("MERGE_HEAD"));
-	unlink(git_path("MERGE_MSG"));
-	unlink(git_path("MERGE_MODE"));
+	unlink(git_path_unsafe("MERGE_HEAD"));
+	unlink(git_path_unsafe("MERGE_MSG"));
+	unlink(git_path_unsafe("MERGE_MODE"));
 }
 
 static int save_state(unsigned char *stash)
@@ -321,7 +321,7 @@ static void squash_message(struct commit *commit)
 	struct pretty_print_context ctx = {0};
 
 	printf(_("Squash commit -- not updating HEAD\n"));
-	filename = git_path("SQUASH_MSG");
+	filename = git_path_unsafe("SQUASH_MSG");
 	fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not write to '%s'"), filename);
@@ -493,13 +493,13 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	}
 
 	if (!strcmp(remote, "FETCH_HEAD") &&
-			!access(git_path("FETCH_HEAD"), R_OK)) {
+			!access(git_path_unsafe("FETCH_HEAD"), R_OK)) {
 		const char *filename;
 		FILE *fp;
 		struct strbuf line = STRBUF_INIT;
 		char *ptr;
 
-		filename = git_path("FETCH_HEAD");
+		filename = git_path_unsafe("FETCH_HEAD");
 		fp = fopen(filename, "r");
 		if (!fp)
 			die_errno(_("could not open '%s' for reading"),
@@ -851,7 +851,7 @@ static void add_strategies(const char *string, unsigned attr)
 
 static void write_merge_msg(struct strbuf *msg)
 {
-	const char *filename = git_path("MERGE_MSG");
+	const char *filename = git_path_unsafe("MERGE_MSG");
 	int fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"),
@@ -863,7 +863,7 @@ static void write_merge_msg(struct strbuf *msg)
 
 static void read_merge_msg(struct strbuf *msg)
 {
-	const char *filename = git_path("MERGE_MSG");
+	const char *filename = git_path_unsafe("MERGE_MSG");
 	strbuf_reset(msg);
 	if (strbuf_read_file(msg, filename, 0) < 0)
 		die_errno(_("Could not read from '%s'"), filename);
@@ -887,9 +887,9 @@ static void prepare_to_commit(void)
 	strbuf_addch(&msg, '\n');
 	write_merge_msg(&msg);
 	run_hook(get_index_file(), "prepare-commit-msg",
-		 git_path("MERGE_MSG"), "merge", NULL, NULL);
+		 git_path_unsafe("MERGE_MSG"), "merge", NULL, NULL);
 	if (option_edit) {
-		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
+		if (launch_editor(git_path_unsafe("MERGE_MSG"), NULL, NULL))
 			abort_commit(NULL);
 	}
 	read_merge_msg(&msg);
@@ -958,7 +958,7 @@ static int suggest_conflicts(int renormalizing)
 	FILE *fp;
 	int pos;
 
-	filename = git_path("MERGE_MSG");
+	filename = git_path_unsafe("MERGE_MSG");
 	fp = fopen(filename, "a");
 	if (!fp)
 		die_errno(_("Could not open '%s' for writing"), filename);
@@ -1061,7 +1061,7 @@ static void write_merge_state(void)
 	for (j = remoteheads; j; j = j->next)
 		strbuf_addf(&buf, "%s\n",
 			sha1_to_hex(j->item->object.sha1));
-	filename = git_path("MERGE_HEAD");
+	filename = git_path_unsafe("MERGE_HEAD");
 	fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
@@ -1071,7 +1071,7 @@ static void write_merge_state(void)
 	strbuf_addch(&merge_msg, '\n');
 	write_merge_msg(&merge_msg);
 
-	filename = git_path("MERGE_MODE");
+	filename = git_path_unsafe("MERGE_MODE");
 	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
@@ -1126,7 +1126,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		int nargc = 2;
 		const char *nargv[] = {"reset", "--merge", NULL};
 
-		if (!file_exists(git_path("MERGE_HEAD")))
+		if (!file_exists(git_path_unsafe("MERGE_HEAD")))
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
 
 		/* Invoke 'git reset --merge' */
@@ -1136,7 +1136,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (read_cache_unmerged())
 		die_resolve_conflict("merge");
 
-	if (file_exists(git_path("MERGE_HEAD"))) {
+	if (file_exists(git_path_unsafe("MERGE_HEAD"))) {
 		/*
 		 * There is no unmerged entry, don't advise 'git
 		 * add/rm <file>', just 'git commit'.
@@ -1147,7 +1147,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
-	if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
+	if (file_exists(git_path_unsafe("CHERRY_PICK_HEAD"))) {
 		if (advice_resolve_conflict)
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 			    "Please, commit your changes before you can merge."));
diff --git a/builtin/notes.c b/builtin/notes.c
index f8e437db..c037afe6 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -944,7 +944,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 		printf("Automatic notes merge failed. Fix conflicts in %s and "
 		       "commit the result with 'git notes merge --commit', or "
 		       "abort the merge with 'git notes merge --abort'.\n",
-		       git_path(NOTES_MERGE_WORKTREE));
+		       git_path_unsafe(NOTES_MERGE_WORKTREE));
 	}
 
 	free_notes(t);
diff --git a/builtin/remote.c b/builtin/remote.c
index c8106438..c7032125 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -546,7 +546,7 @@ static int add_branch_for_removal(const char *refname,
 
 	/* make sure that symrefs are deleted */
 	if (flags & REF_ISSYMREF)
-		return unlink(git_path("%s", refname));
+		return unlink(git_path_unsafe("%s", refname));
 
 	item = string_list_append(branches->branches, refname);
 	item->util = xmalloc(20);
@@ -608,9 +608,9 @@ static int migrate_file(struct remote *remote)
 			return error("Could not append '%s' to '%s'",
 					remote->fetch_refspec[i], buf.buf);
 	if (remote->origin == REMOTE_REMOTES)
-		path = git_path("remotes/%s", remote->name);
+		path = git_path_unsafe("remotes/%s", remote->name);
 	else if (remote->origin == REMOTE_BRANCHES)
-		path = git_path("branches/%s", remote->name);
+		path = git_path_unsafe("branches/%s", remote->name);
 	if (path)
 		unlink_or_warn(path);
 	return 0;
diff --git a/builtin/reset.c b/builtin/reset.c
index 811e8e25..18bacdac 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -35,7 +35,7 @@ static const char *reset_type_names[] = {
 
 static inline int is_merge(void)
 {
-	return !access(git_path("MERGE_HEAD"), F_OK);
+	return !access(git_path_unsafe("MERGE_HEAD"), F_OK);
 }
 
 static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet)
diff --git a/builtin/revert.c b/builtin/revert.c
index 985f95b0..09a062c6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -294,7 +294,7 @@ static void write_cherry_pick_head(struct commit *commit)
 
 	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
 
-	filename = git_path("CHERRY_PICK_HEAD");
+	filename = git_path_unsafe("CHERRY_PICK_HEAD");
 	fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
@@ -314,7 +314,7 @@ static void print_advice(int show_hint)
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
-		unlink(git_path("CHERRY_PICK_HEAD"));
+		unlink(git_path_unsafe("CHERRY_PICK_HEAD"));
 		return;
 	}
 
@@ -762,7 +762,7 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 static void read_populate_todo(struct commit_list **todo_list,
 			struct replay_opts *opts)
 {
-	const char *todo_file = git_path(SEQ_TODO_FILE);
+	const char *todo_file = git_path_unsafe(SEQ_TODO_FILE);
 	struct strbuf buf = STRBUF_INIT;
 	int fd, res;
 
@@ -817,7 +817,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static void read_populate_opts(struct replay_opts **opts_ptr)
 {
-	const char *opts_file = git_path(SEQ_OPTS_FILE);
+	const char *opts_file = git_path_unsafe(SEQ_OPTS_FILE);
 
 	if (!file_exists(opts_file))
 		return;
@@ -841,7 +841,7 @@ static void walk_revs_populate_todo(struct commit_list **todo_list,
 
 static int create_seq_dir(void)
 {
-	const char *seq_dir = git_path(SEQ_DIR);
+	const char *seq_dir = git_path_unsafe(SEQ_DIR);
 
 	if (file_exists(seq_dir))
 		return error(_("%s already exists."), seq_dir);
@@ -852,7 +852,7 @@ static int create_seq_dir(void)
 
 static void save_head(const char *head)
 {
-	const char *head_file = git_path(SEQ_HEAD_FILE);
+	const char *head_file = git_path_unsafe(SEQ_HEAD_FILE);
 	static struct lock_file head_lock;
 	struct strbuf buf = STRBUF_INIT;
 	int fd;
@@ -867,7 +867,7 @@ static void save_head(const char *head)
 
 static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 {
-	const char *todo_file = git_path(SEQ_TODO_FILE);
+	const char *todo_file = git_path_unsafe(SEQ_TODO_FILE);
 	static struct lock_file todo_lock;
 	struct strbuf buf = STRBUF_INIT;
 	int fd;
@@ -888,7 +888,7 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 
 static void save_opts(struct replay_opts *opts)
 {
-	const char *opts_file = git_path(SEQ_OPTS_FILE);
+	const char *opts_file = git_path_unsafe(SEQ_OPTS_FILE);
 
 	if (opts->no_commit)
 		git_config_set_in_file(opts_file, "options.no-commit", "true");
@@ -969,7 +969,7 @@ static int pick_revisions(struct replay_opts *opts)
 		remove_sequencer_state(1);
 		return 0;
 	} else if (opts->subcommand == REPLAY_CONTINUE) {
-		if (!file_exists(git_path(SEQ_TODO_FILE)))
+		if (!file_exists(git_path_unsafe(SEQ_TODO_FILE)))
 			goto error;
 		read_populate_opts(&opts);
 		read_populate_todo(&todo_list, opts);
diff --git a/cache.h b/cache.h
index 2e6ad360..7fb85445 100644
--- a/cache.h
+++ b/cache.h
@@ -662,7 +662,8 @@ extern char *git_pathdup(const char *fmt, ...)
 
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern char *git_path_unsafe(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
 extern char *git_path_submodule(const char *path, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
diff --git a/contrib/examples/builtin-fetch--tool.c b/contrib/examples/builtin-fetch--tool.c
index 3140e405..ea18fdac 100644
--- a/contrib/examples/builtin-fetch--tool.c
+++ b/contrib/examples/builtin-fetch--tool.c
@@ -515,7 +515,7 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 
 		if (argc != 8)
 			return error("append-fetch-head takes 6 args");
-		filename = git_path("FETCH_HEAD");
+		filename = git_path_unsafe("FETCH_HEAD");
 		fp = fopen(filename, "a");
 		if (!fp)
 			return error("cannot open %s: %s\n", filename, strerror(errno));
@@ -533,7 +533,7 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 
 		if (argc != 5)
 			return error("fetch-native-store takes 3 args");
-		filename = git_path("FETCH_HEAD");
+		filename = git_path_unsafe("FETCH_HEAD");
 		fp = fopen(filename, "a");
 		if (!fp)
 			return error("cannot open %s: %s\n", filename, strerror(errno));
diff --git a/dir.c b/dir.c
index 6c0d7825..94662509 100644
--- a/dir.c
+++ b/dir.c
@@ -1224,7 +1224,7 @@ void setup_standard_excludes(struct dir_struct *dir)
 	const char *path;
 
 	dir->exclude_per_dir = ".gitignore";
-	path = git_path("info/exclude");
+	path = git_path_unsafe("info/exclude");
 	if (!access(path, R_OK))
 		add_excludes_from_file(dir, path);
 	if (excludes_file && !access(excludes_file, R_OK))
diff --git a/fast-import.c b/fast-import.c
index 8d8ea3c4..04bcd353 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -403,7 +403,7 @@ static void dump_marks_helper(FILE *, uintmax_t, struct mark_set *);
 
 static void write_crash_report(const char *err)
 {
-	char *loc = git_path("fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
+	char *loc = git_path_unsafe("fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
 	FILE *rpt = fopen(loc, "w");
 	struct branch *b;
 	unsigned long lu;
diff --git a/http-backend.c b/http-backend.c
index 59ad7da6..7169e040 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -161,7 +161,7 @@ static void send_strbuf(const char *type, struct strbuf *buf)
 
 static void send_local_file(const char *the_type, const char *name)
 {
-	const char *p = git_path("%s", name);
+	const char *p = git_path_unsafe("%s", name);
 	size_t buf_alloc = 8192;
 	char *buf = xmalloc(buf_alloc);
 	int fd;
diff --git a/notes-merge.c b/notes-merge.c
index e9e41993..0b49e8ad 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -275,35 +275,37 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 		 * Must establish NOTES_MERGE_WORKTREE.
 		 * Abort if NOTES_MERGE_WORKTREE already exists
 		 */
-		if (file_exists(git_path(NOTES_MERGE_WORKTREE))) {
+		if (file_exists(git_path_unsafe(NOTES_MERGE_WORKTREE))) {
 			if (advice_resolve_conflict)
 				die("You have not concluded your previous "
 				    "notes merge (%s exists).\nPlease, use "
 				    "'git notes merge --commit' or 'git notes "
 				    "merge --abort' to commit/abort the "
 				    "previous merge before you start a new "
-				    "notes merge.", git_path("NOTES_MERGE_*"));
+				    "notes merge.",
+				    git_path_unsafe("NOTES_MERGE_*"));
 			else
 				die("You have not concluded your notes merge "
-				    "(%s exists).", git_path("NOTES_MERGE_*"));
+				    "(%s exists).",
+				    git_path_unsafe("NOTES_MERGE_*"));
 		}
 
-		if (safe_create_leading_directories(git_path(
+		if (safe_create_leading_directories(git_path_unsafe(
 				NOTES_MERGE_WORKTREE "/.test")))
 			die_errno("unable to create directory %s",
-				  git_path(NOTES_MERGE_WORKTREE));
+				  git_path_unsafe(NOTES_MERGE_WORKTREE));
 		o->has_worktree = 1;
-	} else if (!file_exists(git_path(NOTES_MERGE_WORKTREE)))
+	} else if (!file_exists(git_path_unsafe(NOTES_MERGE_WORKTREE)))
 		/* NOTES_MERGE_WORKTREE should already be established */
 		die("missing '%s'. This should not happen",
-		    git_path(NOTES_MERGE_WORKTREE));
+		    git_path_unsafe(NOTES_MERGE_WORKTREE));
 }
 
 static void write_buf_to_worktree(const unsigned char *obj,
 				  const char *buf, unsigned long size)
 {
 	int fd;
-	char *path = git_path(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
+	char *path = git_path_unsafe(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
 	if (safe_create_leading_directories(path))
 		die_errno("unable to create directory for '%s'", path);
 	if (file_exists(path))
@@ -681,7 +683,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 	 * Finally store the new commit object SHA1 into 'result_sha1'.
 	 */
 	struct dir_struct dir;
-	char *path = xstrdup(git_path(NOTES_MERGE_WORKTREE "/"));
+	char *path = git_pathdup(NOTES_MERGE_WORKTREE "/");
 	int path_len = strlen(path), i;
 	const char *msg = strstr(partial_commit->buffer, "\n\n");
 
@@ -731,7 +733,7 @@ int notes_merge_abort(struct notes_merge_options *o)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 
-	strbuf_addstr(&buf, git_path(NOTES_MERGE_WORKTREE));
+	strbuf_addstr(&buf, git_path_unsafe(NOTES_MERGE_WORKTREE));
 	OUTPUT(o, 3, "Removing notes merge worktree at %s", buf.buf);
 	ret = remove_dir_recursively(&buf, 0);
 	strbuf_release(&buf);
diff --git a/pack-refs.c b/pack-refs.c
index 23bbd00e..9557b063 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -86,7 +86,7 @@ static void try_remove_empty_parents(char *name)
 		if (q == p)
 			break;
 		*q = '\0';
-		if (rmdir(git_path("%s", name)))
+		if (rmdir(git_path_unsafe("%s", name)))
 			break;
 	}
 }
@@ -97,7 +97,7 @@ static void prune_ref(struct ref_to_prune *r)
 	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
 
 	if (lock) {
-		unlink_or_warn(git_path("%s", r->name));
+		unlink_or_warn(git_path_unsafe("%s", r->name));
 		unlock_ref(lock);
 		try_remove_empty_parents(r->name);
 	}
@@ -121,7 +121,7 @@ int pack_refs(unsigned int flags)
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"),
+	fd = hold_lock_file_for_update(&packed, git_path_unsafe("packed-refs"),
 				       LOCK_DIE_ON_ERROR);
 	cbdata.refs_file = fdopen(fd, "w");
 	if (!cbdata.refs_file)
diff --git a/path.c b/path.c
index b6f71d10..0611b7be 100644
--- a/path.c
+++ b/path.c
@@ -101,7 +101,7 @@ char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname);
 }
 
-char *git_path(const char *fmt, ...)
+char *git_path_unsafe(const char *fmt, ...)
 {
 	const char *git_dir = get_git_dir();
 	char *pathname = get_pathname();
diff --git a/refs.c b/refs.c
index e69ba26b..e527c7b7 100644
--- a/refs.c
+++ b/refs.c
@@ -268,7 +268,7 @@ static struct ref_array *get_packed_refs(const char *submodule)
 		if (submodule)
 			packed_refs_file = git_path_submodule(submodule, "packed-refs");
 		else
-			packed_refs_file = git_path("packed-refs");
+			packed_refs_file = git_path_unsafe("packed-refs");
 		f = fopen(packed_refs_file, "r");
 		if (f) {
 			read_packed_refs(f, &refs->packed);
@@ -288,7 +288,7 @@ static void get_ref_dir(const char *submodule, const char *base,
 	if (submodule)
 		path = git_path_submodule(submodule, "%s", base);
 	else
-		path = git_path("%s", base);
+		path = git_path_unsafe("%s", base);
 
 
 	dir = opendir(path);
@@ -319,7 +319,7 @@ static void get_ref_dir(const char *submodule, const char *base,
 			memcpy(ref + baselen, de->d_name, namelen+1);
 			refdir = submodule
 				? git_path_submodule(submodule, "%s", ref)
-				: git_path("%s", ref);
+				: git_path_unsafe("%s", ref);
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
@@ -1146,11 +1146,11 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		ref = resolve_ref(path, hash, 1, NULL);
 		if (!ref)
 			continue;
-		if (!stat(git_path("logs/%s", path), &st) &&
+		if (!stat(git_path_unsafe("logs/%s", path), &st) &&
 		    S_ISREG(st.st_mode))
 			it = path;
 		else if (strcmp(ref, path) &&
-			 !stat(git_path("logs/%s", ref), &st) &&
+			 !stat(git_path_unsafe("logs/%s", ref), &st) &&
 			 S_ISREG(st.st_mode))
 			it = ref;
 		else
@@ -1186,7 +1186,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 		 * it is normal for the empty directory 'foo'
 		 * to remain.
 		 */
-		ref_file = git_path("%s", orig_ref);
+		ref_file = git_path_unsafe("%s", orig_ref);
 		if (remove_empty_directories(ref_file)) {
 			last_errno = errno;
 			error("there are still refs under '%s'", orig_ref);
@@ -1223,7 +1223,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	}
 	lock->ref_name = xstrdup(ref);
 	lock->orig_ref_name = xstrdup(orig_ref);
-	ref_file = git_path("%s", ref);
+	ref_file = git_path_unsafe("%s", ref);
 	if (missing)
 		lock->force_write = 1;
 	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
@@ -1272,9 +1272,10 @@ static int repack_without_ref(const char *refname)
 	ref = search_ref_array(packed, refname);
 	if (ref == NULL)
 		return 0;
-	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
+	fd = hold_lock_file_for_update(&packlock,
+				       git_path_unsafe("packed-refs"), 0);
 	if (fd < 0) {
-		unable_to_lock_error(git_path("packed-refs"), errno);
+		unable_to_lock_error(git_path_unsafe("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
 
@@ -1313,7 +1314,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 			lock->lk->filename[i] = 0;
 			path = lock->lk->filename;
 		} else {
-			path = git_path("%s", refname);
+			path = git_path_unsafe("%s", refname);
 		}
 		err = unlink_or_warn(path);
 		if (err && errno != ENOENT)
@@ -1328,7 +1329,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	 */
 	ret |= repack_without_ref(refname);
 
-	unlink_or_warn(git_path("logs/%s", lock->ref_name));
+	unlink_or_warn(git_path_unsafe("logs/%s", lock->ref_name));
 	invalidate_ref_cache(NULL);
 	unlock_ref(lock);
 	return ret;
@@ -1349,7 +1350,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
-	int log = !lstat(git_path("logs/%s", oldref), &loginfo);
+	int log = !lstat(git_path_unsafe("logs/%s", oldref), &loginfo);
 	const char *symref = NULL;
 
 	if (log && S_ISLNK(loginfo.st_mode))
@@ -1368,7 +1369,8 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	if (!is_refname_available(newref, oldref, get_loose_refs(NULL), 0))
 		return 1;
 
-	if (log && rename(git_path("logs/%s", oldref), git_path(TMP_RENAMED_LOG)))
+	if (log && rename(git_path_unsafe("logs/%s", oldref),
+			  git_path_unsafe(TMP_RENAMED_LOG)))
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldref, strerror(errno));
 
@@ -1379,7 +1381,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 
 	if (resolve_ref(newref, sha1, 1, &flag) && delete_ref(newref, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
-			if (remove_empty_directories(git_path("%s", newref))) {
+			if (remove_empty_directories(git_path_unsafe("%s", newref))) {
 				error("Directory not empty: %s", newref);
 				goto rollback;
 			}
@@ -1389,20 +1391,21 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 		}
 	}
 
-	if (log && safe_create_leading_directories(git_path("logs/%s", newref))) {
+	if (log && safe_create_leading_directories(git_path_unsafe("logs/%s", newref))) {
 		error("unable to create directory for %s", newref);
 		goto rollback;
 	}
 
  retry:
-	if (log && rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newref))) {
+	if (log && rename(git_path_unsafe(TMP_RENAMED_LOG),
+			  git_path_unsafe("logs/%s", newref))) {
 		if (errno==EISDIR || errno==ENOTDIR) {
 			/*
 			 * rename(a, b) when b is an existing
 			 * directory ought to result in ISDIR, but
 			 * Solaris 5.8 gives ENOTDIR.  Sheesh.
 			 */
-			if (remove_empty_directories(git_path("logs/%s", newref))) {
+			if (remove_empty_directories(git_path_unsafe("logs/%s", newref))) {
 				error("Directory not empty: logs/%s", newref);
 				goto rollback;
 			}
@@ -1444,11 +1447,13 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	log_all_ref_updates = flag;
 
  rollbacklog:
-	if (logmoved && rename(git_path("logs/%s", newref), git_path("logs/%s", oldref)))
+	if (logmoved && rename(git_path_unsafe("logs/%s", newref),
+			       git_path_unsafe("logs/%s", oldref)))
 		error("unable to restore logfile %s from %s: %s",
 			oldref, newref, strerror(errno));
 	if (!logmoved && log &&
-	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldref)))
+	    rename(git_path_unsafe(TMP_RENAMED_LOG),
+		   git_path_unsafe("logs/%s", oldref)))
 		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
 			oldref, strerror(errno));
 
@@ -1741,7 +1746,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	void *log_mapped;
 	size_t mapsz;
 
-	logfile = git_path("logs/%s", ref);
+	logfile = git_path_unsafe("logs/%s", ref);
 	logfd = open(logfile, O_RDONLY, 0);
 	if (logfd < 0)
 		die_errno("Unable to read log '%s'", logfile);
@@ -1841,7 +1846,7 @@ int for_each_recent_reflog_ent(const char *ref, each_reflog_ent_fn fn, long ofs,
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 
-	logfile = git_path("logs/%s", ref);
+	logfile = git_path_unsafe("logs/%s", ref);
 	logfp = fopen(logfile, "r");
 	if (!logfp)
 		return -1;
@@ -1899,7 +1904,7 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 
 static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 {
-	DIR *dir = opendir(git_path("logs/%s", base));
+	DIR *dir = opendir(git_path_unsafe("logs/%s", base));
 	int retval = 0;
 
 	if (dir) {
@@ -1923,7 +1928,7 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 			if (has_extension(de->d_name, ".lock"))
 				continue;
 			memcpy(log + baselen, de->d_name, namelen+1);
-			if (stat(git_path("logs/%s", log), &st) < 0)
+			if (stat(git_path_unsafe("logs/%s", log), &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
 				retval = do_for_each_reflog(log, fn, cb_data);
diff --git a/remote.c b/remote.c
index e2ef9911..bb85b326 100644
--- a/remote.c
+++ b/remote.c
@@ -224,7 +224,7 @@ static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
 
 static void read_remotes_file(struct remote *remote)
 {
-	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
+	FILE *f = fopen(git_path_unsafe("remotes/%s", remote->name), "r");
 
 	if (!f)
 		return;
@@ -275,7 +275,7 @@ static void read_branches_file(struct remote *remote)
 	char *frag;
 	struct strbuf branch = STRBUF_INIT;
 	int n = slash ? slash - remote->name : 1000;
-	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
+	FILE *f = fopen(git_path_unsafe("branches/%.*s", n, remote->name), "r");
 	char *s, *p;
 	int len;
 
diff --git a/rerere.c b/rerere.c
index dcb525a4..61f60701 100644
--- a/rerere.c
+++ b/rerere.c
@@ -22,7 +22,7 @@ static char *merge_rr_path;
 
 const char *rerere_path(const char *hex, const char *file)
 {
-	return git_path("rr-cache/%s/%s", hex, file);
+	return git_path_unsafe("rr-cache/%s/%s", hex, file);
 }
 
 int has_rerere_resolution(const char *hex)
@@ -524,7 +524,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 				continue;
 			hex = xstrdup(sha1_to_hex(sha1));
 			string_list_insert(rr, path)->util = hex;
-			if (mkdir(git_path("rr-cache/%s", hex), 0755))
+			if (mkdir(git_path_unsafe("rr-cache/%s", hex), 0755))
 				continue;
 			handle_file(path, NULL, rerere_path(hex, "preimage"));
 			fprintf(stderr, "Recorded preimage for '%s'\n", path);
@@ -591,7 +591,7 @@ static int is_rerere_enabled(void)
 	if (!rerere_enabled)
 		return 0;
 
-	rr_cache = git_path("rr-cache");
+	rr_cache = git_path_unsafe("rr-cache");
 	rr_cache_exists = is_directory(rr_cache);
 	if (rerere_enabled < 0)
 		return rr_cache_exists;
@@ -695,7 +695,7 @@ static void unlink_rr_item(const char *name)
 	unlink(rerere_path(name, "thisimage"));
 	unlink(rerere_path(name, "preimage"));
 	unlink(rerere_path(name, "postimage"));
-	rmdir(git_path("rr-cache/%s", name));
+	rmdir(git_path_unsafe("rr-cache/%s", name));
 }
 
 struct rerere_gc_config_cb {
@@ -726,7 +726,7 @@ void rerere_gc(struct string_list *rr)
 	struct rerere_gc_config_cb cf = { 15, 60 };
 
 	git_config(git_rerere_gc_config, &cf);
-	dir = opendir(git_path("rr-cache"));
+	dir = opendir(git_path_unsafe("rr-cache"));
 	if (!dir)
 		die_errno("unable to open rr-cache directory");
 	while ((e = readdir(dir))) {
@@ -760,5 +760,5 @@ void rerere_clear(struct string_list *merge_rr)
 		if (!has_rerere_resolution(name))
 			unlink_rr_item(name);
 	}
-	unlink_or_warn(git_path("MERGE_RR"));
+	unlink_or_warn(git_path_unsafe("MERGE_RR"));
 }
diff --git a/run-command.c b/run-command.c
index 1c510438..598e41dd 100644
--- a/run-command.c
+++ b/run-command.c
@@ -612,11 +612,11 @@ int run_hook(const char *index_file, const char *name, ...)
 	va_list args;
 	int ret;
 
-	if (access(git_path("hooks/%s", name), X_OK) < 0)
+	if (access(git_path_unsafe("hooks/%s", name), X_OK) < 0)
 		return 0;
 
 	va_start(args, name);
-	argv_array_push(&argv, git_path("hooks/%s", name));
+	argv_array_push(&argv, git_path_unsafe("hooks/%s", name));
 	while ((p = va_arg(args, const char *)))
 		argv_array_push(&argv, p);
 	va_end(args);
diff --git a/sequencer.c b/sequencer.c
index bc2c046a..2e29152c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -8,10 +8,10 @@ void remove_sequencer_state(int aggressive)
 	struct strbuf seq_dir = STRBUF_INIT;
 	struct strbuf seq_old_dir = STRBUF_INIT;
 
-	strbuf_addf(&seq_dir, "%s", git_path(SEQ_DIR));
-	strbuf_addf(&seq_old_dir, "%s", git_path(SEQ_OLD_DIR));
+	strbuf_addf(&seq_dir, "%s", git_path_unsafe(SEQ_DIR));
+	strbuf_addf(&seq_old_dir, "%s", git_path_unsafe(SEQ_OLD_DIR));
 	remove_dir_recursively(&seq_old_dir, 0);
-	rename(git_path(SEQ_DIR), git_path(SEQ_OLD_DIR));
+	rename(git_path_unsafe(SEQ_DIR), git_path_unsafe(SEQ_OLD_DIR));
 	if (aggressive)
 		remove_dir_recursively(&seq_old_dir, 0);
 	strbuf_release(&seq_dir);
diff --git a/server-info.c b/server-info.c
index 9ec744e9..348a3447 100644
--- a/server-info.c
+++ b/server-info.c
@@ -243,7 +243,7 @@ int update_server_info(int force)
 	errs = errs | update_info_packs(force);
 
 	/* remove leftover rev-cache file if there is any */
-	unlink_or_warn(git_path("info/rev-cache"));
+	unlink_or_warn(git_path_unsafe("info/rev-cache"));
 
 	return errs;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 86705bc9..ba7eca89 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -382,7 +382,7 @@ static void read_info_alternates(const char * relative_base, int depth)
 void add_to_alternates_file(const char *reference)
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), LOCK_DIE_ON_ERROR);
+	int fd = hold_lock_file_for_append(lock, git_path_unsafe("objects/info/alternates"), LOCK_DIE_ON_ERROR);
 	char *alt = mkpath("%s\n", reference);
 	write_or_die(fd, alt, strlen(alt));
 	if (commit_lock_file(lock))
@@ -2706,7 +2706,7 @@ static int index_stream(unsigned char *sha1, int fd, size_t size,
 	int len, tmpfd;
 
 	strbuf_addstr(&export_marks, "--export-marks=");
-	strbuf_addstr(&export_marks, git_path("hashstream_XXXXXX"));
+	strbuf_addstr(&export_marks, git_path_unsafe("hashstream_XXXXXX"));
 	tmpfile = export_marks.buf + strlen("--export-marks=");
 	tmpfd = git_mkstemp_mode(tmpfile, 0600);
 	if (tmpfd < 0)
diff --git a/shallow.c b/shallow.c
index a0363dea..d721397a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -25,7 +25,7 @@ int is_repository_shallow(void)
 	if (is_shallow >= 0)
 		return is_shallow;
 
-	fp = fopen(git_path("shallow"), "r");
+	fp = fopen(git_path_unsafe("shallow"), "r");
 	if (!fp) {
 		is_shallow = 0;
 		return is_shallow;
diff --git a/transport.c b/transport.c
index 51814b5d..cc0ca04c 100644
--- a/transport.c
+++ b/transport.c
@@ -203,7 +203,7 @@ static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 
 	/* copy the refs to the temporary directory */
 
-	strbuf_addstr(&temp_dir, git_path("rsync-refs-XXXXXX"));
+	strbuf_addstr(&temp_dir, git_path_unsafe("rsync-refs-XXXXXX"));
 	if (!mkdtemp(temp_dir.buf))
 		die_errno ("Could not make temporary directory");
 	temp_dir_len = temp_dir.len;
@@ -366,7 +366,7 @@ static int rsync_transport_push(struct transport *transport,
 
 	/* copy the refs to the temporary directory; they could be packed. */
 
-	strbuf_addstr(&temp_dir, git_path("rsync-refs-XXXXXX"));
+	strbuf_addstr(&temp_dir, git_path_unsafe("rsync-refs-XXXXXX"));
 	if (!mkdtemp(temp_dir.buf))
 		die_errno ("Could not make temporary directory");
 	strbuf_addch(&temp_dir, '/');
diff --git a/unpack-trees.c b/unpack-trees.c
index 8282f5e5..44f408b8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1010,7 +1010,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
-		if (add_excludes_from_file_to_list(git_path("info/sparse-checkout"), "", 0, NULL, &el, 0) < 0)
+		if (add_excludes_from_file_to_list(git_path_unsafe("info/sparse-checkout"), "", 0, NULL, &el, 0) < 0)
 			o->skip_sparse_checkout = 1;
 		else
 			o->el = &el;
-- 
1.7.8.rc0
