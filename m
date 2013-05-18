From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 13/15] git-clean: add ask each interactive action
Date: Sat, 18 May 2013 11:19:05 +0800
Message-ID: <310f735ebd82252bdce5e5a5202790104ff611a7.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:21:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXhk-0005De-43
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759354Ab3ERDUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:20:12 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:47571 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570Ab3ERDUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:20:04 -0400
Received: by mail-pa0-f41.google.com with SMTP id rl6so4134532pac.0
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=dpyHjyU/GM5w5Fz+5y22qmpWmNQfibSDcn8Jrj1TvmU=;
        b=aQGZA9Ivsamf8KEgySBc5lLo+4+B8PYPPYKFklHjNg8O23YIaHRay83ZTeW+vNIVka
         yTj9oa0AW6TqFHN3NFc2gZN1Ah2dt7qLyvo0u2NqEJMQ3OU2lpjwneXe4BynCCab9d4F
         iPuj+yQVcycbmqkeSKteXyBmtQs4ZGQydgRJqdl9rc0XIFp6JMzxYBVBwJ8Y0xIsWN1v
         C7HvSq9mDETE6jeKLEMKB6EmngMd82e1wqp2lwSpaM3rXrkNMjcGHXjajJLk37g6Ygy0
         sOqBXticdxQoixb7ICDuLDOf7o9U/zryK7CbVWymUBt4PUHA7iXWKxUb0PY1g3JwsBJQ
         Nhjg==
X-Received: by 10.68.202.34 with SMTP id kf2mr50410411pbc.56.1368847203916;
        Fri, 17 May 2013 20:20:03 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.20.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:20:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224768>

Add a new action for interactive git-clean: ask each. It's just like
the "rm -i" command, that the user must confirm one by one for each
file or directory to be cleaned.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index fd6e6..7d34b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -718,6 +718,40 @@ static int select_by_numbers_cmd(void)
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
@@ -732,6 +766,7 @@ static int help_cmd(void)
 		    "clean               - start cleaning\n"
 		    "filter by pattern   - exclude items from deletion\n"
 		    "select by numbers   - select items to be deleted by numbers\n"
+		    "ask each            - confirm each deletion (like \"rm -i\")\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -749,6 +784,7 @@ static void interactive_main_loop(void)
 			{'c', "clean",			0, clean_cmd},
 			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
 			{'s', "select by numbers",	0, select_by_numbers_cmd},
+			{'a', "ask each",		0, ask_each_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc2.26.g7472058
