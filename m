From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/2] pathattr: allow piping to external program.
Date: Thu, 01 Mar 2007 01:29:55 -0800
Message-ID: <7vzm6xux9o.fsf@assigned-by-dhcp.cox.net>
References: <7vodndxwia.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 10:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhc0-0001uP-Cl
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933217AbXCAJaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933219AbXCAJaG
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:30:06 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39265 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933217AbXCAJaC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:30:02 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301093001.QJJO26279.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 04:30:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VMW01W00Q1kojtg0000000; Thu, 01 Mar 2007 04:30:01 -0500
In-Reply-To: <7vodndxwia.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 28 Feb 2007 23:18:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41064>

This sets up capability for various traits to be an external
process, accessed via pipe.  conv-i and conv-o need to spawn
bidirectional pipe, but I have not coded that part yet.

You can try running:

    $ git show HEAD:Documentation/*.txt

with:

    [pathattr "kludge"]
        path = Documentation/*.txt
        pretty = "pipe sed -e 's/^/>> /'"

to see what it does.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I somehow suspect two Johannes'es would hate me for doing
   this.  I should instead resume coding the part to read
   .gitattributes from each directory, but spawning external
   stuff to borrow what other people already have done is much
   more fun than doing gruntwork in C.

 builtin-log.c |   18 ++++++++++---
 convert.c     |   16 ++++++------
 convert.h     |    3 --
 pathattr.c    |   77 ++++++++++++++++++++++++++++++++++++++++++++++----------
 pathattr.h    |    8 +++++-
 5 files changed, 92 insertions(+), 30 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 519fab2..86062d3 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -87,7 +87,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	return cmd_log_walk(&rev);
 }
 
-static void to_stdout(const unsigned char *blobdata, unsigned long size)
+static void to_stdout(const unsigned char *blobdata, unsigned long size, const char *unused)
 {
 	fwrite(blobdata, size, 1, stdout);
 }
@@ -99,6 +99,7 @@ static int show_object(const unsigned char *sha1, const char *path, int nohead)
 	unsigned char *buf = read_sha1_file(sha1, &type, &size);
 	int offset = 0;
 	pretty_fn pretty = to_stdout;
+	char *pretty_args = NULL;
 
 	if (!buf)
 		return error("Could not read object %s", sha1_to_hex(sha1));
@@ -117,11 +118,13 @@ static int show_object(const unsigned char *sha1, const char *path, int nohead)
 
 	if (path) {
 		const struct pathattr *a = pathattr_lookup(path);
-		if (a && a->pretty)
+		if (a && a->pretty) {
 			pretty = a->pretty;
+			pretty_args = a->pretty_args;
+		}
 	}
 
-	pretty(buf + offset, size - offset);
+	pretty(buf + offset, size - offset, pretty_args);
  finish:
 	free(buf);
 	return 0;
@@ -159,6 +162,13 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		const char *name = objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
+			/*
+			 * This is a hack to make v2.6.0:README
+			 * and friends to work.  Anybody have
+			 * better ideas?
+			 */
+			if (strchr(name, ':'))
+				name = strchr(name, ':') + 1;
 			ret = show_object(o->sha1, name, 0);
 			break;
 		case OBJ_TAG: {
@@ -170,7 +180,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					t->tag,
 					diff_get_color(rev.diffopt.color_diff,
 						DIFF_RESET));
-			ret = show_object(o->sha1, name, 1);
+			ret = show_object(o->sha1, NULL, 1);
 			objects[i].item = (struct object *)t->tagged;
 			i--;
 			break;
