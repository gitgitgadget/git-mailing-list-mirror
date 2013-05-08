From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 02/10] Show items of interactive git-clean in columns
Date: Wed,  8 May 2013 19:38:47 +0800
Message-ID: <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
 <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 13:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2iS-00014J-Bp
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259Ab3EHLjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:39:16 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:38994 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab3EHLjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:39:15 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1178107pde.9
        for <git@vger.kernel.org>; Wed, 08 May 2013 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=zJwakT5EJQ5g2vnTYR4/Iox5C/7T88GIaiL9BbfGmoY=;
        b=m/ROiZOJpoUoOz+CJr19Bhz7Dw8bPLRhYD3mlsKMkU05Ea5Wtx0JELH4CRgnDypkYZ
         4zkpTubnHYv1u/5Ud1WwzrjN+OAXOG5bA/LurfrXJggnOdAl1hVeVm0JnvCffoPXJThp
         ZPuHa6eDi9PD9wEypfT1ue+nHSeYR+rYzlSi6SbprA+Pj1n1oTk8eeIiG2uhC0dgeg2R
         Q34r0leT3Cz1uz6t9vRcVRoB1wwkfzSlF1s6b7PQZWsDeNW2WhN1qjlOTujUP5QA89/k
         po1XjOvMbKGiix8pukMewK1GsbosTVxY09TiHNXJQx5o78TiwWM54CeH5NYR+tybWUcT
         6/Vw==
X-Received: by 10.66.118.172 with SMTP id kn12mr7520968pab.128.1368013154864;
        Wed, 08 May 2013 04:39:14 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id gc5sm32287860pbb.19.2013.05.08.04.39.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 04:39:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g1c24ab7
In-Reply-To: <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223658>

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
index 49aab..38ed0 100644
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
 
+static void pretty_print_dels()
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
 static void edit_by_patterns_cmd()
 {
 	struct dir_struct dir;
@@ -153,7 +187,6 @@ static void edit_by_patterns_cmd()
 	struct strbuf **ignore_list;
 	struct string_list_item *item;
 	struct exclude_list *el;
-	const char *qname;
 	int changed = -1, i;
 
 	while (1) {
@@ -166,12 +199,8 @@ static void edit_by_patterns_cmd()
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
@@ -228,23 +257,17 @@ static void edit_by_patterns_cmd()
 static void interactive_main_loop()
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
@@ -274,7 +297,6 @@ static void interactive_main_loop()
 		}
 	}
 
-	strbuf_release(&buf);
 	strbuf_release(&confirm);
 }
 
-- 
1.8.3.rc1.341.g1c24ab7
