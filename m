Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF1F2070F
	for <e@80x24.org>; Fri, 16 Sep 2016 00:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757423AbcIPAM6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:58 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33058 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757295AbcIPAMe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:34 -0400
Received: by mail-qk0-f193.google.com with SMTP id n66so4510063qkf.0
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=KRgzu6dQVh6pEdD2ZIl9Plx4wTyAFyD/Eg0dSJoU0Qo=;
        b=i4+Dt6P3zaWQVXOCoRLtsSR6iL/uJ34QA8oVCMPfqImlcFO97FNAA78YC44k4/8Vrv
         q3i6f1jGad2yey1o+S0zNF0M3qxvhAg5qRpznKf6hjhwQtkoyWonnWKtWtbNpg2ZS9tb
         Do9WMuw9RiFgFp61vTTl/hDB2VV5T0tNd2L7jlDsp7lPrjj1j36m4q/Vjl9pbjaBJi1o
         RjKDIqyhJw47pd0rC6gxN+iSpCEQWVwcEkc3Vvv/4qBqRYZafu6D89VUteFRyXYinGud
         VTA+Ph/4WP+MiIfTP5Zey6gAT7D6kEG7GitUV+z1WQhmkcdyMa9EgTHmzCp6levWty2R
         IqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=KRgzu6dQVh6pEdD2ZIl9Plx4wTyAFyD/Eg0dSJoU0Qo=;
        b=jKmqxXsEVq1qxtjq86CdhNfb5/HxN1K8nQeLABT9KNk4AuwR5teybqb25aIM+8yosD
         tOB4bUoSOelNjpdX6AmiAFOH+QlTmgS0lRCUMV6rIN3E385GCR9jh8DWkXvp6I+tgiXp
         t5qukBLr0hg9g6VyUxwycbDv4vUs8TCmE9rjUYydYbm3D0wbOIta8UA3hkvHQYSaicYO
         Bop8ZCZck4mt6zabagoTFGHmo8w4ZAtE9Kd7kg780hGaWrJ915BZFL1d0tFFTX9oa1Cp
         bB7l0cXhyDVpSVt3UOKOAHlP0NfHnfs0Ufm4lPZzzZBgVQ+D+rrHYU79Zq2fztR1JgpV
         Ug9g==
X-Gm-Message-State: AE9vXwPFPLSRjKxJ9dcB9yKEYR1xLxm4kEpVJ5o3q/ii5XH8ibPSPTmrZOulE7azmNV7wQ==
X-Received: by 10.55.210.67 with SMTP id f64mr13546166qkj.166.1473984752736;
        Thu, 15 Sep 2016 17:12:32 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:32 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 11/11] Resumable clone: implement primer logic in git-clone
Date:   Thu, 15 Sep 2016 20:12:22 -0400
Message-Id: <1473984742-12516-12-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use transport_download_primer and transport_prime_clone in git clone.
This only supports a fully connected packfile.

transport_prime_clone and transport_download_primer are executed
completely independent of transport_(get|fetch)_remote_refs, et al.
transport_download_primer is executed based on the existence of an
alt_resource. The idea is that the "prime clone" execution should be
able to attempt retrieving an alternate resource without dying, as
opposed to depending on the result of upload pack's "capabilities" to
indicate whether or not the client can attempt it.

If a resumable resource is available, execute a codepath with the
following modular components:
- downloading resource to a specific directory
- using the resource (for pack, indexing and generating the bundle
  file)
- cleaning up the resource (if the download or use fails)
- cleaning up the resource (if the download or use succeeds)

If resume is interrupted on the client side, the alternate resource
info is written to the RESUMABLE file in the git directory.

On resume, the required info is extracted by parsing the created
config file, and that info is used to determine the work and git
directories. If these cannot be determined, the program exits.
The writing of the refspec and determination of the initial git
directories are skipped, along with transport_prime_clone.

The main purpose of this series of patches is to flesh out a codepath
for automatic resuming, manual resuming, and leaving a resumable
directory on exit--the logic for when to do these still needs more
work.

Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
---
 Documentation/git-clone.txt |  16 ++
 builtin/clone.c             | 590 +++++++++++++++++++++++++++++++++++++-------
 t/t9904-git-prime-clone.sh  | 181 ++++++++++++++
 3 files changed, 698 insertions(+), 89 deletions(-)
 create mode 100755 t/t9904-git-prime-clone.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b7c467a..5934bb6 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	  [--depth <depth>] [--[no-]single-branch]
 	  [--recursive | --recurse-submodules] [--] <repository>
 	  [<directory>]
+'git clone --resume <resumable_dir>'
 
 DESCRIPTION
 -----------
