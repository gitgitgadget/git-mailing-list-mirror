From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/19] refs.c: ref_transaction_commit: distinguish name
 conflicts from other errors
Date: Wed, 10 Sep 2014 20:08:28 -0700
Message-ID: <20140911030828.GN18279@google.com>
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
X-From: git-owner@vger.kernel.org Thu Sep 11 05:08:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRukN-0001t8-Dk
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbaIKDIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:08:31 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:51505 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbaIKDIb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:08:31 -0400
Received: by mail-pa0-f49.google.com with SMTP id lf10so7024311pab.22
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KR1JBlCt4C83qCAAbnDeitGuGd5vajvESh/QRLILPBo=;
        b=I10r1CGpgG3N9MEV0TaJ7khIxCB+FqV9hQm+xJKJMOhlhcvTL2Q3omPRSH+C3lf5QG
         fLvK13dqqCSPdH1TdSc9JlK2xd++GGU9Qmc+mttwuGqpHHvuAxZEKmQyuwg0Ee34bJaX
         CUYIf6G+Ot1gW355dnYrgyzdIUefe4ausHisj5Se0vKtgsr3CDClOIHWoDMzV3dk01nT
         zkmymwGucHDfgkhGfaPgkXqwZNgo/qMA1CUx/8sjmwJzqgX8QlpMD4l6fU5uXeuYGj1h
         Ww99BF0oUGShjAVBtHCj1Stt4h758jRxY5coBXvUet/yP6hVU5SCXTjIspwaQ2duIVaJ
         TiUA==
X-Received: by 10.70.53.167 with SMTP id c7mr9181379pdp.25.1410404910657;
        Wed, 10 Sep 2014 20:08:30 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id dm7sm8932510pdb.72.2014.09.10.20.08.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:08:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256822>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Fri, 16 May 2014 14:14:38 -0700

In _commit, ENOTDIR can happen in the call to lock_ref_sha1_basic, either when
we lstat the new refname and it returns ENOTDIR or if the name checking
function reports that the same type of conflict happened. In both cases it
means that we can not create the new ref due to a name conflict.

Start defining specific return codes for _commit: assign -1 as a generic
error and UPDATE_REFS_NAME_CONFLICT (-2) as the error that refers to a name
conflict.

When "git fetch" is creating refs, name conflicts differ from other errors in
that they are likely to be resolved by running "git remote prune <remote>".
"git fetch" currently inspects errno to decide whether to give that advice.
Once it switches to the transaction API, it can check for
UPDATE_REFS_NAME_CONFLICT instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 18 ++++++++++++------
 refs.h |  5 +++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index b63ab2f..86c708a 100644
--- a/refs.c
+++ b/refs.c
@@ -3584,9 +3584,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err);
-	if (ret)
+	if (ref_update_reject_duplicates(updates, n, err)) {
+		ret = -1;
 		goto cleanup;
+	}
 
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
@@ -3600,10 +3601,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   update->flags,
 						   &update->type);
 		if (!update->lock) {
+			int df_conflict = (errno == ENOTDIR);
+
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
 					    update->refname);
-			ret = 1;
+			ret = df_conflict ? UPDATE_REFS_NAME_CONFLICT : -1;
 			goto cleanup;
 		}
 	}
@@ -3620,6 +3623,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				if (err)
 					strbuf_addf(err, "Cannot update the ref '%s'.",
 						    update->refname);
+				ret = -1;
 				goto cleanup;
 			}
 		}
@@ -3630,14 +3634,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			ret |= delete_ref_loose(update->lock, update->type,
-						err);
+			if (delete_ref_loose(update->lock, update->type, err))
+				ret = -1;
+
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum, err);
+	if (repack_without_refs(delnames, delnum, err))
+		ret = -1;
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index 7c1bf95..e14aa31 100644
--- a/refs.h
+++ b/refs.h
@@ -325,7 +325,12 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
+ *
+ * Function returns 0 on success, -1 for generic failures and
+ * UPDATE_REFS_NAME_CONFLICT (-2) if the failure was due to a naming conflict.
+ * For example, the ref names A and A/B conflict.
  */
+#define UPDATE_REFS_NAME_CONFLICT -2
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
-- 
2.1.0.rc2.206.gedb03e5
