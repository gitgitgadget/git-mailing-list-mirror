From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] pathattr: path based configuration of various attributes.
Date: Wed, 28 Feb 2007 23:18:01 -0800
Message-ID: <7vps7txwie.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 08:19:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMfZN-0006Kl-7q
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 08:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024AbXCAHS3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 02:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933014AbXCAHS3
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 02:18:29 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51995 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933024AbXCAHSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 02:18:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301071802.OMIE2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 02:18:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VKJ11W00M1kojtg0000000; Thu, 01 Mar 2007 02:18:02 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41041>

This still does not actually add per-directory "configuration" files
nor reading from the global configuration via git_config() yet,
but lays the groundwork for implementing them.

The idea is to have sections like these in the configuration
files and .gitattributes files in each directory:

	[pathattr "text/plain"]
        	conv_i = crlf
		path = "*.txt"
                path = "*.c"
                path = "*.h"

        [pathattr "binary"]
        	; conv_i = none
                ; conv_o = none
		path = "*.png"
                path = "*.mov"
                path = "*.mp3"

These sections can contain "path", and other variables (let's
call the latter "traits").

"path" specifications are used as fnmatch(3) patterns to
determine if the traits in the section applies to a given path.
Traits give attributes to paths that match the section, and
there are currently two traits defined: conv_i and conv_o.
These are to specify how to convert what's read from the
filesystem before making a blob object out of it, and how to
convert a blob object data before writing it out to the
filesystem.

These configuration sections are grouped by the directory they
were read from, and arranged in a stack, so that we can apply
the ones read from the most specific configuration file,just
like what we do with the current .gitignore mechanism.
In fact, we might want to add "ignore" as the third trait.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is relative to 'next'; you can cherry pick b875e71 from
   'next' on top of 'master' to apply this if you do not want to
   slurp the remainder of 'next'.

 Makefile   |    4 +-
 convert.c  |   43 ++++++----------
 convert.h  |   10 ++++
 pathattr.c |  160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pathattr.h |   18 +++++++
 5 files changed, 206 insertions(+), 29 deletions(-)
 create mode 100644 convert.h
 create mode 100644 pathattr.c
 create mode 100644 pathattr.h

diff --git a/Makefile b/Makefile
index 23ab7d6..ac90543 100644
--- a/Makefile
+++ b/Makefile
@@ -247,7 +247,7 @@ LIB_H = \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
-	utf8.h reflog-walk.h
+	utf8.h reflog-walk.h pathattr.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -260,7 +260,7 @@ LIB_OBJS = \
 	interpolate.o \
 	lockfile.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o sideband.o \
-	reachable.o reflog-walk.o \
+	reachable.o reflog-walk.o pathattr.o \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
diff --git a/convert.c b/convert.c
index e1db76a..c39946d 100644
--- a/convert.c
+++ b/convert.c
@@ -1,4 +1,6 @@
 #include "cache.h"
+#include "pathattr.h"
+
 /*
  * convert.c - convert a file when checking it out and checking it in.
  *
@@ -46,7 +48,7 @@ static int convo_crlf_real(char *in, char *out, unsigned long isize)
 /*
  * Forced CRLF conversion.
  */
-static int convi_crlf(const char *path, char **bufp, unsigned long *sizep)
+int convi_crlf(const char *path, char **bufp, unsigned long *sizep)
 {
 	unsigned long size, cr, i, nsize;
 	char *buf, *nbuf;
@@ -65,7 +67,7 @@ static int convi_crlf(const char *path, char **bufp, unsigned long *sizep)
 	return convi_crlf_real(buf, nbuf, size);
 }
 
