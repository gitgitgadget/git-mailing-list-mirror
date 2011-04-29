From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 4/8] Add config variable for specifying default --dirstat
 behavior
Date: Fri, 29 Apr 2011 11:36:19 +0200
Message-ID: <1304069783-22739-5-git-send-email-johan@herland.net>
References: <7vfwp13dme.fsf@alter.siamese.dyndns.org>
 <1304069783-22739-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 11:37:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFk8Q-0004WC-7z
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 11:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758086Ab1D2Jgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 05:36:52 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52918 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab1D2Jgm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 05:36:42 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKE00BMUQOYZU50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 11:36:34 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id B64CC1EEFD06_DBA86A2B	for <git@vger.kernel.org>; Fri,
 29 Apr 2011 09:36:34 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id AB4491EEFC5D_DBA86A0F	for <git@vger.kernel.org>; Fri,
 29 Apr 2011 09:36:32 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKE00LICQOV8010@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 11:36:32 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1304069783-22739-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172440>

The new diff.dirstat config variable takes the same arguments as
'--dirstat=<args>', and specifies the default arguments for --dirstat.
The config is obviously overridden by --dirstat arguments passed on the
command line.

When not specified, the --dirstat defaults are 'changes,noncumulative,3'.

The patch also adds several tests verifying the interaction between the
diff.dirstat config variable, and the --dirstat command line option.

Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/config.txt       |   36 ++++++++++++++++++++
 Documentation/diff-options.txt |    2 +
 diff.c                         |   10 +++++-
 t/t4047-diff-dirstat.sh        |   72 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6babbc7..c18dd5a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -822,6 +822,42 @@ diff.autorefreshindex::
 	affects only 'git diff' Porcelain, and not lower level
 	'diff' commands such as 'git diff-files'.
 
+diff.dirstat::
+	A comma separated list of `--dirstat` parameters specifying the
+	default behavior of the `--dirstat` option to linkgit:git-diff[1]`
+	and friends. The defaults can be overridden on the command line
+	(using `--dirstat=<param1,param2,...>`). The fallback defaults
+	(when not changed by `diff.dirstat`) are `changes,noncumulative,3`.
+	The following parameters are available:
++
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
+`files,10,cumulative`.
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6a3a9c1..4ad50b9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -70,6 +70,8 @@ endif::git-format-patch[]
 	Output the distribution of relative amount of changes for each
 	sub-directory. The behavior of `--dirstat` can be customized by
 	passing it a comma separated list of parameters.
+	The defaults are controlled by the `diff.dirstat` configuration
+	variable (see linkgit:git-config[1]).
 	The following parameters are available:
 +
 --
diff --git a/diff.c b/diff.c
index 0e4a510..92508b0 100644
--- a/diff.c
+++ b/diff.c
@@ -31,6 +31,7 @@ static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
+static int diff_dirstat_percent_default = 3;
 static struct diff_options default_diff_options;
 
 static char diff_colors[][COLOR_MAXLEN] = {
@@ -180,6 +181,13 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.dirstat")) {
+		default_diff_options.dirstat_percent = diff_dirstat_percent_default;
+		(void) parse_dirstat_params(&default_diff_options, value);
+		diff_dirstat_percent_default = default_diff_options.dirstat_percent;
+		return 0;
+	}
+
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
@@ -2921,7 +2929,7 @@ void diff_setup(struct diff_options *options)
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
-	options->dirstat_percent = 3;
+	options->dirstat_percent = diff_dirstat_percent_default;
 	options->context = 3;
 
 	options->change = diff_change;
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index d0ed62c..c1b3697 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -386,6 +386,15 @@ test_expect_success 'later options override earlier options:' '
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
@@ -437,6 +446,15 @@ test_expect_success '-X0' '
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
@@ -507,6 +525,24 @@ test_expect_success '-X0,cumulative' '
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
@@ -558,6 +594,15 @@ test_expect_success '--dirstat=files' '
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
@@ -601,6 +646,15 @@ test_expect_success '--dirstat=files,10' '
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
@@ -662,6 +716,15 @@ test_expect_success '--dirstat=files,cumulative' '
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
@@ -703,4 +766,13 @@ test_expect_success '--dirstat=files,cumulative,10' '
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
