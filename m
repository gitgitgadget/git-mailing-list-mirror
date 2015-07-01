From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/13] rerere: refactor "replay" part of do_plain_rerere()
Date: Tue, 30 Jun 2015 23:04:59 -0700
Message-ID: <1435730699-9124-14-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:06:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB9u-0004e5-3G
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbbGAGFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:47 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34154 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbbGAGF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:28 -0400
Received: by igcsj18 with SMTP id sj18so126046004igc.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=wHFWMK8eTHxNUu1v0uidwcnaImIUqbg/zzcG6UxhEps=;
        b=Rt0JBId2/UKTlYOvmtIjFLme4EVNckqtGbtzjdffNBcosiylNZyfCuKKwrsis/4Q9W
         +BI/IoWBDGpGfaxocxm0wNcmlTnwIXAJUiWCXiUS7SV7jsNAqEjgF/8MMYvAyGWbR9ZD
         AJEpX8sf/z7vTFb71TvgPZSlkyv1f1Mn7XrGcU73y0pu7XacGYrr7aQ8MMW0s+hKzwJT
         1c6n6BUFNlyI6ahwnSXWGmQSY9OuMs0D1KMMa4C5ft5Ftj3yfrti1ZFVgr6o57VLlNgB
         pty54HPE5LeqesfZRnkWl9TPFK7k9HRz3p7cPjziGtZiOnEJBcVCblCCWc33mdk16/hJ
         4rlA==
X-Received: by 10.107.26.207 with SMTP id a198mr34953461ioa.5.1435730728017;
        Tue, 30 Jun 2015 23:05:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id g18sm693630iod.5.2015.06.30.23.05.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273129>

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
2.5.0-rc0-209-g5e1f148
