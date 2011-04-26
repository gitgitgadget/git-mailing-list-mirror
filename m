From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/6] Add config variable for specifying default --dirstat
 behavior
Date: Tue, 26 Apr 2011 02:01:40 +0200
Message-ID: <1303776102-9085-5-git-send-email-johan@herland.net>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 02:02:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEVjK-0006sD-Ow
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 02:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428Ab1DZACJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 20:02:09 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53577 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932348Ab1DZACF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 20:02:05 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LK800249G3D6S30@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Apr 2011 02:02:01 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 2F7571EEFB10_DB60B79B	for <git@vger.kernel.org>; Tue,
 26 Apr 2011 00:02:01 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 69A841EEFA70_DB60B78F	for <git@vger.kernel.org>; Tue,
 26 Apr 2011 00:02:00 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LK8006GDG35AA10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Apr 2011 02:02:00 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1303776102-9085-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172056>

The new diff.dirstat config variable takes the same arguments as
'--dirstat=<args>', and specifies the default arguments for --dirstat.
The config is obviously overridden by --dirstat arguments passed on the
command line.

When not specified, the --dirstat defaults are 'changes,noncumulative,3'.

The parsing of the config variable is done by the new function -
dirstat_opt_args() - which has been refactored out of dirstat_opt().

The patch also adds several tests verifying the interaction between the
diff.dirstat config variable, and the --dirstat command line option.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/config.txt |   36 +++++++++++++++
 diff.c                   |  110 ++++++++++++++++++++++++++++-----------------
 t/t4046-diff-dirstat.sh  |   72 ++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 42 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6babbc7..10fa89a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -822,6 +822,42 @@ diff.autorefreshindex::
 	affects only 'git diff' Porcelain, and not lower level
 	'diff' commands such as 'git diff-files'.
 
