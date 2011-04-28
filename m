From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 3/7] Refactor --dirstat parsing; deprecate --cumulative and
 --dirstat-by-file
Date: Thu, 28 Apr 2011 03:17:18 +0200
Message-ID: <1303953442-26536-4-git-send-email-johan@herland.net>
References: <1303892653-3958-1-git-send-email-johan@herland.net>
 <1303953442-26536-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 03:17:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFFrf-0005BT-37
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 03:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758187Ab1D1BRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 21:17:32 -0400
Received: from smtp.getmail.no ([84.208.15.66]:46644 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab1D1BR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 21:17:29 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKC00GN48X2P940@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Apr 2011 03:17:26 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 505DE1EA591E_DB8C026B	for <git@vger.kernel.org>; Thu,
 28 Apr 2011 01:17:26 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 5E7EF1EA3908_DB8C025F	for <git@vger.kernel.org>; Thu,
 28 Apr 2011 01:17:25 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKC0058L8X0LO10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Apr 2011 03:17:25 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1303953442-26536-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172304>

Instead of having multiple interconnected dirstat-related options, teach
the --dirstat option itself to accept all behavior modifiers as parameters.

 - Preserve the current --dirstat=<limit> (where <limit> is an integer
   specifying a cut-off percentage)
 - Add --dirstat=cumulative, replacing --cumulative
 - Add --dirstat=files, replacing --dirstat-by-file
 - Also add --dirstat=changes and --dirstat=noncumulative for specifying the
   current default behavior. These allow the user to reset other --dirstat
   parameters (e.g. 'cumulative' and 'files') occuring earlier on the
   command line.

The deprecated options (--cumulative and --dirstat-by-file) are still
functional, although they have been removed from the documentation.

Allow multiple parameters to be separated by commas, e.g.:
  --dirstat=files,10,cumulative

Update the documentation accordingly, and add testcases verifying the
behavior of the new syntax.

Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/diff-options.txt |   44 +++++++++++----
 diff.c                         |   69 ++++++++++++++++++++---
 t/t4047-diff-dirstat.sh        |  119 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+), 21 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7e4bd42..6a3a9c1 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -66,19 +66,39 @@ endif::git-format-patch[]
 	number of modified files, as well as number of added and deleted
 	lines.
 
---dirstat[=<limit>]::
-	Output the distribution of relative amount of changes (number of lines added or
-	removed) for each sub-directory. Directories with changes below
-	a cut-off percent (3% by default) are not shown. The cut-off percent
-	can be set with `--dirstat=<limit>`. Changes in a child directory are not
-	counted for the parent directory, unless `--cumulative` is used.
+--dirstat[=<param1,param2,...>]::
+	Output the distribution of relative amount of changes for each
+	sub-directory. The behavior of `--dirstat` can be customized by
+	passing it a comma separated list of parameters.
+	The following parameters are available:
 +
-Note that the `--dirstat` option computes the changes while ignoring
-the amount of pure code movements within a file.  In other words,
-rearranging lines in a file is not counted as much as other changes.
-
---dirstat-by-file[=<limit>]::
-	Same as `--dirstat`, but counts changed files instead of lines.
+--
+`changes`;;
+	Compute the dirstat numbers by counting the lines that have been
+	removed from the source, or added to the destination. This ignores
+	the amount of pure code movements within a file.  In other words,
+	rearranging lines in a file is not counted as much as other changes.
+	This is the default behavior when no parameter is given.
+`files`;;
+	Compute the dirstat numbers by counting the number of files changed.
+	Each changed file counts equally in the dirstat analysis. This is
+	the computationally cheapest `--dirstat` behavior, since it does
+	not have to look at the file contents at all.
+`cumulative`;;
+	Count changes in a child directory for the parent directory as well.
+	Note that when using `cumulative`, the sum of the percentages
+	reported may exceed 100%. The default (non-cumulative) behavior can
+	be specified with the `noncumulative` parameter.
+<limit>;;
+	An integer parameter specifies a cut-off percent (3% by default).
+	Directories contributing less than this percentage of the changes
+	are not shown in the output.
+--
++
+Example: The following will count changed files, while ignoring
+directories with less than 10% of the total amount of changed files,
+and accumulating child directory counts in the parent directories:
+`--dirstat=files,10,cumulative`.
 
 --summary::
 	Output a condensed summary of extended header information
diff --git a/diff.c b/diff.c
index cfbfa92..0e4a510 100644
--- a/diff.c
+++ b/diff.c
@@ -66,6 +66,41 @@ static int parse_diff_color_slot(const char *var, int ofs)
 	return -1;
 }
 
+static int parse_dirstat_params(struct diff_options *options, const char *params)
+{
+	const char *p = params;
+	while (*p) {
+		if (!prefixcmp(p, "changes")) {
+			p += 7;
+			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
+		} else if (!prefixcmp(p, "files")) {
+			p += 5;
+			DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
+		} else if (!prefixcmp(p, "noncumulative")) {
+			p += 13;
+			DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
+		} else if (!prefixcmp(p, "cumulative")) {
+			p += 10;
+			DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
+		} else if (isdigit(*p)) {
+			char *end;
+			options->dirstat_percent = strtoul(p, &end, 10);
+			p = end;
+		} else
+			return error("Unknown --dirstat parameter '%s'", p);
+
+		if (*p) {
+			/* more parameters, swallow separator */
+			if (*p != ',')
+				return error("Missing comma separator at char "
+					"%"PRIuMAX" of '%s'",
+					(uintmax_t) (p - params), params);
+			p++;
+		}
+	}
+	return 0;
+}
+
 static int git_config_rename(const char *var, const char *value)
 {
 	if (!value)
@@ -3144,6 +3179,18 @@ static int stat_opt(struct diff_options *options, const char **av)
 	return argcount;
 }
 
