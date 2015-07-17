From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/18] rerere: report autoupdated paths only after actually updating them
Date: Fri, 17 Jul 2015 15:24:27 -0700
Message-ID: <1437171880-21590-6-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:24:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE3t-00046y-Cw
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbbGQWYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:24:53 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:32917 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139AbbGQWYu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:24:50 -0400
Received: by pdbqm3 with SMTP id qm3so68133286pdb.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=KH0hwHGSy7LOVxN4fdcrk4EJjoTODEObaHjSsiHMgGk=;
        b=0qn2rjfOm4MtpwhWGGuVA5ggunYM1K/aN6albRFKauKNBlsqeqM8dJA0uVH0XrTDTB
         PBwZ9F1mLS8JIGGyg68skU2C5mhDKTu0TlZZvH7uHvDHSwMdNufR9YXMrjmocosR0SlX
         QHrMipsUCS0uVszfNlaLf0vO8wNVeQzWE8aCwplUvrKoKtifc6YQxklGp2Kicaxt+H7w
         0Gysy9bQ6wu9ttymkHZIPd0pFSkA8SOFdNSiaPWjXQWlafAN0srE0AefLcBKmxeK283T
         8FrwMXEwu2vT5qbuBJC9VBO7sjVzRtcxQnCgcnRuH/q3JIc2/xjOGIljYfja36xSUp1z
         p/5w==
X-Received: by 10.68.131.104 with SMTP id ol8mr34232340pbb.39.1437171890026;
        Fri, 17 Jul 2015 15:24:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id ho2sm12344806pbb.14.2015.07.17.15.24.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274111>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/rerere.c b/rerere.c
index 27b287d..304df02 100644
--- a/rerere.c
+++ b/rerere.c
@@ -482,6 +482,8 @@ static void update_paths(struct string_list *update)
 		struct string_list_item *item = &update->items[i];
 		if (add_file_to_cache(item->string, 0))
 			exit(128);
+		fprintf(stderr, "Staged '%s' using previous resolution.\n",
+			item->string);
 	}
 
 	if (active_cache_changed) {
@@ -536,16 +538,16 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		const char *name = (const char *)rr->items[i].util;
 
 		if (has_rerere_resolution(name)) {
-			if (!merge(name, path)) {
-				const char *msg;
-				if (rerere_autoupdate) {
-					string_list_insert(&update, path);
-					msg = "Staged '%s' using previous resolution.\n";
-				} else
-					msg = "Resolved '%s' using previous resolution.\n";
-				fprintf(stderr, msg, path);
-				goto mark_resolved;
-			}
+			if (merge(name, path))
+				continue;
+
+			if (rerere_autoupdate)
+				string_list_insert(&update, path);
+			else
+				fprintf(stderr,
+					"Resolved '%s' using previous resolution.\n",
+					path);
+			goto mark_resolved;
 		}
 
 		/* Let's see if we have resolved it. */
-- 
2.5.0-rc2-340-g0cccc16
