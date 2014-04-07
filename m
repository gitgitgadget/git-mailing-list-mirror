From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 21/27] refs: remove API function update_refs()
Date: Mon,  7 Apr 2014 15:48:12 +0200
Message-ID: <1396878498-19887-22-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9w0-0003S5-QQ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbaDGNtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:55 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:64179 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755333AbaDGNtF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:49:05 -0400
X-AuditID: 1207440f-f79326d000003c9f-58-5342acd1a314
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 0E.40.15519.1DCA2435; Mon,  7 Apr 2014 09:49:05 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaS026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:49:03 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqHtxjVOwwYL93BY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7owF+x0LHilULHnewdrA+E2yi5GTQ0LARGLjsj9M
	ELaYxIV769m6GLk4hAQuM0rMu3KQESQhJHCMSWLar1QQm01AV2JRTzNYg4iAmsTEtkMsIA3M
	AlcYJa583A7kcHAICzhKzNjqAFLDIqAq0frxKlg9r4CrxJNnfWwQy+QkTh6bzApicwLFZxy6
	BbXLReL+mmMsExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQICTv+
	HYxd62UOMQpwMCrx8K445BgsxJpYVlyZe4hRkoNJSZT3+TKnYCG+pPyUyozE4oz4otKc1OJD
	jBIczEoivFyrgXK8KYmVValF+TApaQ4WJXFe9SXqfkIC6YklqdmpqQWpRTBZGQ4OJQnelyCN
	gkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aC4iC8GRgZIigdo71ywvcUFiblAUYjW
	U4yKUuK8JSAJAZBERmke3FhYMnnFKA70pTDvc5AqHmAigut+BTSYCWiwoSvY4JJEhJRUA+NC
	7x5J0b2FSuzFT6alKS04z3WFMU393PIXR6SfTLCYVR0mrRXUEyGUIXup+8fFHsuTuoqlOwt/
	cvXoasROucTa/ObNzAK/d+1PJuqWbH52/5IW0zude+6cz8/4RKZpXVLrZv2xPEBN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245855>

It has been superseded by reference transactions.  This also means
that struct ref_update can become private.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 33 ++++++++++++++++++++-------------
 refs.h | 20 --------------------
 2 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index f0b5764..6984ff0 100644
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
@@ -3396,16 +3410,17 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 	return 0;
 }
 
-int update_refs(const char *action, struct ref_update * const *updates_orig,
-		int n, enum action_on_err onerr)
+int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3415,7 +3430,7 @@ int update_refs(const char *action, struct ref_update * const *updates_orig,
 	delnames = xmalloc(sizeof(*delnames) * n);
 
 	/* Copy, sort, and reject duplicate refs */
-	memcpy(updates, updates_orig, sizeof(*updates) * n);
+	memcpy(updates, transaction->updates, sizeof(*updates) * n);
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	ret = ref_update_reject_duplicates(updates, n, onerr);
 	if (ret)
@@ -3437,7 +3452,7 @@ int update_refs(const char *action, struct ref_update * const *updates_orig,
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < n; i++)
 		if (!is_null_sha1(updates[i]->new_sha1)) {
-			ret = update_ref_write(action,
+			ret = update_ref_write(msg,
 					       updates[i]->ref_name,
 					       updates[i]->new_sha1,
 					       locks[i], onerr);
@@ -3465,14 +3480,6 @@ cleanup:
 	free(types);
 	free(locks);
 	free(delnames);
-	return ret;
-}
-
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
-{
-	int ret = update_refs(msg, transaction->updates, transaction->nr,
-			      onerr);
 	ref_transaction_free(transaction);
 	return ret;
 }
diff --git a/refs.h b/refs.h
index 0518dd5..cb799a3 100644
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
@@ -290,12 +276,6 @@ int update_ref(const char *action, const char *refname,
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
1.9.1
