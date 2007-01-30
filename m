From: Junio C Hamano <junkio@cox.net>
Subject: Re: More precise tag following
Date: Tue, 30 Jan 2007 01:22:44 -0800
Message-ID: <7vodog3m3f.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701281107050.25027@woody.linux-foundation.org>
	<7vveirdkpb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701281143190.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 10:22:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBpCT-0003Y9-T4
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 10:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965466AbXA3JWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 04:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965467AbXA3JWq
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 04:22:46 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:61924 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965466AbXA3JWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 04:22:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070130092245.GCNK9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jan 2007 04:22:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HMP41W0011kojtg0000000; Tue, 30 Jan 2007 04:23:04 -0500
In-Reply-To: <Pine.LNX.4.64.0701281143190.25027@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 28 Jan 2007 11:57:33 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38143>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> One thing I looked at, which *should* be easy to do inside "git-blame", is 
> to make the case where you do *not* give a head to start with, default to 
> "current working tree" instead of HEAD.

This is still very rough; the existing diff frontends are mess
and making diff-cache and diff-tree behave more or less
interchangeably is quite a pain.  I am not proud of the new
do_diff_cache() interface I had to add, which is probably
totally useless for anybody other than the three calling sites
this patch has.

I tested only the most trivial case that exercises the
do_diff_cache() cal in find_origin() before I got too tired, and
I am retiring to bed now.

-- >8 --
[PATCH] git-blame: no rev means start from the working tree file.

Warning: this changes the semantics.

This is a WIP to make "git blame" without any positive rev to
start digging from the working tree copy, which is made into a
fake commit whose sole parent is the HEAD.

It might make sense to give "git-blame --cached" to start
digging from the index as well, which should be trivial.

