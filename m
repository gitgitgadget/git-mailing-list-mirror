From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 04/15] refs.c: use a stringlist for repack_without_refs
Date: Tue, 21 Oct 2014 13:36:49 -0700
Message-ID: <1413923820-14457-5-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggBf-0000wA-9n
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933341AbaJUUhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:37:36 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:65144 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933066AbaJUUhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:37:05 -0400
Received: by mail-ob0-f202.google.com with SMTP id wp4so306069obc.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zN4IAVWVlOnaknAfldIdITf1grlvCyQbKlZZ50gjmSY=;
        b=Wl0jrhQ+tqAfayLmlHVhvd+ZiBg86WYSSZkRHPkcr3fjvlxG1xl1omyggVHcwtAY8U
         gk9119JQqypcQzGGawyl/MDir/Ja9en5GoeVAqU48BmypuVFmXNAKeNmVuORwcS7Y39r
         IuKBpiGwKHhxri8/jBvs7vPfo9t+ZMuPWYApsNTqd8BIuGDHX4iRwjSVaDFyfjt+DyH9
         B/UK5/MYkouxqIfezimxfjcDKj3uFvUUQ8QOveylF4YgsWVLOhv6PozIuF2U0COkqYLZ
         6xtTt79DaHUC+iuQVm2Cw0AQDWTWjs+45BhhZ453eR9NgFG64ai0i2BZNR/YIR42HFmv
         7Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zN4IAVWVlOnaknAfldIdITf1grlvCyQbKlZZ50gjmSY=;
        b=W8OhHlWQL2DsKd3s2xws+a0wYUB1Eq7m23e1decg5s39H6Y5lV4AhsZeEA45GtxEym
         qNpT7VcheFLzdwHO4uvVOJctEGV1NCpnwY1WQRTWZo0lQqpgJuHEBJ6O8q7Uby6jFX5c
         fsayFB5qDmFJDA1k+BthjYxoD3xy65oEcDPKYTsuVCQntIZFBYNZ7DcABWBh+FQfdCCC
         fFiutjwjD4kiqoQWXn3azYOPlB6QuCUEaB/irzSKPE4utLIEvzhRHfGN3JVPTquhg+au
         JStxcMgwbse+c9RXXaQbMjruV8+iVmW62SvX6M3WKsfmOB4el4okVU2jCzwDKtrGByOK
         mBnw==
X-Gm-Message-State: ALoCoQmItQctvj6hd7mvUYuoZ02TpJGhxmem6QJewH/eaeGuLYKC2ZwSztCNyqK5L5jPngc2iA4b
X-Received: by 10.182.56.113 with SMTP id z17mr18977485obp.35.1413923823895;
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id e24si595475yhe.3.2014.10.21.13.37.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id vvx9HeiN.1; Tue, 21 Oct 2014 13:37:03 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C869CE0978; Tue, 21 Oct 2014 13:37:02 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change-Id: I87a1b93c4b4f4a10ad6a9f8e2bb4d53f89b28c4a
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
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
index 662af9b..b9c8f91 100644
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
@@ -3797,12 +3798,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
 
@@ -3814,9 +3816,6 @@ int transaction_commit(struct transaction *transaction,
 		return 0;
 	}
 
-	/* Allocate work space */
-	delnames = xmalloc(sizeof(*delnames) * n);
-
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	if (ref_update_reject_duplicates(updates, n, err)) {
@@ -3908,7 +3907,8 @@ int transaction_commit(struct transaction *transaction,
 		}
 		try_remove_empty_parents((char *)update->refname);
 		if (!(update->flags & REF_ISPRUNING))
-			  delnames[delnum++] = xstrdup(update->lock->ref_name);
+			string_list_insert(&refs_to_delete,
+					   update->lock->ref_name);
 		unlock_ref(update->lock);
 		update->lock = NULL;
 	}
@@ -3925,7 +3925,7 @@ int transaction_commit(struct transaction *transaction,
 						   (update->have_old ?
 						    update->old_sha1 :
 						    NULL),
-						   NULL,
+						   &refs_to_delete,
 						   update->flags,
 						   &update->type);
 		if (!update->lock) {
@@ -3939,8 +3939,8 @@ int transaction_commit(struct transaction *transaction,
 	}
 
 	/* delete reflog for all deleted refs */
-	for (i = 0; i < delnum; i++)
-		unlink_or_warn(git_path("logs/%s", delnames[i]));
+	for_each_string_list_item(ref_to_delete, &refs_to_delete)
+		unlink_or_warn(git_path("logs/%s", ref_to_delete->string));
 
 	/* Lock all reflog files */
 	for (i = 0; i < n; i++) {
@@ -4047,7 +4047,7 @@ int transaction_commit(struct transaction *transaction,
 		}
 	}
 
-	if (repack_without_refs(delnames, delnum, err))
+	if (repack_without_refs(&refs_to_delete, err))
 		ret = TRANSACTION_GENERIC_ERROR;
 	clear_loose_ref_cache(&ref_cache);
 
@@ -4060,7 +4060,7 @@ cleanup:
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
2.1.0.rc2.206.gedb03e5
