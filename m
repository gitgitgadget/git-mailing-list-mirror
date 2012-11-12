From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v3 3/5] push: flag updates
Date: Sun, 11 Nov 2012 22:08:06 -0600
Message-ID: <1352693288-7396-4-git-send-email-chris@rorvick.com>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 05:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXlNM-00013f-GB
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 05:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab2KLELI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 23:11:08 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65180 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab2KLELE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 23:11:04 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so8424856iea.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 20:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=CzAob5K6nrGeDDh5u5ylFhmheCBySRrmi27NpDCFB3U=;
        b=h3rDsc/oLz+e6FUixL/ITxxIqXBOxVslcqjnmTK/m1TFBwJDy3pdFYIWXjZj9nygMf
         3W/4yCt7ppdnVU6pzDDMIf3ZmnBjjHNmtgryIfundliN/xkkgQJt81YSLIBa8jS/IrDv
         OuY0CPlIV/taHYaHUd8GoSWuxBB70njAq/pe9Z43mW6al+22cuhqtc+Wkimlz01noGkD
         K6o3ik06gs166o1gc+EXTKy1E5FDf+yceBDENHW6PZSNs6bkZM89sveXXQYcwu/dIX2O
         6Q7UgC/HI36GMWVZxaTaEhFoHmA6SGdX8YP/WCiZAa5AJtz0Y7yhkjINkjnuxaR34vEK
         iRaw==
Received: by 10.50.157.200 with SMTP id wo8mr6906391igb.29.1352693463969;
        Sun, 11 Nov 2012 20:11:03 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id wm10sm7396117igc.2.2012.11.11.20.11.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 20:11:03 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352693288-7396-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209468>

If the reference exists on the remote and the the update is not a
delete, then mark as an update.  This is in preparation for handling
tags and branches differently when pushing.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 cache.h  |  1 +
 remote.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 4e25840..9712d1b 100644
--- a/cache.h
+++ b/cache.h
@@ -1003,6 +1003,7 @@ struct ref {
 		merge:1,
 		nonfastforward:1,
 		forwardable:1,
+		update:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
diff --git a/remote.c b/remote.c
index 5ecd58d..7fa9db6 100644
--- a/remote.c
+++ b/remote.c
@@ -1323,15 +1323,19 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			  old->type == OBJ_COMMIT && new->type == OBJ_COMMIT);
 		}
 
-		ref->nonfastforward =
+		ref->update =
 			!ref->deletion &&
-			!is_null_sha1(ref->old_sha1) &&
-			(!has_sha1_file(ref->old_sha1)
-			  || !ref_newer(ref->new_sha1, ref->old_sha1));
+			!is_null_sha1(ref->old_sha1);
 
-		if (ref->nonfastforward && !ref->force && !force_update) {
-			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
-			continue;
+		if (ref->update) {
+			ref->nonfastforward =
+				!has_sha1_file(ref->old_sha1)
+				  || !ref_newer(ref->new_sha1, ref->old_sha1);
+
+			if (ref->nonfastforward && !ref->force && !force_update) {
+				ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+				continue;
+			}
 		}
 	}
 }
-- 
1.8.0
