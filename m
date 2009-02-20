From: eletuchy@gmail.com
Subject: [PATCH] Make git blame date output format configurable, a la git log
Date: Fri, 20 Feb 2009 05:24:12 -0800
Message-ID: <1235136252-29649-1-git-send-email-eletuchy@gmail.com>
Cc: marius@trolltech.com, Eugene Letuchy <eugene@facebook.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 14:30:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaVSr-0003E6-Bk
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 14:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbZBTN3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 08:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbZBTN3U
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 08:29:20 -0500
Received: from outmail006.snc1.tfbnw.net ([69.63.178.165]:55795 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753795AbZBTN3T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 08:29:19 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Feb 2009 08:29:18 EST
Received: from [10.18.255.178] ([10.18.255.178:58527] helo=facebook.com)
	by mta001.snc1.facebook.com (envelope-from <eletuchy@facebook.com>)
	(ecelerity 2.2.2.37 r(28805/28844)) with ESMTP
	id 85/D4-24018-DFEAE994; Fri, 20 Feb 2009 05:24:13 -0800
Received: by dev051.snc1.facebook.com (Postfix, from userid 1200)
	id 0C6AC11C211; Fri, 20 Feb 2009 05:24:13 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.14.g397c24.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110842>

From: Eugene Letuchy <eugene@facebook.com>

Adds the following:
 - git config value blame.date that expects one of the git log date
   formats ({relative,local,default,iso,rfc,short})
 - git blame command line option --date-format expects one of the git
   log date formats ({relative,local,default,iso,rfc,short})
 - documentation in blame-options.txt
 - git blame uses the appropriate date.c functions and enums to
   make sense of the date format and provide appropriate data

The tests pass. The mailmap test needed to be modified to expect iso
formatted blames rather than the new "default".

Signed-off-by: Eugene Letuchy <eugene@facebook.com>
---
 Documentation/blame-options.txt |    6 ++++++
 builtin-blame.c                 |   31 ++++++++++++++++++-------------
 t/t4203-mailmap.sh              |    2 +-
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 1ab1b96..75663ec 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -63,6 +63,12 @@ of lines before or after the line given by <start>.
 	tree copy has the contents of the named file (specify
 	`-` to make the command read from the standard input).
 
+--date-format <format>::
+	The value is one of the following alternatives:
+	{relative,local,default,iso,rfc,short}.  The default format
+	can be set using the blame.date config variable. See the
+	discussion of the --date option at linkgit:git-log[1].
+
 -M|<num>|::
 	Detect moving lines in the file as well.  When a commit
 	moves a block of lines in a file (e.g. the original file
diff --git a/builtin-blame.c b/builtin-blame.c
index 114a214..9ebab43 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1,5 +1,5 @@
 /*
- * Pickaxe
+ * Blame / Pickaxe
  *
  * Copyright (c) 2006, Junio C Hamano
  */
@@ -40,6 +40,9 @@ static int reverse;
 static int blank_boundary;
 static int incremental;
 static int xdl_opts = XDF_NEED_MINIMAL;
+
+static enum date_mode date_mode;
+
 static struct string_list mailmap;
 
 #ifndef DEBUG
@@ -1507,9 +1510,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 			       int show_raw_time)
 {
 	static char time_buf[128];
-	time_t t = time;
-	int minutes, tz;
-	struct tm *tm;
+	int tz;
 
 	if (show_raw_time) {
 		sprintf(time_buf, "%lu %s", time, tz_str);
@@ -1517,15 +1518,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 	}
 
 	tz = atoi(tz_str);
-	minutes = tz < 0 ? -tz : tz;
-	minutes = (minutes / 100)*60 + (minutes % 100);
-	minutes = tz < 0 ? -minutes : minutes;
-	t = time + minutes * 60;
-	tm = gmtime(&t);
-
-	strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S ", tm);
-	strcat(time_buf, tz_str);
-	return time_buf;
+	return show_date(time, tz, date_mode);
 }
 
 #define OUTPUT_ANNOTATE_COMPAT	001
@@ -1967,6 +1960,8 @@ static void prepare_blame_range(struct scoreboard *sb,
 
 static int git_blame_config(const char *var, const char *value, void *cb)
 {
+	const char *default_date_mode;
+
 	if (!strcmp(var, "blame.showroot")) {
 		show_root = git_config_bool(var, value);
 		return 0;
@@ -1975,6 +1970,11 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		blank_boundary = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "blame.date")) {
+		git_config_string(&default_date_mode, var, value);
+		date_mode = parse_date_format(default_date_mode);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -2212,6 +2212,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	static int show_stats = 0;
 	static const char *revs_file = NULL;
 	static const char *contents_from = NULL;
+	static const char *date_format = NULL;
 	static const struct option options[] = {
 		OPT_BOOLEAN(0, "incremental", &incremental, "Show blame entries as we find them, incrementally"),
 		OPT_BOOLEAN('b', NULL, &blank_boundary, "Show blank SHA-1 for boundary commits (Default: off)"),
@@ -2228,6 +2229,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('w', NULL, &xdl_opts, "Ignore whitespace differences", XDF_IGNORE_WHITESPACE),
 		OPT_STRING('S', NULL, &revs_file, "file", "Use revisions from <file> instead of calling git-rev-list"),
 		OPT_STRING(0, "contents", &contents_from, "file", "Use <file>'s contents as the final image"),
+		OPT_STRING(0, "date-format", &date_format, "date mode", "Specify date formatting: relative,local,default,iso,rfc,short. ."),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies within and across files", PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, "score", "Find line movements within and across files", PARSE_OPT_OPTARG, blame_move_callback },
 		OPT_CALLBACK('L', NULL, &bottomtop, "n,m", "Process only line range n,m, counting from 1", blame_bottomtop_callback),
@@ -2266,6 +2268,9 @@ parse_done:
 	if (cmd_is_annotate)
 		output_option |= OUTPUT_ANNOTATE_COMPAT;
 
+	if (date_format)
+		date_mode = parse_date_format(date_format);
+
 	if (DIFF_OPT_TST(&revs.diffopt, FIND_COPIES_HARDER))
 		opt |= (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
 			PICKAXE_BLAME_COPY_HARDER);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 9a7d1b4..13b64dc 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -208,7 +208,7 @@ ff859d96 (Other Author 2005-04-07 15:15:13 -0700 4) four
 EOF
 
 test_expect_success 'Blame output (complex mapping)' '
-	git blame one >actual &&
+	git blame --date-format=iso one >actual &&
 	test_cmp expect actual
 '
 
-- 
1.6.2.rc1.14.g397c24.dirty
