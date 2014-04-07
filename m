From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 19/27] refs: add a concept of a reference transaction
Date: Mon,  7 Apr 2014 15:48:10 +0200
Message-ID: <1396878498-19887-20-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:49:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9vV-00034G-BW
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400AbaDGNtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:25 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:65450 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755381AbaDGNtC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:49:02 -0400
X-AuditID: 12074412-f79d46d000002e58-84-5342accd6bc8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A0.ED.11864.DCCA2435; Mon,  7 Apr 2014 09:49:01 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaQ026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:59 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqHt2jVOwwcIHPBY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7owDNy4xF7wwqTh2dCJrA+NGrS5GTg4JAROJBQtm
	s0LYYhIX7q1n62Lk4hASuMwo0bVzFjNIQkjgGJPEh9tmIDabgK7Eop5mJhBbREBNYmLbIRaQ
	BmaBK4wSVz5uZwFJCAt4SLxqmMEOYrMIqEo8+HeJDcTmFXCVWPlqEgvENjmJk8cmg23mBIrP
	OHSLEWKZi8T9NcdYJjDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mil5pSuokR
	EnpCOxjXn5Q7xCjAwajEw7vikGOwEGtiWXFl7iFGSQ4mJVHe58ucgoX4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8HKtBsrxpiRWVqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnw
	NoI0ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxINiI74YGB0gKR6gvXPB9hYXJOYC
	RSFaTzEqSonzloAkBEASGaV5cGNhCeUVozjQl8K8BSBVPMBkBNf9CmgwE9BgQ1ewwSWJCCmp
	Bkb2czfXbTwQsaRMvIbbmvFg0OUlIi8uLD65c8n6tW+na3hd3O7DYGteuais/JPkdPOsfA/t
	awwHtkX9tX10PPKnhMDHy4uYbsyROlGYoMWZdnRj1bGieO97n/bfNzu/z+jAaQft 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245849>

Build out the API for dealing with a bunch of reference checks and
changes within a transaction.  Define an opaque ref_transaction type
that is managed entirely within refs.c.  Introduce functions for
beginning a transaction, adding updates to a transaction, and
committing/rolling back a transaction.

This API will soon replace update_refs().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h | 65 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/refs.c b/refs.c
index 1305eb1..f0b5764 100644
--- a/refs.c
+++ b/refs.c
@@ -3267,6 +3267,96 @@ static int update_ref_write(const char *action, const char *refname,
 	return 0;
 }
 
+/*
+ * Data structure for holding a reference transaction, which can
+ * consist of checks and updates to multiple references, carried out
+ * as atomically as possible.  This structure is opaque to callers.
+ */
+struct ref_transaction {
+	struct ref_update **updates;
+	size_t alloc;
+	size_t nr;
+};
+
+struct ref_transaction *ref_transaction_begin(void)
+{
+	return xcalloc(1, sizeof(struct ref_transaction));
+}
+
+static void ref_transaction_free(struct ref_transaction *transaction)
+{
+	int i;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+
+		free((char *)update->ref_name);
+		free(update);
+	}
+
+	free(transaction->updates);
+	free(transaction);
+}
+
+void ref_transaction_rollback(struct ref_transaction *transaction)
+{
+	ref_transaction_free(transaction);
+}
+
+static struct ref_update *add_update(struct ref_transaction *transaction,
+				     const char *refname)
+{
+	struct ref_update *update = xcalloc(1, sizeof(*update));
+
+	update->ref_name = xstrdup(refname);
+	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
+	transaction->updates[transaction->nr++] = update;
+	return update;
+}
+
+void ref_transaction_update(struct ref_transaction *transaction,
+			    const char *refname,
+			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    int flags, int have_old)
+{
+	struct ref_update *update = add_update(transaction, refname);
+
+	hashcpy(update->new_sha1, new_sha1);
+	update->flags = flags;
+	update->have_old = have_old;
+	if (have_old)
+		hashcpy(update->old_sha1, old_sha1);
+}
+
+void ref_transaction_create(struct ref_transaction *transaction,
+			    const char *refname,
+			    unsigned char *new_sha1,
+			    int flags)
+{
+	struct ref_update *update = add_update(transaction, refname);
+
+	assert(!is_null_sha1(new_sha1));
+	hashcpy(update->new_sha1, new_sha1);
+	hashclr(update->old_sha1);
+	update->flags = flags;
+	update->have_old = 1;
+}
+
+void ref_transaction_delete(struct ref_transaction *transaction,
+			    const char *refname,
+			    unsigned char *old_sha1,
+			    int flags, int have_old)
+{
+	struct ref_update *update = add_update(transaction, refname);
+
+	update->flags = flags;
+	update->have_old = have_old;
+	if (have_old) {
+		assert(!is_null_sha1(old_sha1));
+		hashcpy(update->old_sha1, old_sha1);
+	}
+}
+
 int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
