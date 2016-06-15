From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v14 13/16] git-clean: add ask each interactive action
Date: Mon, 24 Jun 2013 23:21:37 +0800
Message-ID: <061b72a5ad3ac9c605df503034952e85aeb3ce98.1372087065.git.worldhello.net@gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:22:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8bX-0006sB-HW
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab3FXPWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:22:51 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:65248 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3FXPWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:22:49 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so11147504pbc.11
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=x6Y+4PAc/rnSvgrs1sr3SnHk2EjeHmcEfKSuEU/jJmY=;
        b=yli1DGNOVm48pOrdWSmLHp/G8bFLYW3oitU1BnlcA2PYeC6HAAJQLG01BSiFKFrsUZ
         EW9W2xPnGpOmjeaxL8ATooaN3fANCFUUeigGTjBEK3/bMDN4syZnShqT6Jsei9QZ+NLB
         qgcbXOrmrMr+LxISQ6YfsE5fs2yF6C9P4jGUZCBfdTz4khRG2FHB9wFB2IyWXyi2O2nh
         iqzf8FX/qsGuK6pzi+TyGIjvw9NwfRgjDRG0ZWmSfzzcZMaRAkpv0yS+0a5EQNAyae9z
         0UpMjLmXr7LODxGjxK7gzyygTla+mRZDnC5MUFJtQri0i8BT7SqbcZ/AbZgQ6o7wuMDX
         ehIg==
X-Received: by 10.66.160.1 with SMTP id xg1mr28271173pab.25.1372087368587;
        Mon, 24 Jun 2013 08:22:48 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id ix3sm18576807pbc.37.2013.06.24.08.22.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 08:22:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g41beab0
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
References: <CANYiYbHQ307TroSd6Lk=5zg68jdKxGeA4N=hWGfaz1W29NhNVw@mail.gmail.com> <cover.1372087065.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228836>

Add a new action for interactive git-clean: ask each. It's just like
the "rm -i" command, that the user must confirm one by one for each
file or directory to be cleaned.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 643a5e..bf03a 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -717,6 +717,40 @@ static int select_by_numbers_cmd(void)
 	return 0;
 }
 
+static int ask_each_cmd(void)
+{
+	struct strbuf confirm = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+	const char *qname;
+	int changed = 0, eof = 0;
+
+	for_each_string_list_item(item, &del_list) {
+		/* Ctrl-D should stop removing files */
+		if (!eof) {
+			qname = quote_path_relative(item->string, NULL, &buf);
+			printf(_("remove %s? "), qname);
+			if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
+				strbuf_trim(&confirm);
+			} else {
+				putchar('\n');
+				eof = 1;
+			}
+		}
+		if (!confirm.len || strncasecmp(confirm.buf, "yes", confirm.len)) {
+			*item->string = '\0';
+			changed++;
+		}
+	}
+
+	if (changed)
+		string_list_remove_empty_items(&del_list, 0);
+
+	strbuf_release(&buf);
+	strbuf_release(&confirm);
+	return MENU_RETURN_NO_LOOP;
+}
+
 static int quit_cmd(void)
 {
 	string_list_clear(&del_list, 0);
@@ -731,6 +765,7 @@ static int help_cmd(void)
 		    "clean               - start cleaning\n"
 		    "filter by pattern   - exclude items from deletion\n"
 		    "select by numbers   - select items to be deleted by numbers\n"
+		    "ask each            - confirm each deletion (like \"rm -i\")\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -748,6 +783,7 @@ static void interactive_main_loop(void)
 			{'c', "clean",			0, clean_cmd},
 			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
 			{'s', "select by numbers",	0, select_by_numbers_cmd},
+			{'a', "ask each",		0, ask_each_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.1.756.g41beab0
