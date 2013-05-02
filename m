From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 2/3] Show items of interactive git-clean in columns
Date: Thu,  2 May 2013 21:15:03 +0800
Message-ID: <3b80db3d2e8f31b1d9373406cce3cbdee2094a29.1367500374.git.worldhello.net@gmail.com>
References: <6e795640952cad0eb25cb0db4243b2712f11e957.1367500374.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:15:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtMG-0007dW-ES
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758958Ab3EBNPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:15:25 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34995 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918Ab3EBNPY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:15:24 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so351752pde.32
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=TXjW/a+NpAVaq9E5TAUeaz5vWdWl+dzY8dHsbh6u3tM=;
        b=yQQsyNHPMflRpcQlmYVDCfWgwqUubzQrNSdWvYdPgVSr6MYH09Ydc48SHSeoK779Gx
         1DPWuebg/le7YX+lUqNNV44HTYhvdt1grxSi3qGjIVzCFiHKeuO0Yv+nYUG1f7eBeC3m
         KC2dXHPBA4SCOnQB4R+R7LBFYp0sFRDV8WG7yldRjRpAVJDc3CqFFG6lt8D3QLrhMnSr
         jsDuqcbMIFZrauTXuXakcpCRXTXYaDmUex46EJ9mACyZouTFioxJXuAe3kWfRzaH/HG7
         3If9OyofwH5ec7kiPj7sm0/9sSa7f0LkUr/MQWxaEsLT5S5otH20s66UNo2b3k7BvTUm
         hP2Q==
X-Received: by 10.66.50.138 with SMTP id c10mr9591009pao.220.1367500522908;
        Thu, 02 May 2013 06:15:22 -0700 (PDT)
Received: from localhost.localdomain ([114.246.126.106])
        by mx.google.com with ESMTPSA id ux10sm8293841pab.1.2013.05.02.06.15.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:15:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.364.gbb5463f
In-Reply-To: <6e795640952cad0eb25cb0db4243b2712f11e957.1367500374.git.worldhello.net@gmail.com>
In-Reply-To: <vpq38u6n397.fsf@grenoble-inp.fr>
References: <vpq38u6n397.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223195>

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 63 +++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 407744e5..ac48e 100644
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
@@ -30,8 +32,12 @@ static const char *msg_warn_remove_failed = N_("failed to remove %s");
 
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "clean.requireforce"))
+	if (!prefixcmp(var, "column."))
+		return git_column_config(var, value, "clean", &colopts);
+	if (!strcmp(var, "clean.requireforce")) {
 		force = !git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -143,6 +149,34 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
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
+
+	putchar('\n');
+	strbuf_release(&buf);
+	string_list_clear(&list, 0);
+}
+
 void interactive_clean_edit(struct string_list *dels, const char *prefix)
 {
 	struct dir_struct dir;
@@ -151,7 +185,6 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
 	struct strbuf **ignore_list;
 	struct string_list_item *item;
 	struct exclude_list *el;
-	const char *qname;
 	int changed = -1, i;
 
 	while (1) {
@@ -170,12 +203,8 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
 			putchar('\n');
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
@@ -230,20 +259,21 @@ void interactive_clean_edit(struct string_list *dels, const char *prefix)
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
@@ -271,7 +301,6 @@ void interactive_clean(struct string_list *dels, const char *prefix)
 		count++;
 	}
 
-	strbuf_release(&buf);
 	strbuf_release(&confirm);
 }
 
-- 
1.8.3.rc0.364.gbb5463f
