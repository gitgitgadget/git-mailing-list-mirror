From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH][RFC] grep: add color.grep.matchcontext and color.grep.matchselected
Date: Mon, 27 Oct 2014 19:23:05 +0100
Message-ID: <544E8D89.3030201@web.de>
References: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com> <544D3A3C.4080906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Zoltan Klinger <zoltan.klinger@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 19:23:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xiowv-0007EW-39
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 19:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbaJ0SXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 14:23:21 -0400
Received: from mout.web.de ([212.227.15.3]:59570 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbaJ0SXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 14:23:20 -0400
Received: from [192.168.178.27] ([79.253.149.186]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MNt4V-1Xkkt43md1-007SLG; Mon, 27 Oct 2014 19:23:17
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <544D3A3C.4080906@web.de>
X-Provags-ID: V03:K0:cYM/P/YflS3lgkj5/GdhCj31Ug3hYbzZU8KddSAN5qXxco9iUBd
 YPnCrQ76HAbzO6JQRLyUkGvofKQlYBit2vjUbys81ZAyM7K0vol8HblCCJiGSyZXIAZ+e1d
 nJ8JYfYOu2F736XFhrl+kP56R5B5gqI+VK6AeF/Z/S4+YlGUO53Rdi6OPYXuqFLVY1zyMRC
 0hwsSkaTIOzP5icvm+g1w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The config option color.grep.match can be used to specify the highlighting
color for matching strings.  Add the options matchContext and matchSelected
to allow different colors to be specified for matching strings in the
context vs. in selected lines.  This is similar to the ms and mc specifiers
in GNU grep's environment variable GREP_COLORS.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Only *very* lightly tested, and a test for t/is missing anyway.  Just
wanted to quickly show what I meant.  You'd set color.grep.matchContext=""
to turn off highlighting in context lines.  What do you think?

 Documentation/config.txt |  6 +++++-
 grep.c                   | 29 ++++++++++++++++++++++-------
 grep.h                   |  3 ++-
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8b49813..78832ae 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -885,7 +885,11 @@ color.grep.<slot>::
 `linenumber`;;
 	line number prefix (when using `-n`)
 `match`;;
-	matching text
+	matching text (same as setting `matchContext` and `matchSelected`)
+`matchContext`;;
+	matching text in context lines
+`matchSelected`;;
+	matching text in selected lines
 `selected`;;
 	non-matching text in selected lines
 `separator`;;
diff --git a/grep.c b/grep.c
index 4dc31ea..6e085f8 100644
--- a/grep.c
+++ b/grep.c
@@ -35,7 +35,8 @@ void init_grep_defaults(void)
 	strcpy(opt->color_filename, "");
 	strcpy(opt->color_function, "");
 	strcpy(opt->color_lineno, "");
-	strcpy(opt->color_match, GIT_COLOR_BOLD_RED);
+	strcpy(opt->color_match_context, GIT_COLOR_BOLD_RED);
+	strcpy(opt->color_match_selected, GIT_COLOR_BOLD_RED);
 	strcpy(opt->color_selected, "");
 	strcpy(opt->color_sep, GIT_COLOR_CYAN);
 	opt->color = -1;
@@ -101,12 +102,22 @@ int grep_config(const char *var, const char *value, void *cb)
 		color = opt->color_function;
 	else if (!strcmp(var, "color.grep.linenumber"))
 		color = opt->color_lineno;
-	else if (!strcmp(var, "color.grep.match"))
-		color = opt->color_match;
+	else if (!strcmp(var, "color.grep.matchcontext"))
+		color = opt->color_match_context;
+	else if (!strcmp(var, "color.grep.matchselected"))
+		color = opt->color_match_selected;
 	else if (!strcmp(var, "color.grep.selected"))
 		color = opt->color_selected;
 	else if (!strcmp(var, "color.grep.separator"))
 		color = opt->color_sep;
+	else if (!strcmp(var, "color.grep.match")) {
+		int rc = 0;
+		if (!value)
+			return config_error_nonbool(var);
+		rc |= color_parse(value, opt->color_match_context);
+		rc |= color_parse(value, opt->color_match_selected);
+		return rc;
+	}
 
 	if (color) {
 		if (!value)
@@ -144,7 +155,8 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	strcpy(opt->color_filename, def->color_filename);
 	strcpy(opt->color_function, def->color_function);
 	strcpy(opt->color_lineno, def->color_lineno);
-	strcpy(opt->color_match, def->color_match);
+	strcpy(opt->color_match_context, def->color_match_context);
+	strcpy(opt->color_match_selected, def->color_match_selected);
 	strcpy(opt->color_selected, def->color_selected);
 	strcpy(opt->color_sep, def->color_sep);
 }
@@ -1084,7 +1096,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		      const char *name, unsigned lno, char sign)
 {
 	int rest = eol - bol;
-	char *line_color = NULL;
+	const char *match_color, *line_color = NULL;
 
 	if (opt->file_break && opt->last_shown == 0) {
 		if (opt->show_hunk_mark)
@@ -1123,6 +1135,10 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		int eflags = 0;
 
 		if (sign == ':')
+			match_color = opt->color_match_selected;
+		else
+			match_color = opt->color_match_context;
+		if (sign == ':')
 			line_color = opt->color_selected;
 		else if (sign == '-')
 			line_color = opt->color_context;
@@ -1135,8 +1151,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 
 			output_color(opt, bol, match.rm_so, line_color);
 			output_color(opt, bol + match.rm_so,
-				     match.rm_eo - match.rm_so,
-				     opt->color_match);
+				     match.rm_eo - match.rm_so, match_color);
 			bol += match.rm_eo;
 			rest -= match.rm_eo;
 			eflags = REG_NOTBOL;
diff --git a/grep.h b/grep.h
index eaaced1..95f197a 100644
--- a/grep.h
+++ b/grep.h
@@ -124,7 +124,8 @@ struct grep_opt {
 	char color_filename[COLOR_MAXLEN];
 	char color_function[COLOR_MAXLEN];
 	char color_lineno[COLOR_MAXLEN];
-	char color_match[COLOR_MAXLEN];
+	char color_match_context[COLOR_MAXLEN];
+	char color_match_selected[COLOR_MAXLEN];
 	char color_selected[COLOR_MAXLEN];
 	char color_sep[COLOR_MAXLEN];
 	int regflags;
-- 
2.1.2
