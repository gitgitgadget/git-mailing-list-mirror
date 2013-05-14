From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v9 8/9] git-clean: add ask each interactive action
Date: Tue, 14 May 2013 16:45:22 +0800
Message-ID: <dd85bb5724f571585a26d41b01b987616ff7cfb2.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 14 10:46:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcAsZ-0003DI-72
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 10:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981Ab3ENIqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 04:46:17 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:65235 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab3ENIqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 04:46:16 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so322880pab.17
        for <git@vger.kernel.org>; Tue, 14 May 2013 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=E7O4rvNm3RMyDVJRzcKQLVQm//qcgcxmYyeiYkMMqu8=;
        b=ABv+BYf6agYbP8drVqdY0A00siMcHT+n2IRoBt9Spjp0c/PKI55kaVuaRQws30UUqs
         f2DQimxYtYAtyHv08hu+tUQ7KZEziNM/1lNU53FfLJXrtaeXc81fww2Rjy2KDDOZ52CR
         CC4r1hnrC07wAQ3AKTOisSIM6fX0fqhQP0s8ZFTxM+RL9zsjmakjuB/32xIaCluKN71z
         Opzp5vHwUBWV8Gc5FQbSa29XkgCZVW/w0dpT2vN6Clx9sk0XK+wxFIqrrDn8e2EekxI5
         vx67diX74u/K9GfaFHbmfiS7C5chQAA6bOfEfaUU4CRytItxTAnfrxdTUelLJOAhITiT
         vEkQ==
X-Received: by 10.68.110.133 with SMTP id ia5mr32728198pbb.111.1368521175593;
        Tue, 14 May 2013 01:46:15 -0700 (PDT)
Received: from localhost.localdomain ([114.248.141.128])
        by mx.google.com with ESMTPSA id wt5sm17356069pbc.38.2013.05.14.01.46.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 01:46:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.401.gfc9adf8
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224289>

Add a new action for interactive git-clean: ask each. It's just like
the "rm -i" command, that the user must confirm one by one for each
file or directory to be cleaned.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 74fc9..fc68b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -752,6 +752,40 @@ static int select_by_numbers_cmd(void)
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
+			qname = quote_path_relative(item->string, -1, &buf, NULL);
+			printf(_("remove %s? "), qname);
+			if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
+				strbuf_trim(&confirm);
+			} else {
+				putchar('\n');
+				eof = 1;
+			}
+		}
+		if (!confirm.len || !strncasecmp(confirm.buf, "no", confirm.len)) {
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
@@ -766,6 +800,7 @@ static int help_cmd(void)
 		    "clean               - start cleaning\n"
 		    "filter by pattern   - exclude items from deletion\n"
 		    "select by numbers   - select items to be deleted by numbers\n"
+		    "ask each            - confirm each deletion (like \"rm -i\")\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -783,6 +818,7 @@ static void interactive_main_loop(void)
 			{'c', "clean",			0, clean_cmd},
 			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
 			{'s', "select by numbers",	0, select_by_numbers_cmd},
+			{'a', "ask each",		0, ask_each_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc1.404.gb9fcf3e
