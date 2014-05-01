From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 06/42] refs.c: make update_ref_write update a strbuf on failure
Date: Thu,  1 May 2014 13:37:06 -0700
Message-ID: <1398976662-6962-7-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxmo-00045k-ID
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbaEAUkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:41 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:50774 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbaEAUhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:47 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so799414iec.5
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OQU/eVfEYN9TANQhmliLkSqzwMyWRFOedi5OjoJkgRw=;
        b=Xrm5uJtQgIXIA4MkSgf8UV+dL6Oastv32iybNHAaReX4JuRTvHHLUivqIxfDQzS0dE
         7sPpoaWaPmTTBvjj9KDfWu6riw3Uug5qkzleIOAsdeQvpzHRQKRseFWJNoDpuePISv0N
         wHuZdnC4MF9H5NRhw8TqolHZZ9l9UDqmZyZKDF1jdgPYYSc5QPY+W37nNVtT8vNPhl2L
         c9YQIpb4dPg236oq5XetHETOsvovuxfVMu28AXIkIN3sjBsX16QLEQYqk2bGdL59oMli
         krJkjVabWpi49GnkZZimKMqcVq/2LrdJGy9bMHfX3FqkC266Anh/P53SL7CPRwa1iABF
         s9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OQU/eVfEYN9TANQhmliLkSqzwMyWRFOedi5OjoJkgRw=;
        b=mEN9VUmzAH05gDDzvPGI4TxcBjItR9PpRqaRb+5v4ParRsszv51zk5lGA3z1sG8rwM
         Ta3Ut9mk8zo2crDzY4gEpYPlGls3jQxXfreB7Cf4PznquL00+kC2HtmDzOC09OvbFUoC
         DFmokluznJ8fKMXLl+nDOOjs6e/pTR4nXjtondBI1XnojkHHKIbUXTRLFv7ZMQyKdjLC
         tqFKcXEkeCATAAaggQxKm8CxK9Sw3vBudjr0m3Ed7lABlHIK5kwDYKiQxTB2dWTv9taL
         vfMMqVaXW+mFz9ZjqQvDoHFQUvTnsK81QfrvbMLsNhw/oJPRKRVbzziP9tSxTlDPX4BR
         +BcQ==
X-Gm-Message-State: ALoCoQnclqgandUKdkiGYOQlF2V+07fL1p8YHRZQQWl+hHlpZa/zIJTEcixwZZ1KWgDzVoY0smTt
X-Received: by 10.42.211.15 with SMTP id gm15mr6089228icb.28.1398976667283;
        Thu, 01 May 2014 13:37:47 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3538015yhe.3.2014.05.01.13.37.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:47 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2015331C1CC;
	Thu,  1 May 2014 13:37:47 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D90F9E097F; Thu,  1 May 2014 13:37:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247878>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 21a147b..5e06fd9 100644
--- a/refs.c
+++ b/refs.c
@@ -3253,10 +3253,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
-			    enum action_on_err onerr)
+			    struct strbuf *err, enum action_on_err onerr)
 {
 	if (write_ref_sha1(lock, sha1, action) < 0) {
 		const char *str = "Cannot update the ref '%s'.";
+		if (err)
+			strbuf_addf(err, str, refname);
+
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
 		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
@@ -3382,7 +3385,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3464,7 +3467,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.0.rc1.351.g4d2c8e4
