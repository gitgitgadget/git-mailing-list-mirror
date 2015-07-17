From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/18] rerere: further de-dent do_plain_rerere()
Date: Fri, 17 Jul 2015 15:24:36 -0700
Message-ID: <1437171880-21590-15-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE4T-0004PK-Sj
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199AbbGQWZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:25:08 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33002 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbbGQWZE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:25:04 -0400
Received: by pdbqm3 with SMTP id qm3so68135565pdb.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=liRpBu5b0BQ7Anq3FYFYgh6/PJTZqotWONVM66XX4hQ=;
        b=cXYTXIyfLYTVO3WWa8SCmVUzGmqWoU6o7L8bo9Vu/u8HfPmGu2FPCRq7advSU0nuR1
         vwjRoDw0hbLJriu5XLoWzgLsYLVPtL6yM4FpGpB0uqkNEEZLw4jXaAU6k8fOVzhK6uph
         TBpxG0n9rliJB7PLZYOzkSP9kcb5gOgnKKrjABi3L3M/GN1G3uq7+ToAt2hQ0rue4LkX
         9hksFOhJHpLFgE1K+jwrZDN8D7FXLHg2k+2ZE4ArmddEBf03uKubdtWeZ0Tg5KPeV5sh
         DynH26ZV+CrJjO8iIwL58Q9/xfDx6AcsxCpdKixEDjRo6Z5hPI+D07bobd2w40MyQJ3Z
         Fp1Q==
X-Received: by 10.68.57.168 with SMTP id j8mr32996597pbq.99.1437171904209;
        Fri, 17 Jul 2015 15:25:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id vx5sm12307424pbc.59.2015.07.17.15.25.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:25:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274121>

It's just easier to follow this way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 69 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/rerere.c b/rerere.c
index 09b72ed..1089a9c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -673,42 +673,43 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 	 * initial run would catch all and register their preimages.
 	 */
 	for (i = 0; i < conflict.nr; i++) {
+		unsigned char sha1[20];
+		char *hex;
+		int ret;
 		const char *path = conflict.items[i].string;
-		if (!string_list_has_string(rr, path)) {
-			unsigned char sha1[20];
-			char *hex;
-			int ret;
-
-			/*
-			 * Ask handle_file() to scan and assign a
-			 * conflict ID.  No need to write anything out
-			 * yet.
-			 */
-			ret = handle_file(path, sha1, NULL);
-			if (ret < 1)
-				continue;
-			hex = xstrdup(sha1_to_hex(sha1));
-			string_list_insert(rr, path)->util = hex;
-
-			/*
-			 * If the directory does not exist, create
-			 * it.  mkdir_in_gitdir() will fail with
-			 * EEXIST if there already is one.
-			 *
-			 * NEEDSWORK: make sure "gc" does not remove
-			 * preimage without removing the directory.
-			 */
-			if (mkdir_in_gitdir(git_path("rr-cache/%s", hex)))
-				continue;
 
-			/*
-			 * We are the first to encounter this
-			 * conflict.  Ask handle_file() to write the
-			 * normalized contents to the "preimage" file.
-			 */
-			handle_file(path, NULL, rerere_path(hex, "preimage"));
-			fprintf(stderr, "Recorded preimage for '%s'\n", path);
-		}
+		if (string_list_has_string(rr, path))
+			continue;
+
+		/*
+		 * Ask handle_file() to scan and assign a
+		 * conflict ID.  No need to write anything out
+		 * yet.
+		 */
+		ret = handle_file(path, sha1, NULL);
+		if (ret < 1)
+			continue;
+		hex = xstrdup(sha1_to_hex(sha1));
+		string_list_insert(rr, path)->util = hex;
+
+		/*
+		 * If the directory does not exist, create
+		 * it.  mkdir_in_gitdir() will fail with
+		 * EEXIST if there already is one.
+		 *
+		 * NEEDSWORK: make sure "gc" does not remove
+		 * preimage without removing the directory.
+		 */
+		if (mkdir_in_gitdir(git_path("rr-cache/%s", hex)))
+			continue;
+
+		/*
+		 * We are the first to encounter this
+		 * conflict.  Ask handle_file() to write the
+		 * normalized contents to the "preimage" file.
+		 */
+		handle_file(path, NULL, rerere_path(hex, "preimage"));
+		fprintf(stderr, "Recorded preimage for '%s'\n", path);
 	}
 
 	for (i = 0; i < rr->nr; i++)
-- 
2.5.0-rc2-340-g0cccc16
