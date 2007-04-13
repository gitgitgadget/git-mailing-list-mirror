From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Add basic infrastructure to assign attributes to paths
Date: Fri, 13 Apr 2007 02:01:34 -0700
Message-ID: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 11:02:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcHfh-0006Ne-PN
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 11:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbXDMJBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 05:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbXDMJBh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 05:01:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:41898 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbXDMJBf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 05:01:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413090135.UDNW1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Apr 2007 05:01:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id mZ1a1W0081kojtg0000000; Fri, 13 Apr 2007 05:01:34 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44398>

This adds the basic infrastructure to assign attributes to
paths, in a way similar to what the exclusion mechanism does
based on $GIT_DIR/info/exclude and .gitignore files.

An attribute is just a simple string that does not contain any
whitespace.  They can be specified in $GIT_DIR/info/attributes
file, and .gitattributes file in each directory.

Each line in these files defines a pattern matching rule.
Similar to the exclusion mechanism, a later match overrides an
earlier match in the same file, and entries from .gitattributes
file in the same directory takes precedence over the ones from
parent directories.  Lines in $GIT_DIR/info/attributes file are
used as the lowest precedence default rules.

A line is either a comment (an empty line, or a line that begins
with a '#'), or a rule, which is a whitespace separated list of
tokens.  The first token on the line is a shell glob pattern.
The rest are names of attributes, each of which can optionally
be prefixed with '!'.  Such a line means "if a path matches this
glob, this attribute is set (or unset -- if the attribute name
is prefixed with '!').  For glob matching, the same "if the
pattern does not have a slash in it, the basename of the path is
matched with fnmatch(3) against the pattern, otherwise, the path
is matched with the pattern with FNM_PATHNAME" rule as the
exclusion mechanism is used.

