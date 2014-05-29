From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 26/41] walker.c: use ref transaction for ref updates
Date: Thu, 29 May 2014 09:07:48 -0700
Message-ID: <1401379676-9307-7-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:09:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2su-00079r-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757099AbaE2QIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:48 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:59673 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757464AbaE2QIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:08:00 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so105522obc.0
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hT/OnDUQrbr/w3QLjqlQtSGC4miM8XORmSJlJUrK2m0=;
        b=F8tv1TIv/ErTzopAegFoxLSEflqSR18XZgRNvTdga6cRFkvAA5iJ4ku8jpcUqqZd9i
         owitKWwOn5JeN0SGIIzAug5qGJriY8dW4qb8Jxm+ku/8+NYsU36Z3GSuhxjqesz/VQXW
         FjvSyF4XploqgIVbhn2mZJYRl15j0dFn9ZVvUSbbRNj0+1fmK3z3VkvFHvUWlLpHaB6o
         SpeFxx0CyYt2LwKozzum8yCpd4Rze8OgbgvP+Qgx25mzDsK0H/7lDQp76vBh18f59BCw
         3T9Ghz1S94AWsQ+exmSoTMQYKrdqctTv20MDLqusm8SyA1h4hDXuvy2cPjelU4ms06TU
         C7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hT/OnDUQrbr/w3QLjqlQtSGC4miM8XORmSJlJUrK2m0=;
        b=GTo47iBwr7Ed72C77mUZlFTp3EQhWvRMCQIDVCOxVOYo6fO5tOGqNgw8VE1gu+M9CR
         q6zwnl/V234vnXKOhpITVewQcJm1DKLPdd8nwCuDuoRkMbWY3CBfevhy2NNtO6rf6cQA
         RQsP46j+CAh6Bc3Vj2S2YGB5Z23V4eIvq4KS60C98TtfsgpJU00VvJqg1q9xPnN9Etk1
         dq9/qp7WPGOKswLFW7hqxz+BXrJGGgryO1z2lHRKPyh5WLAPt+rGtd1+Zls/2lNEllfC
         9XmmeiMwyAeb/kpSBX6DeXB0lWD9Hp/vauukMDOr4vOKW/3K+kRDT4IYHIGFhuMHFvhf
         /sUQ==
X-Gm-Message-State: ALoCoQn1aoVr5UCJjLQsWXTyNlYIcM23booNeMTdgNDM/YRCvgEl8dkL5XlgmuKLgJzF+oijPvA/
X-Received: by 10.182.213.37 with SMTP id np5mr3490069obc.36.1401379679602;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si82019yhg.2.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 55C405A4340;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 05AEAE11F5; Thu, 29 May 2014 09:07:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250388>

Switch to using ref transactions in walker_fetch(). As part of the refactoring
to use ref transactions we also fix a potential memory leak where in the
original code if write_ref_sha1() would fail we would end up returning from
the function without free()ing the msg string.

Note that this function is only called when fetching from a remote HTTP
repository onto the local (most of the time single-user) repository which
likely means that the type of collissions that the previous locking would
protect against and cause the fetch to fail for to be even more rare.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 walker.c | 59 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/walker.c b/walker.c
index 1dd86b8..60d9f9e 100644
--- a/walker.c
+++ b/walker.c
@@ -251,39 +251,36 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
 int walker_fetch(struct walker *walker, int targets, char **target,
 		 const char **write_ref, const char *write_ref_log_details)
 {
-	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
+	struct strbuf ref_name = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction = NULL;
 	unsigned char *sha1 = xmalloc(targets * 20);
-	char *msg;
-	int ret;
+	char *msg = NULL;
 	int i;
 
 	save_commit_buffer = 0;
 
-	for (i = 0; i < targets; i++) {
-		if (!write_ref || !write_ref[i])
-			continue;
-
-		lock[i] = lock_ref_sha1(write_ref[i], NULL);
-		if (!lock[i]) {
-			error("Can't lock ref %s", write_ref[i]);
-			goto unlock_and_fail;
+	if (write_ref) {
+		transaction = ref_transaction_begin(&err);
+		if (!transaction) {
+			error("%s", err.buf);
+			goto rollback_and_fail;
 		}
 	}
-
 	if (!walker->get_recover)
 		for_each_ref(mark_complete, NULL);
 
 	for (i = 0; i < targets; i++) {
 		if (interpret_target(walker, target[i], &sha1[20 * i])) {
 			error("Could not interpret response from server '%s' as something to pull", target[i]);
-			goto unlock_and_fail;
+			goto rollback_and_fail;
 		}
 		if (process(walker, lookup_unknown_object(&sha1[20 * i])))
-			goto unlock_and_fail;
+			goto rollback_and_fail;
 	}
 
 	if (loop(walker))
-		goto unlock_and_fail;
+		goto rollback_and_fail;
 
 	if (write_ref_log_details) {
 		msg = xmalloc(strlen(write_ref_log_details) + 12);
@@ -294,19 +291,33 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	for (i = 0; i < targets; i++) {
 		if (!write_ref || !write_ref[i])
 			continue;
-		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
-		lock[i] = NULL;
-		if (ret)
-			goto unlock_and_fail;
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "refs/%s", write_ref[i]);
+		if (ref_transaction_update(transaction, ref_name.buf,
+					   &sha1[20 * i], NULL, 0, 0,
+					   &err)) {
+			error("%s", err.buf);
+			goto rollback_and_fail;
+		}
+	}
+	if (write_ref) {
+		if (ref_transaction_commit(transaction,
+					   msg ? msg : "fetch (unknown)",
+					   &err)) {
+			error("%s", err.buf);
+			goto rollback_and_fail;
+		}
+		ref_transaction_free(transaction);
 	}
-	free(msg);
 
+	free(msg);
 	return 0;
 
-unlock_and_fail:
-	for (i = 0; i < targets; i++)
-		if (lock[i])
-			unlock_ref(lock[i]);
+rollback_and_fail:
+	ref_transaction_free(transaction);
+	free(msg);
+	strbuf_release(&err);
+	strbuf_release(&ref_name);
 
 	return -1;
 }
-- 
2.0.0.rc3.474.g3833130
