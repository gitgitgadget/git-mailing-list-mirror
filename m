From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] diff: unify external diff and funcname parsing code
Date: Sun, 5 Oct 2008 17:43:21 -0400
Message-ID: <20081005214321.GB21925@coredump.intra.peff.net>
References: <20081005214114.GA21875@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Oct 05 23:44:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmbP1-0001nr-UN
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 23:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbYJEVnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 17:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbYJEVnZ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 17:43:25 -0400
Received: from peff.net ([208.65.91.99]:2846 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766AbYJEVnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 17:43:23 -0400
Received: (qmail 17873 invoked by uid 111); 5 Oct 2008 21:43:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 05 Oct 2008 17:43:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2008 17:43:21 -0400
Content-Disposition: inline
In-Reply-To: <20081005214114.GA21875@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97539>

Both sets of code assume that one specifies a diff profile
as a gitattribute via the "diff=foo" attribute. They then
pull information about that profile from the config as
diff.foo.*.

The code for each is currently completely separate from the
other, which has several disadvantages:

  - there is duplication as we maintain code to create and
    search the separate lists of external drivers and
    funcname patterns

  - it is difficult to add new profile options, since it is
    unclear where they should go

  - the code is difficult to follow, as we rely on the
    "check if this file is binary" code to find the funcname
    pattern as a side effect. This is the first step in
    refactoring the binary-checking code.

This patch factors out these diff profiles into "userdiff"
drivers. A file with "diff=foo" uses the "foo" driver, which
is specified by a single struct.

Note that one major difference between the two pieces of
code is that the funcname patterns are always loaded,
whereas external drivers are loaded only for the "git diff"
porcelain; the new code takes care to retain that situation.

Signed-off-by: Jeff King <peff@peff.net>
---
This is obviously a large and difficult to read diff. But I hope the
result is a bit more readable.

 Makefile   |    2 +
 diff.c     |  241 +++++++-----------------------------------------------------
 userdiff.c |  151 +++++++++++++++++++++++++++++++++++++
 userdiff.h |   23 ++++++
 4 files changed, 203 insertions(+), 214 deletions(-)
 create mode 100644 userdiff.c
 create mode 100644 userdiff.h

diff --git a/Makefile b/Makefile
index 308dc70..d6f3695 100644
--- a/Makefile
+++ b/Makefile
@@ -389,6 +389,7 @@ LIB_H += transport.h
 LIB_H += tree.h
 LIB_H += tree-walk.h
 LIB_H += unpack-trees.h
+LIB_H += userdiff.h
 LIB_H += utf8.h
 LIB_H += wt-status.h
 
@@ -485,6 +486,7 @@ LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
 LIB_OBJS += unpack-trees.o
+LIB_OBJS += userdiff.o
 LIB_OBJS += usage.o
 LIB_OBJS += utf8.o
 LIB_OBJS += walker.o
diff --git a/diff.c b/diff.c
index 4e4e439..08f335f 100644
--- a/diff.c
+++ b/diff.c
@@ -11,6 +11,7 @@
 #include "attr.h"
 #include "run-command.h"
 #include "utf8.h"
+#include "userdiff.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -56,80 +57,6 @@ static int parse_diff_color_slot(const char *var, int ofs)
 	die("bad config variable '%s'", var);
 }
 
