From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 40/41] fetch.c: change s_update_ref to use a ref transaction
Date: Thu, 29 May 2014 09:07:55 -0700
Message-ID: <1401379676-9307-14-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:08:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2st-00079r-CE
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567AbaE2QI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:26 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:39824 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757498AbaE2QIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:08:00 -0400
Received: by mail-qg0-f73.google.com with SMTP id q108so38082qgd.2
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9tAkspLEGbq9lVIvN85R6D32WL8Twi2gbS689R2RwNs=;
        b=gvD61ZBlnxDetxDocwj2V5kxc3LCETy1KVNKnxgGG0lXEpZX07Jb3vyQiyLmS3Fg2P
         rApT2BbDT9LBKF11L++9LdH7Aq0HxLCK8Xho7q/65qMp5FA8AYEHKHmgCipD0jab50iE
         +KlHuc7JO5LPenVLDWk3PANHO5+gaso1gTznzB72+z2g03JRa48Sel9ak379uwNjt2Nd
         zrhMD0tYLGFLb/JIGo9erPXXH+3QLG2hWFXAGw+gV4MC/fg9nx60iQsGWIkNes4fOznf
         cRFpEcsB9/Mr++BJJKwcNd+Sh8IDXUPjEqtqNswzp5NKm4MpI7pkMIhEl+fjURAcjKfO
         c4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9tAkspLEGbq9lVIvN85R6D32WL8Twi2gbS689R2RwNs=;
        b=dfy3Ik0BfqN2o9ikxHiwx79OTH/W+IhzSsc1sHM8g+lc0hIi2IDg8hNBAYjZ6dvTgZ
         q9utXZUs+xzNO2IbC1GGO1I7JTxaiORlwelN7iMaCEFTnU2A15QN5Qp13/S8I4Flcrke
         OxjVsmk2myezSIZO2m9a2dZKYrOp5oWnvxtdwbeb/wh5hZ/P1DSClK2r5W+4eADn+5ng
         LzCF0RIzKQsMH0MFqBlGyCvc8KGhzugERBOW3HW40j+4zHj8nPIQlwgWqMm5EQcCxlOq
         tcSF4L51jXsLekP3exC+Trw1dfR1XGM7mgV4JeIRtnpsY+BMCJuut/zGYTkmr2jppG8z
         zR6w==
X-Gm-Message-State: ALoCoQmprhHoA8dlFB4AOenEyUe6gmhyeAOGmyJgXVr69tK+Wpd880PN1ualG6T988qsahSvkB2L
X-Received: by 10.236.89.114 with SMTP id b78mr2012999yhf.13.1401379679834;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si81368yhk.4.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A8F595A4340;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5C94BE0D62; Thu, 29 May 2014 09:07:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250386>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index faa1233..b13e8f9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -375,22 +375,27 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (dry_run)
 		return 0;
 	if (!rla)
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
-	lock = lock_any_ref_for_update(ref->name,
-				       check_old ? ref->old_sha1 : NULL,
-				       0, NULL);
-	if (!lock)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old, msg, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
 		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
+	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.rc3.474.g3833130
