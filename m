From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/19] refs.c: do not permit err == NULL
Date: Wed, 10 Sep 2014 20:11:51 -0700
Message-ID: <20140911031150.GU18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:12:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRung-0003lB-Cu
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbaIKDL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:11:56 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:38978 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbaIKDLy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:11:54 -0400
Received: by mail-pd0-f170.google.com with SMTP id fp1so4568113pdb.29
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IpFNG9Fov6+A0dXk7aCnSnZP+dWNwxGrZWBhosa3dUY=;
        b=CE+iNT5zVhIbGXm0/JcIYMASBdM2ZukXf8ptzi6hX1jNgwZXM02tPbvSQ29qUXb0ST
         Og5mAtprhXRaVwfGnFLn98AZFwr40ltKycQgup4nyMfGaEycoBUDjuh374Y3OoBh3tZ6
         zpTCNQ6kq6/ubTG6C+ttpMJoRnIhVs7s0GMgSiDK7sinW1SrRdXR4s3/Cj14OX7WFDsH
         7W0G7bkMIN4P1eXtMkIyYqCDd9v50dyx/ykQV+5+FKspp8LsABMw7K/yY3msy3enR4yF
         Q4Em55/r5oFB1+NEBSaSD5abHqSQWQLH4rHqZvn2BusYA7QWsUWDd5tEQOiELn/ySEnz
         XZPA==
X-Received: by 10.68.131.38 with SMTP id oj6mr220118pbb.168.1410405113646;
        Wed, 10 Sep 2014 20:11:53 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id rw8sm15771240pbc.11.2014.09.10.20.11.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:11:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256828>

Some functions that take a strbuf argument to append an error to treat
!err as an indication that the message should be suppressed (e.g.,
ref_update_reject_duplicates).  Others write the message to stderr on
!err (e.g., repack_without_refs).  Others crash (e.g.,
ref_transaction_update).

Some of these behaviors are for historical reasons and others were
accidents.  Luckily no callers pass err == NULL any more.  Simplify
by consistently requiring the strbuf argument.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index 6faf0c8..550223c 100644
--- a/refs.c
+++ b/refs.c
@@ -2560,6 +2560,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	struct string_list_item *ref_to_delete;
 	int i, ret, removed = 0;
 
+	assert(err);
+
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
 		if (get_packed_ref(refnames[i]))
@@ -2570,13 +2572,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
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
 
@@ -2602,7 +2599,7 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 
 	/* Write what remains */
 	ret = commit_packed_refs();
-	if (ret && err)
+	if (ret)
 		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
 			    strerror(errno));
 	return ret;
@@ -2610,6 +2607,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 
 static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
+	assert(err);
+
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
 		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
@@ -3459,6 +3458,8 @@ struct ref_transaction {
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
+	assert(err);
+
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
@@ -3498,6 +3499,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
@@ -3530,6 +3533,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: create called for transaction that is not open");
 
@@ -3561,6 +3566,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: delete called for transaction that is not open");
 
@@ -3623,13 +3630,14 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3643,6 +3651,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
 
@@ -3675,9 +3685,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		if (!update->lock) {
 			int df_conflict = (errno == ENOTDIR);
 
-			if (err)
-				strbuf_addf(err, "Cannot lock the ref '%s'.",
-					    update->refname);
+			strbuf_addf(err, "Cannot lock the ref '%s'.",
+				    update->refname);
 			ret = df_conflict ? UPDATE_REFS_NAME_CONFLICT : -1;
 			goto cleanup;
 		}
@@ -3692,9 +3701,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					     update->msg);
 			update->lock = NULL; /* freed by write_ref_sha1 */
 			if (ret) {
-				if (err)
-					strbuf_addf(err, "Cannot update the ref '%s'.",
-						    update->refname);
+				strbuf_addf(err, "Cannot update the ref '%s'.",
+					    update->refname);
 				ret = -1;
 				goto cleanup;
 			}
-- 
2.1.0.rc2.206.gedb03e5
