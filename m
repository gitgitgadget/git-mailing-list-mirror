From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/24] refs.c: ref_transaction_commit: distinguish name
 conflicts from other errors
Date: Wed, 1 Oct 2014 19:05:57 -0700
Message-ID: <20141002020557.GC1175@google.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 02 04:06:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVmQ-0000A8-Ll
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbaJBCGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:06:02 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:54366 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbaJBCGA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:06:00 -0400
Received: by mail-pa0-f54.google.com with SMTP id ey11so1381729pad.13
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UCpDd0VEgI7BLG4rb1+1W2co2o6F4fiyhiGbAb6PI/g=;
        b=NnCxbIH+gKNED5a1tkHhO2D0x1tYLadxHIklSp/TW5FgK+O5yxqmReaGhWLJCp2vX1
         bx62oK/Sl7MI+k+8PZWlceKvmtiV3JR7prahRsFSJsgv0mdpHiA/JyQ450EI9TXE59mk
         xKbs8LTDhD6syU968L+g3rB0LpoatxsSwI0FbsZU9DlCr6j7M1iC/wnoW9Da2xjlaMeN
         0RFNYjpHQOIEvUX8XwTqS8+V2wuPaMfmWD/fR01yK1t7Vacql5BHa/2jnP60r25la570
         DSeBwLU8nndxn0Qd0q2Lv+XnLNmQ/ZOJf2sb+MYClRjGik8J929TNV1QK0HeeW9VKJuE
         BoIg==
X-Received: by 10.70.25.193 with SMTP id e1mr13697769pdg.109.1412215560132;
        Wed, 01 Oct 2014 19:06:00 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id td4sm2117091pbc.36.2014.10.01.19.05.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:05:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257781>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Fri, 16 May 2014 14:14:38 -0700

In _commit, ENOTDIR can happen in the call to lock_ref_sha1_basic, either
when we lstat the new refname or if the name checking function reports that
the same type of conflict happened.  In both cases, it means that we can not
create the new ref due to a name conflict.

Start defining specific return codes for _commit.  TRANSACTION_NAME_CONFLICT
refers to a failure to create a ref due to a name conflict with another ref.
TRANSACTION_GENERIC_ERROR is for all other errors.

When "git fetch" is creating refs, name conflicts differ from other errors in
that they are likely to be resolved by running "git remote prune <remote>".
"git fetch" currently inspects errno to decide whether to give that advice.
Once it switches to the transaction API, it can check for
TRANSACTION_NAME_CONFLICT instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Since v21:
- clarified commit message and updated to match code
- small code cleanups
- clarified API doc, introduced TRANSACTION_GENERIC_ERROR so both error
  codes have names

 refs.c | 26 ++++++++++++++++----------
 refs.h |  9 +++++++--
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 6820c93..623a1ae 100644
--- a/refs.c
+++ b/refs.c
@@ -3583,9 +3583,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err);
-	if (ret)
+	if (ref_update_reject_duplicates(updates, n, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
+	}
 
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
@@ -3599,10 +3600,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   update->flags,
 						   &update->type);
 		if (!update->lock) {
+			ret = (errno == ENOTDIR)
+				? TRANSACTION_NAME_CONFLICT
+				: TRANSACTION_GENERIC_ERROR;
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
 					    update->refname);
-			ret = 1;
 			goto cleanup;
 		}
 	}
@@ -3612,15 +3615,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			ret = write_ref_sha1(update->lock, update->new_sha1,
-					     update->msg);
-			update->lock = NULL; /* freed by write_ref_sha1 */
-			if (ret) {
+			if (write_ref_sha1(update->lock, update->new_sha1,
+					   update->msg)) {
+				update->lock = NULL; /* freed by write_ref_sha1 */
 				if (err)
 					strbuf_addf(err, "Cannot update the ref '%s'.",
 						    update->refname);
+				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
+			update->lock = NULL; /* freed by write_ref_sha1 */
 		}
 	}
 
@@ -3629,14 +3633,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			ret |= delete_ref_loose(update->lock, update->type,
-						err);
+			if (delete_ref_loose(update->lock, update->type, err))
+				ret = TRANSACTION_GENERIC_ERROR;
+
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum, err);
+	if (repack_without_refs(delnames, delnum, err))
+		ret = TRANSACTION_GENERIC_ERROR;
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index aded545..fd63b47 100644
--- a/refs.h
+++ b/refs.h
@@ -323,9 +323,14 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 
 /*
  * Commit all of the changes that have been queued in transaction, as
- * atomically as possible.  Return a nonzero value if there is a
- * problem.
+ * atomically as possible.
+ *
+ * Returns 0 for success, or one of the below error codes for errors.
  */
+/* Naming conflict (for example, the ref names A and A/B conflict). */
+#define TRANSACTION_NAME_CONFLICT -1
+/* All other errors. */
+#define TRANSACTION_GENERIC_ERROR -2
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
-- 
2.1.0.rc2.206.gedb03e5
