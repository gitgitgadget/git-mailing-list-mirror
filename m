From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v3 4/5] push: flag updates that require force
Date: Sun, 11 Nov 2012 22:08:07 -0600
Message-ID: <1352693288-7396-5-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Mon Nov 12 05:11:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXlMz-0000tX-7E
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 05:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab2KLELK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 23:11:10 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65180 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab2KLELG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 23:11:06 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so8424856iea.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 20:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=EpEOxfhjKuglxNc49oMX3rw4g/d7YmhGuMSV2yA2yPg=;
        b=rVmJVyp68nwFrMg78HAtIHn/9tffpGSG2gAO45BwP82RN6WQr5FPBWH05lROw0CxIU
         uv4Bll8Znt5N1mB/JlxC77XlgzUmVYeIdtzujsJa8MiWHFLxZ2ADVbg5SLTb6nejkMUZ
         iTQHNjV6+WB8R4IZ3DAsA1E0c0ZFTRHx1NyoLeLmRPUXlOMeC+7n8ePZB6FzD8MphbsI
         jLlYWrQmuWdlfy/8cZnAPBTB2Cn9IHbxBeezXk/biMfBBy7hvsSD8zJk/zF640CU4pT0
         Z9w2vtIiQuvFU76l8irojblSvXbdRNYo4Ugnc49z+vhQp6JjhP4YfTGj3NggpUZ1YVAn
         Xx8A==
Received: by 10.50.217.195 with SMTP id pa3mr4296805igc.19.1352693465943;
        Sun, 11 Nov 2012 20:11:05 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id wm10sm7396117igc.2.2012.11.11.20.11.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 20:11:05 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352693288-7396-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209466>

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
index 9712d1b..e61dca3 100644
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
index 7fa9db6..82ba5ed 100644
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
@@ -1332,9 +1334,12 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
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
1.8.0
