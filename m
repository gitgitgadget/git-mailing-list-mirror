From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 5/6] Allow specifying --dirstat cut-off percentage as a
 floating point number
Date: Wed, 27 Apr 2011 10:24:12 +0200
Message-ID: <1303892653-3958-6-git-send-email-johan@herland.net>
References: <1303870359-26083-1-git-send-email-johan@herland.net>
 <1303892653-3958-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 10:24:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF03L-0000pU-Hx
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 10:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab1D0IYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 04:24:37 -0400
Received: from smtp.getmail.no ([84.208.15.66]:37992 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686Ab1D0IY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 04:24:29 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA004EWY0J9Y70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 10:24:19 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 72A031EA5925_DB7D2B3B	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 08:24:19 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 2A7131EA38AD_DB7D2B3F	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 08:24:19 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA008RHY0G8H20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 10:24:19 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1303892653-3958-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172194>

Only the first digit after the decimal point is kept, as the dirstat
calculations all happen in permille.

A selftest verifying floating-point percentage input has been added.

Improved-by: Junio C Hamano <gitster@pobox.com>
Improved-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Johan Herland <johan@herland.net>
---
 diff.c                  |   26 ++++++++++++++++----------
 diff.h                  |    2 +-
 t/t4046-diff-dirstat.sh |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 1b6e8c0..3ca129c 100644
--- a/diff.c
+++ b/diff.c
@@ -31,7 +31,7 @@ static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
-static int diff_dirstat_percent_default = 3;
+static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
 
 static char diff_colors[][COLOR_MAXLEN] = {
@@ -95,8 +95,15 @@ static void parse_dirstat_params(struct diff_options *options, const char *param
 		}
 		else if (isdigit(*p)) {
 			char *end;
-			options->dirstat_percent = strtoul(p, &end, 10);
+			options->dirstat_permille = strtoul(p, &end, 10) * 10;
 			p = end;
+			if (*p == '.' && isdigit(*(++p))) {
+				int permille = strtoul(p, &end, 10);
+				p = end;
+				while (permille >= 10)
+					permille /= 10; /* only use first digit */
+				options->dirstat_permille += permille;
+			}
 		}
 		else
 			die("Unknown --dirstat parameter '%s'", p);
@@ -190,9 +197,9 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "diff.dirstat")) {
-		default_diff_options.dirstat_percent = diff_dirstat_percent_default;
+		default_diff_options.dirstat_permille = diff_dirstat_permille_default;
 		parse_dirstat_params(&default_diff_options, value);
-		diff_dirstat_percent_default = default_diff_options.dirstat_percent;
+		diff_dirstat_permille_default = default_diff_options.dirstat_permille;
 		return 0;
 	}
 
@@ -1504,7 +1511,7 @@ struct dirstat_file {
 
 struct dirstat_dir {
 	struct dirstat_file *files;
-	int alloc, nr, percent, cumulative;
+	int alloc, nr, permille, cumulative;
 };
 
 static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
@@ -1553,10 +1560,9 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
 	if (baselen && sources != 1) {
 		if (this_dir) {
 			int permille = this_dir * 1000 / changed;
-			int percent = permille / 10;
-			if (percent >= dir->percent) {
+			if (permille >= dir->permille) {
 				fprintf(opt->file, "%s%4d.%01d%% %.*s\n", line_prefix,
-					percent, permille % 10, baselen, base);
+					permille / 10, permille % 10, baselen, base);
 				if (!dir->cumulative)
 					return 0;
 			}
@@ -1582,7 +1588,7 @@ static void show_dirstat(struct diff_options *options)
 	dir.files = NULL;
 	dir.alloc = 0;
 	dir.nr = 0;
-	dir.percent = options->dirstat_percent;
+	dir.permille = options->dirstat_permille;
 	dir.cumulative = DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE);
 
 	changed = 0;
@@ -2937,7 +2943,7 @@ void diff_setup(struct diff_options *options)
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
-	options->dirstat_percent = diff_dirstat_percent_default;
+	options->dirstat_permille = diff_dirstat_permille_default;
 	options->context = 3;
 
 	options->change = diff_change;
diff --git a/diff.h b/diff.h
index 0083d92..08b4fe0 100644
--- a/diff.h
+++ b/diff.h
@@ -111,7 +111,7 @@ struct diff_options {
 	int rename_score;
 	int rename_limit;
 	int warn_on_too_large_rename;
-	int dirstat_percent;
+	int dirstat_permille;
 	int setup;
 	int abbrev;
 	const char *prefix;
diff --git a/t/t4046-diff-dirstat.sh b/t/t4046-diff-dirstat.sh
index fa1885c..cf75a38 100755
--- a/t/t4046-diff-dirstat.sh
+++ b/t/t4046-diff-dirstat.sh
@@ -768,4 +768,41 @@ test_expect_success 'diff.dirstat=10,cumulative,files' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+cat <<EOF >expect_diff_dirstat
+  27.2% dst/copy/
+  27.2% dst/move/
+  54.5% dst/
+  27.2% src/move/
+EOF
+
+cat <<EOF >expect_diff_dirstat_M
+  42.8% dst/copy/
+  28.5% dst/move/
+  71.4% dst/
+EOF
+
+cat <<EOF >expect_diff_dirstat_CC
+  33.3% dst/copy/
+  33.3% dst/move/
+  66.6% dst/
+EOF
+
+test_expect_success '--dirstat=files,cumulative,16.7' '
+	git diff --dirstat=files,cumulative,16.7 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=files,cumulative,16.7 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=files,cumulative,16.7 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success 'diff.dirstat=16.7,cumulative,files' '
+	git -c diff.dirstat=16.7,cumulative,files diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=16.7,cumulative,files diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=16.7,cumulative,files diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 test_done
-- 
1.7.5.rc1.3.g4d7b
