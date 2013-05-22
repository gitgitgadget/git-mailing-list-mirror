From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v13 13/15] git-clean: add ask each interactive action
Date: Wed, 22 May 2013 09:40:34 +0800
Message-ID: <14fed4c2721c7b4f81fe57f207b1757ef8e65e2c.1369186574.git.worldhello.net@gmail.com>
References: <cover.1369186574.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 03:41:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uey3c-0001cT-Ch
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 03:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720Ab3EVBlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 21:41:32 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:43265 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab3EVBlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 21:41:25 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so1189964pbc.37
        for <git@vger.kernel.org>; Tue, 21 May 2013 18:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=mHSDy4b9ULAUhTIwXVIsE2KplrVcf0VZQrROMtneYKU=;
        b=tDvkPqfkosNCt/MMq6VlnIYUPCEQHwSYyari8x5TQhPx3AXDVXhfFT0+2uPJ5cLJoq
         a8uJwF+0rxcbjO6RpgX2vHMtF9w09CFH6q2ECn1A/QJ+kIdBFfm/+OR80fXAjHH5F1PK
         c1tI5GDLFYG8KhyHlXkoZP6yfr1nrUsjzorQ9cmFsqDtdPgCZK3sQczp9zkzssazXAx4
         9z1sWMWnO75EqFD2rEzfJbdFlA3jkDBR2K4ex2+MXS/0g2IBS/huv7Nv+8az4dpDjdN9
         I0nbEOwSov+0zGVHN8OF/LxXNqlMLh2U31Lkcx4VLIM/knLhcJ/rlEmHzt1Xu+WNoVHK
         /TEQ==
X-Received: by 10.68.189.164 with SMTP id gj4mr5291616pbc.193.1369186885421;
        Tue, 21 May 2013 18:41:25 -0700 (PDT)
Received: from localhost.localdomain ([114.248.150.82])
        by mx.google.com with ESMTPSA id at1sm4939345pbc.10.2013.05.21.18.41.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 18:41:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.368.g7c798dd
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
References: <7vhahwm5n6.fsf@alter.siamese.dyndns.org> <cover.1369186574.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225112>

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
1.8.3.rc3.368.g7c798dd