+diff.dirstat::
+	A comma separated list of `--dirstat` arguments specifying the
+	default behavior of the `--dirstat` option to linkgit:git-diff[1]`
+	and friends. The defaults can be overridden on the command line
+	(using `--dirstat=<arg1,arg2,...>`). The fallback defaults (when
+	not changed by `diff.dirstat`) are `changes,noncumulative,3`.
+	The following arguments are available:
++
+--
+`changes`;;
+	Compute the dirstat numbers by counting the lines that have been
+	removed from the source, or added to the destination. This ignores
+	the amount of pure code movements within a file.  In other words,
+	rearranging lines in a file is not counted as much as other changes.
+	This is the default `--dirstat` behavior.
+`files`;;
+	Compute the dirstat numbers by counting the number of files changed.
+	Each changed file counts equally in the dirstat analysis. This is
+	the computationally cheapest `--dirstat` behavior, since it does
+	not look at the file contents at all.
+`cumulative`;;
+	Count changes in a child directory for the parent directory as well.
+	Note that when using `cumulative`, the sum of the percentages
+	reported may exceed 100%. The default (non-cumulative) behavior can
+	be specified with the `noncumulative` argument.
+<limit>;;
+	An integer argument specifies a cut-off percent (3% by default).
+	Directories contributing less than this percentage of the changes
+	are not shown in the output.
+--
++
+Example: The following will count changed files, while ignoring
+directories with less than 10% of the total amount of changed files,
+and accumulating child directory counts in the parent directories:
+`files,10,cumulative`.
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/diff.c b/diff.c
index 08aaa47..20fe02c 100644
--- a/diff.c
+++ b/diff.c
@@ -45,6 +45,17 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
 };
 
+static void init_default_diff_options()
+{
+	static int initialized = 0;
+	if (initialized)
+		return;
+
+	default_diff_options.dirstat_percent = 3;
+
+	initialized = 1;
+}
+
 static int parse_diff_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
@@ -114,6 +125,44 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	return git_diff_basic_config(var, value, cb);
 }
 
+static void dirstat_opt_args(struct diff_options *options, const char *args)
+{
+	const char *p = args;
+	while (*p) {
+		if (!prefixcmp(p, "changes")) {
+			p += 7;
+			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
+		}
+		else if (!prefixcmp(p, "files")) {
+			p += 5;
+			DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
+		}
+		else if (!prefixcmp(p, "noncumulative")) {
+			p += 13;
+			DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
+		}
+		else if (!prefixcmp(p, "cumulative")) {
+			p += 10;
+			DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
+		}
+		else if (isdigit(*p)) {
+			char *end;
+			options->dirstat_percent = strtoul(p, &end, 10);
+			assert(end > p);
+			p = end;
+		}
+		else
+			die("Unknown --dirstat argument '%s'", p);
+
+		if (*p) { /* more arguments, swallow separator */
+			if (*p != ',')
+				die("Missing comma separator, at index %lu of '%s'",
+				    p - args, args);
+			++p;
+		}
+	}
+}
+
 int git_diff_basic_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.renamelimit")) {
@@ -145,6 +194,12 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.dirstat")) {
+		init_default_diff_options();
+		dirstat_opt_args(&default_diff_options, value);
+		return 0;
+	}
+
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
@@ -2879,6 +2934,8 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 
 void diff_setup(struct diff_options *options)
 {
+	init_default_diff_options();
+
 	memcpy(options, &default_diff_options, sizeof(*options));
 
 	options->file = stdout;
@@ -2886,7 +2943,6 @@ void diff_setup(struct diff_options *options)
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
-	options->dirstat_percent = 3;
 	options->context = 3;
 
 	options->change = diff_change;
@@ -3148,7 +3204,6 @@ static int dirstat_opt(struct diff_options *options, const char **av)
 {
 	const char *p, *arg = av[0];
 	char *mangled = NULL;
-	char sep = '=';
 
 	if (!strcmp(arg, "--cumulative")) /* deprecated */
 		/* handle '--cumulative' like '--dirstat=cumulative' */
@@ -3156,14 +3211,13 @@ static int dirstat_opt(struct diff_options *options, const char **av)
 	else if (!strcmp(arg, "--dirstat-by-file") ||
 		 !prefixcmp(arg, "--dirstat-by-file=")) { /* deprecated */
 		/* handle '--dirstat-by-file=*' like '--dirstat=files,*' */
-		mangled = xstrdup(arg + 2);
-		memcpy(mangled, "--dirstat=files", 15);
-		if (mangled[15]) {
-			assert(mangled[15] == '=');
-			mangled[15] = ',';
+		mangled = xstrdup(arg + 11);
+		memcpy(mangled, "=files", 6);
+		if (mangled[6]) {
+			assert(mangled[6] == '=');
+			mangled[6] = ',';
 		}
-		arg = mangled;
-		p = mangled + 9;
+		p = mangled;
 	}
 	else if (!prefixcmp(arg, "-X"))
 		p = arg + 2;
@@ -3172,40 +3226,12 @@ static int dirstat_opt(struct diff_options *options, const char **av)
 	else
 		return 0;
 
-	options->output_format |= DIFF_FORMAT_DIRSTAT;
-
-	while (*p) {
-		if (*p != sep)
-			die("Missing argument separator ('%c'), at index %lu of '%s'",
-			    sep, p - arg, arg);
-		sep = ',';
-		++p;
-		if (!prefixcmp(p, "changes")) {
-			p += 7;
-			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
-		}
-		else if (!prefixcmp(p, "files")) {
-			p += 5;
-			DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
-		}
-		else if (!prefixcmp(p, "noncumulative")) {
-			p += 13;
-			DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
-		}
-		else if (!prefixcmp(p, "cumulative")) {
-			p += 10;
-			DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
-		}
-		else if (isdigit(*p)) {
-			char *end;
-			options->dirstat_percent = strtoul(p, &end, 10);
-			assert(end > p);
-			p = end;
-		}
-		else
-			die("Unknown --dirstat argument '%s'", p);
-	}
+	if (*p == '=')
+		dirstat_opt_args(options, ++p);
+	else if (*p)
+		return 0;
 
+	options->output_format |= DIFF_FORMAT_DIRSTAT;
 	free(mangled);
 	return 1;
 }
diff --git a/t/t4046-diff-dirstat.sh b/t/t4046-diff-dirstat.sh
index bd1494c..021c9c4 100755
--- a/t/t4046-diff-dirstat.sh
+++ b/t/t4046-diff-dirstat.sh
@@ -362,6 +362,15 @@ test_expect_success 'later options override earlier options:' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success 'non-defaults in config overridden by explicit defaults on command line' '
+	git -c diff.dirstat=files,cumulative,50 diff --dirstat=changes,noncumulative,3 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=files,cumulative,50 diff --dirstat=changes,noncumulative,3 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=files,cumulative,50 diff --dirstat=changes,noncumulative,3 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
    2.1% changed/
   10.8% dst/copy/changed/
@@ -404,6 +413,15 @@ test_expect_success '--dirstat=0' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success 'diff.dirstat=0' '
+	git -c diff.dirstat=0 diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=0 diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=0 diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
    2.1% changed/
   10.8% dst/copy/changed/
@@ -465,6 +483,24 @@ test_expect_success '--dirstat=0,cumulative' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success 'diff.dirstat=0,cumulative' '
+	git -c diff.dirstat=0,cumulative diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=0,cumulative diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=0,cumulative diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success 'diff.dirstat=0 & --dirstat=cumulative' '
+	git -c diff.dirstat=0 diff --dirstat=cumulative HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=0 diff --dirstat=cumulative -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=0 diff --dirstat=cumulative -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
    9.0% changed/
    9.0% dst/copy/changed/
@@ -516,6 +552,15 @@ test_expect_success '--dirstat=files' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success 'diff.dirstat=files' '
+	git -c diff.dirstat=files diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=files diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=files diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
   27.2% dst/copy/
   27.2% dst/move/
@@ -559,6 +604,15 @@ test_expect_success '--dirstat=files,10' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success 'diff.dirstat=10,files' '
+	git -c diff.dirstat=10,files diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=10,files diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=10,files diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
    9.0% changed/
    9.0% dst/copy/changed/
@@ -620,6 +674,15 @@ test_expect_success '--dirstat=files,cumulative' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success 'diff.dirstat=cumulative,files' '
+	git -c diff.dirstat=cumulative,files diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=cumulative,files diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=cumulative,files diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
   27.2% dst/copy/
   27.2% dst/move/
@@ -661,4 +724,13 @@ test_expect_success '--dirstat=files,cumulative,10' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success 'diff.dirstat=10,cumulative,files' '
+	git -c diff.dirstat=10,cumulative,files diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=10,cumulative,files diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=10,cumulative,files diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 test_done
-- 
1.7.5.rc1.3.g4d7b
