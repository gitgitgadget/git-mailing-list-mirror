From: Johan Herland <johan@herland.net>
Subject: [PATCH 5/6] Use floating point for --dirstat percentages
Date: Tue, 26 Apr 2011 02:01:41 +0200
Message-ID: <1303776102-9085-6-git-send-email-johan@herland.net>
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
	id 1QEVjL-0006sD-9V
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 02:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440Ab1DZACK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 20:02:10 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53577 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932353Ab1DZACG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 20:02:06 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LK80024GG3D6S30@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Apr 2011 02:02:01 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id B6FBF1EEF9FA_DB60B79B	for <git@vger.kernel.org>; Tue,
 26 Apr 2011 00:02:01 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 9CCF21EEFA9B_DB60B78F	for <git@vger.kernel.org>; Tue,
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172057>

Allow specifying --dirstat cut-off percentage as a floating point number.

When printing the dirstat output, floating point numbers are presented in
rounded form (as opposed to truncated). Therefore, this patch includes a
significant churn in the expected output of the dirstat selftests.

A selftest verifying floating-point percentage input has been added.

Signed-off-by: Johan Herland <johan@herland.net>
---

Remaining questions:
- Locale issues with strod(), e.g. decimal separator is a comma in certain
  locales.
- Is it really worth the extensive churn in the dirstat output?


Have fun! :)

...Johan

 diff.c                  |   22 ++--
 diff.h                  |    2 +-
 t/t4046-diff-dirstat.sh |  327 ++++++++++++++++++++++++++---------------------
 3 files changed, 195 insertions(+), 156 deletions(-)

diff --git a/diff.c b/diff.c
index 20fe02c..4da3b68 100644
--- a/diff.c
+++ b/diff.c
@@ -51,7 +51,7 @@ static void init_default_diff_options()
 	if (initialized)
 		return;
 
-	default_diff_options.dirstat_percent = 3;
+	default_diff_options.dirstat_percent = 3.0;
 
 	initialized = 1;
 }
@@ -146,10 +146,12 @@ static void dirstat_opt_args(struct diff_options *options, const char *args)
 			DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
 		}
 		else if (isdigit(*p)) {
-			char *end;
-			options->dirstat_percent = strtoul(p, &end, 10);
-			assert(end > p);
-			p = end;
+			char *end = (char *) p;
+			options->dirstat_percent = strtod(p, &end);
+			if (end > p && (*end == ',' || !*end))
+				p = end;
+			else
+				die("Failed to parse percent threshold '%s'", p);
 		}
 		else
 			die("Unknown --dirstat argument '%s'", p);
