From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/26] refs: Add a concept of a reference transaction
Date: Mon, 10 Mar 2014 13:46:34 +0100
Message-ID: <1394455603-2968-18-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:48:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzcs-0008ML-8x
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbaCJMsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:48:09 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49920 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753582AbaCJMrX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:23 -0400
X-AuditID: 12074411-f79ab6d000002f0e-1c-531db45adec8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 96.DD.12046.A54BD135; Mon, 10 Mar 2014 08:47:22 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwf025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:21 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqBu1RTbYoOOoqcXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO6P9VzdzwXyjihmvz7A2MG7S6GLk5JAQMJF4vf4a
	C4QtJnHh3nq2LkYuDiGBy4wSvSt3sUM4J5gktjesYASpYhPQlVjU08wEYosIqElMbDvEAlLE
	LHCFUeLz11/sIAlhAVeJMxd/MoPYLAKqEvO3HwYay8HBK+Ai8alTAWKbnMSU3wvAyjmBwtOv
	PACzhQScJV7uaWadwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZI
	6AnuYJxxUu4QowAHoxIP78G3MsFCrIllxZW5hxglOZiURHknrpUNFuJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCm7kYKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuCt
	3wzUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KjfhiYHSApHiA9m4DaectLkjM
	BYpCtJ5iVJQS550DkhAASWSU5sGNhSWUV4ziQF8K87aCVPEAkxFc9yugwUxAg5uPS4EMLklE
	SEk1MAY/XNV78+35pppvrOodWhVnHxkataxyWZfbe2t78Wml0DVbXNgnX+u41feuScBOZdvk
	qBuBHdHNaWus9eJT/A5ozmFbdo375epGm/cT7a6lXAxZ5jc/b+XfTTbt1dwRfjnS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243748>

Build out the API for dealing with a bunch of reference checks and
changes within a transaction.  Define an opaque ref_transaction type
that is managed entirely within refs.c.  Introduce functions for
starting a transaction, adding updates to a transaction, and
committing a transaction.

This API will soon replace update_refs().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h | 63 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/refs.c b/refs.c
index 0963077..54260ce 100644
--- a/refs.c
+++ b/refs.c
@@ -3267,6 +3267,85 @@ static int update_ref_write(const char *action, const char *refname,
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
+struct ref_transaction *create_ref_transaction(void)
+{
+	return xcalloc(1, sizeof(struct ref_transaction));
+}
+
+void free_ref_transaction(struct ref_transaction *transaction)
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
+void queue_update_ref(struct ref_transaction *transaction, const char *refname,
+		      unsigned char *new_sha1, unsigned char *old_sha1,
+		      int flags, int have_old)
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
+void queue_create_ref(struct ref_transaction *transaction, const char *refname,
+		      unsigned char *new_sha1,
+		      int flags)
+{
+	struct ref_update *update = add_update(transaction, refname);
+
+	hashcpy(update->new_sha1, new_sha1);
+	hashclr(update->old_sha1);
+	update->flags = flags;
+	update->have_old = 1;
+}
+
+void queue_delete_ref(struct ref_transaction *transaction, const char *refname,
+		      unsigned char *old_sha1,
+		      int flags, int have_old)
+{
+	struct ref_update *update = add_update(transaction, refname);
+
+	update->flags = flags;
+	update->have_old = have_old;
+	if (have_old)
+		hashcpy(update->old_sha1, old_sha1);
+}
+
 int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
@@ -3378,6 +3457,12 @@ cleanup:
 	return ret;
 }
 
+int commit_ref_transaction(struct ref_transaction *transaction,
+			   const char *msg, enum action_on_err onerr)
+{
+	return update_refs(msg, transaction->updates, transaction->nr, onerr);
+}
+
 char *shorten_unambiguous_ref(const char *refname, int strict)
 {
 	int i;
diff --git a/refs.h b/refs.h
index 08e60ac..2848fb7 100644
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
@@ -220,6 +222,67 @@ enum action_on_err {
 	UPDATE_REFS_QUIET_ON_ERR
 };
 
+/*
+ * Allocate and initialize a ref_transaction object.  The object must
+ * be freed by calling free_ref_transaction().
+ */
+struct ref_transaction *create_ref_transaction(void);
+
+/*
+ * Free a ref_transaction and all associated data.  This function does
+ * not commit the transaction; that must be done first (if desired) by
+ * calling commit_ref_transaction().
+ */
+void free_ref_transaction(struct ref_transaction *transaction);
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
+void queue_update_ref(struct ref_transaction *transaction, const char *refname,
+		      unsigned char *new_sha1, unsigned char *old_sha1,
+		      int flags, int have_old);
+
+/*
+ * Add a reference creation to transaction.  new_sha1 is the value
+ * that the reference should have after the update, or zeros if it
+ * should be deleted.  It is verified that the reference does not
+ * exist already.
+ */
+void queue_create_ref(struct ref_transaction *transaction, const char *refname,
+		      unsigned char *new_sha1,
+		      int flags);
+
+/*
+ * Add a reference deletion to transaction.  If have_old is true, then
+ * old_sha1 holds the value that the reference should have had before
+ * the update.
+ */
+void queue_delete_ref(struct ref_transaction *transaction, const char *refname,
+		      unsigned char *old_sha1,
+		      int flags, int have_old);
+
+/*
+ * Commit all of the changes that have been queued in transaction, as
+ * atomically as possible.  Return a nonzero value if there is a
+ * problem.  The transaction is unmodified by this function.
+ */
+int commit_ref_transaction(struct ref_transaction *transaction,
+			   const char *msg, enum action_on_err onerr);
+
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
-- 
1.9.0
