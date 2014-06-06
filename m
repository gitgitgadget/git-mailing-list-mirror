From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 39/40] fetch.c: change s_update_ref to use a ref transaction
Date: Fri,  6 Jun 2014 15:29:17 -0700
Message-ID: <1402093758-3162-40-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2e7-0002R3-Ui
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbaFFW3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:55 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:65166 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbaFFW3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:24 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so680022qab.4
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Scyx8aGRgfxIGe6QKMr8/C6ULnEOFhHmbcGX2uxzQfE=;
        b=BfRXHPOXdFi1VgfaTnb+KjBy4DLfZHPUAdtuE8uMGlbS652rxINE+nPPS2vB9C4h8X
         iu/GzTyYcIwrHBv2fl9rJp2YvtKAMFQuHVQgRzKsYRi4e5Z/DBWYAeuxart2N6pDuO/A
         IazJUKOeZECHR1uwkkHsWjyPgbOv5WHsrMiwYuXh8QE5A5viC18S0yvVxnwLh0Wn8nwM
         BnIsCr548TryUbpSMr1gFWK3F9dASVXGCt3nNHbugaqYflh/DbADZV5lGUUc/olR28cz
         hbD49+x2UC3CdPJHEDMlEn3wQ44EDxV5iVm/E8MoLaQ+lMgF6VTjNJJ7HAP+vEAgv+3s
         0KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Scyx8aGRgfxIGe6QKMr8/C6ULnEOFhHmbcGX2uxzQfE=;
        b=lXwrCg8MwWYNaJO+LHQ0UhqrGZuXro1+Is7In5/8TgzdzzAOhSNw4HQlhmE7lG6HrE
         NuzRVQ9i9eYA9ctcRQcQI549tjdxERLQveOBXBATEuYHyTp3UBuaD0mNBImkY+CGkZFP
         zkjP9+Bky6qJ+vBm3+kEkplUEzDuXNnXJRhF7Vuj0OUSMFa49OKYg8vIS7ywekGQCgvL
         Yy3FmaKxv8gb+qfnhqhzbtUCZ67UT2B7cAq+uSS4jF1Z0EuRoy3MVmFbl2cjusTmumLf
         lzxab9tRg3+IWeOeubaHfLpKAiEX8GzW3cXC3BhF/ZA0LMn4Ygcm/nLfPGFXyp26wN4w
         L3uQ==
X-Gm-Message-State: ALoCoQktL7sletfSGRTZqAVckxyzpQd748DwrZbHGCbGEPny/EAFk0ld6eTm+EhvRtUO57tPaxT4
X-Received: by 10.58.132.177 with SMTP id ov17mr5163635veb.25.1402093763489;
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si751225vda.3.2014.06.06.15.29.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4285931C62C;
	Fri,  6 Jun 2014 15:29:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 22E6FE0D74; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250985>

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
2.0.0.582.ge25c160
