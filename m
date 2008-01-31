From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitignore(5): Allow "foo/" in ignore list to match directory "foo"
Date: Thu, 31 Jan 2008 01:17:48 -0800
Message-ID: <7v63xae4lf.fsf_-_@gitster.siamese.dyndns.org>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
	<6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com>
	<alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org>
	<47A06EF9.60704@users.sourceforge.net>
	<7vprvjgi9v.fsf@gitster.siamese.dyndns.org>
	<47A1733E.9040103@users.sourceforge.net>
	<7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	pradeep singh rautela <rautelap@gmail.com>,
	git@vger.kernel.org
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 10:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKVZR-0006N5-2u
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 10:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764405AbYAaJSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 04:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763872AbYAaJSK
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 04:18:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760455AbYAaJSE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 04:18:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC702A78;
	Thu, 31 Jan 2008 04:18:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CDE92A77;
	Thu, 31 Jan 2008 04:17:55 -0500 (EST)
In-Reply-To: <7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 31 Jan 2008 00:54:48 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72108>

A pattern "foo/" in the exclude list did not match directory
"foo", but a pattern "foo" did.  This attempts to extend the
exclude mechanism so that it would while not matching a regular
file or a symbolic link "foo".  In order to differentiate a
directory and non directory, this passes down the type of path
being checked to excluded() function.

A downside is that the recursive directory walk may need to run
lstat(2) more often on systems whose "struct dirent" do not give
the type of the entry; earlier it did not have to do so for an
excluded path, but we now need to figure out if a path is a
directory before deciding to exclude it.  This is especially bad
because an idea similar to the earlier CE_UPTODATE optimization
to reduce number of lstat(2) calls would by definition not apply
to the codepaths involved, as (1) directories will not be
registered in the index, and (2) excluded paths will not be in
the index anyway.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This replaces the earlier patch, which depended on Linus's
   in-core index patch that makes ce->ce_mode the host endian.
   It also comes with a documentation update, and applies to
   master.

 Documentation/gitignore.txt        |    6 +++++
 builtin-ls-files.c                 |    6 +++-
 cache.h                            |   12 ++++++++++
 dir.c                              |   42 ++++++++++++++++++++++++++---------
 dir.h                              |    3 +-
 t/t3001-ls-files-others-exclude.sh |   41 +++++++++++++++++++++++++++++++++++
 unpack-trees.c                     |    2 +-
 7 files changed, 97 insertions(+), 15 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 08373f5..0290bdb 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -57,6 +57,12 @@ Patterns have the following format:
    included again.  If a negated pattern matches, this will
    override lower precedence patterns sources.
 
+ - If the pattern ends with a slash, it is removed for the
+   purpose of the following description, but it would find match
+   only with a directory.  In other words, `foo/` will match a
+   directory `foo` and paths underneath it, but will not match a
+   regular file or a symbolic link `foo`.
+
  - If the pattern does not contain a slash '/', git treats it as
    a shell glob pattern and checks for a match against the
    pathname without leading directories.
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 3801cf4..3089978 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -238,7 +238,8 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
-			if (excluded(dir, ce->name) != dir->show_ignored)
+			if (excluded(dir, ce->name, ce_to_dtype(ce)) !=
+			    dir->show_ignored)
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -252,7 +253,8 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 			struct cache_entry *ce = active_cache[i];
 			struct stat st;
 			int err;
-			if (excluded(dir, ce->name) != dir->show_ignored)
+			if (excluded(dir, ce->name, ce_to_dtype(ce)) !=
+			    dir->show_ignored)
 				continue;
 			err = lstat(ce->name, &st);
 			if (show_deleted && err)
diff --git a/cache.h b/cache.h
index 549f4bb..5529830 100644
--- a/cache.h
+++ b/cache.h
@@ -141,6 +141,18 @@ static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned in
 	}
 	return create_ce_mode(mode);
 }
+static inline int ce_to_dtype(const struct cache_entry *ce)
+{
+	unsigned ce_mode = ntohl(ce->ce_mode);
+	if (S_ISREG(ce_mode))
+		return DT_REG;
+	else if (S_ISDIR(ce_mode) || S_ISGITLINK(ce_mode))
+		return DT_DIR;
+	else if (S_ISLNK(ce_mode))
+		return DT_LNK;
+	else
+		return DT_UNKNOWN;
+}
 #define canon_mode(mode) \
 	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
 	S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? S_IFDIR : S_IFGITLINK)
