From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v6] refs.c: use a string_list for repack_without_refs
Date: Thu, 20 Nov 2014 12:07:46 -0800
Message-ID: <1416514066-17049-1-git-send-email-sbeller@google.com>
References: <CAGZ79kYogEQuynukSkb9La+7DZxOQonAyuYD=kWB7KRdsXLHOA@mail.gmail.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 20 21:07:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrY1C-0000rr-Iz
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 21:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757782AbaKTUHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 15:07:50 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38239 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664AbaKTUHt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 15:07:49 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so3516557iec.33
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 12:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YDDro2NAoxIDJztokFm1FZibMHqbvnKRqydVV+fD+Qc=;
        b=PZ1QNwyWadksLqlEugOk6ZqPS658RaUHoTFKc0+LQL4wZszkNYZEAzEo5shRwPC+rM
         pbLz9jm8UNxU+aU5Ft40vA0nLGf7E4SxzBjOO/HgcLm9oLAIVh7AMkMha7EuvM0shP2/
         DRBv4QvJxWXGBzyKYTYLF7Y01y0Po9b2Gtl0cHyfrtYZx9sQR6U4l9/2EqMhF50qQdw8
         XwIEK/7MzEWeupuWp1O7eKsXoDMjdkQgw3kKd/G+k8xt7pi97DWtoXmqBdbyCs0mW2iQ
         XN5gUySTEuXdw0voHEw92R/RP2XFaHa2sdjNynWN4mPx/DRpCVa76YTPZN6V24K03RR0
         XcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YDDro2NAoxIDJztokFm1FZibMHqbvnKRqydVV+fD+Qc=;
        b=lMw41Mf1sUkeMcgDpvuMtEYgo/oq+GCcT4QKWco4rxndXC8twzvnWLLyxntGcgHDB/
         /I1glsGpb7naTmUmOZ+Zw7ezAKyvjonFobBosUL9xM2hIZpiKClGNE3Ui+8xBsKE8Uwv
         9ldu9mJ843jYO8n7ATTux/5Wyt6jUGl3WYPObNHD30TD6f7aqpVU2LuMndZiTpyvw1K/
         HohWn+8t8bcdJJHYbD4WQjEn8J0ebjucpxJ/kIVJkPqllnC/GPcZXc73kDFWoou7i6+d
         xR36PLG7JrkRHAgNu914r80dEXkcClJvekyYuPmjt1vVfsP+eYzPjoB56cNC7XDEpyhr
         fgbA==
X-Gm-Message-State: ALoCoQk4X3Wde1bD5dssOEHCv4lQ6P1YXmlLmoofqupQpCUpG8zP50CKgHGu/c3lE0qI+INa3S9d
X-Received: by 10.107.167.213 with SMTP id q204mr182406ioe.23.1416514069084;
        Thu, 20 Nov 2014 12:07:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:2878:9312:86d2:4f27])
        by mx.google.com with ESMTPSA id b77sm1696776ioe.35.2014.11.20.12.07.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 12:07:48 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.23.gca0107e
In-Reply-To: <CAGZ79kYogEQuynukSkb9La+7DZxOQonAyuYD=kWB7KRdsXLHOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

This patch doesn't intend any functional changes. It is just
a refactoring, which replaces a char** array by a stringlist
in the function repack_without_refs.

This is easier to read and maintain as it delivers the same
functionality with less lines of code and more lines of
documentation.

[sb: ported this patch from a larger patch series to the
master branch, added documentary comments in refs.h]

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---

Changes to version 1:
 * removed the double blank line
 * rename delete_refs_list to delete_refs
 * add back comments dropped by accident
 * use STRING_LIST_INIT_NODUP instead of the _DUP version in ref_transaction_commit
 * add documentary comments on the repack_without_refs function
 * user string_list_append instead of string_list_insert as it follows the previous
   behavior more closely.
 * put back the early exit of the loop in repack_without_refs
   
Changes to version 2:
 * fixed commit message (comments after the three dashes)
 * fixed the curiosity Junio pointed out as it was just wrong code.
   Now it actually builds a list of all states.stale.items[i].util items.
   
Changes in version 3:

 * reword commit message
 * sort delete_refs before passing it to warn_dangling_symrefs
 * change the comments (get back the one jrn complained about) 
   in repack_without_refs
 * use the suggestion of jonathan for documenting repack_without_refs in the
   header. Add a note about the arguments.

Changes in version 4:
 * I lied, when saying I had all the nits from Jonathan.
   I messed up the documentation in the header.
   This includes the documentary comment in the header.

Changes in version 5:
 * Break lines as suggested by Jonathan, slightly rewording the commit message
 * have an empty line at another place in builtin/remote.c remove_branches to
   tell cleanup parts apart from actual work.
 * fix typo, improve documentary comment in refs.h
 * add Jonathans reviewed by

