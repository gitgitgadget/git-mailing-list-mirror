From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 02/41] refs.c: ref_transaction_commit should not free the transaction
Date: Tue, 27 May 2014 13:25:21 -0700
Message-ID: <1401222360-21175-3-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNx3-00021g-Aw
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbaE0U0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:07 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:59792 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbaE0U0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:04 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so1508605pbc.2
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aqbkmAF5i6M7h6EocLOQKLEcYB5xg9VSGFq9qLdjVuU=;
        b=kzzWRMuftBsimA8ZbA5OjHTmY5+hxxN9NiOHNOsIv12uTxml6nUJxwP1QS/PjSgBJc
         C1D/XR1LDB5LHap6ucNkIbHDfkK9KFiGVDduGHVIj+920AqDLxY3kh/Pvei79uYrMBqg
         p4gSArcIlLu854TFvtu335NoyPguBRplmlHxUd6jtQ2OBlMqkceV9MpTiaffeKD9PDo4
         ux06Dyl+z5RiRTPTU7mNqiNFr8vCCpHQwueXWSi3XvwgPj6Fa3Cfp7akNObXgzN32rNO
         IwgY65m19Bwi9zwbDqBWde+siCmI7udX7fKUiETVX6C8lTvZftPjRqQcObPpmes9txQx
         dlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aqbkmAF5i6M7h6EocLOQKLEcYB5xg9VSGFq9qLdjVuU=;
        b=b0jMHAwmW2NauZE6RHAobugvjsQlv8W3AzFZkMMXKxan7i+OQP+SGOwEnPgRWeKJ2+
         QbfXSeReEZ1cKXsSeA7bl32ztWegs8IbajosKFI2/s1MzF5ZrEP6haKcwYGSC1c6c72W
         r1KtVp5fMFl9e4PJl+1RPAcwbpauMWcUu8E+YmvZupuHWSHxiWyYQTh6qgTdJfdWF7Wv
         pIFjExEZX/ULF8dHtshxtghXYy1bXHSbEsP3iyA4PmwCqkBujVmUwWMmwJkWEuHHujOB
         lbi0wO6uvUrmlZCKgh1HwVV8mUKPyEbwlp3CWtT0IIkL+sGq4z1rWzi6Gd1mDJf0TUM4
         NFOQ==
X-Gm-Message-State: ALoCoQmJTQXmEyatwzh6FCN5GfAorOzHJKTbRRcoSiX7T+xeIHP3cId14upMkH2BA27toSbhjQgi
X-Received: by 10.66.66.35 with SMTP id c3mr14821890pat.7.1401222363903;
        Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1574637yhj.5.2014.05.27.13.26.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B39AF370568;
	Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5D4E2E1081; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250201>

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
index 48573e3..33541f4 100644
--- a/refs.c
+++ b/refs.c
@@ -3483,7 +3483,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index a07a5d0..306d833 100644
--- a/refs.h
+++ b/refs.h
@@ -216,8 +216,7 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or freed by
- * calling ref_transaction_free().
+ * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
@@ -265,7 +264,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The ref_transaction is freed by this function.
+ * problem.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr);
-- 
2.0.0.rc3.474.g0203784
