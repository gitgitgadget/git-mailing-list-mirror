From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 04/16] refs.c: use a stringlist for repack_without_refs
Date: Mon, 17 Nov 2014 17:44:45 -0800
Message-ID: <1416275097-3616-5-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:45:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXr8-0003mc-50
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbaKRBpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:13 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:51492 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbaKRBpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:08 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so209058igi.12
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kWl3nTB1hTJSZV2rk/2GNEBt2ZQnoWWw3mAPs8m15/w=;
        b=kEVnH3twdjw4VOsHJVUuRyt4X4cv6fA67/ke2/QtEGFn6bEA+6tfXZz7Lm68rKGBYM
         xWxlBdpDp+HcYQdSiXSJSm9JZUweg2RY1yV3drm13btnY73zlmgTQQ50wDcVMvRNFHV3
         qeTEGvosDOpQNBmZv/BIG9ZCC6Heb2EOu0mQFjCuCk2FN+/dOS9tjeyNXrjPNGV0SeD2
         ZLcgQWzxD9+piM2sqv1CK8lcjfe69hjwFwQPgIKz8Nlox2P5oimOp7EcapzMewHijDX2
         Rb/tUfCT5GN+JdtClVRfcfnG7otJ0hRhcXU8gCmNosEwFNT0r7T8wvqywfyQyGvdrCSh
         zG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kWl3nTB1hTJSZV2rk/2GNEBt2ZQnoWWw3mAPs8m15/w=;
        b=Lu+Ft+aBEdHef46KtYC1g5JKrkaDTOSo+yr/lg6PCA/8tnMF3S4w74GOA6hA+Ew5iZ
         NujngKiBFANIU8llQcxFMgnoRDjnd7jy38LLILN0YuM/FIRcohptUis2/i4WM6BGLaf+
         s7PGGa7aNn0X+8G3R8a+NDLMa4D/uJEwtsnVGRO+iNX5IpPRUZGax5WLPQ50719Nb7ad
         GcSXTjNVAbPhHwc9VWfIt0LtwWOV87CtEvgvsuxwJW9KpdnxrOBHONavwilPzrHnOBLt
         C0VmaDo7MeNmsfOlmWXTjpzdVd649nSVCN92NAZaud+eBLymVLiCD5Mv7Mt42IEiJgR9
         B1yQ==
