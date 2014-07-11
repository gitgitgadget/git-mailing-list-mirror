From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 15:55:47 -0700
Message-ID: <1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 01:02:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5jpY-0001IK-MV
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 01:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbaGKXCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 19:02:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:12174 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003AbaGKXCD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 19:02:03 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 11 Jul 2014 16:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,646,1400050800"; 
   d="scan'208";a="560731931"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2014 15:55:51 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253346>

Add support for configuring default sort ordering for git tags. Command
line option will override this configured value, using the exact same
syntax.

Cc: Jeff King <peff@peff.net>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Made parse_sort_string take a "var" parameter, and if given will only warn
about invalid parameter, instead of error.

 Documentation/config.txt  |  5 ++++
 Documentation/git-tag.txt |  5 +++-
 builtin/tag.c             | 66 ++++++++++++++++++++++++++++++++++-------------
 t/t7004-tag.sh            | 36 ++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 19 deletions(-)

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
index 9d7643f127e7..97c5317c28e5 100644
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
@@ -346,9 +348,49 @@ static const char tag_template_nocleanup[] =
 	"Lines starting with '%c' will be kept; you may remove them"
 	" yourself if you want to.\n");
 
+/*
+ * Parse a sort string, and return 0 if parsed successfully. Will return
+ * non-zero when the sort string does not parse into a known type.
+ */
+static int parse_sort_string(const char *var, const char *value, int *sort)
+{
+	int type = 0, flags = 0;
+
+	if (skip_prefix(value, "-", &value))
+		flags |= REVERSE_SORT;
+
+	if (skip_prefix(value, "version:", &value) || skip_prefix(value, "v:", &value))
+		type = VERCMP_SORT;
+	else
+		type = STRCMP_SORT;
+
+	if (strcmp(value, "refname")) {
+		if (!var)
+			return error(_("unsupported sort specification '%s'"), value);
+		else {
+			warning(_("unsupported sort specification '%s' in variable '%s'"),
+				var, value);
+			return -1;
+		}
+	}
+
+	*sort = (type | flags);
+
+	return 0;
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
+		parse_sort_string(var, value, &tag_sort);
+		return 0;
+	}
+
+	status = git_gpg_config(var, value, cb);
 	if (status)
 		return status;
 	if (starts_with(var, "column."))
@@ -522,20 +564,8 @@ static int parse_opt_points_at(const struct option *opt __attribute__((unused)),
 static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
 {
 	int *sort = opt->value;
-	int flags = 0;
 
-	if (skip_prefix(arg, "-", &arg))
-		flags |= REVERSE_SORT;
-
-	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
-		*sort = VERCMP_SORT;
-	else
-		*sort = STRCMP_SORT;
-
-	if (strcmp(arg, "refname"))
-		die(_("unsupported sort specification %s"), arg);
-	*sort |= flags;
-	return 0;
+	return parse_sort_string(NULL, arg, sort);
 }
 
 int cmd_tag(int argc, const char **argv, const char *prefix)
@@ -548,7 +578,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1;
-	int cmdmode = 0, sort = 0;
+	int cmdmode = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
@@ -574,7 +604,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT__FORCE(&force, N_("replace the tag if exists")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
 		{
-			OPTION_CALLBACK, 0, "sort", &sort, N_("type"), N_("sort tags"),
+			OPTION_CALLBACK, 0, "sort", &tag_sort, N_("type"), N_("sort tags"),
 			PARSE_OPT_NONEG, parse_opt_sort
 		},
 
@@ -630,9 +660,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
