From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCHv2 3/3] grep: Colorize selected, context, and function lines
Date: Sun,  7 Mar 2010 11:52:47 -0500
Message-ID: <1267980767-12617-4-git-send-email-lodatom@gmail.com>
References: <1267980767-12617-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 17:53:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoJjU-0006nt-Gv
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 17:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528Ab0CGQxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 11:53:21 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:62386 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab0CGQxM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 11:53:12 -0500
Received: by qyk9 with SMTP id 9so4017863qyk.5
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/cRCHvTEYeM2tWVVJ+jdHMJRYKJxdNH56JT4pwTaFxA=;
        b=tcq+4eVIBsT2y3vL7Jna92FKj0v9in4R9gVGpR+SygbYyIVcE1CJ7gStL4JNEL6d0u
         xGUrG6XBnOr0cZQFUs3guLBBGglKv+dwZxEKZnkfHpmZfjCn9tkzNLewDkOXHqAERjYk
         sieLKCaGmE2rcTkoUjhtci+0pgXv3QcFXxcJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XTfJp/kVKHcarVrWD204ojfF4FmLyoqBLWQRZ7Kydi8POW1GQxBMI9xWw80T9sV3tG
         m/ssvvmaP5u05c2MUWuhzce/hoGG8vRCMVanJ7foQQt+h8ZbDlL+BocB819yjX0PjGVl
         aSCoCLMRWvm+II7RdhykAl3AmrtBomc/1ScZY=
Received: by 10.229.189.212 with SMTP id df20mr1647172qcb.21.1267980791729;
        Sun, 07 Mar 2010 08:53:11 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 20sm2767266qyk.4.2010.03.07.08.53.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 08:53:11 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267980767-12617-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141720>

Colorize non-matching text of selected lines, context lines, and
function name lines.  The default for all three is no color, but they
can be configured using color.grep.<slot>.  The first two are similar
to the corresponding options in GNU grep, except that GNU grep applies
the color to the entire line, not just non-matching text.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/config.txt |    6 ++++++
 builtin-grep.c           |    9 +++++++++
 grep.c                   |   11 +++++++++--
 grep.h                   |    3 +++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 711519e..38bc729 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -683,12 +683,18 @@ color.grep.<slot>::
 	part of the line to use the specified color, and is one of
 +
 --
+`context`;;
+	non-matching text in context lines (when using `-A`, `-B`, or `-C`)
 `filename`;;
 	filename prefix (when not using `-h`)
+`function`;;
+	function name lines (when using `-p`)
 `linenumber`;;
 	line number prefix (when using `-n`)
 `match`;;
 	matching text
+`selected`;;
+	non-matching text in selected lines
 `separator`;;
 	separators between fields on a line (`:`, `-`, and `=`)
 	and between hunks (`--`)
diff --git a/builtin-grep.c b/builtin-grep.c
index 0c8115d..e423eac 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -298,12 +298,18 @@ static int grep_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value, -1);
+	else if (!strcmp(var, "color.grep.context"))
+		color = opt->color_context;
 	else if (!strcmp(var, "color.grep.filename"))
 		color = opt->color_filename;
+	else if (!strcmp(var, "color.grep.function"))
+		color = opt->color_function;
 	else if (!strcmp(var, "color.grep.linenumber"))
 		color = opt->color_lineno;
 	else if (!strcmp(var, "color.grep.match"))
 		color = opt->color_match;
+	else if (!strcmp(var, "color.grep.selected"))
+		color = opt->color_selected;
 	else if (!strcmp(var, "color.grep.separator"))
 		color = opt->color_sep;
 	else
@@ -857,9 +863,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	opt.regflags = REG_NEWLINE;
 	opt.max_depth = -1;
 
+	strcpy(opt.color_context, "");
 	strcpy(opt.color_filename, "");
+	strcpy(opt.color_function, "");
 	strcpy(opt.color_lineno, "");
 	strcpy(opt.color_match, GIT_COLOR_BOLD_RED);
+	strcpy(opt.color_selected, "");
 	strcpy(opt.color_sep, GIT_COLOR_CYAN);
 	opt.color = -1;
 	git_config(grep_config, &opt);
diff --git a/grep.c b/grep.c
index 3a03060..1e0b1e6 100644
--- a/grep.c
+++ b/grep.c
@@ -529,6 +529,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		      const char *name, unsigned lno, char sign)
 {
 	int rest = eol - bol;
+	char *line_color = NULL;
 
 	if (opt->pre_context || opt->post_context) {
 		if (opt->last_shown == 0) {
@@ -557,12 +558,18 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		int ch = *eol;
 		int eflags = 0;
 
+		if (sign == ':')
+			line_color = opt->color_selected;
+		else if (sign == '-')
+			line_color = opt->color_context;
+		else if (sign == '=')
+			line_color = opt->color_function;
 		*eol = '\0';
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
 			if (match.rm_so == match.rm_eo)
 				break;
 
-			opt->output(opt, bol, match.rm_so);
+			output_color(opt, bol, match.rm_so, line_color);
 			output_color(opt, bol + match.rm_so,
 				     match.rm_eo - match.rm_so,
 				     opt->color_match);
@@ -572,7 +579,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		}
 		*eol = ch;
 	}
-	opt->output(opt, bol, rest);
+	output_color(opt, bol, rest, line_color);
 	opt->output(opt, "\n", 1);
 }
 
diff --git a/grep.h b/grep.h
index 36919ee..2c4bdac 100644
--- a/grep.h
+++ b/grep.h
@@ -84,9 +84,12 @@ struct grep_opt {
 	int color;
 	int max_depth;
 	int funcname;
+	char color_context[COLOR_MAXLEN];
 	char color_filename[COLOR_MAXLEN];
+	char color_function[COLOR_MAXLEN];
 	char color_lineno[COLOR_MAXLEN];
 	char color_match[COLOR_MAXLEN];
+	char color_selected[COLOR_MAXLEN];
 	char color_sep[COLOR_MAXLEN];
 	int regflags;
 	unsigned pre_context;
-- 
1.7.0
