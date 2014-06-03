From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 40/41] fetch.c: change s_update_ref to use a ref transaction
Date: Tue,  3 Jun 2014 14:37:58 -0700
Message-ID: <1401831479-3388-41-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:39:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwQp-0006Kv-1q
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbaFCVjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:39:17 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:50880 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934313AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-ie0-f201.google.com with SMTP id tp5so1463269ieb.4
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4zmI2ejOAtAMMzddYO1qvfjtOSplklGzhFe04fjhb1Y=;
        b=Hs2eNgC2b7jICnuuHz61gU/03115HUYgNVqLixF9qsLjJ5MqaIRafg4TzDV961WTGs
         VgEwWxw2t/rV9uLaN5Ft1Fd+Q9/vfZvljz+KmCaFQqLdqLd/6uTKsUjpqag3YMd72ls3
         SUW572vczJ+G9cJyMMTRpxqpnc1KVomc2qB/aF2ANjFXk7ErRj1kroI71BhB5NkxGyqL
         TVqtuDrj4nTEl1UhqHQUpUGxuFH1cv3OVxAMQOV4fC5w1MAMSyvPhkECJ8XRTspOWFMc
         o9rFXkXwjs7xCFhHvmcMf0/3LmVOMw1zgHm2qx4OXaKUwCIPjka7MidhL2PU0Y/ZFRlw
         Z9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4zmI2ejOAtAMMzddYO1qvfjtOSplklGzhFe04fjhb1Y=;
        b=YlAs1WsPwdpmZiEL9Hcgt+EQHKCBonNVi0cCfmbiDg7QPPa7n56CAiufvvrD+76Sv5
         nVM9hvhogewnToV4ekr8JF7WQx1fXdglv9ETMkLrVPk+pALSN+v82NmL+UXqI7p8fxuu
         g2ojmBnyHMemATCv/qcT2R88uB3beRseW/+azTZp05ZVTxCdG+RyqnC7o4qOARjzq2g4
         pyEpQwAcImqNUyN5YnQL2M38D44t0F/8iy6s735XukLvCYpEAFrt4a7jVnt3qTRIShmH
         piYLgoXiveJcPZhDXcMSdnWOQv5HYcStu2bmZV/CenQ+Qv5w3xGCBqTJD0tPb3nvgOR1
         8zYg==
X-Gm-Message-State: ALoCoQkAS1rqMXW+H4TW88FGpkjGHQ1UgtEPhX1Q/80eBD1KZuN7CBu5f0FQt3QZHiMQobYu4WJI
X-Received: by 10.182.118.162 with SMTP id kn2mr19709645obb.42.1401831488561;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si30412yhg.2.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 687E931C45F;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4891DE05F1; Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250662>

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
2.0.0.567.g64a7adf
