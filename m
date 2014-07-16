From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 10/12] fetch.c: change s_update_ref to use a ref transaction
Date: Wed, 16 Jul 2014 15:23:10 -0700
Message-ID: <1405549392-27306-11-git-send-email-sahlberg@google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:24:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7XcE-0004PR-0A
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbaGPWXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:23:47 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:53327 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbaGPWXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:23:17 -0400
Received: by mail-vc0-f201.google.com with SMTP id hu12so220495vcb.4
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H3XceTHF8iHN0A3fEhXEC0RhYDOZxIzW4F0yrOQ3MQ8=;
        b=aFUfctIU7zGEzvzZTj4FxhCJXQ8/DJQ1ml1INR5S1cwQfduNiE0yD0K6bTF7V+ReRi
         8U2SJd84E7vV8QtAdmBVVmHmR+dZizJhng8/5FGlqFMq23NwS6hBCa3bEf7+ukBsOJrN
         +lZPB4/lUV7ITaBti4cc7D9saFexDP9pW4pkcrPzSX5DEfvhRYmkG1nP30HkXk1iR1K8
         eG6Q3+sgYgEbopeU0PahI0kGh8BvvXcPJ8bgFMoKYEAd7GnrdRinws8+hLtISMyrsaLF
         4iZaJRXzG18Qxg7ihP85M5mFC6AeKA5VxvqZ+mNumqVxuc75hCOSuCyO6CnM16Vhh9IC
         T3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H3XceTHF8iHN0A3fEhXEC0RhYDOZxIzW4F0yrOQ3MQ8=;
        b=mMKaZsVkK4OfEwehjmls8vMZibxsYw3K/3Xwp4q4dQ/BtvNwcn1aE33cWsvQkla0xu
         BAP0nKT59l/2UaAOwEhMiTe7fHFilsCNYWWbWAKwCfDbIeVqavTydtNeFnBggD22VJ3Q
         vJk0HxXcdpl9gZ/QevrVli2R6BPZOVMblwSNUSUkGj8WqigDZW+luMKKAKdufuYDKo76
         IRIIeFQpnZKPI/YS7+pWZSBCj5ffZU9Qi+YjQTEpom0IMg1/Z7UbUcJq8cEMHfKvUZwl
         DhR7Dh9sL3zWKSDuxIr93WF9161fW5Xyi3yuoKfN+HZemDJE1Na2MUzLTog1Kb1E2HWF
         obWQ==
X-Gm-Message-State: ALoCoQldQ4iMFm0HbVt3/hxE2cGQLujVIayZd9hqSWpzyILB34LotBJm5MkDmqrafXSMmeX2joBH
X-Received: by 10.236.1.198 with SMTP id 46mr13976533yhd.16.1405549396205;
        Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id p3si72110yho.7.2014.07.16.15.23.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 136AC5A4123;
	Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id ACA76E0B2F; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.527.gc6b782e
In-Reply-To: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253707>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 92fad2d..383c385 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -404,23 +404,36 @@ static int s_update_ref(const char *action,
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
2.0.1.527.gc6b782e