The calls to do_diff_cache() in find_copy_in_parent() and
find_rename() need to be vetted, as I haven't checked them yet.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-blame.c |  119 ++++++++++++++++++++++++++++++++++++++++++++----------
 cache.h         |    1 +
 diff-lib.c      |   22 ++++++++++-
 diff.h          |    1 +
 ident.c         |    8 ++--
 5 files changed, 124 insertions(+), 27 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 3033e9b..a8668c0 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -333,9 +333,13 @@ static struct origin *find_origin(struct scoreboard *sb,
 	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
 		die("diff-setup");
-	diff_tree_sha1(parent->tree->object.sha1,
-		       origin->commit->tree->object.sha1,
-		       "", &diff_opts);
+
+	if (is_null_sha1(origin->commit->object.sha1))
+		do_diff_cache(parent->tree->object.sha1, &diff_opts, 0);
+	else
+		diff_tree_sha1(parent->tree->object.sha1,
+			       origin->commit->tree->object.sha1,
+			       "", &diff_opts);
 	diffcore_std(&diff_opts);
 
 	/* It is either one entry that says "modified", or "created",
@@ -402,9 +406,13 @@ static struct origin *find_rename(struct scoreboard *sb,
 	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
 		die("diff-setup");
-	diff_tree_sha1(parent->tree->object.sha1,
-		       origin->commit->tree->object.sha1,
-		       "", &diff_opts);
+
+	if (is_null_sha1(origin->commit->object.sha1))
+		do_diff_cache(parent->tree->object.sha1, &diff_opts, 0);
+	else
+		diff_tree_sha1(parent->tree->object.sha1,
+			       origin->commit->tree->object.sha1,
+			       "", &diff_opts);
 	diffcore_std(&diff_opts);
 
 	for (i = 0; i < diff_queued_diff.nr; i++) {
@@ -1047,9 +1055,12 @@ static int find_copy_in_parent(struct scoreboard *sb,
 	    (!porigin || strcmp(target->path, porigin->path)))
 		diff_opts.find_copies_harder = 1;
 
-	diff_tree_sha1(parent->tree->object.sha1,
-		       target->commit->tree->object.sha1,
-		       "", &diff_opts);
+	if (is_null_sha1(target->commit->object.sha1))
+		do_diff_cache(parent->tree->object.sha1, &diff_opts, 0);
+	else
+		diff_tree_sha1(parent->tree->object.sha1,
+			       target->commit->tree->object.sha1,
+			       "", &diff_opts);
 
 	if (!diff_opts.find_copies_harder)
 		diffcore_std(&diff_opts);
@@ -1910,6 +1921,64 @@ static int git_blame_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
+static struct commit *fake_working_tree_commit(const char *path)
+{
+	struct stat st;
+	struct commit *commit;
+	struct origin *origin;
+	unsigned char head_sha1[20];
+	char *buf;
+	const char *ident;
+	int fd;
+
+	if (lstat(path, &st) < 0)
+		die("Cannot lstat %s", path);
+	if (get_sha1("HEAD", head_sha1))
+		die("No such ref: HEAD");
+
+	commit = xcalloc(1, sizeof(*commit));
+	commit->parents = xcalloc(1, sizeof(*commit->parents));
+	commit->parents->item = lookup_commit_reference(head_sha1);
+	commit->object.parsed = 1;
+	commit->date = st.st_mtime;
+	commit->object.type = OBJ_COMMIT;
+
+	origin = make_origin(commit, path);
+	origin->file.ptr = buf = xmalloc(st.st_size+1);
+	origin->file.size = st.st_size;
+	buf[st.st_size] = 0;
+
+	switch (st.st_mode & S_IFMT) {
+	case S_IFREG:
+		fd = open(path, O_RDONLY);
+		if (fd < 0)
+			die("cannot open %s", path);
+		if (read_in_full(fd, buf, st.st_size) != st.st_size)
+			die("cannot read %s", path);
+		break;
+	case S_IFLNK:
+		if (readlink(path, buf, st.st_size+1) != st.st_size)
+			die("cannot readlink %s", path);
+		break;
+	default:
+		die("unsupported file type %s", path);
+	}
+	hash_sha1_file(buf, st.st_size, blob_type, origin->blob_sha1);
+	commit->util = origin;
+
+	commit->buffer = xmalloc(400);
+	ident = fmt_ident("Not Committed Yet", "not.committed.yet", NULL, 0);
+	sprintf(commit->buffer,
+		"tree 0000000000000000000000000000000000000000\n"
+		"parent %s\n"
+		"author %s\n"
+		"committer %s\n\n"
+		"Version of %s from the working tree",
+		sha1_to_hex(head_sha1),
+		ident, ident, path);
+	return commit;
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -2087,7 +2156,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	argv[unk] = NULL;
 
 	init_revisions(&revs, NULL);
-	setup_revisions(unk, argv, &revs, "HEAD");
+	setup_revisions(unk, argv, &revs, NULL);
 	memset(&sb, 0, sizeof(sb));
 
 	/*
@@ -2114,15 +2183,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (!sb.final) {
 		/*
 		 * "--not A B -- path" without anything positive;
-		 * default to HEAD.
+		 * do not default to HEAD, but use the cache.
 		 */
-		unsigned char head_sha1[20];
-
-		final_commit_name = "HEAD";
-		if (get_sha1(final_commit_name, head_sha1))
-			die("No such ref: HEAD");
-		sb.final = lookup_commit_reference(head_sha1);
-		add_pending_object(&revs, &(sb.final->object), "HEAD");
+		sb.final = fake_working_tree_commit(path);
+		add_pending_object(&revs, &(sb.final->object), ":");
 	}
 
 	/*
@@ -2132,11 +2196,22 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	 */
 	prepare_revision_walk(&revs);
 
