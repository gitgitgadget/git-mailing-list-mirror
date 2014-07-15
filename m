From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v9 4/4] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 16:32:59 -0700
Message-ID: <1405467179-16064-4-git-send-email-jacob.e.keller@intel.com>
References: <1405467179-16064-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:33:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CDt-0002u8-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934279AbaGOXdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:33:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:7335 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760390AbaGOXdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:33:08 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 15 Jul 2014 16:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,668,1400050800"; 
   d="scan'208";a="543903110"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2014 16:33:02 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1405467179-16064-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253623>

Add support for configuring default sort specification for git tags.
Command line option will override the configured value. Both methods use
the same syntax. Make use of (set/pop)_error_routine to temporarily
modify error reporting when parsing as a configuration option.

Cc: Jeff King <peff@peff.net>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/config.txt  |   5 ++
 Documentation/git-tag.txt |   5 +-
 builtin/tag.c             | 124 ++++++++++++++++++++++++++++------------------
 t/t7004-tag.sh            |  36 ++++++++++++++
 4 files changed, 120 insertions(+), 50 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1d718bdb9662..c55c22ab7be9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2354,6 +2354,11 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+tag.sort::
+	This variable controls the sort ordering of tags when displayed by
+	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
+	value of this variable will be used as the default.
+
 tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b424a1bc48bb..320908369f06 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -99,7 +99,9 @@ OPTIONS
 	Sort in a specific order. Supported type is "refname"
 	(lexicographic order), "version:refname" or "v:refname" (tag
 	names are treated as versions). Prepend "-" to reverse sort
-	order.
+	order. When this option is not given, the sort order defaults to the
+	value configured for the 'tag.sort' variable if it exists, or
+	lexicographic order otherwise. See linkgit:git-config[1].
 
 --column[=<options>]::
 --no-column::
@@ -317,6 +319,7 @@ include::date-formats.txt[]
 SEE ALSO
 --------
 linkgit:git-check-ref-format[1].
+linkgit:git-config[1].
 
 GIT
 ---
