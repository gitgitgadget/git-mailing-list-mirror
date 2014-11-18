From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: use a stringlist for repack_without_refs
Date: Tue, 18 Nov 2014 14:43:56 -0800
Message-ID: <1416350636-12934-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 18 23:44:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqrVb-0005ol-9M
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 23:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbaKRWoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 17:44:22 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:42508 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322AbaKRWoV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 17:44:21 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so5082026iec.39
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 14:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MOh3iazierYbYnxZmT0eWpNVrom7P5csAKYm+mtJdb8=;
        b=NlnQ3tpJITJ436u4+KHbaX+UdcCrBHBT5lVVK4xUqbaxwL+6sTCAx8Q079ELbCKaZn
         P8nR2lSFFYj09apUDCxA1EtIKh9ZUxit0RFUjbiavMojZLU+riw+8vR0L8z8jqLDNk26
         iuiBM+f83O2TXtke9bse4u5/X6w+E58ap5UHhE9hWmLiLoltP1uL8Xp/Hl1vZDzetcpv
         nvR0HSTjo4qSQRC/iJFmmZAQZlTr62gUtANx6z5acYZ74qr8VT9aShapM6HVo6lzqvo1
         c+9shl2/tAu/7j6XejvqkZnX+OAlL+qtWzyxaHRn7PhKcaox8OOQ5fUSjRSyUA97mFR9
         GwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MOh3iazierYbYnxZmT0eWpNVrom7P5csAKYm+mtJdb8=;
        b=hOsrYdoknqHhOBAOpwos5qiHj3KXI3ReMiR8J19tH6mKk2UMw5v0utSSA2kJIB+CO6
         aD33h7qgqATgfr6ETsMcTPoPj9VvgXsul93nvIxyK+G1RKuw1fEk/23+BSeSR5LVAAPD
         ptNgFcArmPZtDSCDs24IVPR8mpzM/ZiodNAeei7O9V24RIb/TAqfV11ED+xMDCmfBBNc
         3JiorVsGHa8pCRoQRtF7hS6PQ82vIySrD75Vh7FUig+StXS40HWvxk2Icjy4wiIt/de0
         DHI0aCTb89FBun7wF3AoCGby4O1QothHevnbPYyvsAngv9IV2Me7aD0bncsQkIQDz9Qs
         hXwQ==
X-Gm-Message-State: ALoCoQllqYw+XiPd0lczuXkYbT+LDsiEvE+kHRlwyeDsxemuaHi17mgr3mwhveushCrT2+TWzsWM
X-Received: by 10.42.175.3 with SMTP id ay3mr19796879icb.45.1416350660133;
        Tue, 18 Nov 2014 14:44:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d130:77f5:c37c:28a8])
        by mx.google.com with ESMTPSA id 131sm21330002ioo.8.2014.11.18.14.44.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 14:44:19 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch was heavily inspired by a part of the ref-transactions-rename
series[1], but people tend to dislike large series and this part is
relatively easy to take out and unrelated, so I'll send it as a single
patch.

This patch doesn't intend any functional changes. It is just a refactoring, 
which replaces a char** array by a stringlist in the function 
repack_without_refs.

[1] https://www.mail-archive.com/git@vger.kernel.org/msg60604.html

