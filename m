From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 19/20] refs.c: make prune_ref use a transaction to delete the ref
Date: Tue, 15 Jul 2014 16:34:17 -0700
Message-ID: <1405467258-24102-20-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:35:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFP-0003Pj-Px
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934193AbaGOXey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:54 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:49221 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934326AbaGOXe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:26 -0400
Received: by mail-vc0-f201.google.com with SMTP id hu12so21036vcb.4
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xhkc30hr1PvIYRjyTw3buhh7wSiidMGsQEAK/C3X4+k=;
        b=InUZ6yi9IHyDQe7TFBmJ1nKWfBnr/bL7B6+iASsT9fx1WAd2AuxL4cgYoDL/aUyT8o
         mwSBhKrqB9FjqLGp+hxrBvfGX/t4p1jFRkrDErDGiiJJyZuIANudSC70C3LDpAdIdQye
         oTCjFuu9YZLhVOmq2zY7J1p9PdZwEU5spIdhm2pBj2A8Rs6TkLLRFLRWQkkrSL8Xzi0X
         NrFHiZ7I8Uis4m+HzVE96GS77c5ejx45Tebob4xxNBd/XMBpfvp/vI5iZjGulYP8h4pd
         lI72kSRMoJ7EvTvC1JhWKWcsA8w8ELF07fSdChaHxrWoKocLHiEfmaDNJc3KgG8Dzr1f
         Aa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xhkc30hr1PvIYRjyTw3buhh7wSiidMGsQEAK/C3X4+k=;
        b=GwYmJmws0L7y6JaSo7LPguaSgioxM0lnx/ZCuGwmXmHz39ig/hStziL88x/dtCOpoS
         81dCCxT/SbwL5jh5H0sEVjApGfOD74oMxgBn+bgxCBhNEe0MKo2agUf5DUdSYqiIVPfU
         GRu+sFs/ElwHiTxuKlY81Kxausx7iX8lJGj2mkit22WbsXQOaAMyEwtOK8LAhNBQU7Z0
         cmcp/afyDVWSvWWGYSXyrWo/kFEVASs2q9n/IK+iC85usDzjgA4iblyqeHeIfvFBKfBS
         0kDU9Q53o6Yzi2s/BiSvlteshd+3mTplr+xEus1pj+gfw9gLfhoRatQ/sbelXeu8QADA
         tY3Q==
X-Gm-Message-State: ALoCoQnACrDu8LMYbgGPKfJmYpho3XIbLSAYiBpnOoA2ubTWVQEtslt4cGvojoldAa/OpAUTgH2S
X-Received: by 10.236.63.197 with SMTP id a45mr12327806yhd.9.1405467265412;
        Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1058687yhl.7.2014.07.15.16.34.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 28EAF5A433E;
	Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D9055E0B27; Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253634>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 27 ++++++++++++++++++++-------
 refs.h | 14 ++++++++++++--
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index dbf6af9..186df37 100644
--- a/refs.c
+++ b/refs.c
@@ -25,6 +25,11 @@ static unsigned char refname_disposition[256] = {
 };
 
 /*
+ * Used as a flag to ref_transaction_delete when a loose ref is being
+ * pruned.
+ */
+#define REF_ISPRUNING	0x0100
+/*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
  * not legal.  It is legal if it is something reasonable to have under
@@ -2379,17 +2384,24 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (check_refname_format(r->name + 5, 0))
 		return;
 
-	lock = lock_ref_sha1_basic(r->name, r->sha1, 0, NULL);
-	if (lock) {
-		unlink_or_warn(git_path("%s", r->name));
-		unlock_ref(lock);
-		try_remove_empty_parents(r->name);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, r->name, r->sha1,
+				   REF_ISPRUNING, 1, &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return;
 	}
+	ref_transaction_free(transaction);
+	try_remove_empty_parents(r->name);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3598,8 +3610,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			delnames[delnum++] = update->lock->ref_name;
 			ret |= delete_ref_loose(update->lock, update->type);
+			if (!(update->flags & REF_ISPRUNING))
+				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
diff --git a/refs.h b/refs.h
index 65dd593..aad846c 100644
--- a/refs.h
+++ b/refs.h
@@ -170,9 +170,19 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks any ref (for 'HEAD' type refs). */
+/*
+ * Flags controlling lock_any_ref_for_update(), ref_transaction_update(),
+ * ref_transaction_create(), etc.
+ * REF_NODEREF: act on the ref directly, instead of dereferencing
+ *              symbolic references.
+ *
+ * Flags >= 0x100 are reserved for internal use.
+ */
 #define REF_NODEREF	0x01
-/* errno is set to something meaningful on failure */
+/*
+ * Locks any ref (for 'HEAD' type refs) and sets errno to something
+ * meaningful on failure.
+ */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
-- 
2.0.1.442.g7fe6834.dirty
