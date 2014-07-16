From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v10] tag: support configuring --sort via .gitconfig
Date: Wed, 16 Jul 2014 14:48:02 -0700
Message-ID: <1405547282-19815-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 23:48:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7X3a-0007yd-Ue
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 23:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbaGPVsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 17:48:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:22439 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805AbaGPVsF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 17:48:05 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 16 Jul 2014 14:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,673,1400050800"; 
   d="scan'208";a="570946790"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2014 14:48:03 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253695>

Add support for configuring default sort ordering for git tags. Command
line option will override this configured value, using the exact same
syntax.

Cc: Jeff King <peff@peff.net>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Based on what's in Junio's tree, this patch includes some minor changes to fix
up other non-error reporting changes included in previous versions. The other
patches in his tree already match so we can leave them as they are.

 Documentation/config.txt  |  5 ++++ 
 Documentation/git-tag.txt |  5 +++-
 builtin/tag.c             | 68 ++++++++++++++++++++++++++++++++++-------------
 t/t7004-tag.sh            | 36 +++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 19 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9f467d3820a4..9d4f249606b3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2351,6 +2351,11 @@ submodule.<name>.ignore::
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
index 1101c19596c5..e063035515d9 100644
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
@@ -346,9 +348,51 @@ static const char tag_template_nocleanup[] =
 	"Lines starting with '%c' will be kept; you may remove them"
 	" yourself if you want to.\n");
 
+/*
+ * Parse a sort string, and return 0 if parsed successfully. Will return
+ * non-zero when the sort string does not parse into a known type. If var is
+ * given, the error message becomes a warning and includes information about
+ * the configuration value.
+ */
+static int parse_sort_string(const char *var, const char *arg, int *sort)
+{
+	int type = 0, flags = 0;
+
+	if (skip_prefix(arg, "-", &arg))
+		flags |= REVERSE_SORT;
+
+	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
+		type = VERCMP_SORT;
+	else
+		type = STRCMP_SORT;
+
+	if (strcmp(arg, "refname")) {
+		if (!var)
+			return error(_("unsupported sort specification '%s'"), arg);
+		else {
+			warning(_("unsupported sort specification '%s' in variable '%s'"),
+				var, arg);
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
@@ -522,20 +566,8 @@ static int parse_opt_points_at(const struct option *opt __attribute__((unused)),
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
@@ -548,7 +580,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1;
-	int cmdmode = 0, sort = 0;
+	int cmdmode = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
@@ -574,7 +606,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT__FORCE(&force, N_("replace the tag if exists")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
 		{
-			OPTION_CALLBACK, 0, "sort", &sort, N_("type"), N_("sort tags"),
+			OPTION_CALLBACK, 0, "sort", &tag_sort, N_("type"), N_("sort tags"),
 			PARSE_OPT_NONEG, parse_opt_sort
 		},
 
@@ -630,9 +662,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
