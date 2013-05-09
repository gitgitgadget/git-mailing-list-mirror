From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 03/12] git-clean: show items of del_list in columns
Date: Fri, 10 May 2013 01:14:07 +0800
Message-ID: <cb530e2eb30aa09bf293d60d04e15e0309059f51.1368118918.git.worldhello.net@gmail.com>
References: <cover.1368118918.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:14:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUQd-0002jf-53
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab3EIROp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:14:45 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:54203 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab3EIROn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:14:43 -0400
Received: by mail-da0-f43.google.com with SMTP id u7so1719864dae.2
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=E3cHXhiXZSanau+ngGMSiusCJBpSmjNrI4Hv4wueQH4=;
        b=G0V6zIS2fw6eW7h4wa3QJZXsmrKuqA6J9IV05jliV7j0S7rwErlpAc/+dn893hkzLg
         sRgRQi4ZZ8J6/gjwz1AXSl9GmfHHcp4irkhXU180pKofWHx6haZ36DWRax7YnVvy+tJ8
         TMRcpKDnAIQhBSTlWnvu5iS1sMRKsdFs2Blz8y7rVphT2YxJ4IV2uVE56ecz09+/5g4/
         pLVZgn3az2/p8PahRLjTLvfIB1bpbL84PFB52mKW3QsqtKVLNmXyIpbs3p7UM1yM0uaj
         U8L2+RKUgQYpjl59wBqdoL/4pux9RqAjlfcrea7wVwIXd6sMHIJmC0vkX4331UlMgK9G
         +ahA==
X-Received: by 10.68.162.163 with SMTP id yb3mr13291814pbb.212.1368119683350;
        Thu, 09 May 2013 10:14:43 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.14.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:14:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com> <cover.1368118918.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223752>

When there are lots of items to be cleaned, it is hard to see them all
in one screen. Show them in columns instead of in one column will solve
this problem.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Comments-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt |  4 ++++
 builtin/clean.c          | 49 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 9 deletions(-)

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
index 2f9b9..a16988 100644
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
 		printf(_("Remove (y/n) ? "));
 		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
 			strbuf_trim(&confirm);
@@ -226,7 +258,6 @@ static void interactive_main_loop(void)
 		}
 	}
 
-	strbuf_release(&buf);
 	strbuf_release(&confirm);
 }
 
-- 
1.8.3.rc1.341.g24a8a0f