@@ -3378,6 +3468,15 @@ cleanup:
 	return ret;
 }
 
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   const char *msg, enum action_on_err onerr)
+{
+	int ret = update_refs(msg, transaction->updates, transaction->nr,
+			      onerr);
+	ref_transaction_free(transaction);
+	return ret;
+}
+
 char *shorten_unambiguous_ref(const char *refname, int strict)
 {
 	int i;
diff --git a/refs.h b/refs.h
index 08e60ac..0518dd5 100644
--- a/refs.h
+++ b/refs.h
@@ -24,6 +24,8 @@ struct ref_update {
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 };
 
+struct ref_transaction;
+
 /*
  * Bit values set in the flags argument passed to each_ref_fn():
  */
@@ -220,6 +222,69 @@ enum action_on_err {
 	UPDATE_REFS_QUIET_ON_ERR
 };
 
+/*
+ * Begin a reference transaction.  The reference transaction must
+ * eventually be commited using ref_transaction_commit() or rolled
+ * back using ref_transaction_rollback().
+ */
+struct ref_transaction *ref_transaction_begin(void);
+
+/*
+ * Roll back a ref_transaction and free all associated data.
+ */
+void ref_transaction_rollback(struct ref_transaction *transaction);
+
+
+/*
+ * The following functions add a reference check or update to a
+ * ref_transaction.  In all of them, refname is the name of the
+ * reference to be affected.  The functions make internal copies of
+ * refname, so the caller retains ownership of the parameter.  flags
+ * can be REF_NODEREF; it is passed to update_ref_lock().
+ */
+
+
+/*
+ * Add a reference update to transaction.  new_sha1 is the value that
+ * the reference should have after the update, or zeros if it should
+ * be deleted.  If have_old is true, then old_sha1 holds the value
+ * that the reference should have had before the update, or zeros if
+ * it must not have existed beforehand.
+ */
+void ref_transaction_update(struct ref_transaction *transaction,
+			    const char *refname,
+			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    int flags, int have_old);
+
+/*
+ * Add a reference creation to transaction.  new_sha1 is the value
+ * that the reference should have after the update; it must not be the
+ * null SHA-1.  It is verified that the reference does not exist
+ * already.
+ */
+void ref_transaction_create(struct ref_transaction *transaction,
+			    const char *refname,
+			    unsigned char *new_sha1,
+			    int flags);
+
+/*
+ * Add a reference deletion to transaction.  If have_old is true, then
+ * old_sha1 holds the value that the reference should have had before
+ * the update (which must not be the null SHA-1).
+ */
+void ref_transaction_delete(struct ref_transaction *transaction,
+			    const char *refname,
+			    unsigned char *old_sha1,
+			    int flags, int have_old);
+
+/*
+ * Commit all of the changes that have been queued in transaction, as
+ * atomically as possible.  Return a nonzero value if there is a
+ * problem.  The ref_transaction is freed by this function.
+ */
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   const char *msg, enum action_on_err onerr);
+
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
-- 
1.9.1