+static int parse_dirstat_opt(struct diff_options *options, const char *params)
+{
+	if (parse_dirstat_params(options, params))
+		die("Failed to parse --dirstat/-X option parameter");
+	/*
+	 * The caller knows a dirstat-related option is given from the command
+	 * line; allow it to say "return this_function();"
+	 */
+	options->output_format |= DIFF_FORMAT_DIRSTAT;
+	return 1;
+}
+
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
@@ -3163,15 +3210,19 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-	else if (opt_arg(arg, 'X', "dirstat", &options->dirstat_percent))
-		options->output_format |= DIFF_FORMAT_DIRSTAT;
-	else if (!strcmp(arg, "--cumulative")) {
-		options->output_format |= DIFF_FORMAT_DIRSTAT;
-		DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
-	} else if (opt_arg(arg, 0, "dirstat-by-file",
-			   &options->dirstat_percent)) {
-		options->output_format |= DIFF_FORMAT_DIRSTAT;
-		DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
+	else if (!strcmp(arg, "-X") || !strcmp(arg, "--dirstat"))
+		return parse_dirstat_opt(options, "");
+	else if (!prefixcmp(arg, "-X"))
+		return parse_dirstat_opt(options, arg + 2);
+	else if (!prefixcmp(arg, "--dirstat="))
+		return parse_dirstat_opt(options, arg + 10);
+	else if (!strcmp(arg, "--cumulative"))
+		return parse_dirstat_opt(options, "cumulative");
+	else if (!strcmp(arg, "--dirstat-by-file"))
+		return parse_dirstat_opt(options, "files");
+	else if (!prefixcmp(arg, "--dirstat-by-file=")) {
+		parse_dirstat_opt(options, "files");
+		return parse_dirstat_opt(options, arg + 18);
 	}
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 6ff7f9f..0ede619 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -346,6 +346,39 @@ test_expect_success 'vanilla -X' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success 'explicit defaults: --dirstat=changes,noncumulative,3' '
+	git diff --dirstat=changes,noncumulative,3 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=changes,noncumulative,3 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=changes,noncumulative,3 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success 'explicit defaults: -Xchanges,noncumulative,3' '
+	git diff -Xchanges,noncumulative,3 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff -Xchanges,noncumulative,3 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff -Xchanges,noncumulative,3 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success 'later options override earlier options:' '
+	git diff --dirstat=files,10,cumulative,changes,noncumulative,3 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=files,10,cumulative,changes,noncumulative,3 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=files,10,cumulative,changes,noncumulative,3 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+	git diff --dirstat=files --dirstat=10 --dirstat=cumulative --dirstat=changes --dirstat=noncumulative -X3 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=files --dirstat=10 --dirstat=cumulative --dirstat=changes --dirstat=noncumulative -X3 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=files --dirstat=10 --dirstat=cumulative --dirstat=changes --dirstat=noncumulative -X3 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
    2.1% changed/
   10.8% dst/copy/changed/
@@ -449,6 +482,24 @@ test_expect_success '--dirstat=0 --cumulative' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success '--dirstat=0,cumulative' '
+	git diff --dirstat=0,cumulative HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=0,cumulative -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=0,cumulative -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success '-X0,cumulative' '
+	git diff -X0,cumulative HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff -X0,cumulative -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff -X0,cumulative -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
    9.0% changed/
    9.0% dst/copy/changed/
@@ -491,6 +542,15 @@ test_expect_success '--dirstat-by-file' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success '--dirstat=files' '
+	git diff --dirstat=files HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=files -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=files -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
   27.2% dst/copy/
   27.2% dst/move/
@@ -525,6 +585,15 @@ test_expect_success '--dirstat-by-file=10' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success '--dirstat=files,10' '
+	git diff --dirstat=files,10 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=files,10 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=files,10 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
    9.0% changed/
    9.0% dst/copy/changed/
@@ -577,4 +646,54 @@ test_expect_success '--dirstat-by-file --cumulative' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success '--dirstat=files,cumulative' '
+	git diff --dirstat=files,cumulative HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=files,cumulative -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=files,cumulative -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+cat <<EOF >expect_diff_dirstat
+  27.2% dst/copy/
+  27.2% dst/move/
+  54.5% dst/
+  27.2% src/move/
+EOF
+
+cat <<EOF >expect_diff_dirstat_M
+  14.2% changed/
+  14.2% dst/copy/changed/
+  14.2% dst/copy/rearranged/
+  14.2% dst/copy/unchanged/
+  42.8% dst/copy/
+  14.2% dst/move/changed/
+  14.2% dst/move/rearranged/
+  28.5% dst/move/
+  71.4% dst/
+  14.2% rearranged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_CC
+  16.6% changed/
+  16.6% dst/copy/changed/
+  16.6% dst/copy/rearranged/
+  33.3% dst/copy/
+  16.6% dst/move/changed/
+  16.6% dst/move/rearranged/
+  33.3% dst/move/
+  66.6% dst/
+  16.6% rearranged/
+EOF
+
+test_expect_success '--dirstat=files,cumulative,10' '
+	git diff --dirstat=files,cumulative,10 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=files,cumulative,10 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=files,cumulative,10 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 test_done
-- 
1.7.5.rc1.3.g4d7b
