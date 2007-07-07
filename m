From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix configuration syntax to specify customized hunk header patterns.
Date: Sat, 07 Jul 2007 03:12:15 -0700
Message-ID: <7vhcog8qv4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
	<alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
	<7vejjnhpap.fsf@assigned-by-dhcp.cox.net>
	<7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
	<7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707051223520.9789@racer.site>
	<7v8x9uexji.fsf_-_@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0707061051020.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 07 12:12:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I77H4-0003eJ-AA
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 12:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbXGGKMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 06:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbXGGKMT
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 06:12:19 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:54372 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbXGGKMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 06:12:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707101217.OEVI1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Jul 2007 06:12:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LaCF1X00J1kojtg0000000; Sat, 07 Jul 2007 06:12:17 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51810>

This updates the hunk header customization syntax.  The special
case 'funcname' attribute is gone.  It also uses the name
'funcname" throughout, instead of "hunk_header".

You assign the name of the type of contents to path's "diff"
attribute as a string value in .gitattributes like this:

	*.java diff=java
	*.perl diff=perl
	*.doc diff=doc

If you supply "diff.<name>.funcname" variable via the
configuration mechanism (e.g. in $HOME/.gitconfig), the value is
used as the regexp set to find the line to use for the hunk
header (the variable is called "funcname" because such a line
typically is the one that has the name of the function in
programming language source text).

If there is no such configuration, built-in default is used, if
any.  Currently there are two default patterns: default and java.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                   |  147 +++++++++++++++++++++++++---------------------
 diffcore.h               |    2 +-
 t/t4018-diff-funcname.sh |    6 +-
 3 files changed, 84 insertions(+), 71 deletions(-)

diff --git a/diff.c b/diff.c
index 04e7e91..21e61af 100644
--- a/diff.c
+++ b/diff.c
@@ -56,6 +56,14 @@ static struct ll_diff_driver {
 	char *cmd;
 } *user_diff, **user_diff_tail;
 
+static void read_config_if_needed(void)
+{
+	if (!user_diff_tail) {
+		user_diff_tail = &user_diff;
+		git_config(git_diff_ui_config);
+	}
+}
+
 /*
  * Currently there is only "diff.<drivername>.command" variable;
  * because there are "diff.color.<slot>" variables, we are parsing
@@ -94,6 +102,45 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
 }
 
 /*
+ * 'diff.<what>.funcname' attribute can be specified in the configuration
+ * to define a customized regexp to find the beginning of a function to
+ * be used for hunk header lines of "diff -p" style output.
+ */
+static struct funcname_pattern {
+	char *name;
+	char *pattern;
+	struct funcname_pattern *next;
+} *funcname_pattern_list;
+
+static int parse_funcname_pattern(const char *var, const char *ep, const char *value)
+{
+	const char *name;
+	int namelen;
+	struct funcname_pattern *pp;
+
+	name = var + 5; /* "diff." */
+	namelen = ep - name;
+
+	for (pp = funcname_pattern_list; pp; pp = pp->next)
+		if (!strncmp(pp->name, name, namelen) && !pp->name[namelen])
+			break;
+	if (!pp) {
+		char *namebuf;
+		pp = xcalloc(1, sizeof(*pp));
+		namebuf = xmalloc(namelen + 1);
+		memcpy(namebuf, name, namelen);
+		namebuf[namelen] = 0;
+		pp->name = namebuf;
+		pp->next = funcname_pattern_list;
+		funcname_pattern_list = pp;
+	}
+	if (pp->pattern)
+		free(pp->pattern);
+	pp->pattern = xstrdup(value);
+	return 0;
+}
+
+/*
  * These are to give UI layer defaults.
  * The core-level commands such as git-diff-files should
  * never be affected by the setting of diff.renames
@@ -122,8 +169,12 @@ int git_diff_ui_config(const char *var, const char *value)
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep = strrchr(var, '.');
 
-		if (ep != var + 4 && !strcmp(ep, ".command"))
-			return parse_lldiff_command(var, ep, value);
+		if (ep != var + 4) {
+			if (!strcmp(ep, ".command"))
+				return parse_lldiff_command(var, ep, value);
+			if (!strcmp(ep, ".funcname"))
+				return parse_funcname_pattern(var, ep, value);
+		}
 	}
 	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff.")) {
 		int slot = parse_diff_color_slot(var, 11);
@@ -1101,43 +1152,39 @@ static void emit_binary_diff(mmfile_t *one, mmfile_t *two)
 static void setup_diff_attr_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_diff;
-	static struct git_attr *attr_diff_func_name;
 
 	if (!attr_diff) {
 		attr_diff = git_attr("diff", 4);
-		attr_diff_func_name = git_attr("funcname", 8);
 	}
 	check[0].attr = attr_diff;
-	check[1].attr = attr_diff_func_name;
 }
 
 static void diff_filespec_check_attr(struct diff_filespec *one)
 {
-	struct git_attr_check attr_diff_check[2];
+	struct git_attr_check attr_diff_check;
 
 	if (one->checked_attr)
 		return;
 
-	setup_diff_attr_check(attr_diff_check);
+	setup_diff_attr_check(&attr_diff_check);
 	one->is_binary = 0;
-	one->hunk_header_ident = NULL;
+	one->funcname_pattern_ident = NULL;
 
-	if (!git_checkattr(one->path, ARRAY_SIZE(attr_diff_check), attr_diff_check)) {
+	if (!git_checkattr(one->path, 1, &attr_diff_check)) {
 		const char *value;
 
 		/* binaryness */
