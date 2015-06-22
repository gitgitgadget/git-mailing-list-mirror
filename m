From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/19] initial_ref_transaction_commit(): function for initial ref creation
Date: Mon, 22 Jun 2015 16:03:01 +0200
Message-ID: <066845f7d6989a34856ae6370f95690f06fbd5f2.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:04:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72Kr-0005yL-3x
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933700AbbFVOEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:04:24 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42110 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752606AbbFVOD2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:28 -0400
X-AuditID: 1207440f-f79df6d000007c0f-8c-558815b06226
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D5.99.31759.0B518855; Mon, 22 Jun 2015 10:03:28 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3Cc8030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:27 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqLtBtCPUYG43p0XXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M14/XMtSMFm9YtL/+cwNjHvkuxg5OCQETCT6+4u6GDmBTDGJC/fWs3UxcnEICVxmlFi8
	tIkJwjnJJPH93iEmkCo2AV2JRT3NYLaIgJrExLZDLCBFzAIdjBIXlm9jB0kIC8RK7Njzlxlk
	A4uAqsSKz9wgYV6BKIkd9/4xQmyTkzh//CcziM0pYCExf99/sFYhAXOJiTMfsUxg5F3AyLCK
	US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdELzezRC81pXQTIySg+Hcwdq2XOcQowMGoxMPrYNse
	KsSaWFZcmXuIUZKDSUmU98BroBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3pazQDnelMTKqtSi
	fJiUNAeLkjiv+hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSvn0hHqJBgUWp6akVaZk4JQpqJgxNk
	OJeUSHFqXkpqUWJpSUY8KDLii4GxAZLiAdqbA9LOW1yQmAsUhWg9xagoJc47GSQhAJLIKM2D
	GwtLE68YxYG+FObdIwxUxQNMMXDdr4AGMwEN/pLbBjK4JBEhJdXAyCg961bsgilWF56ulLki
	LW5U6L5MeWZix7Yv52OnXbkfY6Acu8m922vJSx5jo605ClO6W+fr/JOeH67IN1O8dkma+5HG
	AgHFs12lt26klTz9YN/EcGEqc97SuzebZx+7P3u7tI/KO/WTRyLvMq3R/m4rHWk8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272362>

"git clone" uses shortcuts when creating the initial set of
references:

* It writes them directly to packed-refs.

* It doesn't lock the individual references (though it does lock the
  packed-refs file).

* It doesn't check for refname conflicts between two new references or
  between one new reference and any hypothetical old ones.

* It doesn't create reflog entries for the reference creations.

This functionality was implemented in builtin/clone.c. But really that
file shouldn't have such intimate knowledge of how references are
stored. So provide a new function in the refs API,
initial_ref_transaction_commit(), which can be used for initial
reference creation. The new function is based on the ref_transaction
interface.

This means that we can make some other functions private to the refs
module. That will be done in a followup commit.

It would seem to make sense to add a test here that there are no
existing references, because that is how the function *should* be
used. But in fact, the "testgit" remote helper appears to call it
*after* having set up refs/remotes/<name>/HEAD and
refs/remotes/<name>/master, so we can't be so strict. For now, the
function trusts its caller to only call it when it makes sense. Future
commits will add some more limited sanity checks.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/clone.c | 18 ++++++++++++++----
 refs.c          | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 refs.h          | 14 ++++++++++++++
 3 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b878252..771d450 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -500,16 +500,26 @@ static void write_remote_refs(const struct ref *local_refs)
 {
 	const struct ref *r;
 
-	lock_packed_refs(LOCK_DIE_ON_ERROR);
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin(&err);
+	if (!t)
+		die("%s", err.buf);
 
 	for (r = local_refs; r; r = r->next) {
 		if (!r->peer_ref)
 			continue;
-		add_packed_ref(r->peer_ref->name, r->old_sha1);
+		if (ref_transaction_create(t, r->peer_ref->name, r->old_sha1,
+					   0, NULL, &err))
+			die("%s", err.buf);
 	}
 
-	if (commit_packed_refs())
-		die_errno("unable to overwrite old ref-pack file");
+	if (initial_ref_transaction_commit(t, &err))
+		die("%s", err.buf);
+
+	strbuf_release(&err);
+	ref_transaction_free(t);
 }
 
 static void write_followtags(const struct ref *refs, const char *msg)
diff --git a/refs.c b/refs.c
index b21bb55..2367572 100644
--- a/refs.c
+++ b/refs.c
@@ -4064,6 +4064,53 @@ cleanup:
 	return ret;
 }
 
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	int ret = 0, i;
+	int n = transaction->nr;
+	struct ref_update **updates = transaction->updates;
+
+	assert(err);
+
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: commit called for transaction that is not open");
+
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if ((update->flags & REF_HAVE_OLD) &&
+		    !is_null_sha1(update->old_sha1))
+			die("BUG: initial ref transaction with old_sha1 set");
+	}
+
+	if (lock_packed_refs(0)) {
+		strbuf_addf(err, "unable to lock packed-refs file: %s",
+			    strerror(errno));
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
+
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if ((update->flags & REF_HAVE_NEW) &&
+		    !is_null_sha1(update->new_sha1))
+			add_packed_ref(update->refname, update->new_sha1);
+	}
+
+	if (commit_packed_refs()) {
+		strbuf_addf(err, "unable to commit packed-refs file: %s",
+			    strerror(errno));
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
+
+cleanup:
+	transaction->state = REF_TRANSACTION_CLOSED;
+	return ret;
+}
+
 char *shorten_unambiguous_ref(const char *refname, int strict)
 {
 	int i;
diff --git a/refs.h b/refs.h
index 5f3bea7..9602889 100644
--- a/refs.h
+++ b/refs.h
@@ -366,6 +366,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
 /*
+ * Like ref_transaction_commit(), but optimized for creating
+ * references when originally initializing a repository (e.g., by "git
+ * clone"). It writes the new references directly to packed-refs
+ * without locking the individual references.
+ *
+ * It is a bug to call this function when there might be other
+ * processes accessing the repository or if there are existing
+ * references that might conflict with the ones being created. All
+ * old_sha1 values must either be absent or NULL_SHA1.
+ */
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err);
+
+/*
  * Free an existing transaction and all associated data.
  */
 void ref_transaction_free(struct ref_transaction *transaction);
-- 
2.1.4
