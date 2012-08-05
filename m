From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 2/2] allow recovery from command name typos
Date: Mon,  6 Aug 2012 02:45:40 +0800
Message-ID: <1344192340-19415-3-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 20:46:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy5q4-0003Hp-0h
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 20:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab2HESqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 14:46:03 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60972 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab2HESqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 14:46:00 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so1357511pbb.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8OIViktPLLKgntLCKdoqnyjHbV1JfFuhF4nn0ICaOok=;
        b=w+p9e7x+V4IFcVaMCmhPUkcOq5sYy1tEsuBgfOiePoz7btrz0tdQ9ig31FSLUkwKHA
         1JELHoTB3ySYiklx8+I8BKI0yNetVV4VfFtmB3/MhkmmrdMYP9cYKv4Yx4NvDPN6d7LR
         j9Ag2JIzOP7WKQMiUS3hC7bsiXIQEjKhn8Usf2b9VPbRxucGxj2RK0w9OQ3Rey4UyGwu
         NTeAnfNGLdx60NIX+3yavabXdYb0CbeMT0Uyx/gqAAkp50aVdUci2p3Y/puP+8vMHVUN
         ad/ddwX5nmO2vEYy6fg6XcqE06iqoZ/nPi91+3S5JBl5GXeu4h/QPnRiuQIkJOvZViut
         0QKQ==
Received: by 10.66.86.71 with SMTP id n7mr13071093paz.7.1344192360612;
        Sun, 05 Aug 2012 11:46:00 -0700 (PDT)
Received: from ubu-01-asus.gateway.2wire.net (cm83.beta238.maxonline.com.sg. [116.86.238.83])
        by mx.google.com with ESMTPS id sf2sm4151691pbc.57.2012.08.05.11.45.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 11:46:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1.187.g6dd9156
In-Reply-To: <1344192340-19415-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202915>

If suggestions are available (based on Levenshtein distance) and if the
terminal isatty(), present a prompt to the user to select one of the
computed suggestions.

In the case where there is a single suggestion, present the prompt
"[Y/n]", such that "" (ie. the default), "y" and "Y" as input leads git
to proceed executing the suggestion, while everything else (possibly
"n") leads git to terminate.

In the case where there are multiple suggestions, number the suggestions
1 to <n> (the number of suggestions), and accept an integer as input,
while everything else (possibly "n") leads git to terminate. In this
case there is no default; an empty input leads git to terminate. A
sample run:

  $ git sh --pretty=oneline
  git: 'sh' is not a git command. See 'git --help'.

  Did you mean one of these?
  1:    show
  2:    push
  [N/1/2/...]

This prompt is enabled only if help.autocorrect is set to ask; if unset,
advise the user about this ability.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed in v3:
 - say do_* instead of shall_*
 - use new terminal interface

 Documentation/config.txt | 30 ++++++++++++++++-----
 advice.c                 |  2 ++
 advice.h                 |  1 +
 help.c                   | 68 +++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcea8a..0bb175a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -177,6 +177,10 @@ advice.*::
 		Advice shown when you used linkgit:git-checkout[1] to
 		move to the detach HEAD state, to instruct how to create
 		a local branch after the fact.
+	typoPrompt::
+		Upon a mistyped command, if 'help.autocorrect' is unset
+		advise that an interactive prompt can be displayed to
+		recover from the typo.
 --
 
 core.fileMode::
@@ -1323,13 +1327,25 @@ help.format::
 	the default. 'web' and 'html' are the same.
 
 help.autocorrect::
-	Automatically correct and execute mistyped commands after
-	waiting for the given number of deciseconds (0.1 sec). If more
-	than one command can be deduced from the entered text, nothing
-	will be executed.  If the value of this option is negative,
-	the corrected command will be executed immediately. If the
-	value is 0 - the command will be just shown but not executed.
-	This is the default.
+	Specifies behaviour to recover from mistyped commands.
++
+When set to `ask`, an interactive prompt is displayed, allowing the user
+to select a suggested command for execution.
++
+When set to `off`, no attempt to recover is made.
++
+If a number is given, it will be interpreted as the deciseconds (0.1
+sec) to wait before automatically correcting and executing the mistyped
+command, with the following behaviour:
++
+* If more than one command can be deduced from the entered text, nothing
+  will be executed.
+* If the value of this option is negative, the corrected command will be
+  executed immediately.
+* If the value is 0 - the command will be just shown but not executed.
++
+The default is to display a message suggesting that this option be set
+to `ask`, without attempting to recover (see `advice.typoPrompt`).
 
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy',
diff --git a/advice.c b/advice.c
index a492eea..d070a05 100644
--- a/advice.c
+++ b/advice.c
@@ -9,6 +9,7 @@ int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
 int advice_implicit_identity = 1;
 int advice_detached_head = 1;
