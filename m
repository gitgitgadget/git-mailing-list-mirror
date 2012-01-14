From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH] grep: resolve symlinks for --no-index and untracked symlinks for --untracked
Date: Sat, 14 Jan 2012 15:10:50 +0800
Message-ID: <1326525050-8011-1-git-send-email-pangyanhan@gmail.com>
Cc: Bertrand BENOIT <projettwk@users.sourceforge.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 08:11:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlxlh-0000eV-LI
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 08:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab2ANHLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 02:11:08 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54602 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab2ANHLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 02:11:07 -0500
Received: by yenq4 with SMTP id q4so587637yen.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 23:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wvyJrSQ6gdtddmMfRMBltgwwuhUFq1KjfqabFfpq2dg=;
        b=jDZh+xIjCqbG5dBDKFLLUvfRPlOfYfrWonC5jxauE10ZFfiR8aa0fLi3jwPNTZhCyo
         evnag5Oz0ymUHUFtmP/MdBZsxPPLrnQA5zU331p3dWxg30pL4MA/OHUSUqt0vTTDqH0M
         ZmavdqYVHtjzNI56cjKLnxvuE4cDOtes+HzQM=
Received: by 10.236.155.101 with SMTP id i65mr5716445yhk.104.1326525064828;
        Fri, 13 Jan 2012 23:11:04 -0800 (PST)
Received: from localhost (bb219-75-66-235.singnet.com.sg. [219.75.66.235])
        by mx.google.com with ESMTPS id q15sm30353942anm.4.2012.01.13.23.11.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 Jan 2012 23:11:04 -0800 (PST)
X-Mailer: git-send-email 1.7.9.rc0.24.ga4351
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188552>

For a tracked symbolic link, git tracks where the symbolic link points to
and as such, git grep does not search for patterns in where the symbolic link
points to.

However, git grep with --no-index is supposed to work similarly to GNU grep by
pretending that the current directory is not a git repository and hence resolve
symbolic links.

When used with the --untracked option, untracked symbolic links should also
be resolved.

Teach git grep to resolve symbolic links for --no-index and untracked symbolic
links for --untracked.
---
 builtin/grep.c  |   49 +++++++++++++++++++++++++++++++++++--------------
 t/t7810-grep.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9ce064a..c7883c3 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -29,9 +29,12 @@ static int use_threads = 1;
 #define THREADS 8
 static pthread_t threads[THREADS];
 
+#define UNTRACKED 0
+#define TRACKED 1
+
 static void *load_sha1(const unsigned char *sha1, unsigned long *size,
 		       const char *name);
-static void *load_file(const char *filename, size_t *sz);
+static void *load_file(const char *filename, size_t *sz, int tracked);
 
 enum work_type {WORK_SHA1, WORK_FILE};
 
@@ -50,6 +53,11 @@ struct work_item {
 	void *identifier;
 	char done;
 	struct strbuf out;
+	/* indicates whether file is tracked by git.
+	 * with --no-index, resolve all symlinks.
+	 * with --untracked, resolve only untracked symlinks.
+	 */
+	int tracked;
 };
 
 /* In the range [todo_done, todo_start) in 'todo' we have work_items
@@ -113,7 +121,7 @@ static pthread_cond_t cond_result;
 
 static int skip_first_line;
 
-static void add_work(enum work_type type, char *name, void *id)
+static void add_work(enum work_type type, char *name, void *id, int tracked)
 {
 	grep_lock();
 
@@ -125,6 +133,7 @@ static void add_work(enum work_type type, char *name, void *id)
 	todo[todo_end].name = name;
 	todo[todo_end].identifier = id;
 	todo[todo_end].done = 0;
+	todo[todo_end].tracked = tracked;
 	strbuf_reset(&todo[todo_end].out);
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
 
@@ -157,13 +166,13 @@ static void grep_sha1_async(struct grep_opt *opt, char *name,
 	unsigned char *s;
 	s = xmalloc(20);
 	memcpy(s, sha1, 20);
-	add_work(WORK_SHA1, name, s);
+	add_work(WORK_SHA1, name, s, TRACKED);
 }
 
 static void grep_file_async(struct grep_opt *opt, char *name,
-			    const char *filename)
+			    const char *filename, int tracked)
 {
-	add_work(WORK_FILE, name, xstrdup(filename));
+	add_work(WORK_FILE, name, xstrdup(filename), tracked);
 }
 
 static void work_done(struct work_item *w)
@@ -226,7 +235,7 @@ static void *run(void *arg)
 			}
 		} else if (w->type == WORK_FILE) {
 			size_t sz;
-			void* data = load_file(w->identifier, &sz);
+			void* data = load_file(w->identifier, &sz, w->tracked);
 			if (data) {
 				hit |= grep_buffer(opt, w->name, data, sz);
 				free(data);
@@ -429,7 +438,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 	}
 }
 
-static void *load_file(const char *filename, size_t *sz)
+static void *load_file(const char *filename, size_t *sz, int tracked)
 {
 	struct stat st;
 	char *data;
@@ -441,6 +450,12 @@ static void *load_file(const char *filename, size_t *sz)
 			error(_("'%s': %s"), filename, strerror(errno));
 		return NULL;
 	}
+	/* Resolve symlink if file is not tracked */
+	if (S_ISLNK(st.st_mode) && !tracked) {
+		memset(&st, 0, sizeof(st));
+		if (stat(filename, &st) < 0)
+			goto err_ret;
+	}
 	if (!S_ISREG(st.st_mode))
 		return NULL;
 	*sz = xsize_t(st.st_size);