-		value = attr_diff_check[0].value;
+		value = attr_diff_check.value;
 		if (ATTR_TRUE(value))
 			;
 		else if (ATTR_FALSE(value))
 			one->is_binary = 1;
 
-		/* hunk header ident */
-		value = attr_diff_check[1].value;
+		/* funcname pattern ident */
 		if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value))
 			;
 		else
-			one->hunk_header_ident = value;
+			one->funcname_pattern_ident = value;
 	}
 
 	if (!one->data && DIFF_FILE_VALID(one))
@@ -1154,54 +1201,23 @@ int diff_filespec_is_binary(struct diff_filespec *one)
 	return one->is_binary;
 }
 
-static struct hunk_header_regexp {
-	char *name;
-	char *regexp;
-	struct hunk_header_regexp *next;
-} *hunk_header_regexp_list, **hunk_header_regexp_tail;
-
-static int hunk_header_config(const char *var, const char *value)
+static const char *funcname_pattern(const char *ident)
 {
-	static const char funcname[] = "funcname.";
-	struct hunk_header_regexp *hh;
+	struct funcname_pattern *pp;
 
-	if (prefixcmp(var, funcname))
-		return 0;
-	var += strlen(funcname);
-	for (hh = hunk_header_regexp_list; hh; hh = hh->next)
-		if (!strcmp(var, hh->name)) {
-			free(hh->regexp);
-			hh->regexp = xstrdup(value);
-			return 0;
-		}
-	hh = xcalloc(1, sizeof(*hh));
-	hh->name = xstrdup(var);
-	hh->regexp = xstrdup(value);
-	hh->next = NULL;
-	*hunk_header_regexp_tail = hh;
-	return 0;
-}
-
-static const char *hunk_header_regexp(const char *ident)
-{
-	struct hunk_header_regexp *hh;
-
-	if (!hunk_header_regexp_tail) {
-		hunk_header_regexp_tail = &hunk_header_regexp_list;
-		git_config(hunk_header_config);
-	}
-	for (hh = hunk_header_regexp_list; hh; hh = hh->next)
-		if (!strcmp(ident, hh->name))
-			return hh->regexp;
+	read_config_if_needed();
+	for (pp = funcname_pattern_list; pp; pp = pp->next)
+		if (!strcmp(ident, pp->name))
+			return pp->pattern;
 	return NULL;
 }
 
