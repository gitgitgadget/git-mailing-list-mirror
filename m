From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v15 13/16] git-clean: add ask each interactive action
Date: Tue, 25 Jun 2013 23:53:54 +0800
Message-ID: <932e2efee70dadb893dcd8498d7da17f68eb9d96.1372175283.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 17:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrVaL-0004Ki-1p
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 17:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620Ab3FYPzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 11:55:05 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:62670 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab3FYPzC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 11:55:02 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so12821340pbc.12
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=G5fHfxUBGYeuo5ibApbu0fgQRCZsD78hcj1ZEQ9Lebs=;
        b=u9EFn+jWRFNaXE2hhjkvLAckf5gB9BpEz5pFd7qVMloM3ZncJciwNckrj/TK17QHkr
         GlFB0dvhvh1+66YQ4dYq34hoOhWf9Slq6jbZqBLR4OguugW1M26cpTDYSNug3gop48R2
         GvXbLSLN+lEdV4zMK5OiZbLCvIu7M5iU4dNvld+gklgBobb+xSr4OsUKqNcuwoXYim0m
         2HqrdZ+e1NC6aTm7vrI05QG81LTjeehlaSy/fJvpghmI9TVF70CDV/Na1fHnlVYLjPt6
         LEN7mDv6KkwTckN9PFtBBpoD0tpajFTqInEFuWOBRn/0IGUwDJvv6W9e2l8YvqHGkKyq
         38Tg==
X-Received: by 10.66.146.164 with SMTP id td4mr454108pab.106.1372175701550;
        Tue, 25 Jun 2013 08:55:01 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id pb5sm23760930pbc.29.2013.06.25.08.54.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 08:55:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g2e9b71f
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228974>

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
1.8.3.1.756.g2e9b71f