@@ -459,7 +474,8 @@ static void *load_file(const char *filename, size_t *sz)
 	return data;
 }
 
-static int grep_file(struct grep_opt *opt, const char *filename)
+static int grep_file(struct grep_opt *opt, const char *filename,
+		int tracked)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char *name;
@@ -472,14 +488,14 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		grep_file_async(opt, name, filename);
+		grep_file_async(opt, name, filename, tracked);
 		return 0;
 	} else
 #endif
 	{
 		int hit;
 		size_t sz;
-		void *data = load_file(filename, &sz);
+		void *data = load_file(filename, &sz, tracked);
 		if (!data)
 			hit = 0;
 		else
@@ -541,7 +557,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 			hit |= grep_sha1(opt, ce->sha1, ce->name, 0);
 		}
 		else
-			hit |= grep_file(opt, ce->name);
+			hit |= grep_file(opt, ce->name, TRACKED);
 		if (ce_stage(ce)) {
 			do {
 				nr++;
@@ -658,7 +674,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
-			  int exc_std)
+			  int exc_std, int use_index)
 {
 	struct dir_struct dir;
 	int i, hit = 0;
@@ -668,12 +684,17 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 		setup_standard_excludes(&dir);
 
 	fill_directory(&dir, pathspec->raw);
+	if (use_index)
+		read_cache();
 	for (i = 0; i < dir.nr; i++) {
 		const char *name = dir.entries[i]->name;
 		int namelen = strlen(name);
 		if (!match_pathspec_depth(pathspec, name, namelen, 0, NULL))
 			continue;
-		hit |= grep_file(opt, dir.entries[i]->name);
+		if (use_index && cache_name_exists(name, namelen, ignore_case))
+			hit |= grep_file(opt, dir.entries[i]->name, TRACKED);
+		else
+			hit |= grep_file(opt, dir.entries[i]->name, UNTRACKED);
 		if (hit && opt->status_only)
 			break;
 	}
@@ -1083,7 +1104,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
 		if (list.nr)
 			die(_("--no-index or --untracked cannot be used with revs."));
-		hit = grep_directory(&opt, &pathspec, use_exclude);
+		hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
 	} else if (0 <= opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
 	} else if (!list.nr) {
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7ba5b16..fe41095 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -647,6 +647,41 @@ test_expect_success 'inside git repository but with --no-index' '
 	)
 '
 
+test_expect_success '--no-index greps contents of targets of symlinks' '
+	mkdir -p repo/sub &&
+	echo hello >repo/file &&
+	echo hello there >repo/sub/file1 &&
+	(cd repo/sub && ln -s ../file link1 && ln -s ../file link2 &&
+	git init && git add link1 && git commit -m "first" &&
+	test_must_fail git grep "hello" &&
+	cat >../expected <<-EOF &&
+	file1:hello there
+	link1:hello
+	link2:hello
+	EOF
+	git grep --no-index "hello" >../actual &&
+	test_cmp ../expected ../actual
+	) &&
+	rm -rf repo
+'
+
+test_expect_success '--untracked greps targets of untracked symlinks' '
+	mkdir -p repo/sub &&
+	echo hello >repo/file &&
+	echo hello there > repo/sub/file1 &&
+	(cd repo/sub && ln -s ../file link1 && ln -s ../file link2 &&
+	git init && git add link1 && git commit -m "first" &&
+	test_must_fail git grep "hello" &&
+	cat >../expected <<-EOF &&
+	file1:hello there
+	link2:hello
+	EOF
+	git grep --untracked "hello" >../actual &&
+	test_cmp ../expected ../actual
+	) &&
+	rm -rf repo
+'
+
 test_expect_success 'setup double-dash tests' '
 cat >double-dash <<EOF &&
 --
-- 
1.7.9.rc0.24.ga4351
