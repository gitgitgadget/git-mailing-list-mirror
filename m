From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 03/10] mailmap: remove email copy and length limitation
Date: Sat,  5 Jan 2013 22:26:39 +0100
Message-ID: <1357421206-5014-4-git-send-email-apelisse@gmail.com>
References: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:28:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbHY-0000ix-F5
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab3AEV1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:27:24 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:39082 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab3AEV1R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:27:17 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so1094783wgb.2
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 13:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Sg7Lm2kZjWZryvvHk7bTE5F3EYuxke/QBaPRoA2SXx0=;
        b=YHG5JdtPJZ7eGqxeByWKm0xHqOd5qatdXyY30VDxm9XLQPXVMYp6NjYSAp8ZffIKJu
         EO+EYK6ysbf/4ALHzPXsoWjtAmfwLZA6QK/GRBOUv9jTRS/7srt4V3AahCMDLx6lbluQ
         UevI98N2I2/Kklfj4paWQvcvw4+jTZSDf45Pg017/M2gkrATkyybci0oopFpDBE6vQ3h
         J878Ilup9dA75v39BYHZiMrmNqr3sM1p/M46v6FnQaFxQDIDDlCqyYIzieCl9VA+uLyY
         tYYUVCrpIPkthtOettm5us0K1vCwlEGdtdICQkL4b4RHY5rqH5OBtT30qfJcHQRhzM2A
         U4Vw==
X-Received: by 10.180.97.68 with SMTP id dy4mr3196136wib.7.1357421235647;
        Sat, 05 Jan 2013 13:27:15 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id t17sm5623711wiv.6.2013.01.05.13.27.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 13:27:15 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.15.g5ddde70
In-Reply-To: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212723>

In map_user(), the new string_list_lookup_extended() allows us to remove
the copy of email buffer to lower it.
This also removes the limitation on the length of the copy buffer and
simplifies the function.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 mailmap.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index ea4b471..9db8a1b 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -193,8 +193,7 @@ int map_user(struct string_list *map,
 	char *end_of_email;
 	struct string_list_item *item;
 	struct mailmap_entry *me;
-	char buf[1024], *mailbuf;
-	int i;
+	size_t maillen;
 
 	/* figure out space requirement for email */
 	end_of_email = strchr(email, '>');
@@ -204,18 +203,11 @@ int map_user(struct string_list *map,
 		if (!end_of_email)
 			return 0;
 	}
-	if (end_of_email - email + 1 < sizeof(buf))
-		mailbuf = buf;
-	else
-		mailbuf = xmalloc(end_of_email - email + 1);
-
-	/* downcase the email address */
-	for (i = 0; i < end_of_email - email; i++)
-		mailbuf[i] = tolower(email[i]);
-	mailbuf[i] = 0;
-
-	debug_mm("map_user: map '%s' <%s>\n", name, mailbuf);
-	item = string_list_lookup(map, mailbuf);
+
+	maillen = end_of_email - email;
+
+	debug_mm("map_user: map '%s' <%.*s>\n", name, maillen, email);
+	item = string_list_lookup_extended(map, email, 0, maillen);
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
 		if (me->namemap.nr) {
@@ -226,8 +218,6 @@ int map_user(struct string_list *map,
 				item = subitem;
 		}
 	}
-	if (mailbuf != buf)
-		free(mailbuf);
 	if (item != NULL) {
 		struct mailmap_info *mi = (struct mailmap_info *)item->util;
 		if (mi->name == NULL && (mi->email == NULL || maxlen_email == 0)) {
-- 
1.7.12.4.3.g2036a08.dirty