@@ -172,6 +173,12 @@ objects from the source repository into a pack in the cloned repository.
 	via ssh, this specifies a non-default path for the command
 	run on the other end.
 
+--prime-clone <prime-clone>::
+-p <prime-clone>::
+	When given and the repository to clone from is accessed
+	via ssh, this specifies a non-default path for the command
+	run on the other end.
+
 --template=<template_directory>::
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
@@ -232,6 +239,15 @@ objects from the source repository into a pack in the cloned repository.
 	for `host.xz:foo/.git`).  Cloning into an existing directory
 	is only allowed if the directory is empty.
 
+--resume::
+	Resume a partially cloned repo in a "resumable" state. This
+	can only be specified with a single local directory (<resumable
+	dir>). This is incompatible with all other options.
+
+<resumable_dir>::
+	The directory of the partial clone. This could be either the
+	work directory or the git directory.
+
 :git-clone: 1
 include::urls.txt[]
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 9ac6c01..d9a13dc 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,7 +8,9 @@
  * Clone a repository into a different directory that does not yet exist.
  */
 
+#include "cache.h"
 #include "builtin.h"
+#include "bundle.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
@@ -40,17 +42,20 @@ static const char * const builtin_clone_usage[] = {
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
 static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
+static int option_resume;
 static char *option_template, *option_depth;
-static char *option_origin = NULL;
+static const char *option_origin = NULL;
 static char *option_branch = NULL;
 static const char *real_git_dir;
 static char *option_upload_pack = "git-upload-pack";
+static char *option_prime_clone = "git-prime-clone";
 static int option_verbosity;
 static int option_progress = -1;
 static enum transport_family family;
 static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
+static const struct alt_resource *alt_res = NULL;
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -85,10 +90,14 @@ static struct option builtin_clone_options[] = {
 		   N_("checkout <branch> instead of the remote's HEAD")),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
 		   N_("path to git-upload-pack on the remote")),
+	OPT_STRING('p', "prime-clone", &option_prime_clone, N_("path"),
+		   N_("path to git-prime-clone on the remote")),
 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
 		    N_("create a shallow clone of that depth")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
+	OPT_BOOL(0, "resume", &option_resume,
+		    N_("continue a resumable clone")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
@@ -278,6 +287,21 @@ static void strip_trailing_slashes(char *dir)
 	*end = '\0';
 }
 
+static char *get_filename(const char *dir)
+{
+	char *dir_copy = xstrdup(dir);
+	strip_trailing_slashes(dir_copy);
+	char *filename, *final = NULL;
+
+	filename = find_last_dir_sep(dir);
+
+	if (filename && *(++filename))
+		final = xstrdup(filename);
+
+	free(dir_copy);
+	return final;
+}
+
 static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
 	char *ref_git;
@@ -451,6 +475,7 @@ static const char *junk_work_tree;
 static const char *junk_git_dir;
 static enum {
 	JUNK_LEAVE_NONE,
+	JUNK_LEAVE_RESUMABLE,
 	JUNK_LEAVE_REPO,
 	JUNK_LEAVE_ALL
 } junk_mode = JUNK_LEAVE_NONE;
@@ -460,6 +485,29 @@ N_("Clone succeeded, but checkout failed.\n"
    "You can inspect what was checked out with 'git status'\n"
    "and retry the checkout with 'git checkout -f HEAD'\n");
 
