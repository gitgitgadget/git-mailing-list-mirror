From: Junio C Hamano <gitster@pobox.com>
Subject: *Re: Why does git track directory listed in .gitignore/".git/info/exclude"?
Date: Thu, 31 Jan 2008 00:54:48 -0800
Message-ID: <7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
	<6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com>
	<alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org>
	<47A06EF9.60704@users.sourceforge.net>
	<7vprvjgi9v.fsf@gitster.siamese.dyndns.org>
	<47A1733E.9040103@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	pradeep singh rautela <rautelap@gmail.com>,
	git@vger.kernel.org
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 09:55:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKVCw-0007ps-Ha
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 09:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765429AbYAaIzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 03:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765361AbYAaIzH
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 03:55:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765124AbYAaIzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 03:55:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D77662413;
	Thu, 31 Jan 2008 03:55:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C53A2412;
	Thu, 31 Jan 2008 03:54:55 -0500 (EST)
In-Reply-To: <47A1733E.9040103@users.sourceforge.net> (Adam Piatyszek's
	message of "Thu, 31 Jan 2008 08:05:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72106>

Adam Piatyszek <ediap@users.sourceforge.net> writes:

> I hope you now understand what I was trying to express in my previous
> email. :-)

I am afraid that it is _you_ who doesn't understand.

We both know that a pattern "foo" in the ignore list matches
directory "foo/" and everything under it.  We also both know
that such a pattern also matches a regular file or a symbolic
link "foo", too.

I already said that it would make sense to make a pattern in the
ignore list "foo/" to match directory "foo/" and everything
under it, in addition to the above.  Currently it doesn't.  We
agreed that it might be a good idea to allow it as well.

My point was that a naive implementation to make "foo/" match
directory "foo/" by pretending as if the user said "foo" is not
good, because it would also make such a user-supplied pattern
"foo/" to match a regular file "foo".

In other words, you would need to do something like the attached
patch, if you wanted to solve this correctly.

Note that this is not tested heavily.  It just looks obvious
enough, but (1) testing is for wimps, (2) I do not care deeply
about having to say "foo" instead of "foo/", and (3) we are in
pre-release freeze to fix obvious bugs and regressions.

Wimps ^W People who care deeply enough can apply this to their
trees, use it for a week or so to make sure it does not break
other things, and then send the patch back with Tested-by: if
everything works out Ok ;-).

I also strongly suspect that we would need a similar change to
gitattributes side (attr.c) for consistency, but I haven't
looked at it.

-- >8 --
[PATCH] Allow "foo/" in ignore list to match directory "foo"

A naive implementation that pretends the user said "foo" would
not work well as it would make "foo/" match a non directory
"foo" as well.  This passes down the type of path being checked
to excluded() function to make sure that "foo/" matches
directory "foo/" and not regular file "foo".

A downside is that recursive directory walk may need to run
lstat(2) more often on systems whose "struct dirent" does not
give the type of the entry; earlier it did not have to for an
excluded path, but we now need to figure out if a path is a
directory before deciding to exclude it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---

 builtin-ls-files.c                 |   19 ++++++++++++++-
 cache.h                            |   12 ++++++++++
 dir.c                              |   42 ++++++++++++++++++++++++++---------
 dir.h                              |    3 +-
 t/t3001-ls-files-others-exclude.sh |   41 +++++++++++++++++++++++++++++++++++
 unpack-trees.c                     |    2 +-
 6 files changed, 104 insertions(+), 15 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 3801cf4..24646ef 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -218,6 +218,19 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 	write_name_quoted(ce->name + offset, stdout, line_terminator);
 }
 
+static int ce_mode_to_dtype(struct cache_entry *ce)
+{
+	unsigned ce_mode = ce->ce_mode;
+	if (S_ISREG(ce_mode))
+		return DT_REG;
+	else if (S_ISDIR(ce_mode) || S_ISGITLINK(ce_mode))
+		return DT_DIR;
+	else if (S_ISLNK(ce_mode))
+		return DT_LNK;
+	else
+		return DT_UNKNOWN;
+}
+
 static void show_files(struct dir_struct *dir, const char *prefix)
 {
 	int i;
@@ -238,7 +251,8 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
-			if (excluded(dir, ce->name) != dir->show_ignored)
+			if (excluded(dir, ce->name, ce_mode_to_dtype(ce)) !=
+			    dir->show_ignored)
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -252,7 +266,8 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 			struct cache_entry *ce = active_cache[i];
 			struct stat st;
 			int err;
-			if (excluded(dir, ce->name) != dir->show_ignored)
+			if (excluded(dir, ce->name, ce_mode_to_dtype(ce)) !=
+			    dir->show_ignored)
 				continue;
 			err = lstat(ce->name, &st);
 			if (show_deleted && err)
diff --git a/cache.h b/cache.h
index 549f4bb..c282021 100644
--- a/cache.h
+++ b/cache.h
@@ -141,6 +141,18 @@ static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned in
 	}
 	return create_ce_mode(mode);
 }
+static inline int ce_to_dtype(const struct cache_entry *ce)
+{
+	unsigned ce_mode = ce->ce_mode;
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
index 3e345c2..354c8f0 100644
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
