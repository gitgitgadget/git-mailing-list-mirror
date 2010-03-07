From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCHv2 2/3] grep: Colorize filename, line number, and separator
Date: Sun,  7 Mar 2010 11:52:46 -0500
Message-ID: <1267980767-12617-3-git-send-email-lodatom@gmail.com>
References: <1267980767-12617-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 17:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoJjF-0005kc-UQ
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 17:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab0CGQxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 11:53:14 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:35422 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab0CGQxL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 11:53:11 -0500
Received: by qyk9 with SMTP id 9so4017855qyk.5
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=e9Nst+tMze33mdZ+RT5+gx03J/jei7T4YUIOSNDUlq8=;
        b=EzDwcQrMDqjpEgbyHdrDWxoGOkMzWvK3Yc2TzdfO9qDL4TOyWSRCvyOo+MkboiGjWm
         usufPnXwWDE8ZH/gAf4q4qwRx6lSYJNwHM0qItO01sfu3qwrxKk18tRgnKbkBlwQ48sS
         L3EkjrjmQlBPHCBNXKB3tTB0Cb1h48ZEhaHlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QlZYFShCS1qashJNsmNXftpCqRAMIcChnazegsrprsYbMnZE23uvztgZimEk/LuwTF
         GT/DezA8nqE47TanW5Sx+ruSpa7JJrDBBJ1NhyE5S7mQvSpahR+m2ah15/j0amS4FZfD
         O8quK02ogGwvJma59C3Ib1wPE426EBvnCTwBQ=
Received: by 10.224.43.159 with SMTP id w31mr1823395qae.270.1267980790684;
        Sun, 07 Mar 2010 08:53:10 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 20sm2767266qyk.4.2010.03.07.08.53.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 08:53:10 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267980767-12617-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141718>

Colorize the filename, line number, and separator in git grep output, as
GNU grep does.  The colors are customizable through color.grep.<slot>.
The default is to only color the separator (in cyan), since this gives
the biggest legibility increase without overwhelming the user with
colors.  GNU grep also defaults cyan for the separator, but defaults to
magenta for the filename and to green for the line number, as well.

There is one difference from GNU grep: When a binary file matches
without -a, GNU grep does not color the <file> in "Binary file <file>
matches", but we do.

Like GNU grep, if --null is given, the null separators are not colored.

For config.txt, use a a sub-list to describe the slots, rather than
a single paragraph with parentheses, since this is much more readable.

Remove the cast to int for `rm_eo - rm_so` since it is not necessary.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/config.txt |   20 ++++++++++++++--
 builtin-grep.c           |   27 ++++++++++++++++------
 grep.c                   |   55 ++++++++++++++++++++++++++++-----------------
 grep.h                   |    3 ++
 4 files changed, 74 insertions(+), 31 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2dc3a05..711519e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -678,9 +678,23 @@ color.grep::
 	`never`), never.  When set to `true` or `auto`, use color only
 	when the output is written to the terminal.  Defaults to `false`.
 
-color.grep.match::
-	Use customized color for matches.  The value of this variable
-	may be specified as in color.branch.<slot>.
+color.grep.<slot>::
+	Use customized color for grep colorization.  `<slot>` specifies which
+	part of the line to use the specified color, and is one of
++
+--
+`filename`;;
+	filename prefix (when not using `-h`)
+`linenumber`;;
+	line number prefix (when using `-n`)
+`match`;;
+	matching text
+`separator`;;
+	separators between fields on a line (`:`, `-`, and `=`)
+	and between hunks (`--`)
+--
++
+The values of these variables may be specified as in color.branch.<slot>.
 
 color.interactive::
 	When set to `always`, always use colors for interactive prompts
diff --git a/builtin-grep.c b/builtin-grep.c
index 2a876c4..0c8115d 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -288,6 +288,7 @@ static int wait_all(void)
 static int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = cb;
+	char *color = NULL;
 
 	switch (userdiff_config(var, value)) {
 	case 0: break;
@@ -295,17 +296,26 @@ static int grep_config(const char *var, const char *value, void *cb)
 	default: return 0;
 	}
 