-	o = get_origin(&sb, sb.final, path);
-	if (fill_blob_sha1(o))
-		die("no such path %s in %s", path, final_commit_name);
+	if (is_null_sha1(sb.final->object.sha1)) {
+		char *buf;
+		o = sb.final->util;
+		buf = xmalloc(o->file.size + 1);
+		memcpy(buf, o->file.ptr, o->file.size + 1);
+		sb.final_buf = buf;
+		sb.final_buf_size = o->file.size;
+	}
+	else {
+		o = get_origin(&sb, sb.final, path);
+		if (fill_blob_sha1(o))
+			die("no such path %s in %s", path, final_commit_name);
 
-	sb.final_buf = read_sha1_file(o->blob_sha1, type, &sb.final_buf_size);
+		sb.final_buf = read_sha1_file(o->blob_sha1, type,
+					      &sb.final_buf_size);
+	}
 	num_read_blob++;
 	lno = prepare_lines(&sb);
 
diff --git a/cache.h b/cache.h
index 9873ee9..dcceea4 100644
--- a/cache.h
+++ b/cache.h
@@ -321,6 +321,7 @@ unsigned long approxidate(const char *);
 
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
+extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
 
 struct checkout {
 	const char *base_dir;
diff --git a/diff-lib.c b/diff-lib.c
index 2c9be60..b93f7a3 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -271,7 +271,7 @@ static int diff_cache(struct rev_info *revs,
 				break;
 			}
 			/* Show difference between old and new */
-			show_modified(revs,ac[1], ce, 1,
+			show_modified(revs, ac[1], ce, 1,
 				      cached, match_missing);
 			break;
 		case 1:
@@ -372,3 +372,23 @@ int run_diff_index(struct rev_info *revs, int cached)
 	diff_flush(&revs->diffopt);
 	return ret;
 }
+
+int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt, int cached)
+{
+	struct tree *tree;
+	struct rev_info revs;
+
+	init_revisions(&revs, NULL);
+	revs.prune_data = opt->paths;
+	discard_cache();
+	if (read_cache() < 0)
+		die("cannot read index");
+	mark_merge_entries();
+	tree = parse_tree_indirect(tree_sha1);
+	if (!tree)
+		die("bad tree object %s", sha1_to_hex(tree_sha1));
+	if (read_tree(tree, 1, opt->paths))
+		return error("unable to read tree %s", sha1_to_hex(tree_sha1));
+	return diff_cache(&revs, active_cache, active_nr, revs.prune_data,
+			  cached, 0);
+}
diff --git a/diff.h b/diff.h
index 7a347cf..dd180b8 100644
--- a/diff.h
+++ b/diff.h
@@ -222,6 +222,7 @@ extern int run_diff_files(struct rev_info *revs, int silent_on_removed);
 
 extern int run_diff_index(struct rev_info *revs, int cached);
 
+extern int do_diff_cache(const unsigned char *, struct diff_options *, int);
 extern int diff_flush_patch_id(struct diff_options *, unsigned char *);
 
 #endif /* DIFF_H */
diff --git a/ident.c b/ident.c
index a6fc7b5..bb03bdd 100644
--- a/ident.c
+++ b/ident.c
@@ -185,8 +185,8 @@ static const char *env_hint =
 "Add --global to set your account\'s default\n"
 "\n";
 
-static const char *get_ident(const char *name, const char *email,
-			     const char *date_str, int error_on_no_name)
+const char *fmt_ident(const char *name, const char *email,
+		      const char *date_str, int error_on_no_name)
 {
 	static char buffer[1000];
 	char date[50];
@@ -233,7 +233,7 @@ static const char *get_ident(const char *name, const char *email,
 
 const char *git_author_info(int error_on_no_name)
 {
-	return get_ident(getenv("GIT_AUTHOR_NAME"),
+	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
 			 getenv("GIT_AUTHOR_DATE"),
 			 error_on_no_name);
@@ -241,7 +241,7 @@ const char *git_author_info(int error_on_no_name)
 
 const char *git_committer_info(int error_on_no_name)
 {
-	return get_ident(getenv("GIT_COMMITTER_NAME"),
+	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
 			 getenv("GIT_COMMITTER_DATE"),
 			 error_on_no_name);
-- 
1.5.0.rc2.77.g1732a
