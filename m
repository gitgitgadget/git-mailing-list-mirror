From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/18] rerere: refactor "replay" part of do_plain_rerere()
Date: Fri, 17 Jul 2015 15:24:35 -0700
Message-ID: <1437171880-21590-14-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE4P-0004Mn-2u
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbbGQWZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:25:11 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35757 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184AbbGQWZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:25:03 -0400
Received: by pactm7 with SMTP id tm7so67788933pac.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=v9cj49Eie1krVDNuMLQ2t8A7e63p23cTzKH31vUFy0A=;
        b=O4MpG18yq+orFaA7ZuWAVbZeAkq7huhvCITX8z1xi3uEJBkUWOxRdZSPpk+HugBslz
         jS5A9AXejv5Fcyfx7XYmqMlRfClXa6pBDqQrcbxJL73OCEG9DDPQi5hIyHxQ6V7wMk+t
         FZDLeTRKxwaTqAcSY9scqAKBeROu2QB6G/qvTc+N5k9xu/WbrwFeLSlVn6F6fs9fT0L3
         61zzxdr88IOvxGMQrr9IY32PoefdmOcnMHGFjh2CfMVRlk0nYp4Tl0xk5HB8q5vonuzT
         ln+aYGTeiTxuiM6mBVWKnFhL1MV5l82CLx2v3M8HeCVJGvooGBwGdxyL+/vlf9oR9IAA
         XzBg==
X-Received: by 10.70.53.99 with SMTP id a3mr33642104pdp.169.1437171902503;
        Fri, 17 Jul 2015 15:25:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id dc8sm12359299pdb.23.2015.07.17.15.25.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:25:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274120>

Extract the body of a loop that attempts to replay recorded
resolution for each conflicted path into a helper function, not
because I want to call it from multiple places later, but because
the logic has become too deeply nested and hard to read.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 75 ++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/rerere.c b/rerere.c
index 7ef951e..09b72ed 100644
--- a/rerere.c
+++ b/rerere.c
@@ -620,6 +620,44 @@ static void update_paths(struct string_list *update)
 		rollback_lock_file(&index_lock);
 }
 
+/*
+ * The path indicated by rr_item may still have conflict for which we
+ * have a recorded resolution, in which case replay it and optionally
+ * update it.  Or it may have been resolved by the user and we may
+ * only have the preimage for that conflict, in which case the result
+ * needs to be recorded as a resolution in a postimage file.
+ */
+static void do_rerere_one_path(struct string_list_item *rr_item,
+			       struct string_list *update)
+{
+	const char *path = rr_item->string;
+	const char *name = (const char *)rr_item->util;
+
+	/* Is there a recorded resolution we could attempt to apply? */
+	if (has_rerere_resolution(name)) {
+		if (merge(name, path))
+			return; /* failed to replay */
+
+		if (rerere_autoupdate)
+			string_list_insert(update, path);
+		else
+			fprintf(stderr,
+				"Resolved '%s' using previous resolution.\n",
+				path);
+		goto mark_resolved;
+	}
+
+	/* Let's see if the user has resolved it. */
+	if (handle_file(path, NULL, NULL))
+		return; /* not yet resolved */
+
+	copy_file(rerere_path(name, "postimage"), path, 0666);
+	fprintf(stderr, "Recorded resolution for '%s'.\n", path);
+mark_resolved:
+	free(rr_item->util);
+	rr_item->util = NULL;
+}
+
 static int do_plain_rerere(struct string_list *rr, int fd)
 {
 	struct string_list conflict = STRING_LIST_INIT_DUP;
@@ -673,41 +711,8 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		}
 	}
 
-	/*
-	 * Some of the paths that had conflicts earlier might have
-	 * been resolved by the user.  Others may be similar to a
-	 * conflict already that was resolved before.
-	 */
-	for (i = 0; i < rr->nr; i++) {
-		int ret;
-		const char *path = rr->items[i].string;
-		const char *name = (const char *)rr->items[i].util;
-
-		/* Is there a recorded resolution we could attempt to apply? */
-		if (has_rerere_resolution(name)) {
-			if (merge(name, path))
-				continue;
-
-			if (rerere_autoupdate)
-				string_list_insert(&update, path);
-			else
-				fprintf(stderr,
-					"Resolved '%s' using previous resolution.\n",
-					path);
-			goto mark_resolved;
-		}
-
-		/* Let's see if the user has resolved it. */
-		ret = handle_file(path, NULL, NULL);
-		if (ret)
-			continue;
-
-		copy_file(rerere_path(name, "postimage"), path, 0666);
-		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
-	mark_resolved:
-		free(rr->items[i].util);
-		rr->items[i].util = NULL;
-	}
+	for (i = 0; i < rr->nr; i++)
+		do_rerere_one_path(&rr->items[i], &update);
 
 	if (update.nr)
 		update_paths(&update);
-- 
2.5.0-rc2-340-g0cccc16
