From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v6 4/8] push: flag updates that require force
Date: Thu, 29 Nov 2012 19:41:36 -0600
Message-ID: <1354239700-3325-5-git-send-email-chris@rorvick.com>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 30 02:44:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeFdh-0006sW-Fy
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 02:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481Ab2K3BnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 20:43:23 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41967 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab2K3BnS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 20:43:18 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so11433874iay.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 17:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Gx8KDrMeQ4EBVNYtTVjfyRUaD/Fu5T8Yixl9txmX6I8=;
        b=iXXGsprr0Yslpvnp1821X/PyghJCH3s7IBKznWCp3+qVmCfNqLTUBmVIOrfs00mErj
         wXpExBVPEf7WTWzmG4BBzy7AKXYfh1ApGGXx9WlKFMCeMwuMzRlO5PBmFQ2W6UjFMa/3
         0h2G6QTHc72Yr2jYrPzUlNrHISJl/gCdAmrrneWxxKEJkqxYDnbXBKhfZEVVSEopnQ8s
         wDbDN8BaHkegDInD0M632ShYirug/P4F87JtDfj1J4inhfxepMsy92f77JCLqpnAxD1G
         b6o71eVQTg8EkiqTY1mm5hd+Dvr0NpoL/AuYJKRJ6gW/PGDY+C2ceCOG2ywIsG5K/oq8
         +Fjw==
Received: by 10.50.0.140 with SMTP id 12mr27956688ige.63.1354239797894;
        Thu, 29 Nov 2012 17:43:17 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id c3sm8955228igj.1.2012.11.29.17.43.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 17:43:17 -0800 (PST)
X-Mailer: git-send-email 1.8.0.158.g0c4328c
In-Reply-To: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210889>

Add a flag for indicating an update to a reference requires force.
Currently the `nonfastforward` flag is used for this when generating the
status message.  A separate flag insulates dependent logic from the
details of set_ref_status_for_push().

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
index bc31e8e..f3160b1 100644
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
1.8.0.158.g0c4328c
