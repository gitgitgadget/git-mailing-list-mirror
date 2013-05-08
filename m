From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 06/10] git-clean: rm -i style interactive cleaning
Date: Wed,  8 May 2013 19:38:51 +0800
Message-ID: <95c019e293fcea899e5e227c35338f696f99525f.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
 <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
 <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
 <d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
 <e7cf5d7ffd83e238078b4585ac4bef4ec9a48e21.1368011946.git.worldhello.net@gmail.com>
 <ae69a75fa1bbad9827ef3891a33c3bfa6685d914.1368011946.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 13:39:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2il-0001Lx-6P
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab3EHLja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:39:30 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58100 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab3EHLj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:39:29 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so1277157pad.39
        for <git@vger.kernel.org>; Wed, 08 May 2013 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=fJUxpdaNzTnRA0HAY8wA0B4ZCWd/ysUHXeDVNp7THNI=;
        b=LIDnR463wK0moWl8Iq+rn2/JWzhT2hMhgfEh2ITWTFbBW00zswJHaCqK7Ycv1cfCHc
         N2Plqck8ZaewyMdVdxslZXuAwDtSAmxRzN5USXs0kQCl7US+uy4Tj8OrGXhDyKnpX768
         Dht9VIuUaJA5TxjqHaTuTJPQkmKhxRNphM9t0CIljDyooZw2uDdnUOgxiBTTR/p4HFil
         Y/XjORJZRvINhKG/n5oHSU7KyM5X004MMXrwuOc/dV7UHHUUBBqOATQLwRnAaepoyoC2
         x3jD7oJvfi6Gwwn+6Ngq/qzI60/15DhpoCAE+gqpjFagWn0r0hCCEwEfbiSKvTpDXgq4
         X2zg==
X-Received: by 10.68.75.110 with SMTP id b14mr7140631pbw.89.1368013169431;
        Wed, 08 May 2013 04:39:29 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id gc5sm32287860pbb.19.2013.05.08.04.39.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 04:39:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g1c24ab7
In-Reply-To: <ae69a75fa1bbad9827ef3891a33c3bfa6685d914.1368011946.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223665>

Add a "rm -i" style interactive cleaning method. User must confirm one
by one before starting to delete.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 75e37..5bb36 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -721,6 +721,40 @@ static int edit_by_numbers_cmd()
 	return 0;
 }
 
+static int rm_i_cmd()
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
+			qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
+			printf(_("remove %s ? "), qname);
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
 static int quit_cmd()
 {
 	string_list_clear(&del_list, 0);
@@ -735,6 +769,7 @@ static int help_cmd(int x)
 		    "clean            - start cleaning\n"
 		    "edit by patterns - exclude items from deletion\n"
 		    "edit by numbers  - select items to be deleted by numbers\n"
+		    "rm -i            - delete items one by one, like \"rm -i\"\n"
 		    "quit             - stop cleaning\n"
 		    "help             - this screen\n"
 		    "?                - help for prompt selection"
@@ -753,6 +788,7 @@ static void interactive_main_loop()
 			{'c', "clean",			0, clean_cmd},
 			{'p', "edit by patterns",	0, edit_by_patterns_cmd},
 			{'n', "edit by numbers",	0, edit_by_numbers_cmd},
+			{'i', "rm -i",			0, rm_i_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc1.341.g1c24ab7
