From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 19/26] refs: Remove API function update_refs()
Date: Mon, 10 Mar 2014 13:46:36 +0100
Message-ID: <1394455603-2968-20-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzcJ-0007oJ-9P
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbaCJMra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:30 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57770 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753590AbaCJMr1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:27 -0400
X-AuditID: 12074412-f79d46d000002e58-e1-531db45ed0be
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C4.41.11864.E54BD135; Mon, 10 Mar 2014 08:47:26 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwh025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:25 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqBu3RTbY4NQqU4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd0bzjp/sBfsUKjr6vrE1MN6T7GLk5JAQMJGY0rmZ
	EcIWk7hwbz1bFyMXh5DAZUaJyd2nGCGcE0wS985NAKtiE9CVWNTTzARiiwioSUxsO8QCUsQs
	cIVR4vPXX+wgCWEBO4kXmzYC2RwcLAKqEu/3uoKEeQVcJLobtrFAbJOTmPJ7AVg5J1B8+pUH
	YLaQgLPEyz3NrBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXTy80s0UtNKd3ECAk9
	oR2M60/KHWIU4GBU4uE98FYmWIg1say4MvcQoyQHk5Io78S1ssFCfEn5KZUZicUZ8UWlOanF
	hxglOJiVRHgzFwPleFMSK6tSi/JhUtIcLErivD8Xq/sJCaQnlqRmp6YWpBbBZGU4OJQkeH03
	AzUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2IjvhgYHSApHqC920DaeYsLEnOB
	ohCtpxgVpcR554AkBEASGaV5cGNhCeUVozjQl8K8rSBVPMBkBNf9CmgwE9Dg5uNSIINLEhFS
	Ug2MRzJ790g77LmqtcV0Ks/fK2urJjWcVvDd9PX2EecTKk3dz5seSoqe5nr/ZV5zhqZS9Y6z
	W7cJVAVNq+84dPrE1NnlSU/69E3e7+VY71OVmHv9XNspq9O3z00L7pkc0Rf+MFnm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243741>

This should be done via reference transactions now.  This also means
that struct ref_update can become private.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 31 ++++++++++++++++++++-----------
 refs.h | 20 --------------------
 2 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/refs.c b/refs.c
index 54260ce..91af0a0 100644
--- a/refs.c
+++ b/refs.c
@@ -3267,6 +3267,20 @@ static int update_ref_write(const char *action, const char *refname,
 	return 0;
 }
 
+/**
+ * Information needed for a single ref update.  Set new_sha1 to the
+ * new value or to zero to delete the ref.  To check the old value
+ * while locking the ref, set have_old to 1 and set old_sha1 to the
+ * value or to zero to ensure the ref does not exist before update.
+ */
+struct ref_update {
+	const char *ref_name;
+	unsigned char new_sha1[20];
+	unsigned char old_sha1[20];
+	int flags; /* REF_NODEREF? */
+	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+};
+
 /*
  * Data structure for holding a reference transaction, which can
  * consist of checks and updates to multiple references, carried out
@@ -3385,16 +3399,17 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 	return 0;
 }
 
-int update_refs(const char *action, struct ref_update * const *updates_orig,
-		int n, enum action_on_err onerr)
+int commit_ref_transaction(struct ref_transaction *transaction,
+			   const char *msg, enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
 	struct ref_update **updates;
 	int *types;
 	struct ref_lock **locks;
 	const char **delnames;
+	int n = transaction->nr;
 
-	if (!updates_orig || !n)
+	if (!n)
 		return 0;
 
 	/* Allocate work space */
@@ -3404,7 +3419,7 @@ int update_refs(const char *action, struct ref_update * const *updates_orig,
 	delnames = xmalloc(sizeof(*delnames) * n);
 
 	/* Copy, sort, and reject duplicate refs */
-	memcpy(updates, updates_orig, sizeof(*updates) * n);
+	memcpy(updates, transaction->updates, sizeof(*updates) * n);
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	ret = ref_update_reject_duplicates(updates, n, onerr);
 	if (ret)
@@ -3426,7 +3441,7 @@ int update_refs(const char *action, struct ref_update * const *updates_orig,
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < n; i++)
 		if (!is_null_sha1(updates[i]->new_sha1)) {
-			ret = update_ref_write(action,
+			ret = update_ref_write(msg,
 					       updates[i]->ref_name,
 					       updates[i]->new_sha1,
 					       locks[i], onerr);
@@ -3457,12 +3472,6 @@ cleanup:
 	return ret;
 }
 
-int commit_ref_transaction(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
-{
-	return update_refs(msg, transaction->updates, transaction->nr, onerr);
-}
-
 char *shorten_unambiguous_ref(const char *refname, int strict)
 {
 	int i;
diff --git a/refs.h b/refs.h
index 2848fb7..b1f8b74 100644
--- a/refs.h
+++ b/refs.h
@@ -10,20 +10,6 @@ struct ref_lock {
 	int force_write;
 };
 
-/**
- * Information needed for a single ref update.  Set new_sha1 to the
- * new value or to zero to delete the ref.  To check the old value
- * while locking the ref, set have_old to 1 and set old_sha1 to the
- * value or to zero to ensure the ref does not exist before update.
- */
-struct ref_update {
-	const char *ref_name;
-	unsigned char new_sha1[20];
-	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
-	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
-};
-
 struct ref_transaction;
 
 /*
@@ -288,12 +274,6 @@ int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
 
-/**
- * Lock all refs and then perform all modifications.
- */
-int update_refs(const char *action, struct ref_update * const *updates,
-		int n, enum action_on_err onerr);
-
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
 
-- 
1.9.0
