From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 21/42] fetch.c: change s_update_ref to use a ref transaction
Date: Thu,  1 May 2014 13:37:21 -0700
Message-ID: <1398976662-6962-22-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxke-0001Qi-9Z
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbaEAUiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:00 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:62008 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbaEAUhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:54 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so549119vcb.4
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/7n0U6p3FFGHfJPSTQniQbcghu7Wc9IlBy0FjTNYTmA=;
        b=FKTpZrN/GwSxq/vg9DECD6hDxn7Q7irM+//0gbAywM1qLDp1ZoidOPGFIMqsYvKgmN
         YOYC23BOWZ4HyY+pubg/KEnCMKDbvh209wc0ns9oqtx6n8jTzfUrmvky70R7MdP1NsLe
         7xInitXSwDzEIyZ4VHJBW3MFMbFLdOyN6Ha/HH2b3bvE+/wXmMKaIyzhfzJGpBLuCUcD
         WKWHJEjV5BrhmjRDDNLUZR1JBZFiv2Va0OrPkH7kiXwYsyUCx7PBmfzk1oB12gRAd6rL
         iw29LEg0c6G1KgDa17yuktaBGV7COHU4WHEhC+iijUQB65hOe6vqGr1K0+OQrVR71A7c
         I5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/7n0U6p3FFGHfJPSTQniQbcghu7Wc9IlBy0FjTNYTmA=;
        b=cfYTJjNPJbtLhzUpiWlSKNjVbzqV9ApLx78MD6OCXAdVCUik2muMoRJIFNSFH38RGI
         4JtNy8z8+90CAemUBtbeXtAI0rxzDUrmWisVxcdKPOLGUDjXjLhaAQYBX2dw33fkFmyL
         bJ1hVaG+B5j0HHFUC4/NbsHvCQecKtw7xQjY8d5MuVID0PIHw/KWnCRw4xvxIYD/PufN
         uRIULKkX9+eEnBCAchYsRs/tmhBsWsrzWyV5k7wslYzfnDAbGkqn7Qud8J9QfA8pj4NC
         JGiVUhRUNsNsx+5Orlq9DnZglUzmErM5WKGm2IJsWJviv/5VDiXcbUS1NMh4jiBFk9SL
         IZpw==
X-Gm-Message-State: ALoCoQm9Lz7gSxzpIpYxfmTUXO9YBrDWLnbiyGhONchejgvgOEj1OMercvNG3mF9r8w1TpaXZ2Po
X-Received: by 10.52.90.168 with SMTP id bx8mr748451vdb.5.1398976673683;
        Thu, 01 May 2014 13:37:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x22si3537107yhd.5.2014.05.01.13.37.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8745B31C2C1;
	Thu,  1 May 2014 13:37:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4C429E0A5B; Thu,  1 May 2014 13:37:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247845>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a93c893..b41d7b7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -375,7 +375,7 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;
+	struct ref_transaction *transaction;
 
 	if (dry_run)
 		return 0;
@@ -384,15 +384,16 @@ static int s_update_ref(const char *action,
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 
 	errno = 0;
-	lock = lock_any_ref_for_update(ref->name,
-				       check_old ? ref->old_sha1 : NULL,
-				       0, NULL);
-	if (!lock)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old) ||
+	    ref_transaction_commit(transaction, msg, NULL)) {
+		ref_transaction_rollback(transaction);
 		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
+	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.rc1.351.g4d2c8e4
