From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 2/7] Show items of interactive git-clean in columns
Date: Tue,  7 May 2013 03:18:51 +0800
Message-ID: <6276dc8861b40e8377586f30b85c33e92c4e68fe.1367867498.git.worldhello.net@gmail.com>
References: <cover.1367867498.git.worldhello.net@gmail.com>
 <4a32eb7cc4e277fcbf4b46c13524874334bea2a3.1367867498.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 06 21:19:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQwZ-0001yF-8f
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693Ab3EFTTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:19:24 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:57484 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab3EFTTX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:19:23 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so2135794pbc.26
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=MoPnevXkjeurm9YIN4Oww0JCkODUlScHXKVHUoL28io=;
        b=pTUNjd9grPtVszt6hpihn4rZIHx9Bnc8Ae7Nq9o1zTjn//y9sAnmF00V00A3f3VIdB
         uSID2agq6sPsaxSe25Fg30yzwiduJmfbBGlEYBhXDz5/IUxJEhhojEkgkikzmdQrWVj1
         n7/aroMFefXrod8GJTyDdJg1I85HXIBgPTQN3713PcuK8msDdRdI2vNgwpr1Dd7OExS8
         rm3uqXdMINlSphqfiJhW/4lFmanYRBpMwIMA8+PZefhxFuef2c1GHCa27b6yC+nB9dYb
         nws4ZcESXnXQQFCD4ZBdoFqJIfR+wpdiW195guCdghuAKHsjfjedIihi1ap3W9lO9Rb2
         p8lw==
X-Received: by 10.67.5.168 with SMTP id cn8mr28592204pad.119.1367867963108;
        Mon, 06 May 2013 12:19:23 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id z8sm24951256pbt.23.2013.05.06.12.19.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 May 2013 12:19:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.338.gb35aa5d
In-Reply-To: <4a32eb7cc4e277fcbf4b46c13524874334bea2a3.1367867498.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1367867498.git.worldhello.net@gmail.com>
References: <CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com> <cover.1367867498.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223492>

When there are lots of items to be cleaned, it is hard to see them all
in one screen. Show them in columns instead of in one column will solve
this problem.

Since no longer show items to be cleaned using the "Would remove ..."
format (only plain filenames) in interactive mode, we add instructions
and warnings as header before them.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Comments-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt |  4 ++++
 builtin/clean.c          | 58 +++++++++++++++++++++++++++++++++---------------
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53f..98bfa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -955,6 +955,10 @@ column.branch::
 	Specify whether to output branch listing in `git branch` in columns.
 	See `column.ui` for details.
 
+column.clean::
+	Specify whether to output cleaning files in `git clean -i` in columns.
+	See `column.ui` for details.
+
 column.status::
 	Specify whether to output untracked files in `git status` in columns.
 	See `column.ui` for details.
diff --git a/builtin/clean.c b/builtin/clean.c
index 29fbf..43383 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -13,11 +13,13 @@
 #include "refs.h"
 #include "string-list.h"
 #include "quote.h"
+#include "column.h"
 
 static int force = -1; /* unset */
 static int interactive;
 static struct string_list del_list = STRING_LIST_INIT_DUP;
 static const char **the_prefix;
+static unsigned int colopts;
 
 static const char *const builtin_clean_usage[] = {
 	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
@@ -32,8 +34,13 @@ static const char *msg_warn_remove_failed = N_("failed to remove %s");
 
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "clean.requireforce"))
+	if (!prefixcmp(var, "column."))
+		return git_column_config(var, value, "clean", &colopts);
+
+	if (!strcmp(var, "clean.requireforce")) {
 		force = !git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -145,6 +152,33 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	return ret;
 }
 
+void pretty_print_dels()
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct strbuf buf = STRBUF_INIT;
+	const char *qname;
+	struct column_options copts;
+
+	for_each_string_list_item(item, &del_list) {
+		qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
+		string_list_append(&list, qname);
+	}
+
+	/*
+	 * always enable column display, we only consult column.*
+	 * about layout strategy and stuff
+	 */
+	colopts = (colopts & ~COL_ENABLE_MASK) | COL_ENABLED;
+	memset(&copts, 0, sizeof(copts));
+	copts.indent = "  ";
+	copts.padding = 2;
+	print_columns(&list, colopts, &copts);
+	putchar('\n');
+	strbuf_release(&buf);
+	string_list_clear(&list, 0);
+}
+
 void edit_by_patterns_cmd()
 {
 	struct dir_struct dir;
@@ -153,7 +187,6 @@ void edit_by_patterns_cmd()
 	struct strbuf **ignore_list;
 	struct string_list_item *item;
 	struct exclude_list *el;
-	const char *qname;
 	int changed = -1, i;
 
 	while (1) {
@@ -166,12 +199,8 @@ void edit_by_patterns_cmd()
 		if (changed) {
 			putchar('\n');
 
-			/* Display dels in "Would remove ..." format */
-			for_each_string_list_item(item, &del_list) {
-				qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
-				printf(_(msg_would_remove), qname);
-			}
-			putchar('\n');
+			/* Display dels in columns */
+			pretty_print_dels();
 		}
 
 		printf(_("Input ignore patterns>> "));
@@ -228,23 +257,17 @@ void edit_by_patterns_cmd()
 void interactive_main_loop()
 {
 	struct strbuf confirm = STRBUF_INIT;
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list_item *item;
-	const char *qname;
 
 	/* dels list may become empty after return back from edit mode */
 	while (del_list.nr) {
+		putchar('\n');
 		printf_ln(Q_("Would remove the following item:",
 			     "Would remove the following items:",
 			     del_list.nr));
 		putchar('\n');
 
-		/* Display dels in "Would remove ..." format */
-		for_each_string_list_item(item, &del_list) {
-			qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
-			printf(_(msg_would_remove), qname);
-		}
-		putchar('\n');
+		/* Display dels in columns */
+		pretty_print_dels();
 
 		/* Confirmation dialog */
 		printf(_("Remove ([y]es/[n]o/[e]dit) ? "));
@@ -274,7 +297,6 @@ void interactive_main_loop()
 		}
 	}
 
-	strbuf_release(&buf);
 	strbuf_release(&confirm);
 }
 
-- 
1.8.3.rc1.338.gb35aa5d
