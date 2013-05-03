From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 2/3] Show items of interactive git-clean in columns
Date: Fri,  3 May 2013 11:49:54 +0800
Message-ID: <4f3bc9f30c0f544d16bef5b2a5ea4f5412ca3b36.1367551846.git.worldhello.net@gmail.com>
References: <cover.1367551846.git.worldhello.net@gmail.com>
 <63984814a9679ca8eedecda308bd1131658e95d6.1367551846.git.worldhello.net@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 03 05:50:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY711-0000lZ-BY
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 05:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762545Ab3ECDuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 23:50:23 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:54373 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761475Ab3ECDuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 23:50:17 -0400
Received: by mail-pb0-f42.google.com with SMTP id up7so685248pbc.15
        for <git@vger.kernel.org>; Thu, 02 May 2013 20:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=/BXLj1inhsgHNcEOgka4QjXMN/FFbqATECrZcnevpHk=;
        b=lTvNF2R4pjhL/OQM7RLDurkSTNzhLHiIULbtwSYdwSHif5UaFifclvsP1eKgc42zLx
         RMBCjmBsv9fDkw9ozd8rfB+59IvV+7yh2dEftHAtbAuNjLa1XVTqW8vFbwgMHtW3fxlk
         3Wmxl9YXbK93cv0vsEJTG5qPZ19l+FLNS3mUw+4lHbgY0rUw0fkzGb9cFj98nFB627vp
         1tJewK00VFbMw/EwhEmjBq8a952sUEmJkIdQWh2OFU4+HCq4FKchwDYFaxRO9zOn5oHt
         RQTwtS5AsIe34+IRBoKrGxDZXmW13qJPZLmodTzqSJ0XOQcL4P6YAJNLWBxUBFHn6oUl
         +2IA==
X-Received: by 10.66.175.73 with SMTP id by9mr12558288pac.191.1367553016920;
        Thu, 02 May 2013 20:50:16 -0700 (PDT)
Received: from localhost.localdomain ([114.246.126.106])
        by mx.google.com with ESMTPSA id qb1sm9819651pbb.33.2013.05.02.20.50.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 20:50:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.364.g6e54870
In-Reply-To: <63984814a9679ca8eedecda308bd1131658e95d6.1367551846.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1367551846.git.worldhello.net@gmail.com>
References: <cover.1367551846.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223274>

When there are lots of items to be cleaned, it is hard to see them all
in one screen. Show them in columns instead of in one column will solve
this problem.

Since no longer show items to be cleaned using the "Would remove ..."
format (only plain filenames) in interactive mode, we add instructions
and warnings as header before them.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Comments-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/clean.c | 64 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 12489..6ee7 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -13,9 +13,11 @@
 #include "refs.h"
 #include "string-list.h"
 #include "quote.h"
+#include "column.h"
 
 static int force = -1; /* unset */
 static int interactive;
+static unsigned int colopts;
 
 static const char *const builtin_clean_usage[] = {
 	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
@@ -30,8 +32,14 @@ static const char *msg_warn_remove_failed = N_("failed to remove %s");
 
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "clean.requireforce"))
+	/* honors the column.ui config variable only */
+	if (!prefixcmp(var, "column."))
+		return git_column_config(var, value, NULL, &colopts);
+
+	if (!strcmp(var, "clean.requireforce")) {
 		force = !git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -143,6 +151,33 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	return ret;
 }
 
+void pretty_print_dels(struct string_list *dels, const char *prefix)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct strbuf buf = STRBUF_INIT;
+	const char *qname;
+	struct column_options copts;
+
+	for_each_string_list_item(item, dels) {
+		qname = quote_path_relative(item->string, -1, &buf, prefix);
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
 void interactive_clean_edit(struct string_list *dels, const char *prefix)
 {
 	struct dir_struct dir;
@@ -151,7 +186,6 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
 	struct strbuf **ignore_list;
 	struct string_list_item *item;
 	struct exclude_list *el;
-	const char *qname;
 	int changed = -1, i;
 
 	putchar('\n');
@@ -171,12 +205,8 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
 		if (changed) {
 			putchar('\n');
 
-			/* Display dels in "Would remove ..." format */
-			for_each_string_list_item(item, dels) {
-				qname = quote_path_relative(item->string, -1, &buf, prefix);
-				printf(_(msg_would_remove), qname);
-			}
-			putchar('\n');
+			/* Display dels in columns */
+			pretty_print_dels(dels, prefix);
 		}
 
 		printf(_("Input ignore patterns> "));
@@ -229,21 +259,22 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
 void interactive_clean(struct string_list *dels, const char *prefix)
 {
 	struct strbuf confirm = STRBUF_INIT;
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list_item *item;
-	const char *qname;
 	int count = 0;
 
 	/* dels list may become empty after return back from edit mode */
 	while (dels->nr) {
-		/* Display dels in "Would remove ..." format */
 		putchar('\n');
-		for_each_string_list_item(item, dels) {
-			qname = quote_path_relative(item->string, -1, &buf, prefix);
-			printf(_(msg_would_remove), qname);
-		}
+		printf_ln(_(
+			    "WARNING: The following items will be removed permanently. Press \"y\"\n"
+			    "WARNING: to start cleaning, and press \"n\" to abort the cleaning.\n"
+			    "WARNING: You can also enter the \"edit\" mode, and select items\n"
+			    "WARNING: to be excluded from the cleaning."
+			   ));
 		putchar('\n');
 
+		/* Display dels in columns */
+		pretty_print_dels(dels, prefix);
+
 		/* Confirmation dialog */
 		printf(count > 0 ? _("Remove (Yes/no/edit) ? ") : _("Remove (yes/no/Edit) ? "));
 		strbuf_getline(&confirm, stdin, '\n');
@@ -271,7 +302,6 @@ void interactive_clean(struct string_list *dels, const char *prefix)
 		count++;
 	}
 
-	strbuf_release(&buf);
 	strbuf_release(&confirm);
 }
 
-- 
1.8.3.rc0.364.gc6aefbf
