From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 22/48] refs.c: update ref_transaction_delete to check for error and return status
Date: Thu, 12 Jun 2014 10:21:13 -0700
Message-ID: <1402593699-13983-23-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8jB-0000FP-IM
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbaFLRXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:23:32 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:37265 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so245433qcz.2
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xEDLCRSSp2tGpbpHTh9KlIq2eWtxPc9ngEmoFgrIbi4=;
        b=CRtsKCMKlGRrHLGqGnf8Xfk6kXDmeLdyWq3XQui9I5stcr0WvfVSZ3deC0FooYS/cs
         UzPtT0Tv5zmCmnInQ9R6nFusm8ldKS5vOeZ3UajkP7PavpeDdzMqj7qunCpuc+YRLhXA
         J4UXSmMA7OuUuQflD8M0420wCTHibKDNEgPXtvJE8RRrfQvfLyIobeWTBPz/XVcen67Z
         nZfGX1B1/QOt0NMRfSO+pA/DzLdK8IOBUeJJOzMxpLu8S8K+HNh8r8lwXZwWMxSXtr4E
         mRQOUuJx5il4ZCgsgF9+sYufTBNGknqTNvdc5i2Nfyxoe5RKindW3mspOip0t581iLel
         UtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xEDLCRSSp2tGpbpHTh9KlIq2eWtxPc9ngEmoFgrIbi4=;
        b=U/Vs0Xkp/mi85x8bj+dfPUUW6sn4sVtPBToud2a9GNnDMp8yvIaJhz8ci4xlhEbkuE
         CCt+5xCQnOF9kHa0IpMSe3bdBpqQNosartU8/8ph99hdVfTY8wGRmNUBsoiTtpQ5nATM
         alqdTdC5jBx+1gsoENcF67N50n6xu4fxdk+DxStpqpVIKa/EkhxgB8KDOHeasQG+G3VP
         BnFHLcPyIMpACDgxBhdvocRgJm4eHCDwnJvTN/OcRAYNvxn2F7l1ZeiBpROCu6skrjFT
         xjUIGy64wgmFnZ8C7Go4Xbzd4q1XbTe4Mt3kqY5VKD6C57eRb9ka5BnovcMw/KZzBK8t
         6JkA==
X-Gm-Message-State: ALoCoQn/Vj20qLoYIsVBRR3EmS1GZQGzz0FcMgPfSZckBWuzt4GbQu/1O2EY0wy2k393yLZ268uV
X-Received: by 10.236.222.36 with SMTP id s34mr4827551yhp.24.1402593703634;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si113769yhm.0.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7424331C6AC;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5297FE0D36; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251454>

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
index 680415c..6c2e7e5 100644
--- a/refs.c
+++ b/refs.c
@@ -3466,19 +3466,25 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
index 27c470c..193c818 100644
--- a/refs.h
+++ b/refs.h
@@ -311,11 +311,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
2.0.0.599.g83ced0e
