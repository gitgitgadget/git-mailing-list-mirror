From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v10 12/14] git-clean: add ask each interactive action
Date: Thu, 16 May 2013 17:53:43 +0800
Message-ID: <25323f98dce032c958c42ce106a6f18bd0f4d657.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 11:54:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcutZ-0001AN-55
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab3EPJyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:54:41 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:59663 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab3EPJyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:54:39 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so2169204pdj.26
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=2deZeYWtdzOhVkf+1L8VrAzBPj2Rl7sjwnIGoK5jf0I=;
        b=GVgH4mS+ajYeKcq4sinDNb2xDYo95KHUYvG5RWHpZxmndm0yYBQa2PdWBEfN8wTjIu
         pPdXW8mBKW5ReZGinjjnhwx7xjvhUciAO7ZVtR88Yrtv4i5qpp4g3EiyB1mdAcljQ14G
         5PUvuWlhIqgflcAEp0Ib300bf9kQjoTasTsg9PswC47iNmbl1IAcaDYPcF1jMpt/nn2Z
         x01b33eT+iqYv8LZRy+hCpAz33gu2SOIq+HurUWQeycBBiw5RYT98S5lNMFKizijDzAz
         73MrFn9o3OHzbkeeegzu2RK0AFIeJPsOw2xyZQbh4b+SRd6MqiXJJowk47slI1kEgips
         N93w==
X-Received: by 10.66.118.39 with SMTP id kj7mr43425234pab.90.1368698078841;
        Thu, 16 May 2013 02:54:38 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id cd2sm6183092pbd.35.2013.05.16.02.54.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 02:54:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.407.g762149a
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224540>

Add a new action for interactive git-clean: ask each. It's just like
the "rm -i" command, that the user must confirm one by one for each
file or directory to be cleaned.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 96a5bb..1c6315 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -710,6 +710,40 @@ static int select_by_numbers_cmd(void)
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
@@ -724,6 +758,7 @@ static int help_cmd(void)
 		    "clean               - start cleaning\n"
 		    "filter by pattern   - exclude items from deletion\n"
 		    "select by numbers   - select items to be deleted by numbers\n"
+		    "ask each            - confirm each deletion (like \"rm -i\")\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -741,6 +776,7 @@ static void interactive_main_loop(void)
 			{'c', "clean",			0, clean_cmd},
 			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
 			{'s', "select by numbers",	0, select_by_numbers_cmd},
+			{'a', "ask each",		0, ask_each_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc1.407.g762149a
