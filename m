From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2 2/7] mailmap: Remove buffer length limit in map_user
Date: Sat, 15 Dec 2012 19:05:49 +0100
Message-ID: <1355594754-27589-3-git-send-email-apelisse@gmail.com>
References: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 19:06:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw84-00011g-K0
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab2LOSGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:06:10 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:45771 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab2LOSGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:06:05 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1888846wgb.1
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 10:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PES4ktajwmqEs85rvNl8UDjA4MCHJtVL/72TkOqtQd4=;
        b=o1nUjC0ItDGFhZg/0ftgotN3W46hEoOz9u70mL2+u4glWaBUiB8/mYutI2dfIZPrD9
         RP7dURt1EP1BOUhhXaLcS1kTxqVU82pjbo5H+Vh83ucKZliGwOSxLHsCWNY2zBA2lbca
         569ooYi6aCII2DjtOXuuMD3MDNLOTI8wmFZOws8AuAsgSWHhwH37e9q0CzEP9nrVZf4r
         fgYdyTLOrVwtUY/51DHAbABmy9xSp6ClIX6nVRwIhfRBo5oSNptBE/8aJBEasF9Tz8Fv
         Liaa/KmN34yfm1Er7ie9upCEtjma02evgI/gjxKtmMt4HnlCFsCGLu7IZf2ZDCVlqncn
         uYRQ==
Received: by 10.194.71.140 with SMTP id v12mr9332505wju.36.1355594764269;
        Sat, 15 Dec 2012 10:06:04 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id bd7sm3570983wib.8.2012.12.15.10.06.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 10:06:03 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211544>

Remove the hard limit set by mail buffer in map_user and
use the strbuf API to replace it.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 mailmap.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index ea4b471..3bc6491 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -193,7 +193,7 @@ int map_user(struct string_list *map,
 	char *end_of_email;
 	struct string_list_item *item;
 	struct mailmap_entry *me;
-	char buf[1024], *mailbuf;
+	struct strbuf mailbuf = STRBUF_INIT;
 	int i;
 
 	/* figure out space requirement for email */
@@ -204,18 +204,14 @@ int map_user(struct string_list *map,
 		if (!end_of_email)
 			return 0;
 	}
-	if (end_of_email - email + 1 < sizeof(buf))
-		mailbuf = buf;
-	else
-		mailbuf = xmalloc(end_of_email - email + 1);
 
 	/* downcase the email address */
+	strbuf_grow(&mailbuf, end_of_email - email);
 	for (i = 0; i < end_of_email - email; i++)
-		mailbuf[i] = tolower(email[i]);
-	mailbuf[i] = 0;
+		strbuf_addch(&mailbuf, tolower(email[i]));
 
-	debug_mm("map_user: map '%s' <%s>\n", name, mailbuf);
-	item = string_list_lookup(map, mailbuf);
+	debug_mm("map_user: map '%s' <%s>\n", name, mailbuf.buf);
+	item = string_list_lookup(map, mailbuf.buf);
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
 		if (me->namemap.nr) {
@@ -226,8 +222,7 @@ int map_user(struct string_list *map,
 				item = subitem;
 		}
 	}
-	if (mailbuf != buf)
-		free(mailbuf);
+	strbuf_release(&mailbuf);
 	if (item != NULL) {
 		struct mailmap_info *mi = (struct mailmap_info *)item->util;
 		if (mi->name == NULL && (mi->email == NULL || maxlen_email == 0)) {
-- 
1.7.9.5
