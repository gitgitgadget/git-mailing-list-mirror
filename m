From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/PATCH 9/9] submodule: teach unpack_trees() to update submodules
Date: Mon, 03 Feb 2014 20:54:17 +0100
Message-ID: <52EFF3E9.2060403@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:54:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPb6-0002lR-8w
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbaBCTyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:54:20 -0500
Received: from mout.web.de ([212.227.17.12]:53413 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbaBCTyT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:54:19 -0500
Received: from [192.168.178.41] ([84.132.165.229]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LgYG1-1VVFka2aLV-00nvdt for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 20:54:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52EFF25E.6080306@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:5Hp7PGFHA8lAFDD6A58m1fxbIrD9xag99OUXmE5BM2AAwuvsZ6e
 lrszN/uhz9sN7vKsjpAliv3o8/eZL6m0SIKPw1UeSeKoAn18qqbNzy/LvOvz9vHysvbrYa4
 bXlzuePnw2tl+xXdpdhWQq4pKuVTsYuGh6Vibb6KU4VeOotOGLmc5+ZkfKfrFBoLuVX0gSM
 MOSueyxCWiZEDgYpfeXmw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241465>

Implement the functionality needed to enable work tree manipulating
commands so that an changed submodule does not only affect the index but
it also updates the work tree of any initialized submodule according to
the SHA-1 recorded in the superproject.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 entry.c        | 15 ++++++++--
 submodule.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h    |  3 ++
 unpack-trees.c | 69 ++++++++++++++++++++++++++++++++++++----------
 unpack-trees.h |  1 +
 5 files changed, 157 insertions(+), 17 deletions(-)

diff --git a/entry.c b/entry.c
index d1bf6ec..61a2767 100644
--- a/entry.c
+++ b/entry.c
@@ -265,7 +265,7 @@ int checkout_entry(struct cache_entry *ce,

 	if (!check_path(path, len, &st, state->base_dir_len)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
-		if (!changed)
+		if (!changed && (!S_ISDIR(st.st_mode) || !S_ISGITLINK(ce->ce_mode)))
 			return 0;
 		if (!state->force) {
 			if (!state->quiet)
@@ -280,9 +280,18 @@ int checkout_entry(struct cache_entry *ce,
 		 * just do the right thing)
 		 */
 		if (S_ISDIR(st.st_mode)) {
-			/* If it is a gitlink, leave it alone! */
-			if (S_ISGITLINK(ce->ce_mode))
+			if (S_ISGITLINK(ce->ce_mode)) {
+				if (submodule_needs_update(ce->name)) {
+					if (is_submodule_populated(ce->name)) {
+						if (update_submodule(ce->name, ce->sha1, state->force))
+							return error("cannot checkout submodule %s", path);
+					} else {
+						if (populate_submodule(path, ce->sha1, state->force))
+							return error("cannot populate submodule %s", path);
+					}
+				}
 				return 0;
+			}
 			if (!state->force)
 				return error("%s is a directory", path);
 			remove_subtree(path);
diff --git a/submodule.c b/submodule.c
index 3907034..83e7595 100644
--- a/submodule.c
+++ b/submodule.c
@@ -520,6 +520,42 @@ int depopulate_submodule(const char *path)
 	return 0;
 }

+int update_submodule(const char *path, const unsigned char sha1[20], int force)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process cp;
+	const char *hex_sha1 = sha1_to_hex(sha1);
+	const char *argv[] = {
+		"checkout",
+		force ? "-fq" : "-q",
+		hex_sha1,
+		NULL,
+	};
+	const char *git_dir;
+
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile(buf.buf);
+	if (!git_dir)
+		git_dir = buf.buf;
+	if (!is_directory(git_dir)) {
+		strbuf_release(&buf);
+		/* The submodule is not populated, so we can't check it out */
+		return 0;
+	}
+	strbuf_release(&buf);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;   /* GIT_WORK_TREE doesn't work for git checkout */
+	if (run_command(&cp))
+		return error("Could not checkout submodule %s", path);
+
+	return 0;
+}
+
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
@@ -961,6 +997,17 @@ out:
 	return result;
 }

+int is_submodule_populated(const char *path)
+{
+	int retval = 0;
+	struct strbuf gitdir = STRBUF_INIT;
+	strbuf_addf(&gitdir, "%s/.git", path);
+	if (resolve_gitdir(gitdir.buf))
+		retval = 1;
+	strbuf_release(&gitdir);
+	return retval;
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	ssize_t len;
@@ -1110,6 +1157,45 @@ int ok_to_remove_submodule(const char *path)
 	return ok_to_remove;
 }

+unsigned is_submodule_checkout_safe(const char *path, const unsigned char sha1[20])
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process cp;
+	const char *hex_sha1 = sha1_to_hex(sha1);
+	const char *argv[] = {
+		"read-tree",
+		"-n",
+		"-m",
+		"HEAD",
+		hex_sha1,
+		NULL,
+	};
+	const char *git_dir;
+
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile(buf.buf);
+	if (!git_dir)
+		git_dir = buf.buf;
+	if (!is_directory(git_dir)) {
+		strbuf_release(&buf);
+		/* The submodule is not populated, it's safe to check it out */
+		/*
+		 * TODO: When git learns to re-populate submodules, a check must be
+		 * added here to assert that no local files will be overwritten.
+		 */
+		return 1;
+	}
+	strbuf_release(&buf);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+	return run_command(&cp) == 0;
+}
+
 static int find_first_merges(struct object_array *result, const char *path,
 		struct commit *a, struct commit *b)
 {
diff --git a/submodule.h b/submodule.h
index a7d09a5..65f6396 100644
--- a/submodule.h
+++ b/submodule.h
@@ -30,6 +30,7 @@ int option_parse_update_submodules(const struct option *opt,
 int submodule_needs_update(const char *path);
 int populate_submodule(const char *path, unsigned char sha1[20], int force);
 int depopulate_submodule(const char *path);
+int update_submodule(const char *path, const unsigned char sha1[20], int force);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
@@ -41,9 +42,11 @@ void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet);
+int is_submodule_populated(const char *path);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 int ok_to_remove_submodule(const char *path);
+unsigned is_submodule_checkout_safe(const char *path, const unsigned char sha1[20]);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20], int search);
 int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
diff --git a/unpack-trees.c b/unpack-trees.c
index 49d0a67..46b85ac 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -27,6 +27,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_NOT_UPTODATE_DIR */
 	"Updating '%s' would lose untracked files in it",

+	/* ERROR_NOT_UPTODATE_SUBMODULE */
+	"Updating submodule '%s' would lose modifications in it",
+
 	/* ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN */
 	"Untracked working tree file '%s' would be overwritten by merge.",

@@ -71,6 +74,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,

 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		"Updating the following directories would lose untracked files in it:\n%s";
+	msgs[ERROR_NOT_UPTODATE_SUBMODULE] =
+		"Updating the following submodules would lose modifications in it:\n%s";

 	if (advice_commit_before_merge)
 		msg = "The following untracked working tree files would be %s by %s:\n%%s"
@@ -1224,17 +1229,15 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 	if (!lstat(ce->name, &st)) {
 		int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
 		unsigned changed = ie_match_stat(o->src_index, ce, &st, flags);
-		if (!changed)
-			return 0;
-		/*
-		 * NEEDSWORK: the current default policy is to allow
-		 * submodule to be out of sync wrt the superproject
-		 * index.  This needs to be tightened later for
-		 * submodules that are marked to be automatically
-		 * checked out.
-		 */
-		if (S_ISGITLINK(ce->ce_mode))
-			return 0;
+		if (!changed) {
+			if (!S_ISGITLINK(ce->ce_mode) || !submodule_needs_update(ce->name) ||
+			    (ce_stage(ce) ? is_submodule_checkout_safe(ce->name, ce->sha1)
+			    : !is_submodule_modified(ce->name, 1)))
+				return 0;
+		} else
+			if (S_ISGITLINK(ce->ce_mode) && !submodule_needs_update(ce->name))
+				return 0;
+
 		errno = 0;
 	}
 	if (errno == ENOENT)
@@ -1257,6 +1260,36 @@ static int verify_uptodate_sparse(const struct cache_entry *ce,
 	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);
 }