This does not define what an attribute means.  Tying an
attribute to various effects it has on git operation for paths
that have it (or doesn't) will be specified separately.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 .gitignore           |    1 +
 Makefile             |    5 +-
 attr.c               |  301 ++++++++++++++++++++++++++++++++++++++++++++++++++
 attr.h               |   16 +++
 builtin-check-attr.c |   31 +++++
 builtin.h            |    1 +
 cache.h              |    1 +
 git.c                |    1 +
 8 files changed, 355 insertions(+), 2 deletions(-)
 create mode 100644 attr.c
 create mode 100644 attr.h
 create mode 100644 builtin-check-attr.c

diff --git a/.gitignore b/.gitignore
index 9229e91..d96f4f0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -16,6 +16,7 @@ git-blame
 git-branch
 git-bundle
 git-cat-file
+git-check-attr
 git-check-ref-format
 git-checkout
 git-checkout-index
diff --git a/Makefile b/Makefile
index b8e6030..ac89d1b 100644
--- a/Makefile
+++ b/Makefile
@@ -283,7 +283,7 @@ LIB_H = \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
-	utf8.h reflog-walk.h patch-ids.h
+	utf8.h reflog-walk.h attr.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -305,7 +305,7 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o
+	convert.o attr.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
@@ -316,6 +316,7 @@ BUILTIN_OBJS = \
 	builtin-branch.o \
 	builtin-bundle.o \
 	builtin-cat-file.o \
+	builtin-check-attr.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
 	builtin-commit-tree.o \
diff --git a/attr.c b/attr.c
new file mode 100644
index 0000000..bdbc4a3
--- /dev/null
+++ b/attr.c
@@ -0,0 +1,301 @@
+#include "cache.h"
+#include "attr.h"
+
+/*
+ * The basic design decision here is that we are not going to have
+ * insanely large number of attributes.
+ *
+ * This is a randomly chosen prime.
+ */
+#define HASHSIZE 257
+
+struct git_attr {
+	struct git_attr *next;
+	unsigned h;
+	char name[FLEX_ARRAY];
+};
+
+static struct git_attr *(git_attr_hash[HASHSIZE]);
+
+static unsigned hash_name(const char *name, int namelen)
+{
+	unsigned val = 0;
+	unsigned char c;
+
+	while (namelen--) {
+		c = *name++;
+		val = ((val << 7) | (val >> 22)) ^ c;
+	}
+	return val;
+}
+
+struct git_attr *git_attr(const char *name, int len)
+{
+	unsigned hval = hash_name(name, len);
+	unsigned pos = hval % HASHSIZE;
+	struct git_attr *a;
+
+	for (a = git_attr_hash[pos]; a; a = a->next) {
+		if (a->h == hval &&
+		    !memcmp(a->name, name, len) && !a->name[len])
+			return a;
+	}
+
+	a = xmalloc(sizeof(*a) + len + 1);
+	memcpy(a->name, name, len);
+	a->name[len] = 0;
+	a->h = hval;
+	a->next = git_attr_hash[pos];
+	git_attr_hash[pos] = a;
+	return a;
+}
+
+/*
+ * .gitattributes file is one line per record, each of which is
+ *
+ * (1) glob pattern.
+ * (2) whitespace
+ * (3) whitespace separated list of attribute names, each of which
+ *     could be prefixed with '!' to mean "not set".
+ */
+
+struct attr_state {
+	int unset;
+	struct git_attr *attr;
+};
+
+struct match_attr {
+	char *pattern;
+	unsigned num_attr;
+	struct attr_state state[FLEX_ARRAY];
+};
+
+static const char blank[] = " \t\r\n";
+
+static struct match_attr *parse_attr_line(char *line)
+{
+	int namelen;
+	int num_attr;
+	char *cp, *name;
+	struct match_attr *res = res;
+	int pass;
+
+	cp = line + strspn(line, blank);
+	if (!*cp || *cp == '#')
+		return NULL;
+	name = cp;
+	namelen = strcspn(name, blank);
+
+	for (pass = 0; pass < 2; pass++) {
+		/* pass 0 counts and allocates, pass 1 fills */
+		num_attr = 0;
+		cp = name + namelen;
+		cp = cp + strspn(cp, blank);
+		while (*cp) {
+			char *ep;
+			ep = cp + strcspn(cp, blank);
+			if (pass) {
+				struct attr_state *e;
+
+				e = &(res->state[num_attr]);
+				if (*cp == '!') {
+					e->unset = 1;
+					cp++;
+				}
+				e->attr = git_attr(cp, ep - cp);
+			}
+			num_attr++;
+			cp = ep + strspn(ep, blank);
+		}
+		if (pass)
+			break;
+		res = xcalloc(1,
+			      sizeof(*res) +
+			      sizeof(struct attr_state) * num_attr +
+			      namelen + 1);
+		res->pattern = (char*)&(res->state[num_attr]);
+		memcpy(res->pattern, name, namelen);
+		res->pattern[namelen] = 0;
+		res->num_attr = num_attr;
+	}
+	return res;
+}
+
+/*
+ * Like info/exclude and .gitignore, the attribute information can
+ * come from many places.
+ *
+ * (1) .gitattribute file of the same directory;
+ * (2) .gitattribute file of the parent directory if (1) does not have any match;
+ *     this goes recursively upwards, just like .gitignore
+ * (3) perhaps $GIT_DIR/info/attributes, as the final fallback.
+ *
+ * In the same file, later entries override the earlier match, so in the
+ * global list, we would have entries from info/attributes the earliest
+ * (reading the file from top to bottom), .gitattribute of the root
+ * directory (again, reading the file from top to bottom) down to the
+ * current directory, and then scan the list backwards to find the first match.
+ * This is exactly the same as what excluded() does in dir.c to deal with
+ * .gitignore
+ */
+
+static struct attr_stack {
+	struct attr_stack *prev;
+	char *origin;
+	unsigned num_matches;
+	struct match_attr **attrs;
+} *attr_stack;
+
+static void free_attr_elem(struct attr_stack *e)
+{
+	int i;
+	free(e->origin);
+	for (i = 0; i < e->num_matches; i++)
+		free(e->attrs[i]);
+	free(e);
+}
+
+static struct attr_stack *read_attr_from_file(const char *path)
+{
+	FILE *fp;
+	struct attr_stack *res;
+	char buf[2048];
+
+	res = xcalloc(1, sizeof(*res));
+	fp = fopen(path, "r");
+	if (!fp)
+		return res;
+
+	while (fgets(buf, sizeof(buf), fp)) {
+		struct match_attr *a = parse_attr_line(buf);
+		if (!a)
+			continue;
+		res->attrs = xrealloc(res->attrs, res->num_matches + 1);
+		res->attrs[res->num_matches++] = a;
+	}
+	fclose(fp);
+	return res;
+}
+
+static void prepare_attr_stack(const char *path, int dirlen)
+{
+	struct attr_stack *elem;
+	int len;
+	char pathbuf[PATH_MAX];
+
+	if (!attr_stack) {
+		elem = read_attr_from_file(git_path("info/attributes"));
+		elem->origin = NULL;
+		attr_stack = elem;
+
+		elem = read_attr_from_file(GITATTRIBUTES_FILE);
+		elem->origin = strdup("");
+		elem->prev = attr_stack;
+		attr_stack = elem;
+	}
+
+	while (attr_stack && attr_stack->origin) {
+		int namelen = strlen(attr_stack->origin);
+		int len = (dirlen < namelen) ? dirlen : namelen;
+		if (!strncmp(attr_stack->origin, path, len))
+			break;
+		elem = attr_stack;
+		attr_stack = elem->prev;
+		free_attr_elem(elem);
+	}
+
+	while (1) {
+		char *cp;
+
+		len = strlen(attr_stack->origin);
+		if (dirlen <= len)
+			break;
+		memcpy(pathbuf, path, dirlen);
+		memcpy(pathbuf + dirlen, "/", 2);
+		cp = strchr(pathbuf + len + 1, '/');
+		strcpy(cp + 1, GITATTRIBUTES_FILE);
+		elem = read_attr_from_file(pathbuf);
+		*cp = '\0';
+		elem->origin = strdup(pathbuf);
+		elem->prev = attr_stack;
+		attr_stack = elem;
+	}
+}
+
+static int path_matches(const char *pathname, int pathlen,
+			const char *pattern,
+			const char *base, int baselen)
+{
+	if (!strchr(pattern, '/')) {
+		/* match basename */
+		const char *basename = strrchr(pathname, '/');
+		basename = basename ? basename + 1 : pathname;
+		return (fnmatch(pattern, basename, 0) == 0);
+	}
+	/*
+	 * match with FNM_PATHNAME; the pattern has base implicitly
+	 * in front of it.
+	 */
+	if (*pattern == '/')
+		pattern++;
+	if (pathlen < baselen ||
+	    (baselen && pathname[baselen - 1] != '/') ||
+	    strncmp(pathname, base, baselen))
+		return 0;
+	return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) == 0;
+}
+
+/*
+ * I do not like this at all.  Only because we allow individual
+ * attribute to be set or unset incrementally by individual
+ * lines in .gitattribute files, we need to do this triple
+ * loop which looks quite wasteful.
+ */
+static int fill(const char *path, int pathlen,
+		struct attr_stack *stk, struct git_attr_check *check,
+		int num, int rem)
+{
+	int i, j, k;
+	const char *base = stk->origin ? stk->origin : "";
+
+	for (i = stk->num_matches - 1; 0 < rem && 0 <= i; i--) {
+		struct match_attr *a = stk->attrs[i];
+		if (path_matches(path, pathlen,
+				 a->pattern, base, strlen(base))) {
+			for (j = 0; j < a->num_attr; j++) {
+				struct git_attr *attr = a->state[j].attr;
+				int set = !a->state[j].unset;
+				for (k = 0; k < num; k++) {
+					if (0 <= check[k].isset ||
+					    check[k].attr != attr)
+						continue;
+					check[k].isset = set;
+					rem--;
+				}
+			}
+		}
+	}
+	return rem;
+}
+
+int git_checkattr(const char *path, int num, struct git_attr_check *check)
+{
+	struct attr_stack *stk;
+	const char *cp;
+	int dirlen, pathlen, i, rem;
+
+	for (i = 0; i < num; i++)
+		check[i].isset = -1;
+
+	pathlen = strlen(path);
+	cp = strrchr(path, '/');
+	if (!cp)
+		dirlen = 0;
+	else
+		dirlen = cp - path;
+	prepare_attr_stack(path, dirlen);
+	rem = num;
+	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
+		rem = fill(path, pathlen, stk, check, num, rem);
+	return 0;
+}
diff --git a/attr.h b/attr.h
new file mode 100644
index 0000000..1e5ab40
--- /dev/null
+++ b/attr.h
@@ -0,0 +1,16 @@
+#ifndef ATTR_H
+#define ATTR_H
+
+/* An attribute is a pointer to this opaque structure */
+struct git_attr;
+
+struct git_attr *git_attr(const char *, int);
+
+struct git_attr_check {
+	struct git_attr *attr;
+	int isset;
+};
+
+int git_checkattr(const char *path, int, struct git_attr_check *);
+
+#endif /* ATTR_H */
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
new file mode 100644
index 0000000..643f3ba
--- /dev/null
+++ b/builtin-check-attr.c
@@ -0,0 +1,31 @@
+#include "builtin.h"
+#include "attr.h"
+
+static const char check_attr_usage[] =
+"git-check-attr pathname attr...";
+
+int cmd_check_attr(int argc, const char **argv, const char *prefix)
+{
+
+	struct git_attr_check *check;
+	int cnt, i;
+
+	if (argc < 3)
+		usage(check_attr_usage);
+
+	cnt = argc - 2;
+	check = xcalloc(cnt, sizeof(*check));
+	for (i = 0; i < cnt; i++) {
+		const char *name;
+		name = argv[i+2];
+		check[i].attr = git_attr(name, strlen(name));
+	}
+	if (git_checkattr(argv[1], cnt, check))
+		die("git_checkattr died");
+	for (i = 0; i < cnt; i++)
+		printf("%s: %s\n", argv[i+2],
+		       (check[i].isset < 0) ? "unspecified" :
+		       (check[i].isset == 0) ? "unset" :
+		       "set");
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index af203e9..d3f3a74 100644
--- a/builtin.h
+++ b/builtin.h
@@ -22,6 +22,7 @@ extern int cmd_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_bundle(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
+extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
diff --git a/cache.h b/cache.h
index b1bd9e4..bec1938 100644
--- a/cache.h
+++ b/cache.h
@@ -151,6 +151,7 @@ enum object_type {
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
+#define GITATTRIBUTES_FILE ".gitattributes"
 
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
diff --git a/git.c b/git.c
index 7def319..f200907 100644
--- a/git.c
+++ b/git.c
@@ -234,6 +234,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
 		{ "check-ref-format", cmd_check_ref_format },
+		{ "check-attr", cmd_check_attr, RUN_SETUP | NOT_BARE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NOT_BARE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-- 
1.5.1.1.784.g95e2
