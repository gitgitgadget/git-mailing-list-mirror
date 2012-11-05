From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 4/5] push: flag updates that require force
Date: Sun,  4 Nov 2012 21:08:27 -0600
Message-ID: <1352084908-32333-5-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Mon Nov 05 04:09:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVD3i-0002cf-80
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 04:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab2KEDIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 22:08:44 -0500
Received: from [38.98.186.242] ([38.98.186.242]:31495 "HELO burner.cogcap.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1752547Ab2KEDIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 22:08:40 -0500
Received: by burner.cogcap.com (Postfix, from userid 10028)
	id C3E852B09C7; Sun,  4 Nov 2012 21:08:39 -0600 (CST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1352084908-32333-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209045>

Add a flag for indicating an update to a reference requires force.
Currently the nonfastforward flag of a ref is used for this when
generating status the status message.  A separate flag insulates the
status logic from the details of set_ref_status_for_push().

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 cache.h     |    4 +++-
 remote.c    |   11 ++++++++---
 transport.c |    2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 1d10761..b74c744 100644
--- a/cache.h
+++ b/cache.h
@@ -999,7 +999,9 @@ struct ref {
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
 	char *symref;
-	unsigned int force:1,
+	unsigned int
+		force:1,
+		requires_force:1,
 		merge:1,
 		nonfastforward:1,
 		forwardable:1,
diff --git a/remote.c b/remote.c
index 3d43bb5..552afd0 100644
--- a/remote.c
+++ b/remote.c
@@ -1285,6 +1285,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	struct ref *ref;
 
 	for (ref = remote_refs; ref; ref = ref->next) {
+		int force_ref_update = ref->force || force_update;
+
 		if (ref->peer_ref)
 			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
 		else if (!send_mirror)
@@ -1333,9 +1335,12 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				(!has_sha1_file(ref->old_sha1)
 				  || !ref_newer(ref->new_sha1, ref->old_sha1));
 
-			if (ref->nonfastforward && !ref->force && !force_update) {
-				ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
-				continue;
+			if (ref->nonfastforward) {
+				ref->requires_force = 1;
+				if (!force_ref_update) {
+					ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+					continue;
+				}
 			}
 		}
 	}
diff --git a/transport.c b/transport.c
index 1657798..632f8b0 100644
--- a/transport.c
+++ b/transport.c
@@ -659,7 +659,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 		const char *msg;
 
 		strcpy(quickref, status_abbrev(ref->old_sha1));
-		if (ref->nonfastforward) {
+		if (ref->requires_force) {
 			strcat(quickref, "...");
 			type = '+';
 			msg = "forced update";
-- 
1.7.1