-static int convo_crlf(const char *path, char **bufp, unsigned long *sizep)
+int convo_crlf(const char *path, char **bufp, unsigned long *sizep)
 {
 	unsigned long size, cr, i, nsize;
 	unsigned char last;
@@ -245,34 +247,18 @@ static int convo_autocrlf(const char *path, char **bufp, unsigned long *sizep)
 
 /******************************************************************/
 
-typedef int (*convi_fn)(const char *, char **, unsigned long *);
-typedef int (*convo_fn)(const char *, char **, unsigned long *);
-
-static convi_fn pathattr_find_conv_i(const char *path)
-{
-	/* A silly example */
-	if (!fnmatch("*.dos-txt", path, 0))
-		return convi_crlf;
-	return NULL;
-}
-
-static convo_fn pathattr_find_conv_o(const char *path)
-{
-	/* A silly example */
-	if (!fnmatch("*.dos-txt", path, 0))
-		return convo_crlf;
-	return NULL;
-}
-
 /*
  * Main entry points
  */
 int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
 {
 	if (path) {
-		convi_fn conv_i = pathattr_find_conv_i(path);
-		if (conv_i)
-			return conv_i(path, bufp, sizep);
+		const struct pathattr *attr = pathattr_lookup(path);
+		if (attr) {
+			if (!attr->conv_i)
+				return 0;
+			return attr->conv_i(path, bufp, sizep);
+		}
 	}
 	/* Fallback */
 	return convi_autocrlf(path, bufp, sizep);
@@ -282,9 +268,12 @@ int convert_to_working_tree(const char *path, char **bufp,
 			    unsigned long *sizep)
 {
 	if (path) {
-		convi_fn conv_o = pathattr_find_conv_o(path);
-		if (conv_o)
-			return conv_o(path, bufp, sizep);
+		const struct pathattr *attr = pathattr_lookup(path);
+		if (attr) {
+			if (!attr->conv_o)
+				return 0;
+			return attr->conv_o(path, bufp, sizep);
+		}
 	}
 	/* Fallback */
 	return convo_autocrlf(path, bufp, sizep);
diff --git a/convert.h b/convert.h
new file mode 100644
index 0000000..e54b3ef
--- /dev/null
+++ b/convert.h
@@ -0,0 +1,10 @@
+#ifndef CONVERT_H
+#define CONVERT_H
+
+typedef int (*convi_fn)(const char *, char **, unsigned long *);
+typedef int (*convo_fn)(const char *, char **, unsigned long *);
+
+int convi_crlf(const char *path, char **bufp, unsigned long *sizep);
+int convo_crlf(const char *path, char **bufp, unsigned long *sizep);
+
+#endif /* CONVERT_H */
diff --git a/pathattr.c b/pathattr.c
new file mode 100644
index 0000000..06bbb4e
--- /dev/null
+++ b/pathattr.c
@@ -0,0 +1,160 @@
+#include "cache.h"
+#include "pathattr.h"
+
+/*
+ * Path match specification
+ */
+struct pathattr_match {
+	int type;
+	char *pattern;
+	struct pathattr *attr;
+};
+
+/*
+ * List of pathattr specifications are maintained per
+ * directory.
+ */
+struct pathattr_stack {
+	struct pathattr_stack *next;
+	int baselen;
+	const char *base;
+
+	int attr_nr;
+	int attr_alloc;
+	int match_nr;
+	int match_alloc;
+	struct pathattr *attr;
+	struct pathattr_match *match;
+};
+
+static struct pathattr_stack *stk;
+
+/*
+ * Bottom stack element is special -- it is what we read
+ * from the configuration file.
+ */
+static struct pathattr_stack *btm;
+
+static inline int match_base(const char *path, int pathlen,
+			     const char *base, int baselen)
+{
+	if (pathlen < baselen)
+		return 0;
+	if (strncmp(path, base, baselen))
+		return 0;
+	if (baselen && path[baselen])
+		return 0;
+	return 1;
+}
+
+static struct pathattr *locate(struct pathattr_stack *s, const char *name)
+{
+	struct pathattr *a;
+	int i;
+
+	for (i = 0; i < s->attr_nr; i++)
+		if (!strcmp(s->attr[i].name, name))
+			return &(s->attr[i]);
+	if (s->attr_nr <= s->attr_alloc) {
+		s->attr_alloc = alloc_nr(s->attr_nr);
+		s->attr = xrealloc(s->attr, sizeof(*a) * s->attr_alloc);
+	}
+	a = &(s->attr[s->attr_nr++]);
+	a->name = xstrdup(name);
+	return a;
+}
+
+static void add_match(struct pathattr_stack *s, struct pathattr *a, const char *pattern)
+{
+	struct pathattr_match *m;
+
+	if (s->match_nr <= s->match_alloc) {
+		s->match_alloc = alloc_nr(s->match_nr);
+		s->match = xrealloc(s->match, sizeof(*m) * s->match_alloc);
+	}
+	m = &(s->match[s->match_nr++]);
+	m->pattern = xstrdup(pattern);
+	m->type = strchr(pattern, '/') ? FNM_PATHNAME : 0;
+	m->attr = a;
+}
+
+static void init_stack(void)
+{
+	struct pathattr *a;
+
+	btm = stk = xcalloc(1, sizeof(*stk));
+
+	/* A couple of silly example as an illustration */
+	a = locate(stk, "silly");
+	a->conv_i = convi_crlf;
+	a->conv_o = convo_crlf;
+	add_match(stk, a, "*.dos-txt");
+
+	a = locate(stk, "image/*");
+	a->conv_i = NULL;
+	a->conv_o = NULL;
+	add_match(stk, a, "*.png");
+	add_match(stk, a, "*.jpg");
+	add_match(stk, a, "*.gif");
+
+	/* NEEDSWORK: read from config */
+}
+
+static void pop_stack(void)
+{
+	struct pathattr_stack *s;
+	int i;
+
+	if (stk == btm)
+		return;
+	s = stk;
+	for (i = 0; i < s->attr_nr; i++)
+		free(s->attr[i].name);
+	free(s->attr);
+	for (i = 0; i < s->match_nr; i++)
+		free(s->match[i].pattern);
+	free(s->match);
+	stk = stk->next;
+}
+
+static void adjust_stack(const char *path, int len)
+{
+	if (!btm)
+		init_stack();
+	while (stk && stk != btm &&
+	       match_base(path, len, stk->base, stk->baselen))
+		pop_stack();
+	/*
+	 * NEEDSWORK:
+	 *
+	 * Now, (stk->base, stk->baselen) is a leading directory
+	 * of (path, len), and we would need to read the entries
+	 * for remaining subdirectories.
+	 *
+	 * e.g. stk->base = "", path = "a/b/c" or
+	 * stk->base = "a/", path = "a/b/c".
+	 */
+}
+
+
+const struct pathattr *pathattr_lookup(const char *path)
+{
+	int len = strlen(path);
+	struct pathattr_stack *s;
+
+	if (!stk || !match_base(path, len, stk->base, stk->baselen))
+		adjust_stack(path, len);
+
+	for (s = stk; s; s = s->next) {
+		int i;
+		int baselen = s->baselen;
+
+		for (i = 0; i < s->match_nr; i++) {
+			struct pathattr_match *m = &(s->match[i]);
+
+			if (!fnmatch(m->pattern, path + baselen, m->type))
+				return m->attr;
+		}
+	}
+	return NULL;
+}
diff --git a/pathattr.h b/pathattr.h
new file mode 100644
index 0000000..4ca4e60
--- /dev/null
+++ b/pathattr.h
@@ -0,0 +1,18 @@
+#ifndef PATHATTR_H
+#define PATHATTR_H
+
+#include "convert.h"
+
+/*
+ * Data in one section of [pathattr "name"], except
+ * the path match specification.
+ */
+struct pathattr {
+	char *name;
+	convi_fn conv_i;
+	convo_fn conv_o;
+};
+
+const struct pathattr *pathattr_lookup(const char *);
+
+#endif /* PATHATTR_H */
-- 
1.5.0.2.809.g0f936
