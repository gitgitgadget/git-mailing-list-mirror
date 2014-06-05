From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/2] refs.c: write updates to packed refs when a transaction has more than one ref
Date: Thu,  5 Jun 2014 16:26:27 -0700
Message-ID: <1402010788-8236-2-git-send-email-sahlberg@google.com>
References: <1402010788-8236-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 01:26:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsh3Z-0001yK-0R
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 01:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbaFEX0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 19:26:34 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:62093 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbaFEX0e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 19:26:34 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so358909obc.3
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 16:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HOxfWBWQGHd3WyfgDjH197pWBUoJ1xKbLZ7kwnuMgxY=;
        b=fGejP6I5HWox5KDExw2vrC1AO10bNa2d01QjFlzrnO3FstBWWILbWMH6L263faKD55
         rW3Fd+hKa8rtSTG+N+dwXwfxl7B4ZaQi1cumnLdCgOSPCQl4KtGWrEBGlUpd/5UG5uET
         yo7OmTGInxG+ArDiHMPq3tFoMLpoSRNJh4chRU4o8k/pr9GgNRR/xNFqo61oVj6Qcx0h
         Xe9dfemr2RXZKzeL93lQqPIjL0W2+oMfWoGYWVN2pe0eBiSM0JDDCbvU45KLmc6qVWGJ
         JNt3uutW2i7cPpSbppr2YBprRkKmZ0/QzqBSxOTNAa7V7noux+eU++iUm2KHLqUkn/yi
         Su4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HOxfWBWQGHd3WyfgDjH197pWBUoJ1xKbLZ7kwnuMgxY=;
        b=VpLylLclYBUHmbMzQwxPn35aTianrv+n82V81jb9+M3ZzyBCOiRar4wtxHE7h9i/E3
         jc4EtrW1CmQqrtXzSF8miHW0Ku7Tu8eFIzHdTGU9SQO1bgPwRQlPt+oAZuEyum3N+Pp9
         N4UNijve4OkskZwb+uGTYKdP1E09LT7ibVXS4fO4/cUHeWEjQMJr1EE8OpvjSOpvgpBL
         Yj27xa2g8aHSvu4NhzR5l2PKAs5EH/y1M57HmCdkMgDRtp60UyS91ka3wxiOCALHhDLD
         G2INDoqPjLSnbKoYQwSs+EEIe06ZQzT/q5hOLZL4RYg5y3Zwrtt+dKAe+lwfF1RGarVQ
         tJxQ==
X-Gm-Message-State: ALoCoQkojzLNXrAyzL1caUCLLTe44fu+6n/HbPWEg/tw8eO6jPJDGJDIyq369m47X34sJ+rX2gPj
X-Received: by 10.50.57.84 with SMTP id g20mr47565igq.8.1402010793248;
        Thu, 05 Jun 2014 16:26:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si671400yhg.2.2014.06.05.16.26.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jun 2014 16:26:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0C9C331C777;
	Thu,  5 Jun 2014 16:26:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AD76EE045A; Thu,  5 Jun 2014 16:26:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.583.g402232d
In-Reply-To: <1402010788-8236-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250878>

When we are updating more than one single ref, i.e. not a commit, then
write the updated refs directly to the packed refs file instead of writing
them as loose refs.

Change clone to use a transaction instead of using the pacekd refs api.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/clone.c | 16 +++++++++----
 refs.c          | 74 +++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b12989d..000a236 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -497,17 +497,25 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 static void write_remote_refs(const struct ref *local_refs)
 {
 	const struct ref *r;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	lock_packed_refs(LOCK_DIE_ON_ERROR);
+	transaction = transaction_begin(&err);
+	if (!transaction)
+		die("%s", err.buf);
 
 	for (r = local_refs; r; r = r->next) {
 		if (!r->peer_ref)
 			continue;
-		add_packed_ref(r->peer_ref->name, r->old_sha1);
+		if (transaction_update_sha1(transaction, r->peer_ref->name,
+					    r->old_sha1, NULL, 0, 0, NULL,
+					    &err))
+			die("%s", err.buf);
 	}
 
-	if (commit_packed_refs())
-		die_errno("unable to overwrite old ref-pack file");
+	if (transaction_commit(transaction, &err))
+		die("%s", err.buf);
+	transaction_free(transaction);
 }
 
 static void write_followtags(const struct ref *refs, const char *msg)
