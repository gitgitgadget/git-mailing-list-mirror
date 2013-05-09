From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 08/12] git-clean: add ask each interactive action
Date: Fri, 10 May 2013 01:14:12 +0800
Message-ID: <a62c4951bed18ade8b7bf8de9a7719ac18323db6.1368118918.git.worldhello.net@gmail.com>
References: <cover.1368118918.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:15:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUQz-00039M-2B
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab3EIRPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:15:05 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35723 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3EIRPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:15:05 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so2261050pab.27
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=n4doYCJ00V5jG82t78UM2mzKsYLGy/w+9fpSnW5oARw=;
        b=H9fiZ0hugaajnACRgKDa+QPoMFrO8Pnt0Wi5r7AkptU3RTii01ZcxARuspD7E0Rxiy
         xe26txJZ3cH0qplDv+f5qc2o0KTHVKtIkGqLdVz9qlQfyaFwqBd9C0SZiinGsJBkWwKe
         xdF9bjqu2Dui1uYE836E2A/XDe+69g1aGR73wplZ3C1vTbnsMICT06MELTv9kzsrX0aU
         eTemapT0a+nOfvZSFFtGiGrkN115YM9L0Uv7usY43foc7PF7LMaEnKjaorq2i+x91aGJ
         VcDBpSWGvlUT49EvkXfSThqddioCpMZ8UtdJldEdx/Jmux2jksZfYb/+3yDqlhaAdpXD
         J50Q==
X-Received: by 10.68.162.163 with SMTP id yb3mr13293060pbb.212.1368119703664;
        Thu, 09 May 2013 10:15:03 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.14.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:15:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com> <cover.1368118918.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223756>

Add a new action for interactive git-clean: ask each. It's just like
the "rm -i" command, that the user must confirm one by one for each
file or directory to be cleaned.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 17b65..85345 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -749,6 +749,40 @@ static int select_by_numbers_cmd(void)
 	return 0;
 }
 
+static int rm_i_cmd(void)
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
 static int quit_cmd(void)
 {
 	string_list_clear(&del_list, 0);
@@ -763,6 +797,7 @@ static int help_cmd(void)
 		    "clean               - start cleaning\n"
 		    "filter by pattern   - exclude items from deletion\n"
 		    "select by numbers   - select items to be deleted by numbers\n"
+		    "ask each            - confirm each deletion (like \"rm -i\")\n"
 		    "quit                - stop cleaning\n"
 		    "help                - this screen\n"
 		    "?                   - help for prompt selection"
@@ -780,6 +815,7 @@ static void interactive_main_loop(void)
 			{'c', "clean",			0, clean_cmd},
 			{'f', "filter by pattern",	0, filter_by_patterns_cmd},
 			{'s', "select by numbers",	0, select_by_numbers_cmd},
+			{'a', "ask each",		0, rm_i_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
-- 
1.8.3.rc1.341.g24a8a0f
