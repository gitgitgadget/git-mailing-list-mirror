From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 6/4] add grep.hunkHeadingFunction option
Date: Tue, 27 Mar 2012 01:31:26 -0400
Message-ID: <1332826286-13490-2-git-send-email-lodatom@gmail.com>
References: <1332826286-13490-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:32:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCP16-0006KU-Kg
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 07:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab2C0FcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 01:32:14 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:40235 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab2C0FcL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 01:32:11 -0400
Received: by qadc11 with SMTP id c11so2616269qad.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 22:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=D9SONyJzE/0pHzL2YEvoEFhG3vQ0ExSXFpy9Jz8IiO4=;
        b=EVIWCAkKXhF9Zqgv8J5MM4r0ht5x4b2adjTFwIFcBVwSNULM+rPdopLGXf71AWL6bD
         IQRSiiKt7hK3PYRA6xLVtD+08XgVcjtpMur9pzlyzE36YYX1BahIrvodtkpq3Q59LPEe
         5XIqZ+c2R8j+DuIz0RGhDAvUg1Let22sOZd7g3jgvSoVO7WjS7tJ9rbShODsTMYvJzFz
         q9z+K2yLqz1DBiMI5IpYPKXUJQ3llSL5Nf6cIIoj9PVU2eJwBbED21qR+MW7P6jFATcw
         GtKPB7BcEHd8gUzPJHfTF5CJ7GxqG+xPJNly1k6eRpH42fFD8FOg2izLMOl5l9S2NYs7
         Sx+A==
Received: by 10.224.116.18 with SMTP id k18mr31106370qaq.14.1332826330965;
        Mon, 26 Mar 2012 22:32:10 -0700 (PDT)
Received: from mark.hsd1.dc.comcast.net. (c-76-21-213-235.hsd1.dc.comcast.net. [76.21.213.235])
        by mx.google.com with ESMTPS id fp8sm20718309qab.20.2012.03.26.22.32.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 22:32:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.4
In-Reply-To: <1332826286-13490-1-git-send-email-lodatom@gmail.com>
In-Reply-To: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194010>

If set to true, the function line is printed on the same line as the
first hunk header (but only if a hunk header is printed).

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---

I was not sure if it would be better to have this as a configuration setting,
a command-line option, or both.  It probably doesn't matter for this round,
since the main purpose of this post is to get the idea out there so people can
try it out this feature see if they like it at all.

There might have been a better way to implement this.  Currently, we have the
entire file in memory, so I could have just stored a pointer to the function
name line, rather than copying it.  Perhaps this would have been better?

Also, I chose to only print the function name once, rather than duplicating it
on each header, so as to reduce visual clutter.  I can see an argument both
ways, so if you would like to have the function name printed on every header,
just remove the "opt->func_line[0] = '\0'" from the beginning of
show_funcname_line().


 Documentation/config.txt   |    5 +++++
 Documentation/git-grep.txt |    5 +++++
 builtin/grep.c             |    5 +++++
 grep.c                     |   24 +++++++++++++++++++++++-
 grep.h                     |    3 +++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ade9503..1e3b5ec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1143,6 +1143,11 @@ grep.extendedRegexp::
 grep.hunkHeading::
 	If set to true, enable '--hunk-heading' option by default.
 
+grep.hunkHeadingFunction::
+	If set to true, print the function name in the hunk heading rather
+	than on its own line.  This only occurs when hunk headings would have
+	been shown and '--show-function' is used.
+
 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
 	making or verifying a PGP signature. The program must support the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 26c085b..a32ac5e 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -46,6 +46,11 @@ grep.extendedRegexp::
 grep.hunkHeading::
 	If set to true, enable '--hunk-heading' option by default.
 
+grep.hunkHeadingFunction::
+	If set to true, print the function name in the hunk heading rather
+	than on its own line.  This only occurs when hunk headings would have
+	been shown and '--show-function' is used.
+
 
 OPTIONS
 -------
diff --git a/builtin/grep.c b/builtin/grep.c
index cdafc5a..d4c9f92 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -281,6 +281,11 @@ static int grep_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "grep.hunkheadingfunction")) {
+		opt->hunk_heading_function = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "grep.linenumber")) {
 		opt->linenum = git_config_bool(var, value);
 		return 0;
diff --git a/grep.c b/grep.c
index f0e00f7..49e66e3 100644
--- a/grep.c
+++ b/grep.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "grep.h"
 #include "userdiff.h"
+#include "utf8.h"
 #include "xdiff-interface.h"
 
 void append_header_grep_pattern(struct grep_opt *opt, enum grep_header_field field, const char *pat)
@@ -776,6 +777,12 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 			opt->output(opt, " ", 1);
 			output_color(opt, "--", 2, opt->color_sep);
 		}
+		if (opt->hunk_heading && opt->func_line[0] != '\0') {
+			opt->output(opt, " ", 1);
+			output_color(opt, opt->func_line,
+				     strlen(opt->func_line),
+				     opt->color_function);
+		}
 		opt->output(opt, "\n", 1);
 	}
 	opt->last_shown = lno;
@@ -882,6 +889,7 @@ static int match_funcname(struct grep_opt *opt, struct grep_source *gs, char *bo
 static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 			       char *bol, unsigned lno)
 {
+	opt->func_line[0] = '\0';
 	while (bol > gs->buf) {
 		char *eol = --bol;
 
@@ -893,7 +901,18 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 			break;
 
 		if (match_funcname(opt, gs, bol, eol)) {
-			show_line(opt, bol, eol, gs->name, lno, '=');
+			if (opt->hunk_heading_function && opt->hunk_heading &&
+			    opt->funcname &&
+			    (opt->pre_context || opt->post_context ||
+			     opt->funcbody)) {
+				unsigned long len = eol - bol;
+				if (len > GREP_MAX_FUNCLINE)
+					len = GREP_MAX_FUNCLINE;
+				len = utf8_truncate_line(bol, len);
+				memcpy(opt->func_line, bol, len);
+				opt->func_line[len] = '\0';
+			} else
+				show_line(opt, bol, eol, gs->name, lno, '=');
 			break;
 		}
 	}
@@ -930,6 +949,8 @@ static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 	/* We need to look even further back to find a function signature. */
 	if (opt->funcname && funcname_needed)
 		show_funcname_line(opt, gs, bol, cur);
+	else
+		opt->func_line[0] = '\0';
 
 	/* Back forward. */
 	while (cur < lno) {
@@ -1034,6 +1055,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 			opt->show_hunk_mark = 1;
 	}
 	opt->last_shown = 0;
+	opt->func_line[0] = '\0';
 
 	switch (opt->binary) {
 	case GREP_BINARY_DEFAULT:
diff --git a/grep.h b/grep.h
index 761db2a..8112e07 100644
--- a/grep.h
+++ b/grep.h
@@ -118,6 +118,9 @@ struct grep_opt {
 	int file_break;
 	int heading;
 	int hunk_heading;
+	int hunk_heading_function;
+#define GREP_MAX_FUNCLINE	80
+	char func_line[GREP_MAX_FUNCLINE+1];
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
-- 
1.7.9.4
