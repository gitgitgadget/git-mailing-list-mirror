From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 04/16] refs.c: use a stringlist for repack_without_refs
Date: Fri,  7 Nov 2014 11:38:53 -0800
Message-ID: <1415389145-6391-5-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpNP-0003pU-TA
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbaKGTjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:39:14 -0500
Received: from mail-pa0-f74.google.com ([209.85.220.74]:46479 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbaKGTjL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:39:11 -0500
Received: by mail-pa0-f74.google.com with SMTP id kx10so646524pab.5
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AXKn6mfoWm3G5dUuLnS/8igfA06+NtII1PfHNvXJKM4=;
        b=gRZJTSyVhmo21gQgOZjxnFtOuvw0+qaZ+tPp7tkqk/fc0LRKSpfeCuISyj3/PlfVDX
         hZ380e79Ml2//TtTLZyHfcdYBZPkUzF8qhRwu5qyH9l9FoYm+nKjBfsFmLAqC5P1dV5V
         SYjVQ+2Mzu4IW3OtSmPDuhPzQsDb6X1TqMZ06Ymy93vs0gmTeF3oOvGmgLaQr2JxXTay
         CqhC4xacsZ3Y/fwPRCja8Xpkno6is8UHp7FX1XK9oclXcbRPL5tYDWiMpqJXRApsYPzb
         sRuproQ7PWbYOTl/Mk1m+cCAMbjnYYDpBuBdPpWQZnNy3OpDh9/869qYdhfgKlZSZ+jx
         0h7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AXKn6mfoWm3G5dUuLnS/8igfA06+NtII1PfHNvXJKM4=;
        b=MRJ0GVM+v9jSfLQPaw4Tq0qPoKwuIj1sehpDI+sB1+S0MhWpKyg+M2kAq2JxvLrkNq
         s5POC2Lh9Vek7HbtpgIgT4M4fXN5ykaRPPv9ifHRXGUKY2k4x7JcZTZV0aO2SlyRD6gA
         GxWUCHWeuybNWXdxSvjiOM+23W6P3sOQmt8wpy97Wpe3KUaL0ybjKdAuK/rMNSGU3g6f
         uuqRbW6V+ycmS7Wi25TKW6p09BbuVwvJvNq2o+xM493T6n+d4JovVuPM02Saqy+Bkmuj
         GhQPFSQyX+kjIMAIfCg+KwDwArGqGd3t+aba/eKgPDBYg6nCeRvs4FPGAK6gniNCB1N7
         OYtg==
X-Gm-Message-State: ALoCoQmoC8OxpvVP8MfUFFc0ISn8T2Su/LhdMq2HbMfo+e9bRhdxk0lctcJX2AbGqStniA5ZCfwL
X-Received: by 10.66.120.237 with SMTP id lf13mr10170777pab.40.1415389150359;
        Fri, 07 Nov 2014 11:39:10 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id s23si405355yhf.0.2014.11.07.11.39.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:10 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id cHLFsWlF.1; Fri, 07 Nov 2014 11:39:10 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7AF37E0A73; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 809bd3f..e9e321e 100644
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
2.1.0.rc2.206.gedb03e5