-static struct ll_diff_driver {
-	const char *name;
-	struct ll_diff_driver *next;
-	const char *cmd;
-} *user_diff, **user_diff_tail;
-
-/*
- * Currently there is only "diff.<drivername>.command" variable;
- * because there are "diff.color.<slot>" variables, we are parsing
- * this in a bit convoluted way to allow low level diff driver
- * called "color".
- */
-static int parse_lldiff_command(const char *var, const char *ep, const char *value)
-{
-	const char *name;
-	int namelen;
-	struct ll_diff_driver *drv;
-
-	name = var + 5;
-	namelen = ep - name;
-	for (drv = user_diff; drv; drv = drv->next)
-		if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
-			break;
-	if (!drv) {
-		drv = xcalloc(1, sizeof(struct ll_diff_driver));
-		drv->name = xmemdupz(name, namelen);
-		if (!user_diff_tail)
-			user_diff_tail = &user_diff;
-		*user_diff_tail = drv;
-		user_diff_tail = &(drv->next);
-	}
-
-	return git_config_string(&(drv->cmd), var, value);
-}
-
-/*
- * 'diff.<what>.funcname' attribute can be specified in the configuration
- * to define a customized regexp to find the beginning of a function to
- * be used for hunk header lines of "diff -p" style output.
- */
-struct funcname_pattern_entry {
-	char *name;
-	char *pattern;
-	int cflags;
-};
-static struct funcname_pattern_list {
-	struct funcname_pattern_list *next;
-	struct funcname_pattern_entry e;
-} *funcname_pattern_list;
-
-static int parse_funcname_pattern(const char *var, const char *ep, const char *value, int cflags)
-{
-	const char *name;
-	int namelen;
-	struct funcname_pattern_list *pp;
-
-	name = var + 5; /* "diff." */
-	namelen = ep - name;
-
-	for (pp = funcname_pattern_list; pp; pp = pp->next)
-		if (!strncmp(pp->e.name, name, namelen) && !pp->e.name[namelen])
-			break;
-	if (!pp) {
-		pp = xcalloc(1, sizeof(*pp));
-		pp->e.name = xmemdupz(name, namelen);
-		pp->next = funcname_pattern_list;
-		funcname_pattern_list = pp;
-	}
-	free(pp->e.pattern);
-	pp->e.pattern = xstrdup(value);
-	pp->e.cflags = cflags;
-	return 0;
-}
-
 /*
  * These are to give UI layer defaults.
  * The core-level commands such as git-diff-files should
@@ -162,11 +89,11 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cmd_cfg, var, value);
-	if (!prefixcmp(var, "diff.")) {
-		const char *ep = strrchr(var, '.');
 
-		if (ep != var + 4 && !strcmp(ep, ".command"))
-			return parse_lldiff_command(var, ep, value);
+	switch (userdiff_config_porcelain(var, value)) {
+		case 0: break;
+		case -1: return -1;
+		default: return 0;
 	}
 
 	return git_diff_basic_config(var, value, cb);
@@ -193,21 +120,10 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!prefixcmp(var, "diff.")) {
-		const char *ep = strrchr(var, '.');
-		if (ep != var + 4) {
-			if (!strcmp(ep, ".funcname")) {
-				if (!value)
-					return config_error_nonbool(var);
-				return parse_funcname_pattern(var, ep, value,
-					0);
-			} else if (!strcmp(ep, ".xfuncname")) {
-				if (!value)
-					return config_error_nonbool(var);
-				return parse_funcname_pattern(var, ep, value,
-					REG_EXTENDED);
-			}
-		}
+	switch (userdiff_config_basic(var, value)) {
+		case 0: break;
+		case -1: return -1;
+		default: return 0;
 	}
 
 	return git_color_default_config(var, value, cb);
@@ -1355,46 +1271,24 @@ static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two)
 	emit_binary_diff_body(file, two, one);
 }
 
-static void setup_diff_attr_check(struct git_attr_check *check)
-{
-	static struct git_attr *attr_diff;
-
-	if (!attr_diff) {
-		attr_diff = git_attr("diff", 4);
-	}
-	check[0].attr = attr_diff;
-}
-
 static void diff_filespec_check_attr(struct diff_filespec *one)
 {
-	struct git_attr_check attr_diff_check;
+	struct userdiff_driver *drv;
 	int check_from_data = 0;
 
 	if (one->checked_attr)
 		return;
 
-	setup_diff_attr_check(&attr_diff_check);
+	drv = userdiff_find_by_path(one->path);
 	one->is_binary = 0;
-	one->funcname_pattern_ident = NULL;
 
-	if (!git_checkattr(one->path, 1, &attr_diff_check)) {
-		const char *value;
-
-		/* binaryness */
-		value = attr_diff_check.value;
-		if (ATTR_TRUE(value))
-			;
-		else if (ATTR_FALSE(value))
-			one->is_binary = 1;
-		else
-			check_from_data = 1;
-
-		/* funcname pattern ident */
-		if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value))
-			;
-		else
-			one->funcname_pattern_ident = value;
-	}
+	/* binaryness */
+	if (drv == USERDIFF_ATTR_TRUE)
+		;
+	else if (drv == USERDIFF_ATTR_FALSE)
+		one->is_binary = 1;
+	else
+		check_from_data = 1;
 
 	if (check_from_data) {
 		if (!one->data && DIFF_FILE_VALID(one))
@@ -1411,70 +1305,12 @@ int diff_filespec_is_binary(struct diff_filespec *one)
 	return one->is_binary;
 }
 
