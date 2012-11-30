From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v6 3/8] push: flag updates
Date: Thu, 29 Nov 2012 19:41:35 -0600
Message-ID: <1354239700-3325-4-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 30 02:44:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeFdg-0006sW-UV
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 02:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab2K3BnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 20:43:18 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43897 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab2K3BnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 20:43:16 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so13169118iea.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 17:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=QAP1G3/LRNk7THkR4a+lo+8+WjT77uHPuGgazxN7TuI=;
        b=dbxptwyEehPHZ4hEpY8cUEBm1EXlPLeC50Cy1nuHlrIU+Lxwzx24bucYQc/1zrf0Rq
         ueRzZg1UdjBV0V8pKM/rTTAxemC8StIGPaZxsRIZq+VZ2WgNqyTNlZWE2WiZgY6i5OJk
         yiWuY2AvUs5OlzsTWo5NIeBT9GotQlJ8PZxJZNPdEuaGf6Y9LA7gwK79CBbuNjnkxGrR
         GVooh2BSWfLlHUt4jSSUgoKjMBMqsfNexaohbgF8Su8FDJnVbBvAlHEYXORvL1mhrajU
         4XuEq5i63eGJqgh0RpaiA8f5f+L1tJXLWstFYDpppxoxKENNRVOidQlXRRMq9eiEZ6Vv
         pWqg==
Received: by 10.50.85.170 with SMTP id i10mr24916607igz.14.1354239795835;
        Thu, 29 Nov 2012 17:43:15 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id c3sm8955228igj.1.2012.11.29.17.43.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 17:43:15 -0800 (PST)
X-Mailer: git-send-email 1.8.0.158.g0c4328c
In-Reply-To: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210897>

If the reference exists on the remote and it is not being removed, then
mark as an update.  This is in preparation for handling tags (lightweight
and annotated) exceptionally.

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
1.8.0.158.g0c4328c
