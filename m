From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 16/40] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Fri,  6 Jun 2014 15:28:54 -0700
Message-ID: <1402093758-3162-17-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2f6-00033e-UN
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbaFFWap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:45 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:52933 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-qa0-f74.google.com with SMTP id j5so680484qaq.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HZJ4UTUe7KOjY/ak8lAkO/Z/8/8uFZfhSKEl7VJbNFQ=;
        b=Vt76bqxxDYT6ZHZBHVV1StyaW8FAjQKtxBNIuy6l8Cl3Ggq6sEngWuodWGOBTXqoG3
         s62HiCAw+dBUufBPKMc//wmrckQFH+AbrrS1OelZW2cJU9nrqPgdHVZ7yC9D1Mv9lF69
         /k+oUc692E4WmFGCKjAyyNG3IBYyTcDLeFHLhBfAdmx8y1JDry8f6X8dKa+BPsXKHezS
         BXRD/4giQAQnXTs9dJfToVmEWcZ8j+q+4WR8xe1Lxf6OiQb1l/XY9IeSyStjdpo7WBa5
         Ijei2ErlKPHvcCJyRJT8ryvjYndT4igDOs73pGgUzBI81JndURuq/XrSKL+SvzlThSq2
         mZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HZJ4UTUe7KOjY/ak8lAkO/Z/8/8uFZfhSKEl7VJbNFQ=;
        b=OZWbaPfyCZz4DKAda5DcLr082f0sgtNkrVLiHvyZ8WonnU1YIzMChl2W7uNAOZ4Api
         A950EKMGlsOfcB+ZnytExPzSVWpsgbbot4aoZTCnt+pQSTx7dbvyIIm8q4AbONCuG1gg
         rg0tyUENM5dKlFiisH14dlQD9AiNWYzxfiGxRMv6sc7qG7LD7dDdVzBGGBAcaaAdgITh
         HDj3OuAmYl6JD5O4fLEitOpqjN/5JMDK0Z6m513zKWS0Am4XJLrZ3gGLolmneHiFkJSA
         fpq91GpOWWuh8lbobYFRFaVIZRHqhwMF6kLq8msuzRPtgSRVRw03/9RETa+RDF+Uvuv/
         j+bw==
X-Gm-Message-State: ALoCoQkPrgdWfMF4mIo9AC8S79G94L4qROH5eTq2Kb1Bc9x9XRFurJiwH1wd8QPy5g/++ks75vue
X-Received: by 10.58.165.33 with SMTP id yv1mr5209913veb.30.1402093762369;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si751212vda.3.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 029E431C62E;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D4A04E047D; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251000>

Track the status of a transaction in a new status field. Check the field for
sanity, i.e. that status must be OPEN when _commit/_create/_delete or
_update is called or else die(BUG:...)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index ee87eda..dd98202 100644
--- a/refs.c
+++ b/refs.c
@@ -3377,6 +3377,25 @@ struct ref_update {
 };
 
 /*
+ * Transaction states.
+ * OPEN:   The transaction is in a valid state and can accept new updates.
+ *         An OPEN transaction can be committed.
+ * CLOSED: If an open transaction is successfully committed the state will
+ *         change to CLOSED. No further changes can be made to a CLOSED
+ *         transaction.
+ *         CLOSED means that all updates have been successfully committed and
+ *         the only thing that remains is to free the completed transaction.
+ * ERROR:  The transaction has failed and is no longer committable.
+ *         No further changes can be made to a CLOSED transaction and it must
+ *         be rolled back using transaction_free.
+ */
+enum ref_transaction_state {
+	REF_TRANSACTION_OPEN   = 0,
+	REF_TRANSACTION_CLOSED = 1,
+	REF_TRANSACTION_ERROR  = 2,
+};
+
+/*
  * Data structure for holding a reference transaction, which can
  * consist of checks and updates to multiple references, carried out
  * as atomically as possible.  This structure is opaque to callers.
@@ -3385,6 +3404,8 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
+	enum ref_transaction_state state;
+	int status;
 };
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
@@ -3427,6 +3448,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3447,6 +3471,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: create called for transaction that is not open");
+
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
@@ -3467,6 +3494,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: delete called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
@@ -3522,8 +3552,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n)
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: commit called for transaction that is not open");
+
+	if (!n) {
+		transaction->state = REF_TRANSACTION_CLOSED;
 		return 0;
+	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3586,6 +3621,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
+	transaction->state = ret ? REF_TRANSACTION_ERROR
+		: REF_TRANSACTION_CLOSED;
+
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-- 
2.0.0.582.ge25c160
