From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 47/48] fetch.c: change s_update_ref to use a ref transaction
Date: Thu, 12 Jun 2014 10:21:38 -0700
Message-ID: <1402593699-13983-48-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hn-0007Gc-5U
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933385AbaFLRWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:22 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:46405 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756288AbaFLRVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:46 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so310169obb.4
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yf63ngJ7b6ObNhdznod55KV2+LYtwYzqzlujQHjT31k=;
        b=VlEBhVUn+6ufrbz1Baj45GLAUSStqarc2DKFpktXgIiKXaCzIzYBfdYTdOsczxdDty
         SpER3/W0SgoV8gYSr0TX58373vnJ22EoCaOUW5HGWJCYKQwxPphkMmpmUtDauyU+lTU2
         5B8mamRFULaYY5KGRoZdVk0l8e0MGsaL6qsGF5yv4392BGJwPtMaQGXYm8O7LTesWiHo
         FcAL8Z/xzw6Vcre5NG3S0CV4/ct6+yks5TfIspSp7F0A3cRIYw22Lo+zXli6+G7m7wpg
         w0OBAovw3YNor68G7hZ1Q9gk0MHvDFNQ6lTn2cEKT00Vi7lq4dEASE9TWzcSAnsmYkfX
         zO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yf63ngJ7b6ObNhdznod55KV2+LYtwYzqzlujQHjT31k=;
        b=A67PDfjej4MPjQNWHZkpSXc88RpwV4KNCmPrjybCsvVvtSWMLBUKNAkLeIiFAGD5oS
         Og5mvnVQtwEg0sKRNkSUfOAf5zad2WBg7rsy1+fStUGO0/MLx9im5Qkc5FYObzBpl9Sz
         SJ43p/Ll92IuW6TwuRUs1FgF4mU0tMTk1iEa9ALq9Kn1t2t4nowQSrrauY9OwL8RL2GZ
         RB4S4Q3Ycr8NKybooXadRrDCwdKvDEHAyAi50v2iB9Szg/r3NQ6acRJHsjF+16hPfY+C
         79k7ifKp8oHkhuGecFvJpDRBx7M0u9wFL7cPp14l4gDlOq4ieUBkGDy9kM2UXKX+DQuI
         r48w==
X-Gm-Message-State: ALoCoQmUfOHdXDlzTQbljbf6SWwZJzsY46wWQElBiCOzmc11FjE/Vfsj2TlLnDJVNKdpkxKHB1JV
X-Received: by 10.50.148.1 with SMTP id to1mr1156659igb.0.1402593704981;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si113148yhg.2.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CDF355A47F2;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AC8E4E0C3E; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251428>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index faa1233..52f1ebc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -375,23 +375,36 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+	int ret, df_conflict = 0;
 
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
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old, msg, &err))
+		goto fail;
+
+	ret = ref_transaction_commit(transaction, &err);
+	if (ret == UPDATE_REFS_NAME_CONFLICT)
+		df_conflict = 1;
+	if (ret)
+		goto fail;
+
+	ref_transaction_free(transaction);
 	return 0;
+fail:
+	ref_transaction_free(transaction);
+	error("%s", err.buf);
+	strbuf_release(&err);
+	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
+			   : STORE_REF_ERROR_OTHER;
 }
 
 #define REFCOL_WIDTH  10
-- 
2.0.0.599.g83ced0e
