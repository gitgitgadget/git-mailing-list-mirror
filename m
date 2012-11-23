From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 4/7] push: flag updates that require force
Date: Thu, 22 Nov 2012 22:21:52 -0600
Message-ID: <1353644515-17349-5-git-send-email-chris@rorvick.com>
References: <1353644515-17349-1-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 23 05:23:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbkne-0001OK-Jp
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 05:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148Ab2KWEXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 23:23:20 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35469 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229Ab2KWEXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 23:23:19 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2857476iea.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 20:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dhart3/2fA7dHEfe0mJXvk4nBzIB1VhAXgOa+MgMMVU=;
        b=DL9C/VytWxaSbK+OL4Sot3UwKqs6qkhr+tjuFfWbBeYM9eWXobA5/flKAZrPUqTl7D
         FnwRHmQBjow1+92eS9Ezksrf4o3LWARlz+lP0Nn1zgv/ZOf7GUwr3uIEMB+23S3sHobl
         1kXOGnBqnaB8ovXKaHoSzHfcxWLxrzvjkpWW9/BbyGokMauEXSoCOX7BXMs5KfEzVKRX
         5KYd5qGhT/oq85Tg6ezOqNAqMttHboGNQwz2Zx/IAsDwPYaeINouVRlYnfwAmS123X6F
         6vMQXIOR+0c9zk3q2eocGex7MmhRjCFtmVYIs+DJPm3djHRbDmNCJA/3CwNWcGyuzsB0
         mQ5A==
Received: by 10.50.46.198 with SMTP id x6mr2477740igm.28.1353644598842;
        Thu, 22 Nov 2012 20:23:18 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id l8sm3909944igo.13.2012.11.22.20.23.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 20:23:18 -0800 (PST)
X-Mailer: git-send-email 1.8.0.209.gf3828dc
In-Reply-To: <1353644515-17349-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210227>

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
index 722321c..b7ab4ac 100644
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
 		not_forwardable:1,
diff --git a/remote.c b/remote.c
index 07040b8..4a6f822 100644
--- a/remote.c
+++ b/remote.c
@@ -1293,6 +1293,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	struct ref *ref;
 
 	for (ref = remote_refs; ref; ref = ref->next) {
+		int force_ref_update = ref->force || force_update;
+
 		if (ref->peer_ref)
 			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
 		else if (!send_mirror)
@@ -1335,9 +1337,12 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
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
index 271965e..ea8bbbd 100644
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
1.8.0.209.gf3828dc
