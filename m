From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] tag: teach -n to override tag.sort configuration
Date: Wed, 26 Aug 2015 14:15:00 -0700
Message-ID: <1440623700-29324-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 26 23:15:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUi2I-0003XR-VX
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 23:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbbHZVPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 17:15:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:57172 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbbHZVPC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 17:15:02 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP; 26 Aug 2015 14:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,418,1437462000"; 
   d="scan'208";a="632848842"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.123])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2015 14:15:02 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276639>

From: Jacob Keller <jacob.keller@gmail.com>

git tag -n will always fail if tag.sort is set to a sort other than the
default "refname" setting. Teach git tag to have -n override the
configuration setting when -n is used, instead of failing with

fatal: --sort and -n incompatible

since the user probably sets tag.sort once as a default and would expect
-n to override this setting.

As a consequence, -n and --sort will always be incompatible now, even if
the --sort is "--sort=refname" which is essentially a no-op and
previously was acceptable. No sane user should be doing such.

Add a test to document that --sort and -n are incompatible. Add a
further test to show that tag.sort should be ignored if -n is
configured.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

I wasn't sure who to Cc for this, since I wrote the tag.sort code.
Noticed this when I tried to use -n option, and it kept failing. Maybe
this isn't the best way to implement this. I could replace how we read
tag.sort and grab it using git_config_get_string or something after we
parse the command line options. But this seemed like the easiest way.

 builtin/tag.c  | 11 +++++++++--
 t/t7004-tag.sh | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 471d6b1ab884..83f94bd7f833 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -33,6 +33,7 @@ static const char * const git_tag_usage[] = {
 #define REVERSE_SORT    0x8000
 
 static int tag_sort;
+static int cmd_line_sort = 0;
 
 struct tag_filter {
 	const char **patterns;
@@ -559,6 +560,8 @@ static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
 {
 	int *sort = opt->value;
 
+	cmd_line_sort = 1;
+
 	return parse_sort_string(NULL, arg, sort);
 }
 
@@ -647,8 +650,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			copts.padding = 2;
 			run_column_filter(colopts, &copts);
 		}
-		if (lines != -1 && tag_sort)
-			die(_("--sort and -n are incompatible"));
+		if (lines != -1) {
+			if (cmd_line_sort)
+				die(_("--sort and -n are incompatible"));
+			else
+				tag_sort = 0;
+		}
 		ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit, tag_sort);
 		if (column_active(colopts))
 			stop_column_filter();
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index d31788cc6ce6..92a8f1b4670c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1392,6 +1392,21 @@ test_expect_success 'multiple --points-at are OR-ed together' '
 	test_cmp expect actual
 '
 
+test_expect_success 'listing tag with -n --sort=<sort> should fail' '
+	test_must_fail git tag --sort=refname -n
+'
+
+test_expect_success 'listing tag with -n and tag.sort must not fail' '
+	echo "tag-one-line    A msg" >expect &&
+	git -c tag.sort="v:refname" tag -n1 -l | grep "^tag-one-line" >actual &&
+	test_cmp expect actual &&
+	echo "tag-lines       tag line one" >expect &&
+	echo "    tag line two" >>expect &&
+	echo "    tag line three" >>expect &&
+	git -c tag.sort="v:refname" tag -n3 -l | grep "^ *tag.line" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'lexical sort' '
 	git tag foo1.3 &&
 	git tag foo1.6 &&
-- 
2.5.0.280.g4aaba03
