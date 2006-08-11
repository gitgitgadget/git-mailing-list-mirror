From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-grep --relative: show pathnames relative to the current directory
Date: Fri, 11 Aug 2006 00:50:12 -0700
Message-ID: <7vpsf7u2x7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 11 09:50:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBRn0-0000BA-Bi
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 09:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWHKHuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 03:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWHKHuQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 03:50:16 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:27284 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750744AbWHKHuN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 03:50:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060811075013.QYJR12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Aug 2006 03:50:13 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25220>

By default, the command shows pathnames relative to the project
root, even when run from a subdirectory.  With --relative flag,
however, the command outputs pathnames relative to the current
directory.

This makes it very pleasant to run in Emacs compilation (or
"grep-find") buffer.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Now the question is, shouldn't this be the default, with
   the current output available as an option --full-name, just
   like ls-files?

   Changing the default always risks breaking people's habit and
   scripts, but I tend to think the current output is a
   misfeature which we'd better fix sooner rather than later.

   Opinions? 

 Documentation/git-grep.txt |    7 +++++
 builtin-grep.c             |   58 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index dc76833..6cdc433 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-grep' [--cached]
 	   [-a | --text] [-I] [-i | --ignore-case] [-w | --word-regexp]
-	   [-v | --invert-match]
+	   [-v | --invert-match] [--relative]
 	   [-E | --extended-regexp] [-G | --basic-regexp] [-F | --fixed-strings]
 	   [-n] [-l | --files-with-matches] [-L | --files-without-match]
 	   [-c | --count]
@@ -47,6 +47,11 @@ OPTIONS
 -v | --invert-match::
 	Select non-matching lines.
 
+--relative::
+	When run from a subdirectory, show filenames relative to
+	the current directory, instead of the usual full
+	pathname down from the project root.
+
 -E | --extended-regexp | -G | --basic-regexp::
 	Use POSIX extended/basic regexp for patterns.  Default
 	is to use basic regexp.
diff --git a/builtin-grep.c b/builtin-grep.c
index 93b7e07..f6309f5 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -123,6 +123,7 @@ struct grep_opt {
 	struct grep_pat *pattern_list;
 	struct grep_pat **pattern_tail;
 	struct grep_expr *pattern_expression;
+	int prefix_length;
 	regex_t regexp;
 	unsigned linenum:1;
 	unsigned invert:1;
@@ -136,6 +137,7 @@ #define GREP_BINARY_NOMATCH	1
 #define GREP_BINARY_TEXT	2
 	unsigned binary:2;
 	unsigned extended:1;
+	unsigned relative:1;
 	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
@@ -632,19 +634,40 @@ static int grep_buffer(struct grep_opt *
 	return !!last_hit;
 }
 
-static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1, const char *name)
+static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1, const char *name, int tree_name_len)
 {
 	unsigned long size;
 	char *data;
 	char type[20];
+	char *to_free = NULL;
 	int hit;
+
 	data = read_sha1_file(sha1, type, &size);
 	if (!data) {
 		error("'%s': unable to read %s", name, sha1_to_hex(sha1));
 		return 0;
 	}
+	if (opt->relative && opt->prefix_length) {
+		static char name_buf[PATH_MAX];
+		char *cp;
+		int name_len = strlen(name) - opt->prefix_length + 1;
+
+		if (!tree_name_len)
+			name += opt->prefix_length;
+		else {
+			if (ARRAY_SIZE(name_buf) <= name_len)
+				cp = to_free = xmalloc(name_len);
+			else
+				cp = name_buf;
+			memcpy(cp, name, tree_name_len);
+			strcpy(cp + tree_name_len,
+			       name + tree_name_len + opt->prefix_length);
+			name = cp;
+		}
+	}
 	hit = grep_buffer(opt, name, data, size);
 	free(data);
+	free(to_free);
 	return hit;
 }
 
@@ -674,6 +697,8 @@ static int grep_file(struct grep_opt *op
 		return 0;
 	}
 	close(i);
+	if (opt->relative && opt->prefix_length)
+		filename += opt->prefix_length;
 	i = grep_buffer(opt, filename, data, st.st_size);
 	free(data);
 	return i;
@@ -720,7 +745,7 @@ static int external_grep(struct grep_opt
 	char *argptr = randarg;
 	struct grep_pat *p;
 
-	if (opt->extended)
+	if (opt->extended || (opt->relative && opt->prefix_length))
 		return -1;
 	len = nr = 0;
 	push_arg("grep");
@@ -845,7 +870,7 @@ #endif
 		if (!pathspec_matches(paths, ce->name))
 			continue;
 		if (cached)
-			hit |= grep_sha1(opt, ce->sha1, ce->name);
+			hit |= grep_sha1(opt, ce->sha1, ce->name, 0);
 		else
 			hit |= grep_file(opt, ce->name);
 	}
@@ -860,11 +885,12 @@ static int grep_tree(struct grep_opt *op
 	int hit = 0;
 	struct name_entry entry;
 	char *down;
-	char *path_buf = xmalloc(PATH_MAX + strlen(tree_name) + 100);
+	int tn_len = strlen(tree_name);
+	char *path_buf = xmalloc(PATH_MAX + tn_len + 100);
 
-	if (tree_name[0]) {
-		int offset = sprintf(path_buf, "%s:", tree_name);
-		down = path_buf + offset;
+	if (tn_len) {
+		tn_len = sprintf(path_buf, "%s:", tree_name);
+		down = path_buf + tn_len;
 		strcat(down, base);
 	}
 	else {
@@ -886,7 +912,7 @@ static int grep_tree(struct grep_opt *op
 		if (!pathspec_matches(paths, down))
 			;
 		else if (S_ISREG(entry.mode))
-			hit |= grep_sha1(opt, entry.sha1, path_buf);
+			hit |= grep_sha1(opt, entry.sha1, path_buf, tn_len);
 		else if (S_ISDIR(entry.mode)) {
 			char type[20];
 			struct tree_desc sub;
@@ -907,7 +933,7 @@ static int grep_object(struct grep_opt *
 		       struct object *obj, const char *name)
 {
 	if (obj->type == OBJ_BLOB)
-		return grep_sha1(opt, obj->sha1, name);
+		return grep_sha1(opt, obj->sha1, name, 0);
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
@@ -945,6 +971,7 @@ int cmd_grep(int argc, const char **argv
 	int i;
 
 	memset(&opt, 0, sizeof(opt));
+	opt.prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
 	opt.pattern_tail = &opt.pattern_list;
 	opt.regflags = REG_NEWLINE;
 
@@ -1118,6 +1145,10 @@ int cmd_grep(int argc, const char **argv
 			}
 			die(emsg_missing_argument, arg);
 		}
+		if (!strcmp("--relative", arg)) {
+			opt.relative = 1;
+			continue;
+		}
 		if (!strcmp("--", arg)) {
 			/* later processing wants to have this at argv[1] */
 			argv--;
@@ -1176,8 +1207,15 @@ int cmd_grep(int argc, const char **argv
 			verify_filename(prefix, argv[j]);
 	}
 
-	if (i < argc)
+	if (i < argc) {
 		paths = get_pathspec(prefix, argv + i);
+		if (opt.prefix_length && opt.relative) {
+			/* Make sure we do not get outside of paths */
+			for (i = 0; paths[i]; i++)
+				if (strncmp(prefix, paths[i], opt.prefix_length))
+					die("git-grep: cannot generate relative filenames containing '..'");
+		}
+	}
 	else if (prefix) {
 		paths = xcalloc(2, sizeof(const char *));
 		paths[0] = prefix;
-- 
1.4.2.rc4.g9d8df
