From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 08/15] git-clean: show items of del_list in columns
Date: Sat, 18 May 2013 11:19:00 +0800
Message-ID: <d93dbe148950472982968f171cc9ab228f36db46.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:21:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXhh-0005De-8i
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758694Ab3ERDTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:19:53 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:57473 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757363Ab3ERDTv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:19:51 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp8so2580004pbb.36
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=V+EO+/SunWiqnei6Q73tn7TQnDmKC+xtPcCdTRSH34c=;
        b=ZDxEVT0wvuuF1QaHVkIhrTLsN35YszXrORX8ZnZR/Qn2JS5eiuWr75XziQ7G5bnuu+
         6aLynnLpdf+7TW8gcKj9Cr70k7KrFavcdE/7Y8y6yTe2yJ8dxmEFOluFdIhGroD3roKl
         mjwy4YQEMTEmTpHD9SJ0W3W2bHJWsfPm6QkFoF8yFEPy2LgWUuwqBxbsHYhzbOEVbh7K
         MmlhlDfiu/YJGjDYLkCy8riHuHishVb8x0Izr97snYUjZgfVuCwwsa0HU3NpUFjTs70A
         43RWIavlBWvrQMdrZLtYEapSov6F94/Vp9Lca+qmN3b8/8IrFuipYJZip79F1g9bu2tf
         kETQ==
X-Received: by 10.66.232.196 with SMTP id tq4mr52582012pac.167.1368847190022;
        Fri, 17 May 2013 20:19:50 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.19.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:19:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224762>

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
index f28d6..f25ba 100644
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
 
@@ -144,21 +151,46 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	return ret;
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
+		qname = quote_path_relative(item->string, NULL, &buf);
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
-			qname = quote_path_relative(item->string, NULL, &buf);
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
@@ -184,7 +216,6 @@ static void interactive_main_loop(void)
 		}
 	}
 
-	strbuf_release(&buf);
 	strbuf_release(&confirm);
 }
 
-- 
1.8.3.rc2.26.g7472058
