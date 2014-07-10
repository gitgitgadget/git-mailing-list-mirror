From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 2/2 v4] tag: support configuring --sort via .gitconfig
Date: Thu, 10 Jul 2014 16:52:14 -0700
Message-ID: <1405036334-8093-2-git-send-email-jacob.e.keller@intel.com>
References: <1405036334-8093-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 01:52:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5O8c-0003XZ-MF
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 01:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbaGJXwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 19:52:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:33133 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbaGJXwX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 19:52:23 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 10 Jul 2014 16:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,640,1400050800"; 
   d="scan'208,217";a="568199084"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2014 16:52:16 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1405036334-8093-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253236>

Add support for configuring default sort ordering for git tags. Command
line option will override this configured value, using the exact same
syntax.

Cc: Jeff King <peff@peff.net>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
- v4
* base on top of suggested change by Jeff King to use skip_prefix instead

 Documentation/config.txt  |  6 ++++++
 Documentation/git-tag.txt |  1 +
 builtin/tag.c             | 46 ++++++++++++++++++++++++++++++++--------------
 t/t7004-tag.sh            | 21 +++++++++++++++++++++
 4 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1d718bdb9662..ad8e75fed988 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2354,6 +2354,12 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+tag.sort::
+	This variable is used to control the sort ordering of tags. It is
+	interpreted precisely the same way as "--sort=<value>". If --sort is
+	given on the command line it will override the selection chosen in the
+	configuration. See linkgit:git-tag[1] for more details.
+
 tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b424a1bc48bb..2d246725aeb5 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -317,6 +317,7 @@ include::date-formats.txt[]
 SEE ALSO
 --------
 linkgit:git-check-ref-format[1].
+linkgit:git-config[1].
 
 GIT
 ---
diff --git a/builtin/tag.c b/builtin/tag.c
index 7ccb6f3c581b..a53e27d4e7e4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -18,6 +18,8 @@
 #include "sha1-array.h"
 #include "column.h"
 
+static int tag_sort = 0;
+
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
@@ -346,9 +348,33 @@ static const char tag_template_nocleanup[] =
 	"Lines starting with '%c' will be kept; you may remove them"
 	" yourself if you want to.\n");
 
+static int parse_sort_string(const char *arg)
+{
+	int sort = 0;
+	int flags = 0;
+
+	if (skip_prefix(arg, "-", &arg))
+		flags |= REVERSE_SORT;
+
+	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
+		sort = VERCMP_SORT;
+
+	if (strcmp(arg, "refname"))
+		die(_("unsupported sort specification %s"), arg);
+	sort |= flags;
+
+	return sort;
+}
+
 static int git_tag_config(const char *var, const char *value, void *cb)
 {
-	int status = git_gpg_config(var, value, cb);
+	int status;
+
+	if (!strcmp(var, "tag.sort")) {
+		tag_sort = parse_sort_string(value);
+	}
+
+	status = git_gpg_config(var, value, cb);
 	if (status)
 		return status;
 	if (starts_with(var, "column."))
@@ -522,17 +548,9 @@ static int parse_opt_points_at(const struct option *opt __attribute__((unused)),
 static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
 {
 	int *sort = opt->value;
-	int flags = 0;
 
-	if (skip_prefix(arg, "-", &arg))
-		flags |= REVERSE_SORT;
+	*sort = parse_sort_string(arg);
 
-	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
-		*sort = VERCMP_SORT;
-
-	if (strcmp(arg, "refname"))
-		die(_("unsupported sort specification %s"), arg);
-	*sort |= flags;
 	return 0;
 }
 
@@ -546,7 +564,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1;
-	int cmdmode = 0, sort = 0;
+	int cmdmode = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
@@ -572,7 +590,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT__FORCE(&force, N_("replace the tag if exists")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
 		{
-			OPTION_CALLBACK, 0, "sort", &sort, N_("type"), N_("sort tags"),
+			OPTION_CALLBACK, 0, "sort", &tag_sort, N_("type"), N_("sort tags"),
 			PARSE_OPT_NONEG, parse_opt_sort
 		},
 
@@ -628,9 +646,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
index e4ab0f5b6419..1e8300f6ed7c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1423,6 +1423,27 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'configured lexical sort' '
+	git config tag.sort "v:refname" &&
+	git tag -l "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.3
+foo1.6
+foo1.10
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'option override configured sort' '
+	git tag -l --sort=-refname "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.6
+foo1.3
+foo1.10
+EOF
+	test_cmp expect actual
+'
+
 run_with_limited_stack () {
 	(ulimit -s 64 && "$@")
 }
-- 
2.0.1.475.g9b8d714