+int advice_typo_prompt = 1;
 
 static struct {
 	const char *name;
@@ -23,6 +24,7 @@ static struct {
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
+	{ "typoprompt", &advice_typo_prompt },
 };
 
 void advise(const char *advice, ...)
diff --git a/advice.h b/advice.h
index f3cdbbf..050068d 100644
--- a/advice.h
+++ b/advice.h
@@ -12,6 +12,7 @@ extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
+extern int advice_typo_prompt;
 
 int git_default_advice_config(const char *var, const char *value);
 void advise(const char *advice, ...);
diff --git a/help.c b/help.c
index c4285a5..cc13b92 100644
--- a/help.c
+++ b/help.c
@@ -7,6 +7,7 @@
 #include "string-list.h"
 #include "column.h"
 #include "version.h"
+#include "compat/terminal.h"
 
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
@@ -233,12 +234,30 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 }
 
 static int autocorrect;
+static int do_advise = 1;
+static int do_prompt;
+static const char message_advice_prompt_ability[] =
+	N_("I can display an interactive prompt to proceed with one of the above\n"
+	   "suggestions; if you wish me to do so, use\n"
+	   "\n"
+	   "  git config --global help.autocorrect ask\n"
+	   "\n"
+	   "See 'git help config' and search for 'help.autocorrect' for further\n"
+	   "information.\n");
 static struct cmdnames aliases;
 
 static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "help.autocorrect"))
-		autocorrect = git_config_int(var,value);
+	if (!strcmp(var, "help.autocorrect") && value) {
+		do_advise = 0;
+		if (!strcasecmp(value, "off"))
+			;
+		else if (!strcasecmp(value, "ask"))
+			do_prompt = 1;
+		else
+			autocorrect = git_config_int(var, value);
+	}
+
 	/* Also use aliases for command lookup */
 	if (!prefixcmp(var, "alias."))
 		add_cmdname(&aliases, var + 6, strlen(var + 6));
@@ -366,13 +385,54 @@ const char *help_unknown_cmd(const char *cmd)
 	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 
 	if (SIMILAR_ENOUGH(best_similarity)) {
+		term_t term;
+
 		fprintf_ln(stderr,
 			   Q_("\nDid you mean this?",
 			      "\nDid you mean one of these?",
 			   n));
 
-		for (i = 0; i < n; i++)
-			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+		term = terminal_open();
+		if (!term || !do_prompt) {
+			for (i = 0; i < n; i++)
+				fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+			if (isatty(2) && do_advise && advice_typo_prompt) {
+				fprintf(stderr, "\n");
+				advise(_(message_advice_prompt_ability));
+			}
+		} else if (n == 1) {
+			char *in;
+			const char *ret;
+			fprintf(stderr, "\t%s\n", main_cmds.names[0]->name);
+			in = terminal_prompt(term, "[Y/n] ", 1);
+			terminal_close(term);
+			switch (in[0]) {
+			case 'y': case 'Y': case 0:
+				ret = xstrdup(main_cmds.names[0]->name);
+				clean_cmdnames(&main_cmds);
+				return ret;
+			/* otherwise, don't do anything */
+			}
+		} else {
+			char *in;
+			const char *ret;
+			int opt;
+			for (i = 0; i < n; i++)
+				fprintf(stderr, "%d:\t%s\n", i + 1, main_cmds.names[i]->name);
+			in = terminal_prompt(term, "[N/1/2/...] ", 1);
+			terminal_close(term);
+			switch (in[0]) {
+			case 'n': case 'N': case 0:
+				;
+			default:
+				opt = atoi(in);
+				if (0 < opt && opt <= n) {
+					ret = xstrdup(main_cmds.names[opt - 1]->name);
+					clean_cmdnames(&main_cmds);
+					return ret;
+				}
+			}
+		}
 	}
 
 	exit(1);
-- 
1.7.12.rc1.187.g6dd9156