@@ -1508,7 +1510,8 @@ struct dirstat_file {
 
 struct dirstat_dir {
 	struct dirstat_file *files;
-	int alloc, nr, percent, cumulative;
+	double percent;
+	int alloc, nr, cumulative;
 };
 
 static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
@@ -1556,11 +1559,10 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
 	 */
 	if (baselen && sources != 1) {
 		if (this_dir) {
-			int permille = this_dir * 1000 / changed;
-			int percent = permille / 10;
+			double percent = this_dir * 100.0 / changed;
 			if (percent >= dir->percent) {
-				fprintf(opt->file, "%s%4d.%01d%% %.*s\n", line_prefix,
-					percent, permille % 10, baselen, base);
+				fprintf(opt->file, "%s%6.1f%% %.*s\n", line_prefix,
+					percent, baselen, base);
 				if (!dir->cumulative)
 					return 0;
 			}
diff --git a/diff.h b/diff.h
index 0083d92..781c620 100644
--- a/diff.h
+++ b/diff.h
@@ -111,13 +111,13 @@ struct diff_options {
 	int rename_score;
 	int rename_limit;
 	int warn_on_too_large_rename;
-	int dirstat_percent;
 	int setup;
 	int abbrev;
 	const char *prefix;
 	int prefix_length;
 	const char *stat_sep;
 	long xdl_opts;
+	double dirstat_percent;
 
 	int stat_width;
 	int stat_name_width;
diff --git a/t/t4046-diff-dirstat.sh b/t/t4046-diff-dirstat.sh
index 021c9c4..da4484c 100755
--- a/t/t4046-diff-dirstat.sh
+++ b/t/t4046-diff-dirstat.sh
@@ -301,31 +301,31 @@ test_expect_success 'sanity check setup (--stat)' '
 
 # changed/text and rearranged/text falls below default 3% threshold
 cat <<EOF >expect_diff_dirstat
-  10.8% dst/copy/changed/
-  10.8% dst/copy/rearranged/
-  10.8% dst/copy/unchanged/
-  10.8% dst/move/changed/
-  10.8% dst/move/rearranged/
-  10.8% dst/move/unchanged/
-  10.8% src/move/changed/
-  10.8% src/move/rearranged/
-  10.8% src/move/unchanged/
+  10.9% dst/copy/changed/
+  10.9% dst/copy/rearranged/
+  10.9% dst/copy/unchanged/
+  10.9% dst/move/changed/
+  10.9% dst/move/rearranged/
+  10.9% dst/move/unchanged/
+  10.9% src/move/changed/
+  10.9% src/move/rearranged/
+  10.9% src/move/unchanged/
 EOF
 
 # rearranged/text falls below default 3% threshold
 cat <<EOF >expect_diff_dirstat_M
-   5.8% changed/
+   5.9% changed/
   29.3% dst/copy/changed/
   29.3% dst/copy/rearranged/
   29.3% dst/copy/unchanged/
-   5.8% dst/move/changed/
+   5.9% dst/move/changed/
 EOF
 
 # rearranged/text falls below default 3% threshold
 cat <<EOF >expect_diff_dirstat_CC
-  32.6% changed/
-  32.6% dst/copy/changed/
-  32.6% dst/move/changed/
+  32.7% changed/
+  32.7% dst/copy/changed/
+  32.7% dst/move/changed/
 EOF
 
 test_expect_success 'vanilla --dirstat' '
@@ -372,36 +372,36 @@ test_expect_success 'non-defaults in config overridden by explicit defaults on c
 '
 
 cat <<EOF >expect_diff_dirstat
-   2.1% changed/
-  10.8% dst/copy/changed/
-  10.8% dst/copy/rearranged/
-  10.8% dst/copy/unchanged/
-  10.8% dst/move/changed/
-  10.8% dst/move/rearranged/
-  10.8% dst/move/unchanged/
+   2.2% changed/
+  10.9% dst/copy/changed/
+  10.9% dst/copy/rearranged/
+  10.9% dst/copy/unchanged/
+  10.9% dst/move/changed/
+  10.9% dst/move/rearranged/
+  10.9% dst/move/unchanged/
    0.0% rearranged/
-  10.8% src/move/changed/
-  10.8% src/move/rearranged/
-  10.8% src/move/unchanged/
+  10.9% src/move/changed/
+  10.9% src/move/rearranged/
+  10.9% src/move/unchanged/
 EOF
 
 cat <<EOF >expect_diff_dirstat_M
-   5.8% changed/
+   5.9% changed/
   29.3% dst/copy/changed/
   29.3% dst/copy/rearranged/
   29.3% dst/copy/unchanged/
-   5.8% dst/move/changed/
+   5.9% dst/move/changed/
    0.1% dst/move/rearranged/
    0.1% rearranged/
 EOF
 
 cat <<EOF >expect_diff_dirstat_CC
-  32.6% changed/
-  32.6% dst/copy/changed/
-   0.6% dst/copy/rearranged/
-  32.6% dst/move/changed/
-   0.6% dst/move/rearranged/
-   0.6% rearranged/
+  32.7% changed/
+  32.7% dst/copy/changed/
+   0.7% dst/copy/rearranged/
+  32.7% dst/move/changed/
+   0.7% dst/move/rearranged/
+   0.7% rearranged/
 EOF
 
 test_expect_success '--dirstat=0' '
@@ -423,46 +423,46 @@ test_expect_success 'diff.dirstat=0' '
 '
 
 cat <<EOF >expect_diff_dirstat
-   2.1% changed/
-  10.8% dst/copy/changed/
-  10.8% dst/copy/rearranged/
-  10.8% dst/copy/unchanged/
-  32.5% dst/copy/
-  10.8% dst/move/changed/
-  10.8% dst/move/rearranged/
-  10.8% dst/move/unchanged/
-  32.5% dst/move/
-  65.1% dst/
+   2.2% changed/
+  10.9% dst/copy/changed/
+  10.9% dst/copy/rearranged/
+  10.9% dst/copy/unchanged/
+  32.6% dst/copy/
+  10.9% dst/move/changed/
+  10.9% dst/move/rearranged/
+  10.9% dst/move/unchanged/
+  32.6% dst/move/
+  65.2% dst/
    0.0% rearranged/
-  10.8% src/move/changed/
-  10.8% src/move/rearranged/
-  10.8% src/move/unchanged/
-  32.5% src/move/
+  10.9% src/move/changed/
+  10.9% src/move/rearranged/
+  10.9% src/move/unchanged/
+  32.6% src/move/
 EOF
 
 cat <<EOF >expect_diff_dirstat_M
-   5.8% changed/
+   5.9% changed/
   29.3% dst/copy/changed/
   29.3% dst/copy/rearranged/
   29.3% dst/copy/unchanged/
   88.0% dst/copy/
-   5.8% dst/move/changed/
+   5.9% dst/move/changed/
    0.1% dst/move/rearranged/
-   5.9% dst/move/
+   6.0% dst/move/
   94.0% dst/
    0.1% rearranged/
 EOF
 
 cat <<EOF >expect_diff_dirstat_CC
-  32.6% changed/
-  32.6% dst/copy/changed/
-   0.6% dst/copy/rearranged/
+  32.7% changed/
+  32.7% dst/copy/changed/
+   0.7% dst/copy/rearranged/
   33.3% dst/copy/
-  32.6% dst/move/changed/
-   0.6% dst/move/rearranged/
+  32.7% dst/move/changed/
+   0.7% dst/move/rearranged/
   33.3% dst/move/
-  66.6% dst/
-   0.6% rearranged/
+  66.7% dst/
+   0.7% rearranged/
 EOF
 
 test_expect_success '--dirstat=0 --cumulative' '
@@ -502,36 +502,36 @@ test_expect_success 'diff.dirstat=0 & --dirstat=cumulative' '
 '
 
 cat <<EOF >expect_diff_dirstat
-   9.0% changed/
-   9.0% dst/copy/changed/
-   9.0% dst/copy/rearranged/
-   9.0% dst/copy/unchanged/
-   9.0% dst/move/changed/
-   9.0% dst/move/rearranged/
-   9.0% dst/move/unchanged/
-   9.0% rearranged/
-   9.0% src/move/changed/
-   9.0% src/move/rearranged/
-   9.0% src/move/unchanged/
+   9.1% changed/
+   9.1% dst/copy/changed/
+   9.1% dst/copy/rearranged/
+   9.1% dst/copy/unchanged/
+   9.1% dst/move/changed/
+   9.1% dst/move/rearranged/
+   9.1% dst/move/unchanged/
+   9.1% rearranged/
+   9.1% src/move/changed/
+   9.1% src/move/rearranged/
+   9.1% src/move/unchanged/
 EOF
 
 cat <<EOF >expect_diff_dirstat_M
-  14.2% changed/
-  14.2% dst/copy/changed/
-  14.2% dst/copy/rearranged/
-  14.2% dst/copy/unchanged/
-  14.2% dst/move/changed/
-  14.2% dst/move/rearranged/
-  14.2% rearranged/
+  14.3% changed/
+  14.3% dst/copy/changed/
+  14.3% dst/copy/rearranged/
+  14.3% dst/copy/unchanged/
+  14.3% dst/move/changed/
+  14.3% dst/move/rearranged/
+  14.3% rearranged/
 EOF
 
 cat <<EOF >expect_diff_dirstat_CC
-  16.6% changed/
-  16.6% dst/copy/changed/
-  16.6% dst/copy/rearranged/
-  16.6% dst/move/changed/
-  16.6% dst/move/rearranged/
-  16.6% rearranged/
+  16.7% changed/
+  16.7% dst/copy/changed/
+  16.7% dst/copy/rearranged/
+  16.7% dst/move/changed/
+  16.7% dst/move/rearranged/
+  16.7% rearranged/
 EOF
 
 test_expect_success '--dirstat-by-file' '
@@ -562,28 +562,28 @@ test_expect_success 'diff.dirstat=files' '
 '
 
 cat <<EOF >expect_diff_dirstat
-  27.2% dst/copy/
-  27.2% dst/move/
-  27.2% src/move/
+  27.3% dst/copy/
+  27.3% dst/move/
+  27.3% src/move/
 EOF
 
 cat <<EOF >expect_diff_dirstat_M
-  14.2% changed/
-  14.2% dst/copy/changed/
-  14.2% dst/copy/rearranged/
-  14.2% dst/copy/unchanged/
-  14.2% dst/move/changed/
-  14.2% dst/move/rearranged/
-  14.2% rearranged/
+  14.3% changed/
+  14.3% dst/copy/changed/
+  14.3% dst/copy/rearranged/
+  14.3% dst/copy/unchanged/
+  14.3% dst/move/changed/
+  14.3% dst/move/rearranged/
+  14.3% rearranged/
 EOF
 
 cat <<EOF >expect_diff_dirstat_CC
-  16.6% changed/
-  16.6% dst/copy/changed/
-  16.6% dst/copy/rearranged/
-  16.6% dst/move/changed/
-  16.6% dst/move/rearranged/
-  16.6% rearranged/
+  16.7% changed/
+  16.7% dst/copy/changed/
+  16.7% dst/copy/rearranged/
+  16.7% dst/move/changed/
+  16.7% dst/move/rearranged/
+  16.7% rearranged/
 EOF
 
 test_expect_success '--dirstat-by-file=10' '
@@ -614,46 +614,46 @@ test_expect_success 'diff.dirstat=10,files' '
 '
 
 cat <<EOF >expect_diff_dirstat
-   9.0% changed/
-   9.0% dst/copy/changed/
-   9.0% dst/copy/rearranged/
-   9.0% dst/copy/unchanged/
-  27.2% dst/copy/
-   9.0% dst/move/changed/
-   9.0% dst/move/rearranged/
-   9.0% dst/move/unchanged/
-  27.2% dst/move/
+   9.1% changed/
+   9.1% dst/copy/changed/
+   9.1% dst/copy/rearranged/
+   9.1% dst/copy/unchanged/
+  27.3% dst/copy/
+   9.1% dst/move/changed/
+   9.1% dst/move/rearranged/
+   9.1% dst/move/unchanged/
+  27.3% dst/move/
   54.5% dst/
-   9.0% rearranged/
-   9.0% src/move/changed/
-   9.0% src/move/rearranged/
-   9.0% src/move/unchanged/
-  27.2% src/move/
+   9.1% rearranged/
+   9.1% src/move/changed/
+   9.1% src/move/rearranged/
+   9.1% src/move/unchanged/
+  27.3% src/move/
 EOF
 
 cat <<EOF >expect_diff_dirstat_M
-  14.2% changed/
-  14.2% dst/copy/changed/
-  14.2% dst/copy/rearranged/
-  14.2% dst/copy/unchanged/
-  42.8% dst/copy/
-  14.2% dst/move/changed/
-  14.2% dst/move/rearranged/
-  28.5% dst/move/
+  14.3% changed/
+  14.3% dst/copy/changed/
+  14.3% dst/copy/rearranged/
+  14.3% dst/copy/unchanged/
+  42.9% dst/copy/
+  14.3% dst/move/changed/
+  14.3% dst/move/rearranged/
+  28.6% dst/move/
   71.4% dst/
-  14.2% rearranged/
+  14.3% rearranged/
 EOF
 
 cat <<EOF >expect_diff_dirstat_CC
-  16.6% changed/
-  16.6% dst/copy/changed/
-  16.6% dst/copy/rearranged/
+  16.7% changed/
+  16.7% dst/copy/changed/
+  16.7% dst/copy/rearranged/
   33.3% dst/copy/
-  16.6% dst/move/changed/
-  16.6% dst/move/rearranged/
+  16.7% dst/move/changed/
+  16.7% dst/move/rearranged/
   33.3% dst/move/
-  66.6% dst/
-  16.6% rearranged/
+  66.7% dst/
+  16.7% rearranged/
 EOF
 
 test_expect_success '--dirstat-by-file --cumulative' '
@@ -684,35 +684,35 @@ test_expect_success 'diff.dirstat=cumulative,files' '
 '
 
 cat <<EOF >expect_diff_dirstat
-  27.2% dst/copy/
-  27.2% dst/move/
+  27.3% dst/copy/
+  27.3% dst/move/
   54.5% dst/
-  27.2% src/move/
+  27.3% src/move/
 EOF
 
 cat <<EOF >expect_diff_dirstat_M
-  14.2% changed/
-  14.2% dst/copy/changed/
-  14.2% dst/copy/rearranged/
-  14.2% dst/copy/unchanged/
-  42.8% dst/copy/
-  14.2% dst/move/changed/
-  14.2% dst/move/rearranged/
-  28.5% dst/move/
+  14.3% changed/
+  14.3% dst/copy/changed/
+  14.3% dst/copy/rearranged/
+  14.3% dst/copy/unchanged/
+  42.9% dst/copy/
+  14.3% dst/move/changed/
+  14.3% dst/move/rearranged/
+  28.6% dst/move/
   71.4% dst/
-  14.2% rearranged/
+  14.3% rearranged/
 EOF
 
 cat <<EOF >expect_diff_dirstat_CC
-  16.6% changed/
-  16.6% dst/copy/changed/
-  16.6% dst/copy/rearranged/
+  16.7% changed/
+  16.7% dst/copy/changed/
+  16.7% dst/copy/rearranged/
   33.3% dst/copy/
-  16.6% dst/move/changed/
-  16.6% dst/move/rearranged/
+  16.7% dst/move/changed/
+  16.7% dst/move/rearranged/
   33.3% dst/move/
-  66.6% dst/
-  16.6% rearranged/
+  66.7% dst/
+  16.7% rearranged/
 EOF
 
 test_expect_success '--dirstat=files,cumulative,10' '
@@ -733,4 +733,41 @@ test_expect_success 'diff.dirstat=10,cumulative,files' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+cat <<EOF >expect_diff_dirstat
+  27.3% dst/copy/
+  27.3% dst/move/
+  54.5% dst/
+  27.3% src/move/
+EOF
+
+cat <<EOF >expect_diff_dirstat_M
+  42.9% dst/copy/
+  28.6% dst/move/
+  71.4% dst/
+EOF
+
+cat <<EOF >expect_diff_dirstat_CC
+  33.3% dst/copy/
+  33.3% dst/move/
+  66.7% dst/
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