diff --git a/refs.c b/refs.c
index 4281011..6aa64dd 100644
--- a/refs.c
+++ b/refs.c
@@ -2481,31 +2481,18 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, ret, removed = 0;
+	int i, ret;
 
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
 		if (get_packed_ref(refnames[i]))
 			break;
 
-	/* Avoid processing if we have nothing to do */
-	if (i == n)
-		return 0; /* no refname exists in packed refs */
-
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
 	for (i = 0; i < n; i++)
-		if (remove_entry(packed, refnames[i]) != -1)
-			removed = 1;
-	if (!removed) {
-		/*
-		 * All packed entries disappeared while we were
-		 * acquiring the lock.
-		 */
-		rollback_packed_refs();
-		return 0;
-	}
+		remove_entry(packed, refnames[i]);
 
 	/* Remove any other accumulated cruft */
 	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
@@ -3614,6 +3601,7 @@ int transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i, df_conflict = 0, need_repack = 0;
+	int num_updates = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct packed_ref_cache *packed_ref_cache;
@@ -3647,18 +3635,38 @@ int transaction_commit(struct ref_transaction *transaction,
 		goto cleanup;
 	}
 
-	/* any loose refs are to be deleted are first copied to packed refs */
+	/* count how many refs we are updating (not deleting) */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 		unsigned char sha1[20];
 
 		if (update->update_type != UPDATE_SHA1)
 			continue;
-		if (!is_null_sha1(update->new_sha1))
+		if (is_null_sha1(update->new_sha1))
+			continue;
+
+		num_updates++;
+	}
+
+	/*
+	 * Always copy loose refs that are to be deleted to the packed refs.
+	 * If we are updating multiple refs then copy all non symref refs
+	 * to the packed refs too.
+	 */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+		unsigned char sha1[20];
+		int flag;
+
+		if (update->update_type != UPDATE_SHA1)
+			continue;
+		if (num_updates < 2 && !is_null_sha1(update->new_sha1))
 			continue;
 		if (get_packed_ref(update->refname))
 			continue;
-		if (!resolve_ref_unsafe(update->refname, sha1, 1, NULL))
+		if (!resolve_ref_unsafe(update->refname, sha1, 1, &flag))
+			continue;
+		if (flag & REF_ISSYMREF)
 			continue;
 
 		add_packed_ref(update->refname, sha1);
@@ -3682,11 +3690,14 @@ int transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 	}
+	need_repack = 0;
 
 	/*
 	 * At this stage any refs that are to be deleted have been moved to the
 	 * packed refs file anf the packed refs file is deleted. We can now
 	 * safely delete these loose refs.
+	 * If we are updating multiple normal refs, then those will also be in
+	 * the packed refs file so we can delete them too.
 	 */
 
 	/* Unlink any loose refs scheduled for deletion */
@@ -3724,7 +3735,10 @@ int transaction_commit(struct ref_transaction *transaction,
 		update->lock = NULL;
 	}
 
-	/* Acquire all ref locks for updates while verifying old values */
+	/*
+	 * Acquire all ref locks for updates while verifying old values.
+	 * If we are multi-updating then update them in packed refs.
+	 */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3748,6 +3762,22 @@ int transaction_commit(struct ref_transaction *transaction,
 			ret = -1;
 			goto cleanup;
 		}
+		if (num_updates < 2 || update->type & REF_ISSYMREF)
+			continue;
+
+		if (delete_ref_loose(update->lock, update->type, err)) {
+			ret = -1;
+			goto cleanup;
+		}
+		unlock_ref(update->lock);
+		update->lock = NULL;
+
+		packed = get_packed_refs(&ref_cache);;
+		remove_entry(packed, update->refname);
+		add_packed_ref(update->refname, update->new_sha1);
+		need_repack = 1;
+
+		try_remove_empty_parents((char *)update->refname);
 	}
 
 	/* delete reflog for all deleted refs */
@@ -3795,7 +3825,7 @@ int transaction_commit(struct ref_transaction *transaction,
 
 		if (update->update_type != UPDATE_SHA1)
 			continue;
-		if (!is_null_sha1(update->new_sha1)) {
+		if (update->lock && !is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
 					     update->msg);
 			update->lock = NULL; /* freed by write_ref_sha1 */
@@ -3860,6 +3890,10 @@ int transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
+	if (need_repack) {
+		packed = get_packed_refs(&ref_cache);
+		sort_ref_dir(packed);
+	}
 	if (repack_without_refs(delnames, delnum, err))
 		ret = -1;
 	clear_loose_ref_cache(&ref_cache);
-- 
2.0.0.583.g402232d