-static const char *diff_hunk_header_regexp(struct diff_filespec *one)
+static const char *diff_funcname_pattern(struct diff_filespec *one)
 {
-	const char *ident, *regexp;
+	const char *ident, *pattern;
 
 	diff_filespec_check_attr(one);
-	ident = one->hunk_header_ident;
+	ident = one->funcname_pattern_ident;
 
 	if (!ident)
 		/*
@@ -1209,12 +1225,12 @@ static const char *diff_hunk_header_regexp(struct diff_filespec *one)
 		 * regexp is used; otherwise NULL is returned and xemit uses
 		 * the built-in default.
 		 */
-		return hunk_header_regexp("default");
+		return funcname_pattern("default");
 
 	/* Look up custom "funcname.$ident" regexp from config. */
-	regexp = hunk_header_regexp(ident);
-	if (regexp)
-		return regexp;
+	pattern = funcname_pattern(ident);
+	if (pattern)
+		return pattern;
 
 	/*
 	 * And define built-in fallback patterns here.  Note that
@@ -1304,11 +1320,11 @@ static void builtin_diff(const char *name_a,
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
 		struct emit_callback ecbdata;
-		const char *hunk_header_regexp;
+		const char *funcname_pattern;
 
-		hunk_header_regexp = diff_hunk_header_regexp(one);
-		if (!hunk_header_regexp)
-			hunk_header_regexp = diff_hunk_header_regexp(two);
+		funcname_pattern = diff_funcname_pattern(one);
+		if (!funcname_pattern)
+			funcname_pattern = diff_funcname_pattern(two);
 
 		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
@@ -1318,8 +1334,8 @@ static void builtin_diff(const char *name_a,
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
-		if (hunk_header_regexp)
-			xdiff_set_find_func(&xecfg, hunk_header_regexp);
+		if (funcname_pattern)
+			xdiff_set_find_func(&xecfg, funcname_pattern);
 		if (!diffopts)
 			;
 		else if (!prefixcmp(diffopts, "--unified="))
@@ -1862,10 +1878,7 @@ static const char *external_diff_attr(const char *name)
 		    !ATTR_UNSET(value)) {
 			struct ll_diff_driver *drv;
 
-			if (!user_diff_tail) {
-				user_diff_tail = &user_diff;
-				git_config(git_diff_ui_config);
-			}
+			read_config_if_needed();
 			for (drv = user_diff; drv; drv = drv->next)
 				if (!strcmp(drv->name, value))
 					return drv->cmd;
diff --git a/diffcore.h b/diffcore.h
index 0598514..eef17c4 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -27,7 +27,7 @@ struct diff_filespec {
 	char *path;
 	void *data;
 	void *cnt_data;
-	const void *hunk_header_ident;
+	const char *funcname_pattern_ident;
 	unsigned long size;
 	int xfrm_flags;		 /* for use by the xfrm */
 	unsigned short mode;	 /* file mode */
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index dc7a47b..f9db81d 100644
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -38,12 +38,12 @@ test_expect_success 'default behaviour' '
 '
 
 test_expect_success 'preset java pattern' '
-	echo "*.java funcname=java" >.gitattributes &&
+	echo "*.java diff=java" >.gitattributes &&
 	git diff Beer.java Beer-correct.java |
 	grep "^@@.*@@ public static void main("
 '
 
-git config funcname.java '!static
+git config diff.java.funcname '!static
 !String
 [^ 	].*s.*'
 
@@ -53,7 +53,7 @@ test_expect_success 'custom pattern' '
 '
 
 test_expect_success 'last regexp must not be negated' '
-	git config diff.functionnameregexp "!static" &&
+	git config diff.java.funcname "!static" &&
 	! git diff Beer.java Beer-correct.java
 '
 
-- 
1.5.3.rc0.837.g4574c
