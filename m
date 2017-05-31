Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB391FD09
	for <e@80x24.org>; Wed, 31 May 2017 23:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbdEaXfg (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 19:35:36 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:34858
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751033AbdEaXfd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 May 2017 19:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1496273713;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=DUi6Clt/JgCHW3rZOAUUZwvdA9cy7F1SHN0qB+4KgQw=;
        b=Co2i1ECq+nIYnHgzOKcTxC50BNas3EpBv/W3EKoN29jZ0S+P1A5D8dBtBckApl6a
        vm5ttJUq2pl5VafMyFINw4e6RG2gnjtnvHu4nasWVFB6N7tN3ChcN9EkXiY2TgstFEp
        KjdmzNPDZqutUWZfrbWv4FafbBFDEMMo2tlfVCMM=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c60dcf680-4a036e9e-c152-41d2-a932-b44c1a5bf68e-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
References: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
Subject: [PATCH/RFC v2 2/6] branch: add copy branch option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 May 2017 23:35:12 +0000
X-SES-Outgoing: 2017.05.31-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds copy branch option available using -c or -C (forcefully).

Includes a lot of function renames and their signature changes in order
to introduce a new function parameter - flag 'copy' which determines
whether those functions should do operation copy or move.

Additionally, this changes a lot of other files wherever the renamed
functions were used. By default copy=0 is passed at all those places so
that they keep behaving the way they were, before these changes.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 builtin/branch.c          | 48 +++++++++++++++++++++++++++++++----------------
 builtin/config.c          |  4 ++--
 builtin/remote.c          |  6 +++---
 cache.h                   |  4 ++--
 config.c                  |  6 +++---
 refs.c                    | 10 +++++-----
 refs.h                    |  7 ++++---
 refs/files-backend.c      | 21 ++++++++++++++-------
 refs/refs-internal.h      |  6 +++---
 submodule.c               |  2 +-
 t/helper/test-ref-store.c |  2 +-
 11 files changed, 70 insertions(+), 46 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 83fcda43dceec..16d01a100cbb9 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -27,6 +27,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
+	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
 	NULL
@@ -175,7 +176,7 @@ static void delete_branch_config(const char *branchname)
 {
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, "branch.%s", branchname);
-	if (git_config_rename_section(buf.buf, NULL) < 0)
+	if (git_config_copy_or_rename_section(buf.buf, NULL) < 0)
 		warning(_("Update of config-file failed"));
 	strbuf_release(&buf);
 }
@@ -449,7 +450,7 @@ static void reject_rebase_or_bisect_branch(const char *target)
 	free_worktrees(worktrees);
 }
 
-static void rename_branch(const char *oldname, const char *newname, int force)
+static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
@@ -457,7 +458,8 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	int clobber_head_ok;
 
 	if (!oldname)
-		die(_("cannot rename the current branch while not on any."));
+		die(_("cannot %s the current branch while not on any."),
+			 (copy ? "copy" : "rename"));
 
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -480,17 +482,19 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
-	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
-		 oldref.buf, newref.buf);
+	strbuf_addf(&logmsg, "Branch: %s %s to %s",
+		 (copy ? "copied" : "renamed"), oldref.buf, newref.buf);
 
-	if (rename_ref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch rename failed"));
+	if (copy_or_rename_ref(oldref.buf, newref.buf, logmsg.buf, copy))
+		die(_("Branch %s failed"), (copy ? "copy" : "rename"));
 
 	if (recovery)
-		warning(_("Renamed a misnamed branch '%s' away"), oldref.buf + 11);
+		warning(_("%s a misnamed branch '%s' away"),
+			 (copy ? "copied" : "renamed"), oldref.buf + 11);
 
 	if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
+		die(_("Branch %s to %s, but HEAD is not updated!"),
+			 (copy ? "copied" : "renamed"), newname);
 
 	strbuf_release(&logmsg);
 
@@ -498,8 +502,9 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	strbuf_release(&oldref);
 	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
 	strbuf_release(&newref);
-	if (git_config_rename_section(oldsection.buf, newsection.buf) < 0)
-		die(_("Branch is renamed, but update of config-file failed"));
+	if (git_config_copy_or_rename_section(oldsection.buf, newsection.buf) < 0)
+		die(_("Branch is %s, but update of config-file failed"),
+			 (copy ? "copied" : "renamed"));
 	strbuf_release(&oldsection);
 	strbuf_release(&newsection);
 }
@@ -537,7 +542,7 @@ static int edit_branch_description(const char *branch_name)
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, force = 0, list = 0;
+	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
 	int reflog = 0, edit_description = 0;
 	int quiet = 0, unset_upstream = 0;
 	const char *new_upstream = NULL;
@@ -574,6 +579,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
+		OPT_BIT('c', NULL, &copy, N_("copy a branch and its reflog"), 1),
+		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
 		OPT_BOOL(0, "list", &list, N_("list branch names")),
 		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
@@ -617,14 +624,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
+	if (!delete && !rename && !copy && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr ||
 	    filter.no_commit)
 		list = 1;
 
