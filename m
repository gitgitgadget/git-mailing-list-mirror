From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v4 4/5] push: flag updates that require force
Date: Sat, 17 Nov 2012 14:16:36 -0600
Message-ID: <1353183397-17719-5-git-send-email-chris@rorvick.com>
References: <1353183397-17719-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 21:17:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZopK-0007jb-TS
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 21:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab2KQUQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 15:16:57 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41760 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab2KQUQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 15:16:55 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so5173856iea.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 12:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=NBHOQXwXYCXVHsDyPjNZop4VO5Iosn9nDRiDXIxJPug=;
        b=G9Cchem7Nf0sgkUHpxJxQbRZwqYVy4cYvXZ6+AHLtdeMHmPVKzRxrIooTgG3+tOxiW
         iHtGaoFfff6Fi7O7aSTn9L+LzRwDQ8O8xcBpgljq9Re4zTgr8NVjacl3pj2KRclsEnMu
         UzX7LlExS/ZdPY/b01GSiOA8r/OWex62DyLg6bnYNRziWQx+Axg+lsf1LjD+iOOMGRTX
         9pk0GkX0w8ft9CUJiBr7QNN24sW7/qTGEY3n9mfOG0LVo2ewjhj5LH3aGHORJZ1sqDH6
         EaHZ0E061RTYE0+xx9gVNk8hb2lWkpNyg407Xru/RisZz3cJiNciJg9D3N3JEC6Ksmp5
         1vxA==
Received: by 10.43.50.197 with SMTP id vf5mr7506364icb.13.1353183415351;
        Sat, 17 Nov 2012 12:16:55 -0800 (PST)
Received: from marlin.localdomain (207-179-211-84.mtco.com. [207.179.211.84])
        by mx.google.com with ESMTPS id wm10sm3269004igc.2.2012.11.17.12.16.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Nov 2012 12:16:54 -0800 (PST)
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1353183397-17719-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209976>

Add a flag for indicating an update to a reference requires force.
Currently the nonfastforward flag of a ref is used for this when
generating status the status message.  A separate flag insulates the
status logic from the details of set_ref_status_for_push().

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 cache.h     |  4 +++-
 remote.c    | 11 ++++++++---
 transport.c |  2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 0f53d11..f410d94 100644
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
 		is_a_tag:1,
diff --git a/remote.c b/remote.c
index fe89869..1e263b0 100644
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
@@ -1327,9 +1329,12 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				!has_sha1_file(ref->old_sha1)
 				  || !ref_newer(ref->new_sha1, ref->old_sha1);
 
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
index 5fcaea8..60a7421 100644
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
1.8.0.155.g3a063ad.dirty
