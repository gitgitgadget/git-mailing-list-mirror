From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 47/48] fetch.c: change s_update_ref to use a ref transaction
Date: Tue, 10 Jun 2014 15:29:35 -0700
Message-ID: <1402439376-25839-48-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZh-0005yY-87
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbaFJWa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:58 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:47107 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so450481obb.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JvToMTrNCPJ6Udzs45/GHCELIWMTM8D8kQsHcAnJAd8=;
        b=GAPJiPj0VqOxHwmhcn/Hq8iVH8VR6Q9BdOA9tFIJjvYTLADnVh23ycuuYa1U/iP/RC
         8EKXZO7d2HMMN31QPFcOxcj3Y4lRYj56WT9O13nGvYXb6jChDEtCQt+XvMrASiiuaXgL
         in26DXad0R1Jr7pOz+fddFGT/T0DCOCLElthFuWADnApWEWrInse2mN/SM4gaiHD62Zd
         fx1XLVyAsftEB4Dpqsi4w/lZFkDHKvgETg1GTh6q85L3dxdYJchtPj489bhl01I5Pjgm
         5Pd14ULQJYemFG8gERFaneb1rEQXw/C2AQ3WGNkBlN1yTzoYo3faTqr4KYDTzrzQ0KFd
         i2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JvToMTrNCPJ6Udzs45/GHCELIWMTM8D8kQsHcAnJAd8=;
        b=SV4pRC2DC0rTYPVdXUBM59zSbpHqGR2E+n35Fp6yGLLDbkXRj7aAXznk/PPmihGD/L
         7xiHXTL052TWaTHKm608rP825h7XyWbtqv5VFXBQtaAcomH2fhXieTPftwzCyHhp8Dt8
         VfKl8ddlRV8Qs3kl1pTP7YxComiFucudsNcDXjmTs9JAbnHlEugPxStxuOme/OWSGpi8
         7uqA/BipJJwyT8X6JsHHd6KJ+clZ4iIxmv9PfWYdFrt29dFmUf9zKsXuMxAUpm09oMR0
         6itbfvZVuYFyBDzrRZNcZG8OxGtcR79MgZmhP0GqYg7n7A41U/yi6AO1enjwZwQ4itrF
         QAUA==
X-Gm-Message-State: ALoCoQmHTXEczJ5i1FO9IGcxQJuTNEWCdthaFPBBxSbfXwj2VbxtUzGdNb8cPXeqX2SYo5/RT8eX
X-Received: by 10.182.125.4 with SMTP id mm4mr3060549obb.49.1402439382214;
        Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1395566yhj.5.2014.06.10.15.29.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0F7F431C750;
	Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E6B9CE0B27; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251294>

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
2.0.0.574.g30c2c5e