diff --git a/dir.c b/dir.c
index 3e345c2..a4f8c25 100644
--- a/dir.c
+++ b/dir.c
@@ -126,18 +126,34 @@ static int no_wildcard(const char *string)
 void add_exclude(const char *string, const char *base,
 		 int baselen, struct exclude_list *which)
 {
-	struct exclude *x = xmalloc(sizeof (*x));
+	struct exclude *x;
+	size_t len;
+	int to_exclude = 1;
+	int flags = 0;
 
-	x->to_exclude = 1;
 	if (*string == '!') {
-		x->to_exclude = 0;
+		to_exclude = 0;
 		string++;
 	}
-	x->pattern = string;
+	len = strlen(string);
+	if (len && string[len - 1] == '/') {
+		char *s;
+		x = xmalloc(sizeof(*x) + len);
+		s = (char*)(x+1);
+		memcpy(s, string, len - 1);
+		s[len - 1] = '\0';
+		string = s;
+		x->pattern = s;
+		flags = EXC_FLAG_MUSTBEDIR;
+	} else {
+		x = xmalloc(sizeof(*x));
+		x->pattern = string;
+	}
+	x->to_exclude = to_exclude;
 	x->patternlen = strlen(string);
 	x->base = base;
 	x->baselen = baselen;
-	x->flags = 0;
+	x->flags = flags;
 	if (!strchr(string, '/'))
 		x->flags |= EXC_FLAG_NODIR;
 	if (no_wildcard(string))
@@ -261,7 +277,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
 static int excluded_1(const char *pathname,
-		      int pathlen, const char *basename,
+		      int pathlen, const char *basename, int dtype,
 		      struct exclude_list *el)
 {
 	int i;
@@ -272,6 +288,10 @@ static int excluded_1(const char *pathname,
 			const char *exclude = x->pattern;
 			int to_exclude = x->to_exclude;
 
+			if ((x->flags & EXC_FLAG_MUSTBEDIR) &&
+			    (dtype != DT_DIR))
+				continue;
+
 			if (x->flags & EXC_FLAG_NODIR) {
 				/* match basename */
 				if (x->flags & EXC_FLAG_NOWILDCARD) {
@@ -314,7 +334,7 @@ static int excluded_1(const char *pathname,
 	return -1; /* undecided */
 }
 
-int excluded(struct dir_struct *dir, const char *pathname)
+int excluded(struct dir_struct *dir, const char *pathname, int dtype)
 {
 	int pathlen = strlen(pathname);
 	int st;
@@ -323,7 +343,8 @@ int excluded(struct dir_struct *dir, const char *pathname)
 
 	prep_exclude(dir, pathname, basename-pathname);
 	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
-		switch (excluded_1(pathname, pathlen, basename, &dir->exclude_list[st])) {
+		switch (excluded_1(pathname, pathlen, basename,
+				   dtype, &dir->exclude_list[st])) {
 		case 0:
 			return 0;
 		case 1:
@@ -560,7 +581,8 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			if (simplify_away(fullname, baselen + len, simplify))
 				continue;
 
-			exclude = excluded(dir, fullname);
+			dtype = get_dtype(de, fullname);
+			exclude = excluded(dir, fullname, dtype);
 			if (exclude && dir->collect_ignored
 			    && in_pathspec(fullname, baselen + len, simplify))
 				dir_add_ignored(dir, fullname, baselen + len);
@@ -572,8 +594,6 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			if (exclude && !dir->show_ignored)
 				continue;
 
-			dtype = get_dtype(de, fullname);
-
 			/*
 			 * Do we want to see just the ignored files?
 			 * We still need to recurse into directories,
diff --git a/dir.h b/dir.h
index d8814dc..10d72b5 100644
--- a/dir.h
+++ b/dir.h
@@ -9,6 +9,7 @@ struct dir_entry {
 #define EXC_FLAG_NODIR 1
 #define EXC_FLAG_NOWILDCARD 2
 #define EXC_FLAG_ENDSWITH 4
+#define EXC_FLAG_MUSTBEDIR 8
 
 struct exclude_list {
 	int nr;
@@ -67,7 +68,7 @@ extern int match_pathspec(const char **pathspec, const char *name, int namelen,
 
 extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen, const char **pathspec);
 
-extern int excluded(struct dir_struct *, const char *);
+extern int excluded(struct dir_struct *, const char *, int);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *which);
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index e25b255..b4297ba 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -99,4 +99,45 @@ EOF
 test_expect_success 'git-status honours core.excludesfile' \
 	'diff -u expect output'
 
+test_expect_success 'trailing slash in exclude allows directory match(1)' '
+
+	git ls-files --others --exclude=one/ >output &&
+	if grep "^one/" output
+	then
+		echo Ooops
+		false
+	else
+		: happy
+	fi
+
+'
+
+test_expect_success 'trailing slash in exclude allows directory match (2)' '
+
+	git ls-files --others --exclude=one/two/ >output &&
+	if grep "^one/two/" output
+	then
+		echo Ooops
+		false
+	else
+		: happy
+	fi
+
+'
+
+test_expect_success 'trailing slash in exclude forces directory match (1)' '
+
+	>two
+	git ls-files --others --exclude=two/ >output &&
+	grep "^two" output
+
+'
+
+test_expect_success 'trailing slash in exclude forces directory match (2)' '
+
+	git ls-files --others --exclude=one/a.1/ >output &&
+	grep "^one/a.1" output
+
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index aa2513e..11af263 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -523,7 +523,7 @@ static void verify_absent(struct cache_entry *ce, const char *action,
 	if (!lstat(ce->name, &st)) {
 		int cnt;
 
-		if (o->dir && excluded(o->dir, ce->name))
+		if (o->dir && excluded(o->dir, ce->name, ce_to_dtype(ce)))
 			/*
 			 * ce->name is explicitly excluded, so it is Ok to
 			 * overwrite it.
-- 
1.5.4.rc5.16.gc0279
