From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 3/5] push: flag updates
Date: Sun,  4 Nov 2012 21:08:26 -0600
Message-ID: <1352084908-32333-4-git-send-email-chris@rorvick.com>
References: <1352084908-32333-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 04:09:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVD3h-0002cf-97
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 04:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab2KEDIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 22:08:42 -0500
Received: from [38.98.186.242] ([38.98.186.242]:32042 "HELO burner.cogcap.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1752524Ab2KEDIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 22:08:40 -0500
Received: by burner.cogcap.com (Postfix, from userid 10028)
	id A547B2B09C6; Sun,  4 Nov 2012 21:08:39 -0600 (CST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1352084908-32333-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209048>

If the reference exists on the remote and the the update is not a
delete, then mark as an update.  This is in preparation for handling
tags and branches differently when pushing.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 cache.h  |    1 +
 remote.c |   19 ++++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index bc2fc9a..1d10761 100644
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
index 5ecd58d..3d43bb5 100644
--- a/remote.c
+++ b/remote.c
@@ -1323,15 +1323,20 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
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
+				ref->update &&
+				(!has_sha1_file(ref->old_sha1)
+				  || !ref_newer(ref->new_sha1, ref->old_sha1));
+
+			if (ref->nonfastforward && !ref->force && !force_update) {
+				ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+				continue;
+			}
 		}
 	}
 }
-- 
1.7.1
