From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 2/5] mailmap: Remove buffer length limit in map_user
Date: Tue, 11 Dec 2012 23:21:30 +0100
Message-ID: <1355264493-8298-3-git-send-email-apelisse@gmail.com>
References: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Rich Midwinter <rich.midwinter@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 23:22:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYDc-0001RM-8w
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab2LKWWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:22:10 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:44833 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab2LKWWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:22:09 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so1887158wey.19
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 14:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DksTpqMBHSWRkx51FfVwBJ0SwVhiI07JoSs+OFKnlFM=;
        b=tslHF41xZzqnW3ek4J+qovsfyP566I4k9rMBUCzgAAqAQQ7IxjQiWI6j5fyopdUgDf
         zHIFVkHi68rsAPqggaXm7n/F+9sctCF3HOML+wq0tzMH4UkhNXd3SEoHx7kZEN4yXqAg
         btOchKUgDW24AbBLo/E91yoUcQtmLQTXYBEtjc29KalVLz7di3XFjbr5e4KHlQV2olRn
         MBKdk5GI7euWtUfSLNqkhY6A/dEMmG/yk5FHB5vYZMs90D1Wm5rLfRMzy+JrLcXJG2Xe
         00efHRY/gp24WLYlC01FxJfyy4B7fsvGFV5Pbgk4SylGCEOeGsYgbN+pKtLTMUr5hJJF
         c+mA==
Received: by 10.194.76.99 with SMTP id j3mr3145292wjw.47.1355264528548;
        Tue, 11 Dec 2012 14:22:08 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id ec3sm610033wib.10.2012.12.11.14.22.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2012 14:22:08 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.5.g7e0651a
In-Reply-To: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211304>

Remove the hard limit set by mail buffer in map_user and
use the strbuf API to replace it.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 mailmap.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index ea4b471..e636278 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -193,7 +193,8 @@ int map_user(struct string_list *map,
 	char *end_of_email;
 	struct string_list_item *item;
 	struct mailmap_entry *me;
-	char buf[1024], *mailbuf;
+	struct strbuf buf = STRBUF_INIT;
+	char *mailbuf;
 	int i;
 
 	/* figure out space requirement for email */
@@ -204,15 +205,13 @@ int map_user(struct string_list *map,
 		if (!end_of_email)
 			return 0;
 	}
-	if (end_of_email - email + 1 < sizeof(buf))
-		mailbuf = buf;
-	else
-		mailbuf = xmalloc(end_of_email - email + 1);
 
 	/* downcase the email address */
+	strbuf_grow(&buf, end_of_email - email);
 	for (i = 0; i < end_of_email - email; i++)
-		mailbuf[i] = tolower(email[i]);
-	mailbuf[i] = 0;
+		strbuf_addch(&buf, tolower(email[i]));
+	strbuf_addch(&buf, 0);
+	mailbuf = strbuf_detach(&buf, 0);
 
 	debug_mm("map_user: map '%s' <%s>\n", name, mailbuf);
 	item = string_list_lookup(map, mailbuf);
@@ -226,8 +225,7 @@ int map_user(struct string_list *map,
 				item = subitem;
 		}
 	}
-	if (mailbuf != buf)
-		free(mailbuf);
+	free(mailbuf);
 	if (item != NULL) {
 		struct mailmap_info *mi = (struct mailmap_info *)item->util;
 		if (mi->name == NULL && (mi->email == NULL || maxlen_email == 0)) {
-- 
1.8.1.rc1.5.g7e0651a
