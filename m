From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/3] fetch.c: change s_update_ref to use a ref transaction
Date: Tue, 22 Apr 2014 11:45:26 -0700
Message-ID: <1398192327-21302-3-git-send-email-sahlberg@google.com>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 20:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcfi3-0000rq-U2
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 20:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbaDVSpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 14:45:43 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:42274 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbaDVSpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 14:45:33 -0400
Received: by mail-ie0-f201.google.com with SMTP id rd18so1256792iec.0
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6fGZEW5bfsI3h2gUqwskk+R3SC6aT9qrJYrDXyYpzqU=;
        b=CSAmNm7x4feO46ZxkUi6xaLU/JC3QoDfg1Er1iJaWduHPWQPzov/Bxg+rTnAo1wdnR
         1e2scLEgtxmRmzMtxiG4wyT3vc3+XTGfjJNU8ndFGdJnQJiPU+VbwqvbMQEKnQJMF5dO
         xeP7QMnykwGQ1grf1yrFY4ChHLki6ycl4lE8VggRJSFyMdT0vQh3I4I/rjI1qBd9qcyW
         hswDvEEXZ6rjrP9iOp8YodyseEriOVW46VwogXnIWV1mxKYJgDlKsXn1a3+BOGtm7Gjr
         0HrDxGsDvvPkpM+NATtFf9FJ3qDDWs48ECWTxkwRw8I8vutarWS0Tg1jEsM0BykckuR0
         ybQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6fGZEW5bfsI3h2gUqwskk+R3SC6aT9qrJYrDXyYpzqU=;
        b=FU9MwOy3X4JnpFI5rmjgndbFEGIMRGJcIHpbR2483ZMR6fs+aLCmO/iGISP/8eq9vw
         DJYitlWqAK1OLRHx5lY5xd3x+Mm9LlbkavCK+wEgOhHPKRywEH3jDFNwp97StwUz6T3M
         eodx/qupya+EUrI50ANWxeekMotTXMGjWVuj/k8JHTzNCfpGmT6dvgBqJNN+L7XIvTM9
         Mye9ckIqISr90i92ceBrjE5ZHvTOa7bmsV9lAP9U1qPBJZ5DJz2SofznuknRGhpdqHea
         cEt5f2g7xWGnhYGjITqkU06kMvu650ev25Ik8/LLMop+ce+UdGuDdK8KiaI9z8302UA1
         LVfw==
X-Gm-Message-State: ALoCoQno7ahuEx9YnIfrojfRtOajb/symJLOjGbVDMGQZfLHFKWety6tih0GJNcj27vbmVbVy3+LuGoJ+lnS/t4G4kQ7JXyXWTuAi5RzMfR3vgNf0pMSIK/SxZ6qfVsc/8EG94ZNEW0V6gQStuywFHHqHnCUrIDj+jJdZWhuJz3hDvvY/ynszpUlK/STaUewYP9JJ9+OgeEG
X-Received: by 10.182.219.226 with SMTP id pr2mr22938036obc.44.1398192333329;
        Tue, 22 Apr 2014 11:45:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si2233306yhk.4.2014.04.22.11.45.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Apr 2014 11:45:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 2E5575A4274;
	Tue, 22 Apr 2014 11:45:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DC684E0BB8; Tue, 22 Apr 2014 11:45:32 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.518.g16976cb.dirty
In-Reply-To: <1398192327-21302-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246765>

Change s_update_ref to use a ref transaction for the ref update.
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a93c893..5c15584 100644
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
@@ -384,15 +384,14 @@ static int s_update_ref(const char *action,
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
+	    ref_transaction_commit(transaction, msg, UPDATE_REFS_QUIET_ON_ERR))
 		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
+
 	return 0;
 }
 
-- 
1.9.1.518.g16976cb.dirty
