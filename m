From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v9 3/9] git-clean: show items of del_list in columns
Date: Tue, 14 May 2013 16:45:17 +0800
Message-ID: <0b7d32f9f4e3b457124ca663479220bd78791d7c.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 14 10:46:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcAsF-00030F-0J
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 10:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756946Ab3ENIqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 04:46:06 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:62983 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756925Ab3ENIp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 04:45:58 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so239976pdj.36
        for <git@vger.kernel.org>; Tue, 14 May 2013 01:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=uEfuXjG9yW+BeNnFBhrMlu9I5qF35j5sccBf2O718KQ=;
        b=BgXSqKvLtmNInxovkyljOeYvYYP9ew8YE67Ux5t1UYI9WB3CocsWRinL2Rr9Sy3ElB
         cg39jph/YIGGOm2l5n0Z84S0Ngb/0l9OZ64UV6pMuUDlWtrsNZvJML0qGRWVCuDbhPjn
         emqbLlqD9t7a/XOmJzXxync959E73cmrtDI0MmSkrhuSZYj/qd728AZGsPO79fdtwBok
         dSrIAPHYEFKW/B+N4maNtYCTq4T1oGXAZ1KNpPagGlkP7LVekrSOdlWSbutn5Fjq7zIO
         m1Nt+SSwxM0fltR8PhENkg+iRgNZByJZ23T/UV6Eg3se6H4HQatpQRqZK7CXtkzKY/OA
         vpKA==
X-Received: by 10.66.254.131 with SMTP id ai3mr18197200pad.54.1368521157940;
        Tue, 14 May 2013 01:45:57 -0700 (PDT)
Received: from localhost.localdomain ([114.248.141.128])
        by mx.google.com with ESMTPSA id wt5sm17356069pbc.38.2013.05.14.01.45.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 01:45:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.401.gfc9adf8
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224287>

When there are lots of items to be cleaned, it is hard to see them all
in one screen. Show them in columns will solve this problem.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Comments-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt |  4 ++++
 builtin/clean.c          | 49 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53f..e031b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -955,6 +955,10 @@ column.branch::
 	Specify whether to output branch listing in `git branch` in columns.
 	See `column.ui` for details.
 
+column.clean::
+	Specify the layout when list items in `git clean -i`, which always
+	shows files and directories in columns. See `column.ui` for details.
+
 column.status::
 	Specify whether to output untracked files in `git status` in columns.
 	See `column.ui` for details.
diff --git a/builtin/clean.c b/builtin/clean.c
index 127463..d7c68 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -13,10 +13,12 @@
 #include "refs.h"
 #include "string-list.h"
 #include "quote.h"
+#include "column.h"
 
 static int force = -1; /* unset */
 static int interactive;
 static struct string_list del_list = STRING_LIST_INIT_DUP;
+static unsigned int colopts;
 
 static const char *const builtin_clean_usage[] = {
 	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
@@ -31,8 +33,13 @@ static const char *msg_warn_remove_failed = N_("failed to remove %s");
 
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
 
@@ -186,21 +193,46 @@ static const char *path_relative(const char *in, const char *prefix)
 	return buf;
 }
 
-static void interactive_main_loop(void)
+static void pretty_print_dels(void)
 {
-	struct strbuf confirm = STRBUF_INIT;
-	struct strbuf buf = STRBUF_INIT;
+	struct string_list list = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
+	struct strbuf buf = STRBUF_INIT;
 	const char *qname;
+	struct column_options copts;
+
+	for_each_string_list_item(item, &del_list) {
+		qname = quote_path_relative(item->string, -1, &buf, NULL);
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
+static void interactive_main_loop(void)
+{
+	struct strbuf confirm = STRBUF_INIT;
 
 	while (del_list.nr) {
 		putchar('\n');
-		for_each_string_list_item(item, &del_list) {
-			qname = quote_path_relative(item->string, -1, &buf, NULL);
-			printf(_(msg_would_remove), qname);
-		}
+		printf_ln(Q_("Would remove the following item:",
+			     "Would remove the following items:",
+			     del_list.nr));
 		putchar('\n');
 
+		pretty_print_dels();
+
 		printf(_("Remove [y/n]? "));
 		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
 			strbuf_trim(&confirm);
@@ -226,7 +258,6 @@ static void interactive_main_loop(void)
 		}
 	}
 
-	strbuf_release(&buf);
 	strbuf_release(&confirm);
 }
 
-- 
1.8.3.rc1.404.gb9fcf3e