Changes in version 6:
 * remove change id snuck in v5
 * s/stringlist/string_list/ in commit message title
 * reworded the documentary comment in refs.h once again


 builtin/remote.c | 32 ++++++++++++--------------------
 refs.c           | 38 ++++++++++++++++++++------------------
 refs.h           | 12 ++++++++++--
 3 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f28f92..364350a 100644
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
@@ -1316,8 +1311,8 @@ static int prune_remote(const char *remote, int dry_run)
 {
 	int result = 0, i;
 	struct ref_states states;
-	struct string_list delete_refs_list = STRING_LIST_INIT_NODUP;
-	const char **delete_refs;
+	struct string_list delete_refs = STRING_LIST_INIT_NODUP;
+	struct string_list_item *ref;
 	const char *dangling_msg = dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
@@ -1325,6 +1320,9 @@ static int prune_remote(const char *remote, int dry_run)
 	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
+	for (i = 0; i < states.stale.nr; i++)
+		string_list_append(&delete_refs, states.stale.items[i].util);
+
 	if (states.stale.nr) {
 		printf_ln(_("Pruning %s"), remote);
 		printf_ln(_("URL: %s"),
@@ -1332,23 +1330,16 @@ static int prune_remote(const char *remote, int dry_run)
 		       ? states.remote->url[0]
 		       : _("(no URL)"));
 
-		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
-		for (i = 0; i < states.stale.nr; i++)
-			delete_refs[i] = states.stale.items[i].util;
 		if (!dry_run) {
 			struct strbuf err = STRBUF_INIT;
-			if (repack_without_refs(delete_refs, states.stale.nr,
-						&err))
+			if (repack_without_refs(&delete_refs, &err))
 				result |= error("%s", err.buf);
 			strbuf_release(&err);
 		}
-		free(delete_refs);
 	}
 
-	for (i = 0; i < states.stale.nr; i++) {
-		const char *refname = states.stale.items[i].util;
-
-		string_list_insert(&delete_refs_list, refname);
+	for_each_string_list_item(ref, &delete_refs) {
+		const char *refname = ref->string;
 
 		if (!dry_run)
 			result |= delete_ref(refname, NULL, 0);
@@ -1361,9 +1352,10 @@ static int prune_remote(const char *remote, int dry_run)
 			       abbrev_ref(refname, "refs/remotes/"));
 	}
 
-	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs_list);
-	string_list_clear(&delete_refs_list, 0);
+	sort_string_list(&delete_refs);
+	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs);
 
+	string_list_clear(&delete_refs, 0);
 	free_remote_ref_states(&states);
 	return result;
 }
diff --git a/refs.c b/refs.c
index 5ff457e..ebcd90f 100644
--- a/refs.c
+++ b/refs.c
@@ -2639,23 +2639,26 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-int repack_without_refs(const char **refnames, int n, struct strbuf *err)
+int repack_without_refs(struct string_list *without, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, ret, removed = 0;
+	int ret, needs_repacking = 0, removed = 0;
 
 	assert(err);
 
 	/* Look for a packed ref */
-	for (i = 0; i < n; i++)
-		if (get_packed_ref(refnames[i]))
+	for_each_string_list_item(ref_to_delete, without) {
+		if (get_packed_ref(ref_to_delete->string)) {
+			needs_repacking = 1;
 			break;
+		}
+	}
 
 	/* Avoid locking if we have nothing to do */
-	if (i == n)
-		return 0; /* no refname exists in packed refs */
+	if (!needs_repacking)
+		return 0;
 
 	if (lock_packed_refs(0)) {
 		unable_to_lock_message(git_path("packed-refs"), errno, err);
@@ -2664,8 +2667,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
-	for (i = 0; i < n; i++)
-		if (remove_entry(packed, refnames[i]) != -1)
+	for_each_string_list_item(ref_to_delete, without)
+		if (remove_entry(packed, ref_to_delete->string) != -1)
 			removed = 1;
 	if (!removed) {
 		/*
@@ -3738,10 +3741,11 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
-	const char **delnames;
+	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
+	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
+	struct string_list_item *ref_to_delete;
 
 	assert(err);
 
@@ -3753,9 +3757,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		return 0;
 	}
 
-	/* Allocate work space */
-	delnames = xmalloc(sizeof(*delnames) * n);
-
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	if (ref_update_reject_duplicates(updates, n, err)) {
@@ -3815,16 +3816,17 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
-				delnames[delnum++] = update->lock->ref_name;
+				string_list_append(&refs_to_delete,
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
@@ -3833,7 +3835,7 @@ cleanup:
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-	free(delnames);
+	string_list_clear(&refs_to_delete, 0);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 2bc3556..0bc6a1a 100644
--- a/refs.h
+++ b/refs.h
@@ -163,8 +163,16 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(const char **refnames, int n,
-			       struct strbuf *err);
+/*
+ * Remove the refs listed in the unsorted string list 'without' from
+ * the packed-refs file. On error, packed-refs will be unchanged, the
+ * return value is nonzero, and a message about the error is written
+ * to the 'err' strbuf.
+ *
+ * The refs in 'without' may be unsorted.
+ * 'err' must not be NULL.
+ */
+extern int repack_without_refs(struct string_list *without, struct strbuf *err);
 
 extern int ref_exists(const char *);
 
-- 
2.2.0.rc2.23.gca0107e