-	if (!strcmp(var, "color.grep")) {
+	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value, -1);
-		return 0;
-	}
-	if (!strcmp(var, "color.grep.match")) {
+	else if (!strcmp(var, "color.grep.filename"))
+		color = opt->color_filename;
+	else if (!strcmp(var, "color.grep.linenumber"))
+		color = opt->color_lineno;
+	else if (!strcmp(var, "color.grep.match"))
+		color = opt->color_match;
+	else if (!strcmp(var, "color.grep.separator"))
+		color = opt->color_sep;
+	else
+		return git_color_default_config(var, value, cb);
+	if (color) {
 		if (!value)
 			return config_error_nonbool(var);
-		color_parse(value, var, opt->color_match);
-		return 0;
+		color_parse(value, var, color);
+		if (!strcmp(color, GIT_COLOR_RESET))
+			color[0] = '\0';
 	}
-	return git_color_default_config(var, value, cb);
+	return 0;
 }
 
 /*
@@ -847,7 +857,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	opt.regflags = REG_NEWLINE;
 	opt.max_depth = -1;
 
+	strcpy(opt.color_filename, "");
+	strcpy(opt.color_lineno, "");
 	strcpy(opt.color_match, GIT_COLOR_BOLD_RED);
+	strcpy(opt.color_sep, GIT_COLOR_CYAN);
 	opt.color = -1;
 	git_config(grep_config, &opt);
 	if (opt.color == -1)
diff --git a/grep.c b/grep.c
index a0864f1..3a03060 100644
--- a/grep.c
+++ b/grep.c
@@ -270,9 +270,28 @@ static int word_char(char ch)
 	return isalnum(ch) || ch == '_';
 }
 
+static void output_color(struct grep_opt *opt, const void *data, size_t size,
+			 const char *color)
+{
+	if (opt->color && color && color[0]) {
+		opt->output(opt, color, strlen(color));
+		opt->output(opt, data, size);
+		opt->output(opt, GIT_COLOR_RESET, strlen(GIT_COLOR_RESET));
+	} else
+		opt->output(opt, data, size);
+}
+
+static void output_sep(struct grep_opt *opt, char sign)
+{
+	if (opt->null_following_name)
+		opt->output(opt, "\0", 1);
+	else
+		output_color(opt, &sign, 1, opt->color_sep);
+}
+
 static void show_name(struct grep_opt *opt, const char *name)
 {
-	opt->output(opt, name, strlen(name));
+	output_color(opt, name, strlen(name), opt->color_filename);
 	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
 
@@ -510,31 +529,27 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		      const char *name, unsigned lno, char sign)
 {
 	int rest = eol - bol;
-	char sign_str[1];
 
-	sign_str[0] = sign;
 	if (opt->pre_context || opt->post_context) {
 		if (opt->last_shown == 0) {
 			if (opt->show_hunk_mark)
-				opt->output(opt, "--\n", 3);
+				output_color(opt, "--\n", 3, opt->color_sep);
 			else
 				opt->show_hunk_mark = 1;
 		} else if (lno > opt->last_shown + 1)
-			opt->output(opt, "--\n", 3);
+			output_color(opt, "--\n", 3, opt->color_sep);
 	}
 	opt->last_shown = lno;
 
-	if (opt->null_following_name)
-		sign_str[0] = '\0';
 	if (opt->pathname) {
-		opt->output(opt, name, strlen(name));
-		opt->output(opt, sign_str, 1);
+		output_color(opt, name, strlen(name), opt->color_filename);
+		output_sep(opt, sign);
 	}
 	if (opt->linenum) {
 		char buf[32];
 		snprintf(buf, sizeof(buf), "%d", lno);
-		opt->output(opt, buf, strlen(buf));
-		opt->output(opt, sign_str, 1);
+		output_color(opt, buf, strlen(buf), opt->color_lineno);
+		output_sep(opt, sign);
 	}
 	if (opt->color) {
 		regmatch_t match;
@@ -548,12 +563,9 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 				break;
 
 			opt->output(opt, bol, match.rm_so);
-			opt->output(opt, opt->color_match,
-				    strlen(opt->color_match));
-			opt->output(opt, bol + match.rm_so,
-				    (int)(match.rm_eo - match.rm_so));
-			opt->output(opt, GIT_COLOR_RESET,
-				    strlen(GIT_COLOR_RESET));
+			output_color(opt, bol + match.rm_so,
+				     match.rm_eo - match.rm_so,
+				     opt->color_match);
 			bol += match.rm_eo;
 			rest -= match.rm_eo;
 			eflags = REG_NOTBOL;
@@ -823,7 +835,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 				return 1;
 			if (binary_match_only) {
 				opt->output(opt, "Binary file ", 12);
-				opt->output(opt, name, strlen(name));
+				output_color(opt, name, strlen(name),
+					     opt->color_filename);
 				opt->output(opt, " matches\n", 9);
 				return 1;
 			}
@@ -882,9 +895,9 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	 */
 	if (opt->count && count) {
 		char buf[32];
-		opt->output(opt, name, strlen(name));
-		snprintf(buf, sizeof(buf), "%c%u\n",
-			 opt->null_following_name ? '\0' : ':', count);
+		output_color(opt, name, strlen(name), opt->color_filename);
+		output_sep(opt, ':');
+		snprintf(buf, sizeof(buf), "%u\n", count);
 		opt->output(opt, buf, strlen(buf));
 	}
 	return !!last_hit;
diff --git a/grep.h b/grep.h
index 9703087..36919ee 100644
--- a/grep.h
+++ b/grep.h
@@ -84,7 +84,10 @@ struct grep_opt {
 	int color;
 	int max_depth;
 	int funcname;
+	char color_filename[COLOR_MAXLEN];
+	char color_lineno[COLOR_MAXLEN];
 	char color_match[COLOR_MAXLEN];
+	char color_sep[COLOR_MAXLEN];
 	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
-- 
1.7.0