+static const char junk_leave_resumable_msg[] =
+N_("Clone interrupted while copying resumable resource.\n"
+   "Try using 'git clone --resume <new_directory>',\n"
+   "where <new_directory> is either the new working \n"
+   "directory or git directory.\n\n"
+   "If this does not succeed, it could be because the\n"
+   "resource has been moved, corrupted, or changed.\n"
+   "If this is the case, you should remove <new_directory>\n"
+   "and run the original command.\n");
+
+static void write_resumable_resource()
+{
+	const char *filename = git_path_resumable();
+	struct strbuf content = STRBUF_INIT;
+	strbuf_addf(&content, "%s\n%s\n", alt_res->url, alt_res->filetype);
+	int fd = open(filename, O_WRONLY | O_CREAT, 0666);
+	if (fd < 0)
+		die_errno(_("Could not open '%s' for writing"), filename);
+	if (write_in_full(fd, content.buf, content.len) != content.len)
+		die_errno(_("Could not write to '%s'"), filename);
+	close(fd);
+}
+
 static void remove_junk(void)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -467,7 +515,11 @@ static void remove_junk(void)
 	switch (junk_mode) {
 	case JUNK_LEAVE_REPO:
 		warning("%s", _(junk_leave_repo_msg));
-		/* fall-through */
+		return;
+	case JUNK_LEAVE_RESUMABLE:
+		write_resumable_resource();
+		warning("%s", _(junk_leave_resumable_msg));
+		return;
 	case JUNK_LEAVE_ALL:
 		return;
 	default:
@@ -562,7 +614,7 @@ static void write_remote_refs(const struct ref *local_refs)
 		die("%s", err.buf);
 
 	for (r = local_refs; r; r = r->next) {
-		if (!r->peer_ref)
+		if (!r->peer_ref || ref_exists(r->peer_ref->name))
 			continue;
 		if (ref_transaction_create(t, r->peer_ref->name, r->old_oid.hash,
 					   0, NULL, &err))
@@ -820,11 +872,296 @@ static void dissociate_from_references(void)
 	free(alternates);
 }
 
+static int do_index_pack(const char *in_pack_file, const char *out_idx_file)
+{
+	const char *argv[] = { "index-pack", "--clone-bundle", "-v",
+			       "--check-self-contained-and-connected", "-o",
+			       out_idx_file, in_pack_file, NULL };
+	return run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDOUT);
+}
+
+static const char *replace_extension(const char *filename, const char *existing,
+				     const char *replacement)
+{
+	struct strbuf new_filename = STRBUF_INIT;
+	int existing_len = strlen(existing);
+	int replacement_len = strlen(replacement);
+	int filename_len = strlen(filename);
+
+	if (!(filename && existing && replacement)) {
+		return NULL;
+	}
+
+	if (!strncmp(filename + filename_len - existing_len,
+		     existing, existing_len)) {
+		int existing_position = filename_len - existing_len;
+		strbuf_addstr(&new_filename, filename);
+		strbuf_splice(&new_filename, existing_position, existing_len,
+				replacement, replacement_len);
+	}
+
+	return strbuf_detach(&new_filename, NULL);
+}
+
+static const char *setup_and_index_pack(const char *filename)
+{
+	const char *primer_idx_path = NULL, *primer_bndl_path = NULL;
+	primer_idx_path = replace_extension(filename, ".pack", ".idx");
+	primer_bndl_path = replace_extension(filename, ".pack", ".bndl");
+
+	if (!(primer_idx_path && primer_bndl_path)) {
+		warning("invalid pack filename '%s', falling back to full "
+			"clone", filename);
+		return NULL;
+	}
+
+	if (!file_exists(primer_bndl_path)) {
+		if (do_index_pack(filename, primer_idx_path)) {
+			warning("could not index primer pack, falling back to "
+				"full clone");
+			return NULL;
+		}
+	}
+
+	return primer_bndl_path;
+}
+
+static int write_bundle_refs(const char *bundle_filename)
+{
+	struct ref_transaction *t;
+	struct bundle_header history_tips;
+	const char *temp_ref_base = "resume";
+	struct strbuf err = STRBUF_INIT;
+	int i;
+
+	init_bundle_header(&history_tips, bundle_filename);
+	read_bundle_header(&history_tips);
+
+	t = ref_transaction_begin(&err);
+	for (i = 0; i < history_tips.references.nr; i++) {
+		struct strbuf ref_name = STRBUF_INIT;
+		strbuf_addf(&ref_name, "refs/temp/%s/%s/temp-%s",
+			    option_origin, temp_ref_base,
+			    sha1_to_hex(history_tips.references.list[i].sha1));
+		if (!ref_exists(ref_name.buf)) {
+			if (ref_transaction_create(t, ref_name.buf,
+					history_tips.references.list[i].sha1,
+					0, NULL, &err)) {
+				warning(_("%s"), err.buf);
+				return -1;
+			}
+		}
+		strbuf_release(&ref_name);
+	}
+
+	if (initial_ref_transaction_commit(t, &err)) {
+		warning("%s", err.buf);
+		return -1;
+	}
+	ref_transaction_free(t);
+	release_bundle_header(&history_tips);
+	return 0;
+}
+
+static int use_alt_resource_pack(const char *alt_res_path)
+{
+	int ret = -1;
+	const char *bundle_path = setup_and_index_pack(alt_res_path);
+	if (bundle_path)
+		ret = write_bundle_refs(bundle_path);
+	return ret;
+}
+
+static int use_alt_resource(const char *alt_res_path)
+{
+	int ret = -1;
+	if (!strcmp(alt_res->filetype, "pack"))
+		ret = use_alt_resource_pack(alt_res_path);
+	return ret;
+}
+
+static void clean_alt_resource_pack(const char *resource_path,
+				    int prime_successful)
+{
+	struct bundle_header history_tips;
+	const char *temp_ref_base = "resume";
+	const char *bundle_path;
+
+	if (!resource_path)
+		return;
+
+	bundle_path = replace_extension(resource_path, ".pack", ".bndl");
+
+	if (prime_successful) {
+		init_bundle_header(&history_tips, bundle_path);
+		read_bundle_header(&history_tips);
+
+		for (int i = 0; i < history_tips.references.nr; i++) {
+			struct strbuf ref_name = STRBUF_INIT;
+			strbuf_addf(&ref_name, "refs/temp/%s/%s/temp-%s",
+				    option_origin, temp_ref_base,
+				    sha1_to_hex(history_tips.references.list[i].sha1));
+			if (ref_exists(ref_name.buf)) {
+				delete_ref(ref_name.buf,
+					   history_tips.references.list[i].sha1,
+					   0);
+			}
+			strbuf_release(&ref_name);
+		}
+		release_bundle_header(&history_tips);
+	}
+
+	if (!prime_successful) {
+		const char *tmp_path = mkpath("%s.temp", resource_path);
+		const char *idx_path = replace_extension(resource_path, ".pack",
+							 ".idx");
+		if (file_exists(resource_path)) {
+			unlink(resource_path);
+		}
+		if (file_exists(tmp_path)) {
+			unlink(tmp_path);
+		}
+		if (file_exists(idx_path)) {
+			unlink(idx_path);
+		}
+	}
+	if (file_exists(bundle_path)) {
+		unlink(bundle_path);
+	}
+}
+
+static const char *fetch_alt_resource_pack(struct transport *transport,
+					  const char *base_dir)
+{
+	struct strbuf download_path = STRBUF_INIT;
+	const char *resource_path = NULL;
+	struct remote *primer_remote = remote_get(alt_res->url);
+	struct transport *primer_transport = transport_get(primer_remote,
+							   alt_res->url);
+	strbuf_addf(&download_path, "%s/objects/pack", base_dir);
+	fprintf(stderr, "Downloading primer: %s...\n", alt_res->url);
+	resource_path = transport_download_primer(primer_transport, alt_res,
+						  download_path.buf);
+	transport_disconnect(primer_transport);
+	return resource_path;
+}
+
+static void clean_alt_resource(const char *resource_path, int prime_successful)
+{
+	if (!strcmp(alt_res->filetype, "pack"))
+		clean_alt_resource_pack(resource_path, prime_successful);
+}
+
+static const char *fetch_alt_resource(struct transport *transport,
+				      const char *base_dir)
+{
+	const char *resource_path = NULL;
+	if (!strcmp(alt_res->filetype, "pack"))
+		resource_path = fetch_alt_resource_pack(transport, base_dir);
+	return resource_path;
+}
+
+static const struct alt_resource *get_last_alt_resource(void)
+{
+	struct alt_resource *ret = NULL;
+	FILE *fp;
+	if (fp = fopen(git_path_resumable(), "r")) {
+		ret = xcalloc(1, sizeof(struct alt_resource));
+		struct strbuf line = STRBUF_INIT;
+		strbuf_getline(&line, fp);
+		ret->url = strbuf_detach(&line, NULL);
+		strbuf_getline(&line, fp);
+		ret->filetype = strbuf_detach(&line, NULL);
+		fclose(fp);
+	}
+	return ret;
+}
+
+struct remote_config {
+	const char *name;
+	const char *fetch_pattern;
+	const char *worktree;
+	int bare;
+	int mirror;
+};
+
+static int get_remote_info(const char *key, const char *value, void *priv)
+{
+	struct remote_config *p = priv;
+	char *sub_key;
+	char *name;
+
+	if (skip_prefix(key, "remote.", &key)) {
+		name = xstrdup(key);
+		sub_key = strchr(name, '.');
+		*sub_key++ = 0;
+		if (!p->name)
+			p->name = xstrdup(name);
+		else if (!strcmp(sub_key, "fetch"))
+			git_config_string(&p->fetch_pattern, key, value);
+		else if (!strcmp(sub_key, "mirror"))
+			p->mirror =  git_config_bool(key, value);
+		free(name);
+	}
+	else if (!strcmp(key, "core.bare"))
+		p->bare =  git_config_bool(key, value);
+	else if (!strcmp(key, "core.worktree"))
+		git_config_string(&p->worktree, key, value);
+
+	return 0;
+}
+
+static void get_existing_state(char *dir, const char **git_dir,
+			   const char **work_tree,
+			   struct remote_config *past_info)
+{
+	if (is_git_directory(dir)) {
+		*git_dir = xstrdup(dir);
+		*work_tree = NULL;
+	}
+	else if (file_exists(mkpath("%s/.git", dir))){
+		*work_tree = xstrdup(dir);
+		*git_dir = xstrdup(resolve_gitdir(mkpath("%s/.git", dir)));
+	}
+
+	if (!*git_dir)
+		die(_("'%s' does not appear to be a git repo."), dir);
+
+	set_git_dir(*git_dir);
+	git_config(get_remote_info, past_info);
+
+	if (!*work_tree) {
+		if (past_info->worktree) {
+			*work_tree = past_info->worktree;
+		}
+		else if (!past_info->bare) {
+			int containing_dir_success = 1;
+			char *filename = get_filename(*git_dir);
+			if (filename && !strcmp(filename, ".git")) {
+				const char *parent_dir = mkpath("%s/..",
+								*git_dir);
+				*work_tree = xstrdup(real_path(parent_dir));
+				if (access(*work_tree, W_OK) < 0)
+					containing_dir_success = 0;
+			}
+			else {
+				containing_dir_success = 0;
+			}
+			if (!containing_dir_success)
+				die(_("'%s' is configured for a work tree, "
+				      "but no candidate exists."), dir);
+		}
+	}
+	if (*work_tree)
+		set_git_work_tree(*work_tree);
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
-	int is_bundle = 0, is_local;
+	int is_bundle = 0, is_local, argc_original, option_count;
 	struct stat buf;
-	const char *repo_name, *repo, *work_tree, *git_dir;
+	const char *repo_name, *repo, *work_tree, *git_dir = NULL;
+	const char *resource_path;
 	char *path, *dir;
 	int dest_exists;
 	const struct ref *refs, *remote_head;
@@ -838,13 +1175,23 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const char *src_ref_prefix = "refs/heads/";
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
-
 	struct refspec *refspec;
 	const char *fetch_pattern;
 
 	packet_trace_identity("clone");
+	argc_original = argc;
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
+	option_count = argc_original - argc;
+
+	if (option_resume && option_count > 2) {
+		die(_("--resume is incompatible with all other options."));
+	}
+
+	if (option_resume && argc != 1) {
+		die(_("--resume must be specified with a single resumable "
+		      "directory."));
+	}
 
 	if (argc > 2)
 		usage_msg_opt(_("Too many arguments."),
@@ -872,105 +1219,140 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (!option_origin)
 		option_origin = "origin";
 
-	repo_name = argv[0];
+	if (option_resume) {
+		struct remote_config past_info = {0};
+		dir = xstrdup(real_path(argv[0]));
+		strip_trailing_slashes(dir);
+		if (!file_exists(dir))
+			die(_("directory '%s' does not exist."), dir);
+		get_existing_state(dir, &git_dir, &work_tree, &past_info);
+
+		if (!work_tree)
+			option_no_checkout = 1;
+		if (past_info.fetch_pattern)
+			fetch_pattern = past_info.fetch_pattern;
+		else {
+			struct strbuf fetch_temp = STRBUF_INIT;
+			strbuf_addstr(&branch_top, src_ref_prefix);
+			strbuf_addf(&fetch_temp, "+%s*:%s*", src_ref_prefix,
+					branch_top.buf);
+			fetch_pattern = strbuf_detach(&fetch_temp, NULL);
+		}
 
-	path = get_repo_path(repo_name, &is_bundle);
-	if (path)
-		repo = xstrdup(absolute_path(repo_name));
-	else if (!strchr(repo_name, ':'))
-		die(_("repository '%s' does not exist"), repo_name);
-	else
-		repo = repo_name;
+		option_origin = past_info.name;
+		option_mirror = past_info.mirror;
+		option_bare = past_info.bare;
+		refspec = parse_fetch_refspec(1, &fetch_pattern);
 
-	/* no need to be strict, transport_set_option() will validate it again */
-	if (option_depth && atoi(option_depth) < 1)
-		die(_("depth %s is not a positive number"), option_depth);
+		if (!(alt_res = get_last_alt_resource()))
+			die(_("--resume option used, but current "
+			      "directory is not resumable"));
 
-	if (argc == 2)
-		dir = xstrdup(argv[1]);
-	else
-		dir = guess_dir_name(repo_name, is_bundle, option_bare);
-	strip_trailing_slashes(dir);
+		junk_mode = JUNK_LEAVE_RESUMABLE;
+		atexit(remove_junk);
+		sigchain_push_common(remove_junk_on_signal);
+	}
+	else {
+		repo_name = argv[0];
+
+		path = get_repo_path(repo_name, &is_bundle);
+		if (path)
+			repo = xstrdup(absolute_path(repo_name));
+		else if (!strchr(repo_name, ':'))
+			die(_("repository '%s' does not exist"), repo_name);
+		else
+			repo = repo_name;
 
-	dest_exists = !stat(dir, &buf);
-	if (dest_exists && !is_empty_dir(dir))
-		die(_("destination path '%s' already exists and is not "
-			"an empty directory."), dir);
+		/* no need to be strict, transport_set_option() will validate it again */
+		if (option_depth && atoi(option_depth) < 1)
+			die(_("depth %s is not a positive number"), option_depth);
 
-	strbuf_addf(&reflog_msg, "clone: from %s", repo);
+		if (argc == 2)
+			dir = xstrdup(argv[1]);
+		else
+			dir = guess_dir_name(repo_name, is_bundle, option_bare);
+		strip_trailing_slashes(dir);
 
-	if (option_bare)
-		work_tree = NULL;
-	else {
-		work_tree = getenv("GIT_WORK_TREE");
-		if (work_tree && !stat(work_tree, &buf))
-			die(_("working tree '%s' already exists."), work_tree);
-	}
+		dest_exists = !stat(dir, &buf);
+		if (dest_exists && !is_empty_dir(dir))
+			die(_("destination path '%s' already exists and is not "
+				"an empty directory."), dir);
 
-	if (option_bare || work_tree)
-		git_dir = xstrdup(dir);
-	else {
-		work_tree = dir;
-		git_dir = mkpathdup("%s/.git", dir);
-	}
+		strbuf_addf(&reflog_msg, "clone: from %s", repo);
 
-	atexit(remove_junk);
-	sigchain_push_common(remove_junk_on_signal);
-
-	if (!option_bare) {
-		if (safe_create_leading_directories_const(work_tree) < 0)
-			die_errno(_("could not create leading directories of '%s'"),
-				  work_tree);
-		if (!dest_exists && mkdir(work_tree, 0777))
-			die_errno(_("could not create work tree dir '%s'"),
-				  work_tree);
-		junk_work_tree = work_tree;
-		set_git_work_tree(work_tree);
-	}
+		if (option_bare)
+			work_tree = NULL;
+		else {
+			work_tree = getenv("GIT_WORK_TREE");
+			if (work_tree && !stat(work_tree, &buf))
+				die(_("working tree '%s' already exists."), work_tree);
+		}
 
-	junk_git_dir = git_dir;
-	if (safe_create_leading_directories_const(git_dir) < 0)
-		die(_("could not create leading directories of '%s'"), git_dir);
+		if (option_bare || work_tree)
+			git_dir = xstrdup(dir);
+		else {
+			work_tree = dir;
+			git_dir = mkpathdup("%s/.git", dir);
+		}
 
-	set_git_dir_init(git_dir, real_git_dir, 0);
-	if (real_git_dir) {
-		git_dir = real_git_dir;
-		junk_git_dir = real_git_dir;
-	}
+		atexit(remove_junk);
+		sigchain_push_common(remove_junk_on_signal);
 
-	if (0 <= option_verbosity) {
-		if (option_bare)
-			fprintf(stderr, _("Cloning into bare repository '%s'...\n"), dir);
-		else
-			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
-	}
-	init_db(option_template, INIT_DB_QUIET);
-	write_config(&option_config);
+		if (!option_bare) {
+			if (safe_create_leading_directories_const(work_tree) < 0)
+				die_errno(_("could not create leading directories of '%s'"),
+					  work_tree);
+			if (!dest_exists && mkdir(work_tree, 0777))
+				die_errno(_("could not create work tree dir '%s'"),
+					  work_tree);
+			junk_work_tree = work_tree;
+			set_git_work_tree(work_tree);
+		}
 
-	git_config(git_default_config, NULL);
+		junk_git_dir = git_dir;
+		if (safe_create_leading_directories_const(git_dir) < 0)
+			die(_("could not create leading directories of '%s'"), git_dir);
 
-	if (option_bare) {
-		if (option_mirror)
-			src_ref_prefix = "refs/";
-		strbuf_addstr(&branch_top, src_ref_prefix);
+		set_git_dir_init(git_dir, real_git_dir, 0);
+		if (real_git_dir) {
+			git_dir = real_git_dir;
+			junk_git_dir = real_git_dir;
+		}
 
-		git_config_set("core.bare", "true");
-	} else {
-		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
-	}
+		if (0 <= option_verbosity) {
+			if (option_bare)
+				fprintf(stderr, _("Cloning into bare repository '%s'...\n"), dir);
+			else
+				fprintf(stderr, _("Cloning into '%s'...\n"), dir);
+		}
+		init_db(option_template, INIT_DB_QUIET);
+		write_config(&option_config);
+
+		git_config(git_default_config, NULL);
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
-	strbuf_addf(&key, "remote.%s.url", option_origin);
-	git_config_set(key.buf, repo);
-	strbuf_reset(&key);
+		if (option_bare) {
+			if (option_mirror)
+				src_ref_prefix = "refs/";
+			strbuf_addstr(&branch_top, src_ref_prefix);
 
-	if (option_reference.nr)
-		setup_reference();
+			git_config_set("core.bare", "true");
+		} else {
+			strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
+		}
+
+		strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+		strbuf_addf(&key, "remote.%s.url", option_origin);
+		git_config_set(key.buf, repo);
+		strbuf_reset(&key);
 
-	fetch_pattern = value.buf;
-	refspec = parse_fetch_refspec(1, &fetch_pattern);
+		if (option_reference.nr)
+			setup_reference();
 
-	strbuf_reset(&value);
+		fetch_pattern = value.buf;
+		refspec = parse_fetch_refspec(1, &fetch_pattern);
+
+		strbuf_reset(&value);
+	}
 
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
@@ -1003,6 +1385,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_single_branch)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 
+	if (option_prime_clone)
+		transport_set_option(transport, TRANS_OPT_PRIMECLONE,
+				     option_prime_clone);
+
 	if (option_upload_pack)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
@@ -1010,6 +1396,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (transport->smart_options && !option_depth)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
+	if (!is_local && option_reference.nr == 0 && !alt_res)
+		alt_res = transport_prime_clone(transport);
 	refs = transport_get_remote_refs(transport);
 
 	if (refs) {
@@ -1064,8 +1452,24 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					      "refs/heads/master");
 	}
 