-static const struct funcname_pattern_entry *funcname_pattern(const char *ident)
-{
-	struct funcname_pattern_list *pp;
-
-	for (pp = funcname_pattern_list; pp; pp = pp->next)
-		if (!strcmp(ident, pp->e.name))
-			return &pp->e;
-	return NULL;
-}
-
-static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
-	{ "bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
-	  REG_EXTENDED },
-	{ "html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$", REG_EXTENDED },
-	{ "java",
-	  "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
-	  "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
-	  REG_EXTENDED },
-	{ "pascal",
-	  "^((procedure|function|constructor|destructor|interface|"
-		"implementation|initialization|finalization)[ \t]*.*)$"
-	  "\n"
-	  "^(.*=[ \t]*(class|record).*)$",
-	  REG_EXTENDED },
-	{ "php", "^[\t ]*((function|class).*)", REG_EXTENDED },
-	{ "python", "^[ \t]*((class|def)[ \t].*)$", REG_EXTENDED },
-	{ "ruby", "^[ \t]*((class|module|def)[ \t].*)$",
-	  REG_EXTENDED },
-	{ "tex",
-	  "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-	  REG_EXTENDED },
-};
-
-static const struct funcname_pattern_entry *diff_funcname_pattern(struct diff_filespec *one)
+static const struct userdiff_funcname *diff_funcname_pattern(struct diff_filespec *one)
 {
-	const char *ident;
-	const struct funcname_pattern_entry *pe;
-	int i;
-
-	diff_filespec_check_attr(one);
-	ident = one->funcname_pattern_ident;
-
-	if (!ident)
-		/*
-		 * If the config file has "funcname.default" defined, that
-		 * regexp is used; otherwise NULL is returned and xemit uses
-		 * the built-in default.
-		 */
-		return funcname_pattern("default");
-
-	/* Look up custom "funcname.$ident" regexp from config. */
-	pe = funcname_pattern(ident);
-	if (pe)
-		return pe;
-
-	/*
-	 * And define built-in fallback patterns here.  Note that
-	 * these can be overridden by the user's config settings.
-	 */
-	for (i = 0; i < ARRAY_SIZE(builtin_funcname_pattern); i++)
-		if (!strcmp(ident, builtin_funcname_pattern[i].name))
-			return &builtin_funcname_pattern[i];
-
-	return NULL;
+	struct userdiff_driver *drv = userdiff_find_by_path(one->path);
+	if (!drv)
+		drv = userdiff_find_by_name("default");
+	return drv && drv->funcname.pattern ? &drv->funcname : NULL;
 }
 
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b)
@@ -1568,7 +1404,7 @@ static void builtin_diff(const char *name_a,
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
 		struct emit_callback ecbdata;
-		const struct funcname_pattern_entry *pe;
+		const struct userdiff_funcname *pe;
 
 		pe = diff_funcname_pattern(one);
 		if (!pe)
@@ -2108,29 +1944,6 @@ static void run_external_diff(const char *pgm,
 	}
 }
 