diff --git a/convert.c b/convert.c
index c39946d..504036e 100644
--- a/convert.c
+++ b/convert.c
@@ -253,11 +253,11 @@ static int convo_autocrlf(const char *path, char **bufp, unsigned long *sizep)
 int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
 {
 	if (path) {
-		const struct pathattr *attr = pathattr_lookup(path);
-		if (attr) {
-			if (!attr->conv_i)
+		const struct pathattr *a = pathattr_lookup(path);
+		if (a) {
+			if (!a->conv_i)
 				return 0;
-			return attr->conv_i(path, bufp, sizep);
+			return a->conv_i(path, bufp, sizep, a->conv_i_args);
 		}
 	}
 	/* Fallback */
@@ -268,11 +268,11 @@ int convert_to_working_tree(const char *path, char **bufp,
 			    unsigned long *sizep)
 {
 	if (path) {
-		const struct pathattr *attr = pathattr_lookup(path);
-		if (attr) {
-			if (!attr->conv_o)
+		const struct pathattr *a = pathattr_lookup(path);
+		if (a) {
+			if (!a->conv_o)
 				return 0;
-			return attr->conv_o(path, bufp, sizep);
+			return a->conv_o(path, bufp, sizep, a->conv_o_args);
 		}
 	}
 	/* Fallback */
diff --git a/convert.h b/convert.h
index e54b3ef..ff6fb85 100644
--- a/convert.h
+++ b/convert.h
@@ -1,9 +1,6 @@
 #ifndef CONVERT_H
 #define CONVERT_H
 
-typedef int (*convi_fn)(const char *, char **, unsigned long *);
-typedef int (*convo_fn)(const char *, char **, unsigned long *);
-
 int convi_crlf(const char *path, char **bufp, unsigned long *sizep);
 int convo_crlf(const char *path, char **bufp, unsigned long *sizep);
 
diff --git a/pathattr.c b/pathattr.c
index 2532c9a..9362234 100644
--- a/pathattr.c
+++ b/pathattr.c
@@ -1,9 +1,30 @@
 #include "cache.h"
 #include "pathattr.h"
 
-static void show_display(const unsigned char *blobdata, unsigned long size)
+static int convi_pipe(const char *path, char **bufp, unsigned long *sizep,
+		      const char *args)
 {
-	FILE *display = popen("display -", "w");
+	/* NEEDSWORK: set up two-way pipe, spawn command specified
+	 * with args, and have it convert bufp & sizep
+	 */
+	return 0;
+}
+
+static int convo_pipe(const char *path, char **bufp, unsigned long *sizep,
+		      const char *args)
+{
+	/* NEEDSWORK: set up two-way pipe, spawn command specified
+	 * with args, and have it convert bufp & sizep
+	 */
+	return 0;
+}
+
+static void pretty_pipe(const unsigned char *blobdata, unsigned long size,
+			const char *args)
+{
+	FILE *display;
+
+	display = popen(args, "w");
 	fwrite(blobdata, size, 1, display);
 	fclose(display);
 }
@@ -67,6 +88,7 @@ static struct pathattr *locate(struct pathattr_stack *s, const char *name)
 		s->attr = xrealloc(s->attr, sizeof(*a) * s->attr_alloc);
 	}
 	a = &(s->attr[s->attr_nr++]);
+	memset(a, 0, sizeof(*a));
 	a->name = xstrdup(name);
 	return a;
 }
@@ -80,29 +102,57 @@ static void add_match(struct pathattr_stack *s, struct pathattr *a, const char *
 		s->match = xrealloc(s->match, sizeof(*m) * s->match_alloc);
 	}
 	m = &(s->match[s->match_nr++]);
+	memset(m, 0, sizeof(*m));
 	m->pattern = xstrdup(pattern);
 	m->type = strchr(pattern, '/') ? FNM_PATHNAME : 0;
 	m->attr = a;
 }
 
-static convi_fn conv_i_trait(const char *value)
+static int call_convi_crlf(const char *path, char **bufp, unsigned long *sizep,
+			   const char *args)
+{
+	return convi_crlf(path, bufp, sizep);
+}
+
+static int call_convo_crlf(const char *path, char **bufp, unsigned long *sizep,
+			   const char *args)
+{
+	return convo_crlf(path, bufp, sizep);
+}
+
+static int parse_pipe_trait(const char *value, char **args)
+{
+	if (strncmp(value, "pipe ", 5))
+		return 0;
+	free(*args);
+	*args = xstrdup(value + 5);
+	return 1;
+}
+
+static convi_fn conv_i_trait(const char *value, struct pathattr *a)
 {
 	if (!strcmp(value, "crlf"))
-		return convi_crlf;
+		return call_convi_crlf;
+	if (parse_pipe_trait(value, &a->conv_i_args))
+		return convi_pipe;
 	return NULL;
 }
 
-static convo_fn conv_o_trait(const char *value)
+static convo_fn conv_o_trait(const char *value, struct pathattr *a)
 {
 	if (!strcmp(value, "crlf"))
-		return convo_crlf;
+		return call_convo_crlf;
+	if (parse_pipe_trait(value, &a->conv_o_args))
+		return convo_pipe;
 	return NULL;
 }
 
-static pretty_fn pretty_trait(const char *value)
+static pretty_fn pretty_trait(const char *value, struct pathattr *a)
 {
 	if (!strcmp(value, "display"))
-		return show_display;
+		value = "pipe display -";
+	if (parse_pipe_trait(value, &a->pretty_args))
+		return pretty_pipe;
 	return NULL;
 }
 
@@ -133,11 +183,11 @@ static int attr_config(const char *var, const char *value)
 	if (!strcmp(trait, "path"))
 		add_match(stk, a, value);
 	else if (!strcmp(trait, "conv_i"))
-		a->conv_i = conv_i_trait(value);
+		a->conv_i = conv_i_trait(value, a);
 	else if (!strcmp(trait, "conv_o"))
-		a->conv_i = conv_o_trait(value);
+		a->conv_i = conv_o_trait(value, a);
 	else if (!strcmp(trait, "pretty"))
-		a->pretty = pretty_trait(value);
+		a->pretty = pretty_trait(value, a);
 	/*
 	 * Do not barf if the configuration has unknown trait.
 	 * the user might be bisecting git and trying an older
@@ -154,14 +204,13 @@ static void init_stack(void)
 
 	/* A couple of silly example as an illustration */
 	a = locate(stk, "silly");
-	a->conv_i = convi_crlf;
-	a->conv_o = convo_crlf;
+	a->conv_i = call_convi_crlf;
+	a->conv_o = call_convo_crlf;
 	add_match(stk, a, "*.dos-txt");
 
 	a = locate(stk, "image/*");
 	a->conv_i = NULL;
 	a->conv_o = NULL;
-	a->pretty = show_display;
 	add_match(stk, a, "*.png");
 	add_match(stk, a, "*.jpg");
 	add_match(stk, a, "*.gif");
diff --git a/pathattr.h b/pathattr.h
index bfd9ff1..34e8ce4 100644
--- a/pathattr.h
+++ b/pathattr.h
@@ -3,7 +3,9 @@
 
 #include "convert.h"
 
-typedef void (*pretty_fn)(const unsigned char *blobdata, unsigned long size);
+typedef int (*convi_fn)(const char *, char **, unsigned long *, const char *);
+typedef int (*convo_fn)(const char *, char **, unsigned long *, const char *);
+typedef void (*pretty_fn)(const unsigned char *, unsigned long, const char *);
 
 /*
  * Data in one section of [pathattr "name"], except
@@ -14,6 +16,10 @@ struct pathattr {
 	convi_fn conv_i;
 	convo_fn conv_o;
 	pretty_fn pretty;
+
+	char *conv_i_args;
+	char *conv_o_args;
+	char *pretty_args;
 };
 
 const struct pathattr *pathattr_lookup(const char *);
-- 
1.5.0.2.809.g0f936
