From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5] submodule: teach unpack_trees() to update submodules
Date: Thu, 26 Dec 2013 08:15:40 -0800
Message-ID: <20131226161540.GP20443@google.com>
References: <20131226155857.GL20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 26 17:15:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwDbA-0007f9-E4
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 17:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab3LZQPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 11:15:44 -0500
Received: from mail-yh0-f45.google.com ([209.85.213.45]:51931 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab3LZQPn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 11:15:43 -0500
Received: by mail-yh0-f45.google.com with SMTP id v1so1782517yhn.4
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 08:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2h4C053IPhRS5FFhnwpK4HTFmKv73O6YKotQN44dAlU=;
        b=KZxArmLlAGhmgRZdjyeSm0joJqYP9CHj3/HVHy3SK0BxgM94YA8IJlDu/hzntcZwBQ
         J01YdDgWjDVInKj9iw+w8bzzOFAjHOj351i6AL9QY1xlyl9QEgml8V0YGHNhIptdmGEq
         JEYFLWGHJnY3j6lwyctzmaODUWhru5NttnJ0bVeF2JSGXJlCjI2baYLfwupiuOhQjvTx
         8etYwbsq+2ELHPJHM0pEEKR+TmOdp3Ygf3R9MT/1RaP5wafi7mJHEk5JWJj4nqv9SrCB
         6iwYDo57p9KRPbwvoOMmhs/I2zSTyQqZ0iRFjRjYMdYXWIz9EBVjmJoHmTH4jgIdhcX8
         x14A==
X-Received: by 10.236.110.132 with SMTP id u4mr2484375yhg.119.1388074543326;
        Thu, 26 Dec 2013 08:15:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e39sm42275199yhq.15.2013.12.26.08.15.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 08:15:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131226155857.GL20443@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239699>

From: Jens Lehmann <Jens.Lehmann@web.de>
Date: Fri, 5 Apr 2013 18:35:27 +0200

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Also neat, also would benefit from documentation or tests.

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
index 06df5ae..3365987 100644
--- a/submodule.c
+++ b/submodule.c
@@ -485,6 +485,42 @@ int depopulate_submodule(const char *path)
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
@@ -926,6 +962,17 @@ out:
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
@@ -1075,6 +1122,45 @@ int ok_to_remove_submodule(const char *path)
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
index 3657ca8..b42ae91 100644
--- a/submodule.h
+++ b/submodule.h
@@ -26,6 +26,7 @@ int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int submodule_needs_update(const char *path);
 int populate_submodule(const char *path, unsigned char sha1[20], int force);
 int depopulate_submodule(const char *path);
+int update_submodule(const char *path, const unsigned char sha1[20], int force);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
@@ -37,9 +38,11 @@ void check_for_new_submodule_commits(unsigned char new_sha1[20]);
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
index ed48d41..fc8855e 100644
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
@@ -1221,17 +1226,15 @@ static int verify_uptodate_1(const struct cache_entry *ce,
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
@@ -1254,6 +1257,36 @@ static int verify_uptodate_sparse(const struct cache_entry *ce,
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
@@ -1532,9 +1565,17 @@ static int merged_entry(const struct cache_entry *ce,
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
1.8.5.1
