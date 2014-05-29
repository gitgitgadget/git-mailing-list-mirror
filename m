From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 32/41] refs.c: make delete_ref use a transaction
Date: Thu, 29 May 2014 09:07:50 -0700
Message-ID: <1401379676-9307-9-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:08:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2sv-00079r-Ds
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbaE2QIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:50 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:33521 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757467AbaE2QIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:08:00 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so105624oah.4
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u7e2XYwpcA1zkOHoNpvEW++te+Qhh6P95DUweVY4ygI=;
        b=Ylt2asJZ3DjaJmz+f5UFEZ0GVmRbeuYAYvxYDUGJ1M3s8W6r+JP+ElFbmSzfwIaUrM
         Rp0BqsrtEFwTCUFL7azGNMBRMqOubiAwru3smqT1imn2Rp+kz5k1WG83XcNa1RrCmG3N
         YaXmkiP+yJZTuvlRv5jQk/a/IMKk2ge4YJqySJeNmLyfjQjZ2ZhsRQonQJsnjSSp+TeE
         UApeoWD1HI/Uq5H95jcfHuB/u/D76a3Z+AM0feUX/Z+cPhN0+T0XqcNerv/ZuezxaJxX
         SE/fZNo9RNm6r4n9kQf50zfi/hN2JjZ9zrJrqPLvsOLJOedoKldh8zmDFA+P7BqjpNN3
         jRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u7e2XYwpcA1zkOHoNpvEW++te+Qhh6P95DUweVY4ygI=;
        b=f/qaw4fAst0VcobR7J/kG/cmoKFW8ALb+C0ZLct9lYJEoSr1mRqRBUhXIUJRXSeabI
         Zwc6+Oed8zf2KDAZHLcDoDu8EZ0IQka8bnzKNsoAN/EGm12PXyt6+Ql+sIyP2rbPU7aF
         E+SBbvLgn3T1DtoT27Sykly+uyWn83YIBD+XzXG3qyr6MI5V0NMmTjaME7zFCVMrtCQd
         5uvsw2qzf6Ri0ih8+S6ihdI8n5EH+HyVUuHsZQFBfkZ8yOVmgJw3k8R1MXdPuM5C1h4/
         Nev/zAMfRBnvVVOlMb0vVPXJ003NYkJrVVp78qo1TbFGVtu9iFAG4nCV5eToRN7uP/gz
         d+cA==
X-Gm-Message-State: ALoCoQlFV6hBbx0GXsWkQz9UBKb5J7ulSJ5QWRnfom12PyrRTX8Yd2Rzs7mTcMvFEyMXC+6iA2Ho
X-Received: by 10.182.133.73 with SMTP id pa9mr3382064obb.6.1401379679642;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si81364yhk.4.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 779A331C3F1;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2290AE15B9; Thu, 29 May 2014 09:07:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250387>

Change delete_ref to use a ref transaction for the deletion. At the same time
since we no longer have any callers of repack_without_ref we can now delete
this function.

Change delete_ref to return 0 on success and -1 on failure instead of the
previous 0 on success either 1 or -1 on failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index 60593d7..e2c2249 100644
--- a/refs.c
+++ b/refs.c
@@ -2494,11 +2494,6 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
 }
 
-static int repack_without_ref(const char *refname)
-{
-	return repack_without_refs(&refname, 1, NULL);
-}
-
 static int add_err_if_unremovable(const char *op, const char *file,
 				  struct strbuf *e, int rc)
 {
@@ -2538,24 +2533,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
-	struct ref_lock *lock;
-	int ret = 0, flag = 0;
-
-	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
-	if (!lock)
-		return 1;
-	ret |= delete_ref_loose(lock, flag, NULL);
-
-	/* removing the loose one could have resurrected an earlier
-	 * packed one.  Also, if it was not loose we need to repack
-	 * without it.
-	 */
-	ret |= repack_without_ref(lock->ref_name);
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	clear_loose_ref_cache(&ref_cache);
-	unlock_ref(lock);
-	return ret;
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, refname, sha1, delopt,
+				   sha1 && !is_null_sha1(sha1), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		error("%s", err.buf);
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
+		return -1;
+	}
+	ref_transaction_free(transaction);
+	return 0;
 }
 
 /*
-- 
2.0.0.rc3.474.g3833130
