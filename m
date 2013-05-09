From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 04/12] git-clean: add colors to interactive git-clean
Date: Fri, 10 May 2013 01:14:08 +0800
Message-ID: <69d358f762fab15528910d1429b1b8eb58308560.1368118918.git.worldhello.net@gmail.com>
References: <cover.1368118918.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:15:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUQe-0002jf-84
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab3EIROt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:14:49 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:47747 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab3EIROs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:14:48 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so2282991pad.36
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=Ge46KN5HeyVsCo2jMwpplpgZn8Z90WOeQOwb1XePEyk=;
        b=Itbd9LyHDWeK/qRp8LTTFhwe9P/WWruaIBvUNHNYk7ERgXevJFLupwrzYTpe5nhIih
         TjvIng88jnuC74/3wkLjvQ2gePQQRlm0HqAm4hlXqJTYxrnRjaJWRXLaY2jus9gnwZKO
         qD4cpRjkxnnreFjom6OSpJsYskAR7LuTkcIW1kGyzJsqSZARBI7AWuBxOVQ3wahwfalM
         ljMWe/J0wNBPRXpCnsT8LEBTU3Mvc5BVh1AshcgvPL3x7VBx3SfA8zImhCC2bXVZJGLR
         fEUyLmNAPeKgbuD2CC7XBJ6ymgT3zgkKvADexmTrUqh/owK0cax+iIGW2Pk1T6U03bGT
         t5aw==
X-Received: by 10.66.13.194 with SMTP id j2mr13709404pac.205.1368119687337;
        Thu, 09 May 2013 10:14:47 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.14.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:14:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com> <cover.1368118918.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223753>

Show header, help, error messages, and prompt in colors for interactive
git-clean. Re-use config variables for other git commands, such as
git-add--interactive and git-stash:

 * color.interactive: When set to always, always use colors for
   interactive prompts and displays. When false (or never),
   never. When set to true or auto, use colors only when the
   output is to the terminal.

 * color.interactive.<slot>: Use customized color for interactive
   git-clean output (like git add --interactive). <slot> may be
   prompt, header, help or error.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Comments-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/clean.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index a16988..126fc 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -14,6 +14,7 @@
 #include "string-list.h"
 #include "quote.h"
 #include "column.h"
+#include "color.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -31,16 +32,81 @@ static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
 
+static int clean_use_color = -1;
+static char clean_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RESET,
+	GIT_COLOR_NORMAL,	/* PLAIN */
+	GIT_COLOR_BOLD_BLUE,	/* PROMPT */
+	GIT_COLOR_BOLD,		/* HEADER */
+	GIT_COLOR_BOLD_RED,	/* HELP */
+	GIT_COLOR_BOLD_RED,	/* ERROR */
+};
+enum color_clean {
+	CLEAN_COLOR_RESET = 0,
+	CLEAN_COLOR_PLAIN = 1,
+	CLEAN_COLOR_PROMPT = 2,
+	CLEAN_COLOR_HEADER = 3,
+	CLEAN_COLOR_HELP = 4,
+	CLEAN_COLOR_ERROR = 5,
+};
+
+static int parse_clean_color_slot(const char *var, int ofs)
+{
+	if (!strcasecmp(var+ofs, "reset"))
+		return CLEAN_COLOR_RESET;
+	if (!strcasecmp(var+ofs, "plain"))
+		return CLEAN_COLOR_PLAIN;
+	if (!strcasecmp(var+ofs, "prompt"))
+		return CLEAN_COLOR_PROMPT;
+	if (!strcasecmp(var+ofs, "header"))
+		return CLEAN_COLOR_HEADER;
+	if (!strcasecmp(var+ofs, "help"))
+		return CLEAN_COLOR_HELP;
+	if (!strcasecmp(var+ofs, "error"))
+		return CLEAN_COLOR_ERROR;
+	return -1;
+}
+
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
 	if (!prefixcmp(var, "column."))
 		return git_column_config(var, value, "clean", &colopts);
 
+	/* honors the color.interactive* config variables which also
+	   applied in git-add--interactive and git-stash */
+	if (!strcmp(var, "color.interactive")) {
+		clean_use_color = git_config_colorbool(var, value);
+		return 0;
+	}
+	if (!prefixcmp(var, "color.interactive.")) {
+		int slot = parse_clean_color_slot(var, 18);
+		if (slot < 0)
+			return 0;
+		if (!value)
+			return config_error_nonbool(var);
+		color_parse(value, var, clean_colors[slot]);
+		return 0;
+	}
+
 	if (!strcmp(var, "clean.requireforce")) {
 		force = !git_config_bool(var, value);
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+
+	/* inspect the color.ui config variable and others */
+	return git_color_default_config(var, value, cb);
+}
+
+static const char *clean_get_color(enum color_clean ix)
+{
+	if (want_color(clean_use_color))
+		return clean_colors[ix];
+	return "";
+}
+
+static void clean_print_color(enum color_clean ix)
+{
+	printf("%s", clean_get_color(ix));
 }
 
 static int exclude_cb(const struct option *opt, const char *arg, int unset)
@@ -226,14 +292,18 @@ static void interactive_main_loop(void)
 
 	while (del_list.nr) {
 		putchar('\n');
+		clean_print_color(CLEAN_COLOR_HEADER);
 		printf_ln(Q_("Would remove the following item:",
 			     "Would remove the following items:",
 			     del_list.nr));
+		clean_print_color(CLEAN_COLOR_RESET);
 		putchar('\n');
 
 		pretty_print_dels();
 
+		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Remove (y/n) ? "));
+		clean_print_color(CLEAN_COLOR_RESET);
 		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
 			strbuf_trim(&confirm);
 		} else {
-- 
1.8.3.rc1.341.g24a8a0f
