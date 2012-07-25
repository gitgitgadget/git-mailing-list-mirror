From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 4/4] allow recovery from command name typos
Date: Thu, 26 Jul 2012 00:16:22 +0800
Message-ID: <1343232982-10540-5-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-2-git-send-email-rctay89@gmail.com>
 <1343232982-10540-3-git-send-email-rctay89@gmail.com>
 <1343232982-10540-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 18:17:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su4Gl-0007Bf-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 18:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582Ab2GYQQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 12:16:53 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55919 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab2GYQQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 12:16:51 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1628912pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GFge22BlGGZyxyfO4dT6ezuGnpWy7YH/+2DyPQbHLxI=;
        b=Eb6Vtv2HnRyDfr69oDuKaYumtVocnReFsKfEhxQAKMy7owLzRDYigjxAh67R6NGpO3
         wcwMaOsUx4f7B6ZyoCy62lE44PZPYLQSvCRNRbuvTvq5daPhNdIFY3nTefsXJFhStaQ5
         PSuYWmCAFPzLSmzyPk0gxbzMncSpNysU5sYnukuZHPqaOlixSKtlRel2TrPdpF4l1uCA
         UnxKs1ECSr5zGar70z4S2rJGmZAlT3AUoCMxn97Ba0dGZaQO+621/J9kLjLWVZxxjyL0
         Rv5yKTLxt9c0RvqOuXwzE7FMcHOu8vrjdsyHL28hpbn2E03k+7ShIGrgDEpNvN3fBi46
         F5lQ==
Received: by 10.68.231.39 with SMTP id td7mr54818635pbc.3.1343233011508;
        Wed, 25 Jul 2012 09:16:51 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (cm97.beta238.maxonline.com.sg. [116.86.238.97])
        by mx.google.com with ESMTPS id hw6sm14629418pbc.73.2012.07.25.09.16.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 09:16:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.116.g8228a23
In-Reply-To: <1343232982-10540-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202172>

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

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed in v2: implement Thomas' idea [1] to hijack help.autocorrect to
configure this behaviour.

[1] <878vh4con4.fsf@thomas.inf.ethz.ch>

---
 Documentation/config.txt | 30 +++++++++++++++++------
 advice.c                 |  2 ++
 advice.h                 |  1 +
 help.c                   | 63 +++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 85 insertions(+), 11 deletions(-)

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
index ee261f4..4b45e43 100644
--- a/help.c
+++ b/help.c
@@ -7,6 +7,7 @@
 #include "string-list.h"
 #include "column.h"
 #include "version.h"
+#include "compat/terminal.h"
 
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
@@ -248,12 +249,30 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 }
 
 static int autocorrect;
+static int shall_advise = 1;
+static int shall_prompt;
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
+		shall_advise = 0;
+		if (!strcasecmp(value, "off"))
+			;
+		else if (!strcasecmp(value, "ask"))
+			shall_prompt = 1;
+		else
+			autocorrect = git_config_int(var, value);
+	}
+
 	/* Also use aliases for command lookup */
 	if (!prefixcmp(var, "alias."))
 		add_cmdname(&aliases, var + 6, strlen(var + 6));
@@ -385,8 +404,44 @@ const char *help_unknown_cmd(const char *cmd)
 			      "\nDid you mean one of these?",
 			   n));
 
-		for (i = 0; i < n; i++)
-			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+		if (!isatty(2) || !shall_prompt) {
+			for (i = 0; i < n; i++)
+				fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+			if (isatty(2) && shall_advise && advice_typo_prompt) {
+				fprintf(stderr, "\n");
+				advise(_(message_advice_prompt_ability));
+			}
+		} else if (n == 1) {
+			char *in;
+			const char *ret;
+			fprintf(stderr, "\t%s\n", main_cmds.names[0]->name);
+			in = git_terminal_prompt("[Y/n] ", 1);
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
+			in = git_terminal_prompt("[N/1/2/...] ", 1);
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
 
 	clean_cmdnames(&main_cmds);
-- 
1.7.11.1.116.g8228a23
