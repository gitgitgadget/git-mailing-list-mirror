From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 23/25] refs.c: do not permit err == NULL
Date: Tue, 14 Oct 2014 17:55:06 -0700
Message-ID: <20141015005506.GA32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:55:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCs0-0004Zr-LH
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbaJOAzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:55:10 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:56854 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbaJOAzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:55:09 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so234723pad.22
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=O4VrcVny9JqxP2Sv0QRaApX3YxeG+kBnANh/ARgRmcM=;
        b=s9w/PKIVfiSmSEyJ0/pTt+qow18hn26KOvGMG7j0yh61Zp3POZn5ONHkuhU0C2xGkr
         4tHIsRZeQBwqk6/gwSF79+H2VynCskee781rIbmtSNzuO0s8cEtmi9c6rf1CvxRVPtYI
         lVZahVaNxzxcijvBEGwqap0ZrcRKzIsMtzKcshRBnGMTFIPq9FJ7WihqkHN+/ImbA8Jt
         ydOxMBpT9UMy0amD10DhX66p/Vo5UVPx73zygFooe7RKuSoqxh+RwJ12cTipoeuAKzLH
         X+c3WzNV8nvhOaiEXrwiwiORgZhA/aKb014d/U+0I63nwq7aal0n6eDOGAu2ouH6FB4l
         OAPQ==
X-Received: by 10.66.184.167 with SMTP id ev7mr8700767pac.40.1413334508850;
        Tue, 14 Oct 2014 17:55:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id j11sm15325276pdk.76.2014.10.14.17.55.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:55:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index e7000f2..097fb4b 100644
--- a/refs.c
+++ b/refs.c
@@ -2646,6 +2646,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	struct string_list_item *ref_to_delete;
 	int i, ret, removed = 0;
 
+	assert(err);
+
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
 		if (get_packed_ref(refnames[i]))
@@ -2656,13 +2658,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
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
 
@@ -2688,7 +2685,7 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 
 	/* Write what remains */
 	ret = commit_packed_refs();
-	if (ret && err)
+	if (ret)
 		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
 			    strerror(errno));
 	return ret;
@@ -2696,6 +2693,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 
 static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
+	assert(err);
+
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/*
 		 * loose.  The loose file name is the same as the
@@ -3551,6 +3550,8 @@ struct ref_transaction {
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
+	assert(err);
+
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
@@ -3590,6 +3591,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
@@ -3622,6 +3625,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: create called for transaction that is not open");
 
@@ -3653,6 +3658,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: delete called for transaction that is not open");
 
@@ -3715,13 +3722,14 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3735,6 +3743,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
 
@@ -3771,9 +3781,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3786,9 +3795,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
