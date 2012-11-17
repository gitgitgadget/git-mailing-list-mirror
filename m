From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v4 3/5] push: flag updates
Date: Sat, 17 Nov 2012 14:16:35 -0600
Message-ID: <1353183397-17719-4-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Sat Nov 17 21:17:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZopM-0007jb-6i
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 21:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab2KQURF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 15:17:05 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41760 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab2KQUQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 15:16:53 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so5173856iea.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 12:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=gr5jQGMU0JOfqbABktWFogmuDgFSEJB2gj/xbCRLXpQ=;
        b=uXlk+AcsjGMXpbU6JCI5PsASNYxJ/pXazr3zF2V/mje50jLIYHynwMHYp/gvrgPDdQ
         MvOwI6AbPqmG/FlLeZCvXQJWdgzWZUjimhIMzft3g0jvJ0+SaGhiqfk8DV9dFPKDWGbi
         Va6ADb0j9Sruj7sN8KMt1bjbXN7XKRktdVNpueSCvqHHxiuKGuaeVV0Ol18UmGT1PZXX
         TXJksCAEJE6/8wd3fjwoL6q/OubpcPZ7Mdvok/gCAkJzXXTL76YqOsnlmhicBKXrKnxW
         e0SQTBq0tPOJ2N2AZnIQgYlCM69IBav+kAUzL/6TGRYI/MqE357DfDfHrW1NqgwQB+El
         0uvA==
Received: by 10.50.42.170 with SMTP id p10mr2701228igl.47.1353183413699;
        Sat, 17 Nov 2012 12:16:53 -0800 (PST)
Received: from marlin.localdomain (207-179-211-84.mtco.com. [207.179.211.84])
        by mx.google.com with ESMTPS id wm10sm3269004igc.2.2012.11.17.12.16.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Nov 2012 12:16:52 -0800 (PST)
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1353183397-17719-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209977>

If the reference exists on the remote and the the update is not a
delete, then mark as an update.  This is in preparation for handling
tags and branches differently when pushing.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 cache.h  |  1 +
 remote.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 82dead1..0f53d11 100644
--- a/cache.h
+++ b/cache.h
@@ -1003,6 +1003,7 @@ struct ref {
 		merge:1,
 		nonfastforward:1,
 		is_a_tag:1,
+		update:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
diff --git a/remote.c b/remote.c
index 186814d..fe89869 100644
--- a/remote.c
+++ b/remote.c
@@ -1318,15 +1318,19 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 
 		ref->is_a_tag = !prefixcmp(ref->name, "refs/tags/");
 
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
1.8.0.155.g3a063ad.dirty