X-Gm-Message-State: ALoCoQnIEX0OWQX/dA5uvcPDJVo0XKQooXObyQnggjVmJ9dYTPsGczy0zG4B51Ytv3OZrFpo70JY
X-Received: by 10.107.130.197 with SMTP id m66mr8543850ioi.10.1416275106975;
        Mon, 17 Nov 2014 17:45:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id fk8sm6876033igb.9.2014.11.17.17.45.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:06 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/remote.c | 23 ++++++++---------------
 refs.c           | 42 +++++++++++++++++++++---------------------
 refs.h           |  2 +-
 3 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c25420f..6806251 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -751,7 +751,6 @@ static int mv(int argc, const char **argv)
 static int remove_branches(struct string_list *branches)
 {
 	struct strbuf err = STRBUF_INIT;
-	const char **branch_names;
 	int i, result = 0;
 
 	if (lock_packed_refs(0)) {
@@ -763,13 +762,9 @@ static int remove_branches(struct string_list *branches)
 		return -1;
 	}
 
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
@@ -1327,7 +1322,6 @@ static int prune_remote(const char *remote, int dry_run)
 	int result = 0, i;
 	struct ref_states states;
 	struct string_list delete_refs_list = STRING_LIST_INIT_NODUP;
-	const char **delete_refs;
 	const char *dangling_msg = dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
@@ -1335,6 +1329,11 @@ static int prune_remote(const char *remote, int dry_run)
 	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
+	for (i = 0; i < states.stale.nr; i++) {
+		string_list_insert(&delete_refs_list,
+				   states.stale.items[i].util);
+	}
+
 	if (states.stale.nr) {
 		printf_ln(_("Pruning %s"), remote);
 		printf_ln(_("URL: %s"),
@@ -1342,9 +1341,6 @@ static int prune_remote(const char *remote, int dry_run)
 		       ? states.remote->url[0]
 		       : _("(no URL)"));
 
-		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
-		for (i = 0; i < states.stale.nr; i++)
-			delete_refs[i] = states.stale.items[i].util;
 		if (!dry_run) {
 			struct strbuf err = STRBUF_INIT;
 
@@ -1353,19 +1349,16 @@ static int prune_remote(const char *remote, int dry_run)
 						       errno, &err);
 				result |= error("%s", err.buf);
 			} else
-				if (repack_without_refs(delete_refs,
-							states.stale.nr, &err))
+				if (repack_without_refs(&delete_refs_list,
+							&err))
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
index 3d309bb..519bfed 100644
--- a/refs.c
+++ b/refs.c
@@ -2663,31 +2663,32 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 /*
  * Must be called with packed refs already locked (and sorted)
  */
-int repack_without_refs(const char **refnames, int n, struct strbuf *err)
+int repack_without_refs(struct string_list *without, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, ret, removed = 0;
+	int count, ret, removed = 0;
 
 	assert(err);
 
 	/* Look for a packed ref */
-	for (i = 0; i < n; i++)
-		if (get_packed_ref(refnames[i]))
-			break;
+	count = 0;
+	for_each_string_list_item(ref_to_delete, without)
+		if (get_packed_ref(ref_to_delete->string))
+			count++;
 
-	/* Avoid processing if we have nothing to do */
-	if (i == n) {
+	/* No refname exists in packed refs */
+	if (!count) {
 		rollback_packed_refs();
-		return 0; /* no refname exists in packed refs */
+		return 0;
 	}
 
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
-	for (i = 0; i < n; i++)
-		if (remove_entry(packed, refnames[i]) != -1)
+	for_each_string_list_item(ref_to_delete, without)
+		if (remove_entry(packed, ref_to_delete->string) != -1)
 			removed = 1;
 	if (!removed) {
 		/*
@@ -3799,12 +3800,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int transaction_commit(struct transaction *transaction,
 		       struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i, need_repack = 0;
-	const char **delnames;
+	int ret = 0, i, need_repack = 0;
 	int n = transaction->nr;
 	struct packed_ref_cache *packed_ref_cache;
 	struct ref_update **updates = transaction->updates;
 	struct ref_dir *packed;
+	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct string_list_item *ref_to_delete;
 
 	assert(err);
 
@@ -3816,9 +3818,6 @@ int transaction_commit(struct transaction *transaction,
 		return 0;
 	}
 
-	/* Allocate work space */
-	delnames = xmalloc(sizeof(*delnames) * n);
-
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	if (ref_update_reject_duplicates(updates, n, err)) {
@@ -3910,7 +3909,8 @@ int transaction_commit(struct transaction *transaction,
 		}
 		try_remove_empty_parents((char *)update->refname);
 		if (!(update->flags & REF_ISPRUNING))
-			  delnames[delnum++] = xstrdup(update->lock->ref_name);
+			string_list_insert(&refs_to_delete,
+					   update->lock->ref_name);
 		unlock_ref(update->lock);
 		update->lock = NULL;
 	}
@@ -3927,7 +3927,7 @@ int transaction_commit(struct transaction *transaction,
 						   (update->have_old ?
 						    update->old_sha1 :
 						    NULL),
-						   NULL,
+						   &refs_to_delete,
 						   update->flags,
 						   &update->type);
 		if (!update->lock) {
@@ -3941,8 +3941,8 @@ int transaction_commit(struct transaction *transaction,
 	}
 
 	/* delete reflog for all deleted refs */
-	for (i = 0; i < delnum; i++)
-		unlink_or_warn(git_path("logs/%s", delnames[i]));
+	for_each_string_list_item(ref_to_delete, &refs_to_delete)
+		unlink_or_warn(git_path("logs/%s", ref_to_delete->string));
 
 	/* Lock all reflog files */
 	for (i = 0; i < n; i++) {
@@ -4049,7 +4049,7 @@ int transaction_commit(struct transaction *transaction,
 		}
 	}
 
-	if (repack_without_refs(delnames, delnum, err))
+	if (repack_without_refs(&refs_to_delete, err))
 		ret = TRANSACTION_GENERIC_ERROR;
 	clear_loose_ref_cache(&ref_cache);
 
@@ -4062,7 +4062,7 @@ cleanup:
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-	free(delnames);
+	string_list_clear(&refs_to_delete, 0);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 9153e1d..d174380 100644
--- a/refs.h
+++ b/refs.h
@@ -163,7 +163,7 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(const char **refnames, int n,
+extern int repack_without_refs(struct string_list *without,
 			       struct strbuf *err);
 
 extern int ref_exists(const char *);
-- 
2.2.0.rc2.5.gf7b9fb2