-static const char *external_diff_attr(const char *name)
-{
-	struct git_attr_check attr_diff_check;
-
-	if (!name)
-		return NULL;
-
-	setup_diff_attr_check(&attr_diff_check);
-	if (!git_checkattr(name, 1, &attr_diff_check)) {
-		const char *value = attr_diff_check.value;
-		if (!ATTR_TRUE(value) &&
-		    !ATTR_FALSE(value) &&
-		    !ATTR_UNSET(value)) {
-			struct ll_diff_driver *drv;
-
-			for (drv = user_diff; drv; drv = drv->next)
-				if (!strcmp(drv->name, value))
-					return drv->cmd;
-		}
-	}
-	return NULL;
-}
-
 static void run_diff_cmd(const char *pgm,
 			 const char *name,
 			 const char *other,
@@ -2144,9 +1957,9 @@ static void run_diff_cmd(const char *pgm,
 	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
 		pgm = NULL;
 	else {
-		const char *cmd = external_diff_attr(attr_path);
-		if (cmd)
-			pgm = cmd;
+		struct userdiff_driver *drv = userdiff_find_by_path(attr_path);
+		if (drv && drv->external)
+			pgm = drv->external;
 	}
 
 	if (pgm) {
diff --git a/userdiff.c b/userdiff.c
new file mode 100644
index 0000000..3406adc
--- /dev/null
+++ b/userdiff.c
@@ -0,0 +1,151 @@
+#include "userdiff.h"
+#include "cache.h"
+#include "attr.h"
+
+static struct userdiff_driver *drivers;
+static int ndrivers;
+static int drivers_alloc;
+
+#define FUNCNAME(name, pattern) \
+	{ name, NULL, { pattern, REG_EXTENDED } }
+static struct userdiff_driver builtin_drivers[] = {
+FUNCNAME("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$"),
+FUNCNAME("java",
+	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
+	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$"),
+FUNCNAME("pascal",
+	 "^((procedure|function|constructor|destructor|interface|"
+		"implementation|initialization|finalization)[ \t]*.*)$"
+	 "\n"
+	 "^(.*=[ \t]*(class|record).*)$"),
+FUNCNAME("php", "^[\t ]*((function|class).*)"),
+FUNCNAME("python", "^[ \t]*((class|def)[ \t].*)$"),
+FUNCNAME("ruby", "^[ \t]*((class|module|def)[ \t].*)$"),
+FUNCNAME("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$"),
+FUNCNAME("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$"),
+};
+#undef FUNCNAME
+
+static struct userdiff_driver driver_true = {
+	"diff=true",
+	NULL,
+	{ NULL, 0 }
+};
+struct userdiff_driver *USERDIFF_ATTR_TRUE = &driver_true;
+
+static struct userdiff_driver driver_false = {
+	"!diff",
+	NULL,
+	{ NULL, 0 }
+};
+struct userdiff_driver *USERDIFF_ATTR_FALSE = &driver_false;
+
+static struct userdiff_driver *userdiff_find_by_namelen(const char *k, int len)
+{
+	int i;
+	for (i = 0; i < ndrivers; i++) {
+		struct userdiff_driver *drv = drivers + i;
+		if (!strncmp(drv->name, k, len) && !drv->name[len])
+			return drv;
+	}
+	for (i = 0; i < ARRAY_SIZE(builtin_drivers); i++) {
+		struct userdiff_driver *drv = builtin_drivers + i;
+		if (!strncmp(drv->name, k, len) && !drv->name[len])
+			return drv;
+	}
+	return NULL;
+}
+
+static struct userdiff_driver *parse_driver(const char *var,
+		const char *value, const char *type)
+{
+	struct userdiff_driver *drv;
+	const char *dot;
+	const char *name;
+	int namelen;
+
+	if (prefixcmp(var, "diff."))
+		return NULL;
+	dot = strrchr(var, '.');
+	if (dot == var + 4)
+		return NULL;
+	if (strcmp(type, dot+1))
+		return NULL;
+
+	name = var + 5;
+	namelen = dot - name;
+	drv = userdiff_find_by_namelen(name, namelen);
+	if (!drv) {
+		ALLOC_GROW(drivers, ndrivers+1, drivers_alloc);
+		drv = &drivers[ndrivers++];
+		memset(drv, 0, sizeof(*drv));
+		drv->name = xmemdupz(name, namelen);
+	}
+	return drv;
+}
+
+static int parse_funcname(struct userdiff_funcname *f, const char *k,
+		const char *v, int cflags)
+{
+	if (git_config_string(&f->pattern, k, v) < 0)
+		return -1;
+	f->cflags = cflags;
+	return 1;
+}
+
+static int parse_string(const char **d, const char *k, const char *v)
+{
+	if (git_config_string(d, k, v) < 0)
+		return -1;
+	return 1;
+}
+
+int userdiff_config_basic(const char *k, const char *v)
+{
+	struct userdiff_driver *drv;
+
+	if ((drv = parse_driver(k, v, "funcname")))
+		return parse_funcname(&drv->funcname, k, v, 0);
+	if ((drv = parse_driver(k, v, "xfuncname")))
+		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
+
+	return 0;
+}
+
+int userdiff_config_porcelain(const char *k, const char *v)
+{
+	struct userdiff_driver *drv;
+
+	if ((drv = parse_driver(k, v, "command")))
+		return parse_string(&drv->external, k, v);
+
+	return 0;
+}
+
+struct userdiff_driver *userdiff_find_by_name(const char *name) {
+	int len = strlen(name);
+	return userdiff_find_by_namelen(name, len);
+}
+
+struct userdiff_driver *userdiff_find_by_path(const char *path)
+{
+	static struct git_attr *attr;
+	struct git_attr_check check;
+
+	if (!attr)
+		attr = git_attr("diff", 4);
+	check.attr = attr;
+
+	if (!path)
+		return NULL;
+	if (git_checkattr(path, 1, &check))
+		return NULL;
+
+	if (ATTR_TRUE(check.value))
+		return &driver_true;
+	if (ATTR_FALSE(check.value))
+		return &driver_false;
+	if (ATTR_UNSET(check.value))
+		return NULL;
+	return userdiff_find_by_name(check.value);
+}
diff --git a/userdiff.h b/userdiff.h
new file mode 100644
index 0000000..c64c5f5
--- /dev/null
+++ b/userdiff.h
@@ -0,0 +1,23 @@
+#ifndef USERDIFF_H
+#define USERDIFF_H
+
+struct userdiff_funcname {
+	const char *pattern;
+	int cflags;
+};
+
+struct userdiff_driver {
+	const char *name;
+	const char *external;
+	struct userdiff_funcname funcname;
+};
+
+extern struct userdiff_driver *USERDIFF_ATTR_TRUE;
+extern struct userdiff_driver *USERDIFF_ATTR_FALSE;
+
+int userdiff_config_basic(const char *k, const char *v);
+int userdiff_config_porcelain(const char *k, const char *v);
+struct userdiff_driver *userdiff_find_by_name(const char *name);
+struct userdiff_driver *userdiff_find_by_path(const char *path);
+
+#endif /* USERDIFF */
-- 
1.6.0.2.639.g4d7f.dirty
