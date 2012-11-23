From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 3/7] push: flag updates
Date: Thu, 22 Nov 2012 22:21:51 -0600
Message-ID: <1353644515-17349-4-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 23 05:23:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbkne-0001OK-4s
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 05:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347Ab2KWEXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 23:23:19 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35469 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756033Ab2KWEXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 23:23:17 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2857476iea.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 20:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=S9Y5nyM9TdiLxZaVHH05mwhEbkApY8aBzCcaBOS5j7k=;
        b=ZDxxcGzebjtdMgpUX+uLg6CQw2hg6DrF1G16ZPkPDXtEvnrPOgubRxbUxI09SKxcvZ
         zHEQZ1LhrbM/SUAcJaxpLw7HLK8CeDWQJm2PJMQLxyCevwVaasCyl4ztkStiDyAHuOPO
         Vz/cC7WN+zQ+foLm3F95R0zY30vrkHdYBMB27CD9H3sknSCqI8hk0NeVPp2h3pDE9bpk
         76YwvSQQchZNB7hB9uaIuXQ4Xdc6JtHPOA2otp8hv8MiAMdYEI/CWI3G//SrgJqP2qNU
         LTvVf3sGW0XJSxZ7uL+mrFXYDM45rpgrq1qASeY4vy6aJF1QJLXFPJtF52dwwfCJqDlG
         LXNQ==
Received: by 10.50.190.234 with SMTP id gt10mr2390189igc.73.1353644596935;
        Thu, 22 Nov 2012 20:23:16 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id l8sm3909944igo.13.2012.11.22.20.23.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 20:23:16 -0800 (PST)
X-Mailer: git-send-email 1.8.0.209.gf3828dc
In-Reply-To: <1353644515-17349-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210230>

If the reference exists on the remote and the update is not a delete,
then mark as an update.  This is in preparation for handling tags and
branches differently when pushing.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 cache.h  |  1 +
 remote.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index d72b64d..722321c 100644
--- a/cache.h
+++ b/cache.h
@@ -1003,6 +1003,7 @@ struct ref {
 		merge:1,
 		nonfastforward:1,
 		not_forwardable:1,
+		update:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
diff --git a/remote.c b/remote.c
index 5101683..07040b8 100644
--- a/remote.c
+++ b/remote.c
@@ -1326,15 +1326,19 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 
 		ref->not_forwardable = !is_forwardable(ref);
 
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
1.8.0.209.gf3828dc
