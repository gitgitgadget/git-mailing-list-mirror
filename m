From: eletuchy@gmail.com
Subject: [PATCH 1/2] Make git blame's date output format configurable, like git log
Date: Fri, 20 Feb 2009 13:23:08 -0800
Message-ID: <1235164988-19761-2-git-send-email-eletuchy@gmail.com>
References: <[PATCH] Make git blame date output format configurable, a la git log>
 <1235164988-19761-1-git-send-email-eletuchy@gmail.com>
Cc: git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 20 22:24:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LacrQ-0007Ko-3v
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 22:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbZBTVXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 16:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbZBTVXL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 16:23:11 -0500
Received: from outmail016.snc1.tfbnw.net ([69.63.178.175]:62917 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752441AbZBTVXK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 16:23:10 -0500
Received: from [10.18.255.176] ([10.18.255.176:48324] helo=facebook.com)
	by mta003.snc1.facebook.com (envelope-from <eletuchy@facebook.com>)
	(ecelerity 2.2.2.37 r(28805/28844)) with ESMTP
	id 9C/6B-05945-D3F1F994; Fri, 20 Feb 2009 13:23:09 -0800
Received: by dev051.snc1.facebook.com (Postfix, from userid 1200)
	id 07CBD11C212; Fri, 20 Feb 2009 13:23:09 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.14.g07c3.dirty
In-Reply-To: <1235164988-19761-1-git-send-email-eletuchy@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110890>

From: Eugene Letuchy <eugene@facebook.com>

Add the following:
 - git config value blame.date that expects one of the git log date
   formats ({relative,local,default,iso,rfc,short})
 - git blame command line option --date expects one of the git
   log date formats ({relative,local,default,iso,rfc,short})
 - documentation in blame-options.txt
 - git blame uses the appropriate date.c functions and enums to
   make sense of the date format and provide appropriate data
 - git blame continues to line up the output columns (by padding the
   date column up to the max width of the chosen date format)
 - the date format for git blame without both blame.date and --date
   continues to be ISO for backwards compatibility
 - git annotate ignores the date format specifiers and continues to
   uses the ISO format, as before

Signed-off-by: Eugene Letuchy <eugene@facebook.com>
---
 Documentation/blame-options.txt |    8 +++++
 builtin-blame.c                 |   62 +++++++++++++++++++++++++++++----------
 2 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 1ab1b96..ad00d36 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -63,6 +63,14 @@ of lines before or after the line given by <start>.
 	tree copy has the contents of the named file (specify
 	`-` to make the command read from the standard input).
 
+--date <format>::
+	The value is one of the following alternatives:
+	{relative,local,default,iso,rfc,short}. If --date is not
+	provided, the value of the blame.date config variable is
+	used. If the blame.date config variable is also not set, the
+	iso format is used. For more information, See the discussion
+	of the --date option at linkgit:git-log[1].
+
 -M|<num>|::
 	Detect moving lines in the file as well.  When a commit
 	moves a block of lines in a file (e.g. the original file
diff --git a/builtin-blame.c b/builtin-blame.c
index 114a214..aa5c66c 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1,5 +1,5 @@
 /*
- * Pickaxe
+ * Blame
  *
  * Copyright (c) 2006, Junio C Hamano
  */
@@ -40,6 +40,10 @@ static int reverse;
 static int blank_boundary;
 static int incremental;
 static int xdl_opts = XDF_NEED_MINIMAL;
+
+static enum date_mode blame_date_mode = DATE_ISO8601;
+static size_t blame_date_width;
+
 static struct string_list mailmap;
 
 #ifndef DEBUG
@@ -1507,24 +1511,20 @@ static const char *format_time(unsigned long time, const char *tz_str,
 			       int show_raw_time)
 {
 	static char time_buf[128];
-	time_t t = time;
-	int minutes, tz;
-	struct tm *tm;
+	const char *time_str;
+	int time_len;
+	int tz;
 
 	if (show_raw_time) {
 		sprintf(time_buf, "%lu %s", time, tz_str);
-		return time_buf;
 	}
-
-	tz = atoi(tz_str);
-	minutes = tz < 0 ? -tz : tz;
-	minutes = (minutes / 100)*60 + (minutes % 100);
-	minutes = tz < 0 ? -minutes : minutes;
-	t = time + minutes * 60;
-	tm = gmtime(&t);
-
-	strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S ", tm);
-	strcat(time_buf, tz_str);
+	else {
+		tz = atoi(tz_str);
+		time_str = show_date(time, tz, blame_date_mode);
+		time_len = strlen(time_str);
+		memcpy(time_buf, time_str, time_len);
+		memset(time_buf + time_len, ' ', blame_date_width - time_len);
+	}
 	return time_buf;
 }
 
@@ -1975,6 +1975,9 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		blank_boundary = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "blame.date") && value[0]) {
+		blame_date_mode = parse_date_format(value);
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -2239,6 +2242,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	git_config(git_blame_config, NULL);
 	init_revisions(&revs, NULL);
+	revs.date_mode = blame_date_mode;
+
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
 
@@ -2263,8 +2268,33 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 parse_done:
 	argc = parse_options_end(&ctx);
 
-	if (cmd_is_annotate)
+	if (cmd_is_annotate) {
 		output_option |= OUTPUT_ANNOTATE_COMPAT;
+		blame_date_mode = DATE_ISO8601;
+	} else {
+		blame_date_mode = revs.date_mode;
+	}
+
+	switch (blame_date_mode) {
+	case DATE_RFC2822:
+		blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
+		break;
+	case DATE_ISO8601:
+		blame_date_width = sizeof("2006-10-19 16:00:04 -0700");
+		break;
+	case DATE_SHORT:
+		blame_date_width = sizeof("2006-10-19");
+		break;
+	case DATE_RELATIVE:
+		/* unfortunately "normal" is the fallback for "relative" */
+		/* blame_date_width = sizeof("14 minutes ago"); */
+		/* break; */
+	case DATE_LOCAL:
+	case DATE_NORMAL:
+		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
+		break;
+	}
+	blame_date_width -= 1; /* strip the null */
 
 	if (DIFF_OPT_TST(&revs.diffopt, FIND_COPIES_HARDER))
 		opt |= (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
-- 
1.6.2.rc1.14.g07c3.dirty