+/*
+ * When a submodule gets turned into an unmerged entry, we want it to be
+ * up-to-date regarding the merge changes.
+ */
+static int verify_uptodate_submodule(const struct cache_entry *old,
+				     const struct cache_entry *new,
+				     struct unpack_trees_options *o)
+{
+	struct stat st;
+
+	if (o->index_only || (!((old->ce_flags & CE_VALID) || ce_skip_worktree(old)) && (o->reset || ce_uptodate(old))))
+		return 0;
+	if (!lstat(old->name, &st)) {
+		unsigned changed = ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+		if (!changed) {
+			if (!S_ISGITLINK(old->ce_mode) ||
+			    !submodule_needs_update(new->name) ||
+			    is_submodule_checkout_safe(new->name, new->sha1))
+				return 0;
+		} else
+			if (S_ISGITLINK(old->ce_mode) && !submodule_needs_update(new->name))
+				return 0;
+		errno = 0;
+	}
+	if (errno == ENOENT)
+		return 0;
+	return o->gently ? -1 :
+		add_rejected_path(o, ERROR_NOT_UPTODATE_SUBMODULE, old->name);
+}
+
 static void invalidate_ce_path(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
@@ -1536,9 +1569,17 @@ static int merged_entry(const struct cache_entry *ce,
 			copy_cache_entry(merge, old);
 			update = 0;
 		} else {
-			if (verify_uptodate(old, o)) {
-				free(merge);
-				return -1;
+			if (S_ISGITLINK(old->ce_mode) ||
+			    S_ISGITLINK(merge->ce_mode)) {
+				if (verify_uptodate_submodule(old, merge, o)) {
+					free(merge);
+					return -1;
+				}
+			} else {
+				if (verify_uptodate(old, o)) {
+					free(merge);
+					return -1;
+				}
 			}
 			/* Migrate old flags over */
 			update |= old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
diff --git a/unpack-trees.h b/unpack-trees.h
index 36a73a6..bee8740 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -15,6 +15,7 @@ enum unpack_trees_error_types {
 	ERROR_WOULD_OVERWRITE = 0,
 	ERROR_NOT_UPTODATE_FILE,
 	ERROR_NOT_UPTODATE_DIR,
+	ERROR_NOT_UPTODATE_SUBMODULE,
 	ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN,
 	ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 	ERROR_BIND_OVERLAP,
-- 
1.9.rc0.28.ge3363ff