diff --git a/builtin/tag.c b/builtin/tag.c
index 7d82526e76be..091536c61eab 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -32,6 +32,8 @@ static const char * const git_tag_usage[] = {
 #define SORT_MASK       0x7fff
 #define REVERSE_SORT    0x8000
 
+static int tag_sort;
+
 struct tag_filter {
 	const char **patterns;
 	int lines;
@@ -346,9 +348,76 @@ static const char tag_template_nocleanup[] =
 	"Lines starting with '%c' will be kept; you may remove them"
 	" yourself if you want to.\n");
 
+static int parse_sort_string(const char *arg, int *sort)
+{
+	char *value, *separator, *type, *atom;
+	int flags = 0, function = 0, err = 0;
+
+	/* skip the '-' prefix for reverse sort order first */
+	if (skip_prefix(arg, "-", &arg))
+		flags |= REVERSE_SORT;
+
+	/* duplicate string so we can modify it in place */
+	value = xstrdup(arg);
+
+	/* determine the sort function and the sorting atom */
+	separator = strchr(value, ':');
+	if (separator) {
+		/* split the string at the separator with a NULL byte */
+		*separator = '\0';
+		type = value;
+		atom = separator + 1;
+	} else {
+		/* we have no separator, so assume the whole string is the * atom */
+		type = NULL;
+		atom = value;
+	}
+
+	if (type) {
+		if (!strcmp(type, "version") || !strcmp(type, "v"))
+			function = VERCMP_SORT;
+		else {
+			err = error(_("unsupported sort function '%s'"), type);
+			goto abort;
+		}
+
+	} else
+		function = STRCMP_SORT;
+
+	/* for now, only the refname is a valid atom */
+	if (atom && strcmp(atom, "refname")) {
+		err = error(_("unsupported sort specification '%s'"), atom);
+		goto abort;
+	}
+
+	*sort = (flags | function);
+
+abort:
+	free(value);
+	return err;
+}
+
+static void error_bad_sort_config(const char *err, va_list params)
+{
+	vreportf("warning: tag.sort has ", err, params);
+}
+
 static int git_tag_config(const char *var, const char *value, void *cb)
 {
-	int status = git_gpg_config(var, value, cb);
+	int status;
+
+	if (!strcmp(var, "tag.sort")) {
+		if (!value)
+			return config_error_nonbool(var);
+
+		push_error_routine(error_bad_sort_config);
+		parse_sort_string(value, &tag_sort);
+		pop_error_routine();
+
+		return 0;
+	}
+
+	status = git_gpg_config(var, value, cb);
 	if (status)
 		return status;
 	if (starts_with(var, "column."))
@@ -522,51 +591,8 @@ static int parse_opt_points_at(const struct option *opt __attribute__((unused)),
 static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
 {
 	int *sort = opt->value;
-	char *value, *separator, *type, *atom;
-	int flags = 0, function = 0, err = 0;
 
-	/* skip the '-' prefix for reverse sort order first */
-	if (skip_prefix(arg, "-", &arg))
-		flags |= REVERSE_SORT;
-
-	/* duplicate string so we can modify it in place */
-	value = xstrdup(arg);
-
-	/* determine the sort function and the sorting atom */
-	separator = strchr(value, ':');
-	if (separator) {
-		/* split the string at the separator with a NULL byte */
-		*separator = '\0';
-		type = value;
-		atom = separator + 1;
-	} else {
-		/* we have no separator, so assume the whole string is the * atom */
-		type = NULL;
-		atom = value;
-	}
-
-	if (type) {
-		if (!strcmp(type, "version") || !strcmp(type, "v"))
-			function = VERCMP_SORT;
-		else {
-			err = error(_("unsupported sort function '%s'"), type);
-			goto abort;
-		}
-
-	} else
-		function = STRCMP_SORT;
-
-	/* for now, only the refname is a valid atom */
-	if (atom && strcmp(atom, "refname")) {
-		err = error(_("unsupported sort specification '%s'"), atom);
-		goto abort;
-	}
-
-	*sort = (flags | function);
-
-abort:
-	free(value);
-	return err;
+	return parse_sort_string(arg, sort);
 }
 
 int cmd_tag(int argc, const char **argv, const char *prefix)
@@ -579,7 +605,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1;
-	int cmdmode = 0, sort = 0;
+	int cmdmode = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
@@ -605,7 +631,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT__FORCE(&force, N_("replace the tag if exists")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
 		{
-			OPTION_CALLBACK, 0, "sort", &sort, N_("type"), N_("sort tags"),
+			OPTION_CALLBACK, 0, "sort", &tag_sort, N_("type"), N_("sort tags"),
 			PARSE_OPT_NONEG, parse_opt_sort
 		},
 
@@ -661,9 +687,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			copts.padding = 2;
 			run_column_filter(colopts, &copts);
 		}
-		if (lines != -1 && sort)
+		if (lines != -1 && tag_sort)
 			die(_("--sort and -n are incompatible"));
-		ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit, sort);
+		ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit, tag_sort);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 66010b0e7066..036665308841 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1423,6 +1423,42 @@ test_expect_success 'reverse lexical sort' '
 	test_cmp expect actual
 '
 
+test_expect_success 'configured lexical sort' '
+	git config tag.sort "v:refname" &&
+	git tag -l "foo*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.3
+	foo1.6
+	foo1.10
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'option override configured sort' '
+	git tag -l --sort=-refname "foo*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.6
+	foo1.3
+	foo1.10
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'invalid sort parameter on command line' '
+	test_must_fail git tag -l --sort=notvalid "foo*" >actual
+'
+
+test_expect_success 'invalid sort parameter in configuratoin' '
+	git config tag.sort "v:notvalid" &&
+	git tag -l "foo*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.10
+	foo1.3
+	foo1.6
+	EOF
+	test_cmp expect actual
+'
+
 run_with_limited_stack () {
 	(ulimit -s 64 && "$@")
 }
-- 
2.0.1.475.g9b8d714
