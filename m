From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v14 08/16] git-clean: show items of del_list in columns
Date: Mon, 24 Jun 2013 23:21:32 +0800
Message-ID: <019a43b98c74c3fa42e8c34ed3d2fb295e5a312b.1372087065.git.worldhello.net@gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:22:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8bE-0006dH-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab3FXPWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:22:31 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:56782 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab3FXPWa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:22:30 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so11164098pbc.3
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=71IOCeiihQNHfcQ23a4y33C85hvqshUXH8wRuab+Lvc=;
        b=qEQ2aHrCXVfMw9k6fY4BG0KqQR+2Wb/EOs3jRZIVd1r76wu7Se5+RlfJtDJJ+g4kuF
         B4HCyLhVFsOmT0EiQbARgErrwSqfhlT4LxV1Gbv735yBuklP+BB5AMekk5P+bKb8+qZl
         5OjWVRuxCMFPf50STCQrZcjK7qAHC4+cRRt+F8yc/aLX1GvbdW09MGBo0d19OyNbBEm7
         NYbvCpt4hsnTReC5SUTC5dfNqr+HLAu3yNd/zDzMYxnfHxUvJWB48KRvloSy/X0iNm1b
         N4irNWv+X209rE6WP/Q9RB8WWugWfFHwjc/ThwLbgcPK+2glBjSYcOpKJx4tUgh3KaDZ
         iUuA==
X-Received: by 10.66.149.5 with SMTP id tw5mr28175064pab.87.1372087349603;
        Mon, 24 Jun 2013 08:22:29 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id ix3sm18576807pbc.37.2013.06.24.08.22.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 08:22:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g41beab0
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
References: <CANYiYbHQ307TroSd6Lk=5zg68jdKxGeA4N=hWGfaz1W29NhNVw@mail.gmail.com> <cover.1372087065.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228830>

When there are lots of items to be cleaned, it is hard to see them all
in one screen. Show them in columns will solve this problem.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Comments-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  4 ++++
 builtin/clean.c          | 49 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e203..c415f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -959,6 +959,10 @@ column.branch::
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
index 698fb..75cc6 100644
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
1.8.3.1.756.g41beab0
