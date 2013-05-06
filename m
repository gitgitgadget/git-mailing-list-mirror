From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 6/7] git-clean: rm -i style interactive cleaning
Date: Tue,  7 May 2013 03:18:55 +0800
Message-ID: <5353bf3a49c83ca27ad4be221b1b4856d119f8c1.1367867498.git.worldhello.net@gmail.com>
References: <cover.1367867498.git.worldhello.net@gmail.com>
 <4a32eb7cc4e277fcbf4b46c13524874334bea2a3.1367867498.git.worldhello.net@gmail.com>
 <6276dc8861b40e8377586f30b85c33e92c4e68fe.1367867498.git.worldhello.net@gmail.com>
 <c77c33fe295bb8577336d5bb4fe0d8da32f69df3.1367867498.git.worldhello.net@gmail.com>
 <217e7618e9b9d50a50461959b38984ac8be88651.1367867498.git.worldhello.net@gmail.com>
 <c81cef0983760c76c2a6b92c1fcc2c49a80a8747.1367867498.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 06 21:19:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQwq-0002FN-Km
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970Ab3EFTTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:19:41 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:42300 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab3EFTTj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:19:39 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so2143512pbb.41
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=uFgT1eKeU9NjBfYz98SLEcnMSSTKeaWLoEfflJj11r8=;
        b=MTnnS3M2iry08hdwJhIMYdlYL5qDP1QDxZMOU7sF9sGVQ5g8bIM+lmb+e2E4WktpmO
         GjC+MQST5vI2pvR19w17Hw8fAPdF8Xpsy+FGaFbykK2PaxCA+Ybl0rzXSh9CxWMTSZBO
         QX3grmkQLF48y57xgkpVwoQpCIDXcRDLql7CKi3vwYvZ/taODHgdG1212/Go6Wt2+bDg
         KOnpm9PPVkr3EzhUNCaHaa4BLWL2elHvw5m2/cfg3Ui0cOv0GT08MolSRx0+rZKlLtSD
         +Jw0e6D9Jwz67/SdUowo/pfFb8GFhtCfQJNZgsxR4oHAomJE7yfDM1mrK8vk8BkalxZU
         Ampg==
X-Received: by 10.68.114.100 with SMTP id jf4mr27066243pbb.144.1367867978763;
        Mon, 06 May 2013 12:19:38 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id z8sm24951256pbt.23.2013.05.06.12.19.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 May 2013 12:19:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.338.gb35aa5d
In-Reply-To: <c81cef0983760c76c2a6b92c1fcc2c49a80a8747.1367867498.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1367867498.git.worldhello.net@gmail.com>
References: <CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com> <cover.1367867498.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223497>

Add a "rm -i" style interactive cleaning method. User must confirm one
by one before starting to delete.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 3b07f..f36ad 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -659,6 +659,40 @@ int edit_by_numbers_cmd()
 	return 0;
 }
 
+int rm_i_cmd()
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
 int quit_cmd()
 {
 	string_list_clear(&del_list, 0);
@@ -673,6 +707,7 @@ int help_cmd(int x)
 		    "clean            - start cleaning\n"
 		    "edit by patterns - exclude items from deletion\n"
 		    "edit by numbers  - select items to be deleted by numbers\n"
+		    "rm -i            - delete items one by one, like \"rm -i\"\n"
 		    "quit             - stop cleaning\n"
 		    "help             - this screen\n"
 		    "?                - help for prompt selection"
@@ -691,6 +726,7 @@ void interactive_main_loop()
 			{'c', "clean",			clean_cmd},
 			{'p', "edit by patterns",	edit_by_patterns_cmd},
 			{'n', "edit by numbers",	edit_by_numbers_cmd},
+			{'i', "rm -i",			rm_i_cmd},
 			{'q', "quit",			quit_cmd},
 			{'h', "help",			help_cmd},
 		};
-- 
1.8.3.rc1.338.gb35aa5d
