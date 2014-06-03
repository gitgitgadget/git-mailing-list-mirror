From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 14/41] refs.c: update ref_transaction_delete to check for error and return status
Date: Tue,  3 Jun 2014 14:37:32 -0700
Message-ID: <1401831479-3388-15-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSd-0007Xw-7u
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965417AbaFCVlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:24 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:36265 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934175AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so807211qab.4
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fafy/m87xRiLgtOiRb8IfVjXDMm86jCQxP7nWTbnOl8=;
        b=Wm7nhWsdcMEU4RpesKZSKj0O740R8WP3zhFSGxDtetaweb6Z1yHLnNVjqyOc5qDKNq
         r97hKin6JJAEhpC0XG9rNBruuimEnssajUFO22311GrveYWLab6qnI0FcFmLdp7IFEBp
         xhh6Y0Sp6DvvXoM7CJpiYYbcijHnPMh9hkC4R+rrzFwgMINcLSAB1ZAGbUt9qjq6vyn4
         rXHsc8S0pIj+znj0YRzqjHuZ5SZzbJulABvTEmbly4Qdle8qp+LO2MKPVba5gWLMWHoy
         kNHfq9Gax3jeBh+7wTUCoHZVLUwDc4bV2iuRKH/MqoYF2Z9LjL3yyeetO5zcZOylQzMg
         0dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fafy/m87xRiLgtOiRb8IfVjXDMm86jCQxP7nWTbnOl8=;
        b=TFUTJi+JakUHjTIHy43ozx1O5j+SlbiiSEM9rCKLBWJnYyclreAdifSHabaDoKR/A1
         9djKr7lqdykr7RD4pZvJgefRBkX/qVBLnrHC3MSXY0CUjnuf8/xnTyL5ggWIci+hzzwf
         BEpypijA8HqZZE8pawoM2GOAPnxk82l++omo6W3guFaMOhUEe/rHrdv500lcz+Hig+So
         dKyvwfWSbF8+VMs5eek5libW09Xd8TxnombjkLW34YG33YfuE12MFhR67JjSWfR7cuZ5
         1O6C/+osV6HsbGSw/eouH84qIKPo9Ip+9ShGCGiHUmFiUOsU4ViR2YwQ7wDeYV/sNWHf
         uQOQ==
X-Gm-Message-State: ALoCoQmKUrG6+pVdLpTfU6ZdSmkLEIvDW3b7M4Mux5TFd4pt6z6iV+hszeI08dpBFM1Ok6wSmiwn
X-Received: by 10.224.26.76 with SMTP id d12mr9877771qac.3.1401831487395;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si30408yhg.2.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 33B7331C435;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 061FCE1149; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250674>

Change ref_transaction_delete() to do basic error checking and return
non-zero of error. Update all callers to check the return for
ref_transaction_delete(). There are currently no conditions in _delete that
will return error but there will be in the future. Add an err argument that
will be updated on failure.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 16 +++++++++++-----
 refs.h               | 12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 41121fa..7c9c248 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -258,8 +258,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	ref_transaction_delete(transaction, refname, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_delete(transaction, refname, old_sha1,
+				   update_flags, have_old, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 3cb99f6..d9b99c7 100644
--- a/refs.c
+++ b/refs.c
@@ -3459,19 +3459,25 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
 
+	if (have_old && !old_sha1)
+		die("BUG: have_old is true but old_sha1 is NULL");
+
+	update = add_update(transaction, refname);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old) {
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	return 0;
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index bda790e6..58ba365 100644
--- a/refs.h
+++ b/refs.h
@@ -303,11 +303,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * Add a reference deletion to transaction.  If have_old is true, then
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
+ * Function returns 0 on success and non-zero on failure. A failure to delete
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back.
  */
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
-- 
2.0.0.567.g64a7adf