Idea-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/remote.c | 22 +++++++---------------
 refs.c           | 41 ++++++++++++++++++++---------------------
 refs.h           |  3 +--
 3 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f28f92..dca4ebf 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -750,16 +750,11 @@ static int mv(int argc, const char **argv)
 static int remove_branches(struct string_list *branches)
 {
 	struct strbuf err = STRBUF_INIT;
-	const char **branch_names;
 	int i, result = 0;
 
-	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
-	for (i = 0; i < branches->nr; i++)
-		branch_names[i] = branches->items[i].string;
-	if (repack_without_refs(branch_names, branches->nr, &err))
+	if (repack_without_refs(branches, &err))
 		result |= error("%s", err.buf);
 	strbuf_release(&err);
-	free(branch_names);
 
 	for (i = 0; i < branches->nr; i++) {
 		struct string_list_item *item = branches->items + i;
@@ -1317,7 +1312,6 @@ static int prune_remote(const char *remote, int dry_run)
 	int result = 0, i;
 	struct ref_states states;
 	struct string_list delete_refs_list = STRING_LIST_INIT_NODUP;
-	const char **delete_refs;
 	const char *dangling_msg = dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
@@ -1325,6 +1319,11 @@ static int prune_remote(const char *remote, int dry_run)
 	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
+	for (i = 0; i < states.stale.nr; i++)
+		string_list_insert(&delete_refs_list,
+				   states.stale.items[i].util);
+
+
 	if (states.stale.nr) {
 		printf_ln(_("Pruning %s"), remote);
 		printf_ln(_("URL: %s"),
@@ -1332,24 +1331,17 @@ static int prune_remote(const char *remote, int dry_run)
 		       ? states.remote->url[0]
 		       : _("(no URL)"));
 
-		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
-		for (i = 0; i < states.stale.nr; i++)
-			delete_refs[i] = states.stale.items[i].util;
 		if (!dry_run) {
 			struct strbuf err = STRBUF_INIT;
-			if (repack_without_refs(delete_refs, states.stale.nr,
-						&err))
+			if (repack_without_refs(&delete_refs_list, &err))
 				result |= error("%s", err.buf);
 			strbuf_release(&err);
 		}
-		free(delete_refs);
 	}
 
 	for (i = 0; i < states.stale.nr; i++) {
 		const char *refname = states.stale.items[i].util;
 
-		string_list_insert(&delete_refs_list, refname);
-
 		if (!dry_run)
 			result |= delete_ref(refname, NULL, 0);
 
diff --git a/refs.c b/refs.c
index 5ff457e..2333a9b 100644
--- a/refs.c
+++ b/refs.c
@@ -2639,23 +2639,23 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-int repack_without_refs(const char **refnames, int n, struct strbuf *err)
+int repack_without_refs(struct string_list *without, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, ret, removed = 0;
+	int count, ret, removed = 0;
 
 	assert(err);
 
-	/* Look for a packed ref */
-	for (i = 0; i < n; i++)
-		if (get_packed_ref(refnames[i]))
-			break;
+	count = 0;
+	for_each_string_list_item(ref_to_delete, without)
+		if (get_packed_ref(ref_to_delete->string))
+			count++;
 
-	/* Avoid locking if we have nothing to do */
-	if (i == n)
-		return 0; /* no refname exists in packed refs */
+	/* No refname exists in packed refs */
+	if (!count)
+		return 0;
 
 	if (lock_packed_refs(0)) {
 		unable_to_lock_message(git_path("packed-refs"), errno, err);
@@ -2664,8 +2664,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
-	for (i = 0; i < n; i++)
-		if (remove_entry(packed, refnames[i]) != -1)
+	for_each_string_list_item(ref_to_delete, without)
+		if (remove_entry(packed, ref_to_delete->string) != -1)
 			removed = 1;
 	if (!removed) {
 		/*
@@ -3738,10 +3738,11 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
-	const char **delnames;
+	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
+	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct string_list_item *ref_to_delete;
 
 	assert(err);
 
@@ -3753,9 +3754,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		return 0;
 	}
 
-	/* Allocate work space */
-	delnames = xmalloc(sizeof(*delnames) * n);
-
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	if (ref_update_reject_duplicates(updates, n, err)) {
@@ -3815,16 +3813,17 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
-				delnames[delnum++] = update->lock->ref_name;
+				string_list_insert(&refs_to_delete,
+						   update->lock->ref_name);
 		}
 	}
 
-	if (repack_without_refs(delnames, delnum, err)) {
+	if (repack_without_refs(&refs_to_delete, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
-	for (i = 0; i < delnum; i++)
-		unlink_or_warn(git_path("logs/%s", delnames[i]));
+	for_each_string_list_item(ref_to_delete, &refs_to_delete)
+		unlink_or_warn(git_path("logs/%s", ref_to_delete->string));
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
@@ -3833,7 +3832,7 @@ cleanup:
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-	free(delnames);
+	string_list_clear(&refs_to_delete, 0);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 2bc3556..0416e5f 100644
--- a/refs.h
+++ b/refs.h
@@ -163,8 +163,7 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(const char **refnames, int n,
-			       struct strbuf *err);
+extern int repack_without_refs(struct string_list *without, struct strbuf *err);
 
 extern int ref_exists(const char *);
 
-- 
2.2.0.rc2.5.gf7b9fb2
