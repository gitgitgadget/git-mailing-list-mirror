From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 02/48] refs.c: ref_transaction_commit should not free the transaction
Date: Tue, 17 Jun 2014 08:53:16 -0700
Message-ID: <1403020442-31049-3-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwviF-0003WZ-VH
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358AbaFQPyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:37224 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454AbaFQPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:05 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so1490511oac.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nKZnBXJwWVEgmUP1+HAedGZQLI+kjYYJfqLswQe2IaE=;
        b=mgWF13LRtaoewN5ahr1RlL+hcoB6Mox0En/GbelNqIl0XRmvxt+Cp6d8Y53RD4apKL
         f5OQRwQ6Im0qAXMJyEGo7lV9JiTqXGr+8zPd9HkC6Xwz3QO8/r9eGjrEaRZaKOHLOVfQ
         c4tXGWnODonsM0E37t3vxkCmVJUEFwc6ou1ACXd4dq4rHQxItJOqm80Einj1WrGyc24m
         rYTriQMxBlEivWYgBioXeuPTweXLwBzSQQ7+xrf6RF7sd2GR8QZ/9i87C5ZQsJIuLkBF
         zGnfZaF7PMApk6CZj2/KZEcVj4xoZSShK5yVXAgPjY9fsjOLQRu0soQhQARlhht1p/Kf
         b8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nKZnBXJwWVEgmUP1+HAedGZQLI+kjYYJfqLswQe2IaE=;
        b=V03atrjqbmQJqThm9OkxtLouONaxXFvY+8xVrvV4dzM0FxYr9Fm0wT66zm59WrMDA0
         Jv3uxdX7RMGUwn2ccT88dGJiR8YcSIyQNKC6KC5YfvYRGa0aWsKWpx9gny4R1z97Jvb6
         a4XchAg39vckPA5Enl7Mf3A/Z7Z9/qs/2n/1N+dDbZmCwJfvtPpw5rGYN1tmod5F64em
         EQOi2mLVaHx8z+ioD+OD5bJxhSxl3tizpLf9ZTKxO5R7EM4aA20FzkGiE5DKxAT++3xc
         4M/XrBNf/jlb9tzsZGRcCmjTl2dLNX7Wt6N+a/3bW6tlKH+cnTDVb3zn4/YM+BcvCG0C
         QwGA==
X-Gm-Message-State: ALoCoQlHJ3dgFan39X+uuC2S9fvcdzNnyfwOET/SzpNvRMCMbb0Blr3TFUusTZxIk+nLyw9AwPv7
X-Received: by 10.182.213.135 with SMTP id ns7mr3472332obc.46.1403020444327;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j5si69088yhi.1.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3029B5A45B3;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C77BAE0EE0; Tue, 17 Jun 2014 08:54:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251872>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 1 +
 refs.c               | 1 -
 refs.h               | 5 ++---
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 405267f..1fd7a89 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -369,6 +369,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		update_refs_stdin();
 		ret = ref_transaction_commit(transaction, msg,
 					     UPDATE_REFS_DIE_ON_ERR);
+		ref_transaction_free(transaction);
 		return ret;
 	}
 
diff --git a/refs.c b/refs.c
index 6d841a0..d9cac6d 100644
--- a/refs.c
+++ b/refs.c
@@ -3509,7 +3509,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index cfd1832..7d946f6 100644
--- a/refs.h
+++ b/refs.h
@@ -219,8 +219,7 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or freed by
- * calling ref_transaction_free().
+ * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
@@ -268,7 +267,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The ref_transaction is freed by this function.
+ * problem.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr);
-- 
2.0.0.438.gec92e5c
