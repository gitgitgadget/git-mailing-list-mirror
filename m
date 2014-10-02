From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 22/24] refs.c: do not permit err == NULL
Date: Wed, 1 Oct 2014 19:33:21 -0700
Message-ID: <20141002023321.GO1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 04:33:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZWCu-0002cm-W9
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbaJBCdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:33:25 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:39060 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaJBCdY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:33:24 -0400
Received: by mail-pd0-f179.google.com with SMTP id r10so1224422pdi.24
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iZyygNc/cJDHsu7WeWL+u86x1Rq5/mVo7hlVhch0mZo=;
        b=mkY69E+MDZETDcazo4oj+hk0kuVRQWISWSnbJLk2EXvG+NI4E0tNiu35SRMJgv0Zuw
         BwA308Q+t7RgFJzhXJpjT8M5MOt9AYziiKn5rBQbOUhsBJri0u6q1/bqpkwQssOYjFxn
         q/FPX9aeT+f+2dNYPae/GmoiGRkfeWx/668ep8VXwvtb6JiaZCEefAGdxYIZEDaNsVxU
         Hbf6Y8tQAURLyzyAKoekAkelkBvJ3ti2a6tU3Vu4tNZjdKirijuYntTgmzbQcFXgLmH/
         ZEXgzD64vB67dFrTE3Cq1zRNrssiu9IotUYnj5kAeZcUFnF6sU3soZ5S354GRKplVMXU
         80ig==
X-Received: by 10.70.87.169 with SMTP id az9mr101673974pdb.63.1412217204559;
        Wed, 01 Oct 2014 19:33:24 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id pp2sm2108014pbc.66.2014.10.01.19.33.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:33:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257793>

Date: Thu, 28 Aug 2014 16:42:37 -0700

Some functions that take a strbuf argument to append an error treat
!err as an indication that the message should be suppressed (e.g.,
ref_update_reject_duplicates).  Others write the message to stderr on
!err (e.g., repack_without_refs).  Others crash (e.g.,
ref_transaction_update).

Some of these behaviors are for historical reasons and others were
accidents.  Luckily no callers pass err == NULL any more.  Simplify
by consistently requiring the strbuf argument.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Since v21:
- dropped spurious 'to' from commit message

 refs.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index 0d3abb1..e13f843 100644
--- a/refs.c
+++ b/refs.c
@@ -2596,6 +2596,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	struct string_list_item *ref_to_delete;
 	int i, ret, removed = 0;
 
+	assert(err);
+
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
 		if (get_packed_ref(refnames[i]))
@@ -2606,13 +2608,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(0)) {
-		if (err) {
-			unable_to_lock_message(git_path("packed-refs"), errno,
-					       err);
-			return -1;
-		}
-		unable_to_lock_error(git_path("packed-refs"), errno);
-		return error("cannot delete '%s' from packed refs", refnames[i]);
+		unable_to_lock_message(git_path("packed-refs"), errno, err);
+		return -1;
 	}
 	packed = get_packed_refs(&ref_cache);
 
@@ -2638,7 +2635,7 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 
 	/* Write what remains */
 	ret = commit_packed_refs();
-	if (ret && err)
+	if (ret)
 		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
 			    strerror(errno));
 	return ret;
@@ -2646,6 +2643,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 
 static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
+	assert(err);
+
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
 		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
@@ -3495,6 +3494,8 @@ struct ref_transaction {
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
+	assert(err);
+
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
@@ -3534,6 +3535,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
@@ -3566,6 +3569,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: create called for transaction that is not open");
 
@@ -3597,6 +3602,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: delete called for transaction that is not open");
 
@@ -3659,13 +3666,14 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 					struct strbuf *err)
 {
 	int i;
+
+	assert(err);
+
 	for (i = 1; i < n; i++)
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
-			const char *str =
-				"Multiple updates for ref '%s' not allowed.";
-			if (err)
-				strbuf_addf(err, str, updates[i]->refname);
-
+			strbuf_addf(err,
+				    "Multiple updates for ref '%s' not allowed.",
+				    updates[i]->refname);
 			return 1;
 		}
 	return 0;
@@ -3679,6 +3687,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
 
@@ -3715,9 +3725,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = (errno == ENOTDIR)
 				? TRANSACTION_NAME_CONFLICT
 				: TRANSACTION_GENERIC_ERROR;
-			if (err)
-				strbuf_addf(err, "Cannot lock the ref '%s'.",
-					    update->refname);
+			strbuf_addf(err, "Cannot lock the ref '%s'.",
+				    update->refname);
 			goto cleanup;
 		}
 	}
@@ -3730,9 +3739,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			if (write_ref_sha1(update->lock, update->new_sha1,
 					   update->msg)) {
 				update->lock = NULL; /* freed by write_ref_sha1 */
-				if (err)
-					strbuf_addf(err, "Cannot update the ref '%s'.",
-						    update->refname);
+				strbuf_addf(err, "Cannot update the ref '%s'.",
+					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
-- 
2.1.0.rc2.206.gedb03e5