-	if (!!delete + !!rename + !!new_upstream +
+	if (!!delete + !!rename + !!copy + !!new_upstream +
 	    list + unset_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -696,13 +703,22 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		if (edit_branch_description(branch_name))
 			return 1;
+	} else if (copy) {
+		if (!argc)
+			die(_("branch name required"));
+		else if (argc == 1)
+			copy_or_rename_branch(head, argv[0], 1, copy > 1);
+		else if (argc == 2)
+			copy_or_rename_branch(argv[0], argv[1], 1, copy > 1);
+		else
+			die(_("too many branches for a copy operation"));
 	} else if (rename) {
 		if (!argc)
 			die(_("branch name required"));
 		else if (argc == 1)
-			rename_branch(head, argv[0], rename > 1);
+			copy_or_rename_branch(head, argv[0], 0, rename > 1);
 		else if (argc == 2)
-			rename_branch(argv[0], argv[1], rename > 1);
+			copy_or_rename_branch(argv[0], argv[1], 0, rename > 1);
 		else
 			die(_("too many branches for a rename operation"));
 	} else if (new_upstream) {
diff --git a/builtin/config.c b/builtin/config.c
index 7f6c25d4d95b3..c72972d731bd1 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -693,7 +693,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		int ret;
 		check_write();
 		check_argc(argc, 2, 2);
-		ret = git_config_rename_section_in_file(given_config_source.file,
+		ret = git_config_copy_or_rename_section_in_file(given_config_source.file,
 							argv[0], argv[1]);
 		if (ret < 0)
 			return ret;
@@ -704,7 +704,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		int ret;
 		check_write();
 		check_argc(argc, 1, 1);
-		ret = git_config_rename_section_in_file(given_config_source.file,
+		ret = git_config_copy_or_rename_section_in_file(given_config_source.file,
 							argv[0], NULL);
 		if (ret < 0)
 			return ret;
diff --git a/builtin/remote.c b/builtin/remote.c
index addf97ad29343..ade748044b5ab 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -635,7 +635,7 @@ static int mv(int argc, const char **argv)
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s", rename.old);
 	strbuf_addf(&buf2, "remote.%s", rename.new);
-	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
+	if (git_config_copy_or_rename_section(buf.buf, buf2.buf) < 1)
 		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
 
@@ -706,7 +706,7 @@ static int mv(int argc, const char **argv)
 		strbuf_reset(&buf2);
 		strbuf_addf(&buf2, "remote: renamed %s to %s",
 				item->string, buf.buf);
-		if (rename_ref(item->string, buf.buf, buf2.buf))
+		if (copy_or_rename_ref(item->string, buf.buf, buf2.buf, 0))
 			die(_("renaming '%s' failed"), item->string);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
@@ -804,7 +804,7 @@ static int rm(int argc, const char **argv)
 
 	if (!result) {
 		strbuf_addf(&buf, "remote.%s", remote->name);
-		if (git_config_rename_section(buf.buf, NULL) < 1)
+		if (git_config_copy_or_rename_section(buf.buf, NULL) < 1)
 			return error(_("Could not remove config section '%s'"), buf.buf);
 	}
 
diff --git a/cache.h b/cache.h
index ae4c45d379d5b..b2b043d3505ba 100644
--- a/cache.h
+++ b/cache.h
@@ -1933,8 +1933,8 @@ extern int git_config_set_multivar_gently(const char *, const char *, const char
 extern void git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
 extern void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
-extern int git_config_rename_section(const char *, const char *);
-extern int git_config_rename_section_in_file(const char *, const char *, const char *);
+extern int git_config_copy_or_rename_section(const char *, const char *);
+extern int git_config_copy_or_rename_section_in_file(const char *, const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int git_env_bool(const char *, int);
 extern unsigned long git_env_ulong(const char *, unsigned long);
diff --git a/config.c b/config.c
index 146cb3452adab..78cf1ffac043e 100644
--- a/config.c
+++ b/config.c
@@ -2629,7 +2629,7 @@ static int section_name_is_ok(const char *name)
 }
 
 /* if new_name == NULL, the section is removed instead */
-int git_config_rename_section_in_file(const char *config_filename,
+int git_config_copy_or_rename_section_in_file(const char *config_filename,
 				      const char *old_name, const char *new_name)
 {
 	int ret = 0, remove = 0;
@@ -2733,9 +2733,9 @@ int git_config_rename_section_in_file(const char *config_filename,
 	return ret;
 }
 
-int git_config_rename_section(const char *old_name, const char *new_name)
+int git_config_copy_or_rename_section(const char *old_name, const char *new_name)
 {
-	return git_config_rename_section_in_file(NULL, old_name, new_name);
+	return git_config_copy_or_rename_section_in_file(NULL, old_name, new_name);
 }
 
 /*
diff --git a/refs.c b/refs.c
index 8af9641aa17e6..f8fb2577dfa9c 100644
--- a/refs.c
+++ b/refs.c
@@ -1907,13 +1907,13 @@ int delete_refs(struct string_list *refnames, unsigned int flags)
 	return refs_delete_refs(get_main_ref_store(), refnames, flags);
 }
 
-int refs_rename_ref(struct ref_store *refs, const char *oldref,
-		    const char *newref, const char *logmsg)
+int refs_copy_or_rename_ref(struct ref_store *refs, const char *oldref,
+		    const char *newref, const char *logmsg, int copy)
 {
-	return refs->be->rename_ref(refs, oldref, newref, logmsg);
+	return refs->be->copy_or_rename_ref(refs, oldref, newref, logmsg, copy);
 }
 
-int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+int copy_or_rename_ref(const char *oldref, const char *newref, const char *logmsg, int copy)
 {
-	return refs_rename_ref(get_main_ref_store(), oldref, newref, logmsg);
+	return refs_copy_or_rename_ref(get_main_ref_store(), oldref, newref, logmsg, copy);
 }
diff --git a/refs.h b/refs.h
index 685a979a0eb70..febdb09541813 100644
--- a/refs.h
+++ b/refs.h
@@ -394,9 +394,10 @@ const char *prettify_refname(const char *refname);
 char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
-int refs_rename_ref(struct ref_store *refs, const char *oldref,
-		    const char *newref, const char *logmsg);
-int rename_ref(const char *oldref, const char *newref, const char *logmsg);
+int refs_copy_or_rename_ref(struct ref_store *refs, const char *oldref,
+		    const char *newref, const char *logmsg, int copy);
+int copy_or_rename_ref(const char *oldref, const char *newref,
+			const char *logmsg, int copy);
 
 int refs_create_symref(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index cb1f528cbeec4..670cc00d3f3e3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1703,9 +1703,9 @@ static int commit_ref_update(struct files_ref_store *refs,
 			     const struct object_id *oid, const char *logmsg,
 			     struct strbuf *err);
 
-static int files_rename_ref(struct ref_store *ref_store,
+static int files_copy_or_rename_ref(struct ref_store *ref_store,
 			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg)
+			    const char *logmsg, int copy)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
@@ -1746,14 +1746,21 @@ static int files_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
+	if (!copy && log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
 		ret = error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
 			    oldrefname, strerror(errno));
 		goto out;
 	}
 
-	if (refs_delete_ref(&refs->base, logmsg, oldrefname,
-			    orig_oid.hash, REF_NODEREF)) {
+	// TODO: merge this block with the rename one above
+	if (copy && log && copy_file(tmp_renamed_log.buf, sb_oldref.buf, 0644)) {
+		ret = error("unable to copy logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
+			    oldrefname, strerror(errno));
+		goto out;
+	}
+
+	if (!copy && refs_delete_ref(&refs->base, logmsg, oldrefname,
+			    orig_sha1, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
 	}
@@ -1765,7 +1772,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	 * the safety anyway; we want to delete the reference whatever
 	 * its current value.
 	 */
-	if (!refs_read_ref_full(&refs->base, newrefname,
+	if (!copy && !refs_read_ref_full(&refs->base, newrefname,
 				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 				oid.hash, NULL) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
@@ -3318,7 +3325,7 @@ struct ref_storage_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_delete_refs,
-	files_rename_ref,
+	files_copy_or_rename_ref,
 
 	files_ref_iterator_begin,
 	files_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index b6b291cf00e5c..91d59b01fb570 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -510,9 +510,9 @@ typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *logmsg);
 typedef int delete_refs_fn(struct ref_store *ref_store,
 			   struct string_list *refnames, unsigned int flags);
-typedef int rename_ref_fn(struct ref_store *ref_store,
+typedef int copy_or_rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
-			  const char *logmsg);
+			  const char *logmsg, int copy);
 
 /*
  * Iterate over the references in the specified ref_store that are
@@ -606,7 +606,7 @@ struct ref_storage_be {
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 	delete_refs_fn *delete_refs;
-	rename_ref_fn *rename_ref;
+	copy_or_rename_ref_fn *copy_or_rename_ref;
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
diff --git a/submodule.c b/submodule.c
index bf5a93d16fb71..d93f366be31c6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -107,7 +107,7 @@ int remove_path_from_gitmodules(const char *path)
 	}
 	strbuf_addstr(&sect, "submodule.");
 	strbuf_addstr(&sect, submodule->name);
-	if (git_config_rename_section_in_file(".gitmodules", sect.buf, NULL) < 0) {
+	if (git_config_copy_or_rename_section_in_file(".gitmodules", sect.buf, NULL) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not remove .gitmodules entry for %s"), path);
 		strbuf_release(&sect);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index fba85e7da58fb..bfa031d77c8f0 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -107,7 +107,7 @@ static int cmd_rename_ref(struct ref_store *refs, const char **argv)
 	const char *newref = notnull(*argv++, "newref");
 	const char *logmsg = *argv++;
 
-	return refs_rename_ref(refs, oldref, newref, logmsg);
+	return refs_copy_or_rename_ref(refs, oldref, newref, logmsg, 0);
 }
 
 static int each_ref(const char *refname, const struct object_id *oid,

--
https://github.com/git/git/pull/363