-	write_refspec_config(src_ref_prefix, our_head_points_at,
-			remote_head_points_at, &branch_top);
+	if (!option_resume) {
+		write_refspec_config(src_ref_prefix, our_head_points_at,
+				     remote_head_points_at, &branch_top);
+	}
+
+	if (alt_res) {
+		junk_mode = JUNK_LEAVE_RESUMABLE;
+		resource_path = fetch_alt_resource(transport, git_dir);
+		if (!resource_path || use_alt_resource(resource_path) < 0) {
+			if (option_resume)
+				die(_("resumable resource is no longer "
+				      "available or usable"));
+			junk_mode = JUNK_LEAVE_NONE;
+			clean_alt_resource(resource_path, 0);
+			resource_path = NULL;
+			alt_res = NULL;
+		}
+	}
 
 	if (is_local)
 		clone_local(path, git_dir);
@@ -1085,9 +1489,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		dissociate_from_references();
 	}
 
+	if (resource_path) {
+		clean_alt_resource(resource_path, 1);
+	}
+
 	junk_mode = JUNK_LEAVE_REPO;
 	err = checkout();
 
+	if (file_exists(git_path_resumable())) {
+		unlink(git_path_resumable());
+	}
+
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
diff --git a/t/t9904-git-prime-clone.sh b/t/t9904-git-prime-clone.sh
new file mode 100755
index 0000000..257cea9
--- /dev/null
+++ b/t/t9904-git-prime-clone.sh
@@ -0,0 +1,181 @@
+#!/bin/sh
+
+test_description='tests for git prime-clone'
+. ./test-lib.sh
+
+ROOT_PATH="$PWD"
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'resume fails for no parameters' '
+	test_must_fail git clone --resume
+'
+
+test_expect_success 'resume fails with other options' '
+	test_must_fail git clone --resume --bare
+'
+
+test_expect_success 'resume fails for excess parameters' '
+	test_must_fail git clone --resume a b
+'
+
+test_expect_success 'resume fails for nonexistent directory' '
+	test_must_fail git clone --resume nonexistent
+'
+
+test_expect_success 'setup repo and httpd' '
+	mkdir server &&
+	cd server &&
+	git init &&
+	echo "content\\n" >example.c &&
+	git add example.c &&
+	git commit -m "I am a packed commit" &&
+	git repack . &&
+	git config --local http.primeclone true &&
+	git config --local primeclone.url \
+		$HTTPD_URL/server/.git/objects/pack/$(find .git/objects/pack/*.pack -printf "%f") &&
+	git config --local primeclone.filetype pack &&
+	echo "content\\n" >example2.c &&
+	echo "new content\\n" >example.c &&
+	git add example.c example2.c &&
+	git commit -m "I am an unpacked commit" &&
+	cd - &&
+	mv server "$HTTPD_DOCUMENT_ROOT_PATH"
+'
+
+test_expect_success 'prime-clone works http' '
+	git clone $HTTPD_URL/smart/server client &&
+	rm -r client
+'
+
+test_expect_success 'prime-clone falls back not permitted' '
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	git config --local http.primeclone false &&
+	cd - &&
+	git clone $HTTPD_URL/smart/server client &&
+	rm -r client &&
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	git config --local http.primeclone true &&
+	cd -
+'
+
+test_expect_success 'prime-clone falls back not enabled' '
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	git config --local primeclone.enabled 0 &&
+	cd - &&
+	git clone $HTTPD_URL/smart/server client &&
+	rm -r client &&
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	git config --local --unset-all primeclone.enabled &&
+	cd -
+'
+
+test_expect_success 'prime-clone falls back incorrect config' '
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	git config --local --unset-all primeclone.filetype &&
+	cd - &&
+	git clone $HTTPD_URL/smart/server client &&
+	rm -r client &&
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	git config --local primeclone.filetype pack &&
+	cd -
+'
+
+test_expect_success 'clone resume fails in complete/unmarked directory' '
+	git clone $HTTPD_URL/smart/server client &&
+	test_must_fail git clone --resume client &&
+	rm -r client
+'
+
+test_expect_success 'clone resume works with marked repo (work dir, normal)' '
+	git clone $HTTPD_URL/smart/server client &&
+	cd client &&
+	rm .git/objects/pack/*.idx &&
+	echo -n "$HTTPD_URL/server/" > .git/RESUMABLE &&
+	find .git/objects/pack/*.pack >> .git/RESUMABLE &&
+	echo "pack" >> .git/RESUMABLE &&
+	mv $(find .git/objects/pack/*.pack) $(find .git/objects/pack/*.pack).tmp &&
+	sed -i "2,$ d" $(find .git/objects/pack/*.pack.tmp) &&
+	rm * &&
+	git clone --resume . &&
+	cd - &&
+	rm -r client
+'
+
+test_expect_success 'clone resume works with marked repo (git dir, normal)' '
+	git clone $HTTPD_URL/smart/server client &&
+	cd client &&
+	rm .git/objects/pack/*.idx &&
+	echo -n "$HTTPD_URL/server/" > .git/RESUMABLE &&
+	find .git/objects/pack/*.pack >> .git/RESUMABLE &&
+	echo "pack" >> .git/RESUMABLE &&
+	mv $(find .git/objects/pack/*.pack) $(find .git/objects/pack/*.pack).tmp &&
+	sed -i "2,$ d" $(find .git/objects/pack/*.pack.tmp) &&
+	rm * &&
+	git clone --resume .git &&
+	cd - &&
+	rm -r client
+'
+
+test_expect_success 'clone resume works inside marked repo (git dir, normal)' '
+	git clone $HTTPD_URL/smart/server client &&
+	cd client &&
+	rm .git/objects/pack/*.idx &&
+	echo -n "$HTTPD_URL/server/" > .git/RESUMABLE &&
+	find .git/objects/pack/*.pack >> .git/RESUMABLE &&
+	echo "pack" >> .git/RESUMABLE &&
+	mv $(find .git/objects/pack/*.pack) $(find .git/objects/pack/*.pack).tmp &&
+	sed -i "2,$ d" $(find .git/objects/pack/*.pack.tmp) &&
+	rm * &&
+	cd .git &&
+	git clone --resume . &&
+	cd ../.. &&
+	rm -r client
+'
+
+test_expect_success 'clone resume works with marked repo (work dir, split)' '
+	git clone --separate-git-dir=separate_dir.git \
+		$HTTPD_URL/smart/server client &&
+	cd separate_dir.git &&
+	rm objects/pack/*.idx &&
+	echo -n "$HTTPD_URL/server/" > RESUMABLE &&
+	echo ".git/$(find objects/pack/*.pack)" >> RESUMABLE &&
+	echo "pack" >> RESUMABLE &&
+	mv $(find objects/pack/*.pack) $(find objects/pack/*.pack).tmp &&
+	sed -i "2,$ d" $(find objects/pack/*.pack.tmp) &&
+	cd ../client &&
+	rm * &&
+	cd .. &&
+	git clone --resume client &&
+	rm -r client separate_dir.git
+'
+
+test_expect_success 'clone resume works with marked repo (git dir, split)' '
+	git clone --separate-git-dir=separate_dir.git \
+		$HTTPD_URL/smart/server client &&
+	cd separate_dir.git &&
+	rm objects/pack/*.idx &&
+	echo -n "$HTTPD_URL/server/" > RESUMABLE &&
+	echo ".git/$(find objects/pack/*.pack)" >> RESUMABLE &&
+	echo "pack" >> RESUMABLE &&
+	mv $(find objects/pack/*.pack) $(find objects/pack/*.pack).tmp &&
+	sed -i "2,$ d" $(find objects/pack/*.pack.tmp) &&
+	cd ../client &&
+	rm * &&
+	cd .. &&
+	git clone --resume separate_dir.git &&
+	rm -r client separate_dir.git
+'
+
+test_expect_success 'prime-clone falls back unusable file' '
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	git config --local primeclone.url $HTTPD_URL/server/.git/HEAD &&
+	cd - &&
+	git clone $HTTPD_URL/smart/server client &&
+	rm -r client &&
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	cd -
+'
+
+stop_httpd
+test_done
-- 
2.7.4

