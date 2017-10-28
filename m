Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3AA0202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 09:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdJ1JuW (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 05:50:22 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:47977 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751310AbdJ1JuL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 05:50:11 -0400
X-AuditID: 1207440f-a5bff70000007960-67-59f452d0a20e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F8.DD.31072.0D254F95; Sat, 28 Oct 2017 05:50:09 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE7F1.dip0.t-ipconnect.de [84.170.231.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9S9nwqa016802
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 28 Oct 2017 05:50:07 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/7] refs: tidy up and adjust visibility of the `ref_update` flags
Date:   Sat, 28 Oct 2017 11:49:54 +0200
Message-Id: <da4974c47a7fd72e41513218e0c824d4d6377b8c.1509183413.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509183413.git.mhagger@alum.mit.edu>
References: <cover.1509183413.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqHsx6Eukwbt9WhZdV7qZLBp6rzBb
        3F4xn9nizJtGRgcWj7/vPzB5XLyk7LH4gZfH501yASxRXDYpqTmZZalF+nYJXBl95w6yFczz
        qTj46ihjA+MG6y5GTg4JAROJV8eWMnYxcnEICexgklgzdyorhHOKSaK/ZQ8rSBWbgK7Eop5m
        JhBbREBNYmLbIRYQm1mgSOLr+rNgcWGBIInPv+eAxVkEVCW+TLzCCGLzCkRJfLu7jwVim7zE
        uQe3mUFsTgELibvL1oLZQgLmEm/fLGCdwMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGu
        iV5uZoleakrpJkZIkPDvYOxaL3OIUYCDUYmHVyL3c6QQa2JZcWXuIUZJDiYlUd595z9FCvEl
        5adUZiQWZ8QXleakFh9ilOBgVhLhvejzJVKINyWxsiq1KB8mJc3BoiTOq75E3U9IID2xJDU7
        NbUgtQgmK8PBoSTBOyUQqFGwKDU9tSItM6cEIc3EwQkynAdo+B6QGt7igsTc4sx0iPwpRmOO
        jpt3/zBxPJv5uoFZiCUvPy9VSpxXH6RUAKQ0ozQPbhos0l8xigM9J8w7G6SKB5gk4Oa9AlrF
        BLRKQxJsVUkiQkqqgTHsXZP4vc3TCt/WCW01z3xwwtV6TryHvp3g84c7XF+9WdH1qKPDcsu7
        nAN3t0eJSrYdTvYv5EqZv7zp3uRKb/MnrVIf4rfcjltzl83vf5ObQq/Evy32d6u2lElEcP2q
        YtlirWXP+OphZzJH776notEJs6wt9HWkxIs650m5VzzmvdKr/FpZQImlOCPRUIu5qDgRAI+z
        qZfPAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The constants used for `ref_update::flags` were rather disorganized:

* The definitions in `refs.h` were not close to the functions that
  used them.

* Maybe constants were defined in `refs-internal.h`, making them
  visible to the whole refs module, when in fact they only made sense
  for the files backend.

* The documentation wasn't very consistent and partly still referred
  to sha1s rather than oids.

* The numerical values followed no rational scheme

Fix all of these problems. The main functional improvement is that
some constants' visibility is now limited to `files-backend.c`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h               | 65 +++++++++++++++++++++++++++++---------------------
 refs/files-backend.c | 45 +++++++++++++++++++++++++++++++++++
 refs/refs-internal.h | 67 ++++++++++++----------------------------------------
 3 files changed, 98 insertions(+), 79 deletions(-)

diff --git a/refs.h b/refs.h
index 4ffef9502d..7dc022a809 100644
--- a/refs.h
+++ b/refs.h
@@ -335,22 +335,6 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
  */
 int refs_pack_refs(struct ref_store *refs, unsigned int flags);
 
-/*
- * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
- * REF_NODEREF: act on the ref directly, instead of dereferencing
- *              symbolic references.
- *
- * Other flags are reserved for internal use.
- */
-#define REF_NODEREF	0x01
-#define REF_FORCE_CREATE_REFLOG 0x40
-
-/*
- * Flags that can be passed in to ref_transaction_update
- */
-#define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS \
-	(REF_NODEREF | REF_FORCE_CREATE_REFLOG)
-
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
@@ -478,22 +462,23 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  *
  *     refname -- the name of the reference to be affected.
  *
- *     new_sha1 -- the SHA-1 that should be set to be the new value of
+ *     new_oid -- the SHA-1 that should be set to be the new value of
  *         the reference. Some functions allow this parameter to be
  *         NULL, meaning that the reference is not changed, or
- *         null_sha1, meaning that the reference should be deleted. A
+ *         null_oid, meaning that the reference should be deleted. A
  *         copy of this value is made in the transaction.
  *
- *     old_sha1 -- the SHA-1 value that the reference must have before
+ *     old_oid -- the SHA-1 value that the reference must have before
  *         the update. Some functions allow this parameter to be NULL,
  *         meaning that the old value of the reference is not checked,
- *         or null_sha1, meaning that the reference must not exist
+ *         or null_oid, meaning that the reference must not exist
  *         before the update. A copy of this value is made in the
  *         transaction.
  *
  *     flags -- flags affecting the update, passed to
- *         update_ref_lock(). Can be REF_NODEREF, which means that
- *         symbolic references should not be followed.
+ *         update_ref_lock(). Possible flags: REF_NODEREF,
+ *         REF_FORCE_CREATE_REFLOG. See those constants for more
+ *         information.
  *
  *     msg -- a message describing the change (for the reflog).
  *
@@ -509,11 +494,37 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 
 /*
- * Add a reference update to transaction. new_oid is the value that
- * the reference should have after the update, or null_oid if it
- * should be deleted. If new_oid is NULL, then the reference is not
- * changed at all. old_oid is the value that the reference must have
- * before the update, or null_oid if it must not have existed
+ * The following flags can be passed to ref_transaction_update() etc.
+ * Internally, they are stored in `ref_update::flags`, along with some
+ * internal flags.
+ */
+
+/*
+ * Act on the ref directly; i.e., without dereferencing symbolic refs.
+ * If this flag is not specified, then symbolic references are
+ * dereferenced and the update is applied to the referent.
+ */
+#define REF_NODEREF (1 << 0)
+
+/*
+ * Force the creation of a reflog for this reference, even if it
+ * didn't previously have a reflog.
+ */
+#define REF_FORCE_CREATE_REFLOG (1 << 1)
+
+/*
+ * Bitmask of all of the flags that are allowed to be passed in to
+ * ref_transaction_update() and friends:
+ */
+#define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS \
+	(REF_NODEREF | REF_FORCE_CREATE_REFLOG)
+
+/*
+ * Add a reference update to transaction. `new_oid` is the value that
+ * the reference should have after the update, or `null_oid` if it
+ * should be deleted. If `new_oid` is NULL, then the reference is not
+ * changed at all. `old_oid` is the value that the reference must have
+ * before the update, or `null_oid` if it must not have existed
  * beforehand. The old value is checked after the lock is taken to
  * prevent races. If the old value doesn't agree with old_oid, the
  * whole transaction fails. If old_oid is NULL, then the previous
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a47771e4d4..bbeafe1db7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -10,6 +10,51 @@
 #include "../object.h"
 #include "../dir.h"
 
+/*
+ * This backend uses the following flags in `ref_update::flags` for
+ * internal bookkeeping purposes. Their numerical values must not
+ * conflict with REF_NODEREF, REF_FORCE_CREATE_REFLOG, REF_HAVE_NEW,
+ * REF_HAVE_OLD, or REF_ISPRUNING, which are also stored in
+ * `ref_update::flags`.
+ */
+
+/*
+ * Used as a flag in ref_update::flags when a loose ref is being
+ * pruned. This flag must only be used when REF_NODEREF is set.
+ */
+#define REF_ISPRUNING (1 << 4)
+
+/*
+ * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
+ * refs (i.e., because the reference is about to be deleted anyway).
+ */
+#define REF_DELETING (1 << 5)
+
+/*
+ * Used as a flag in ref_update::flags when the lockfile needs to be
+ * committed.
+ */
+#define REF_NEEDS_COMMIT (1 << 6)
+
+/*
+ * Used as a flag in ref_update::flags when we want to log a ref
+ * update but not actually perform it.  This is used when a symbolic
+ * ref update is split up.
+ */
+#define REF_LOG_ONLY (1 << 7)
+
+/*
+ * Used as a flag in ref_update::flags when the ref_update was via an
+ * update to HEAD.
+ */
+#define REF_UPDATE_VIA_HEAD (1 << 8)
+
+/*
+ * Used as a flag in ref_update::flags when the loose reference has
+ * been deleted.
+ */
+#define REF_DELETED_LOOSE (1 << 9)
+
 struct ref_lock {
 	char *ref_name;
 	struct lock_file lk;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index b0f3e300c7..2ea02dcbe4 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -8,58 +8,22 @@
  */
 
 /*
- * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
- * refs (i.e., because the reference is about to be deleted anyway).
+ * The following flags can appear in `ref_update::flags`. Their
+ * numerical values must not conflict with those of REF_NODEREF and
+ * REF_FORCE_CREATE_REFLOG, which are also stored in
+ * `ref_update::flags`.
  */
-#define REF_DELETING	0x02
 
 /*
- * Used as a flag in ref_update::flags when a loose ref is being
- * pruned. This flag must only be used when REF_NODEREF is set.
+ * The reference should be updated to new_sha1.
  */
-#define REF_ISPRUNING	0x04
+#define REF_HAVE_NEW (1 << 2)
 
 /*
- * Used as a flag in ref_update::flags when the reference should be
- * updated to new_sha1.
+ * The current reference's value should be checked to make sure that
+ * it agrees with old_sha1.
  */
-#define REF_HAVE_NEW	0x08
-
-/*
- * Used as a flag in ref_update::flags when old_sha1 should be
- * checked.
- */
-#define REF_HAVE_OLD	0x10
-
-/*
- * Used as a flag in ref_update::flags when the lockfile needs to be
- * committed.
- */
-#define REF_NEEDS_COMMIT 0x20
-
-/*
- * 0x40 is REF_FORCE_CREATE_REFLOG, so skip it if you're adding a
- * value to ref_update::flags
- */
-
-/*
- * Used as a flag in ref_update::flags when we want to log a ref
- * update but not actually perform it.  This is used when a symbolic
- * ref update is split up.
- */
-#define REF_LOG_ONLY 0x80
-
-/*
- * Internal flag, meaning that the containing ref_update was via an
- * update to HEAD.
- */
-#define REF_UPDATE_VIA_HEAD 0x100
-
-/*
- * Used as a flag in ref_update::flags when the loose reference has
- * been deleted.
- */
-#define REF_DELETED_LOOSE 0x200
+#define REF_HAVE_OLD (1 << 3)
 
 /*
  * Return the length of time to retry acquiring a loose reference lock
@@ -141,23 +105,22 @@ int copy_reflog_msg(char *buf, const char *msg);
  * not exist before update.
  */
 struct ref_update {
-
 	/*
-	 * If (flags & REF_HAVE_NEW), set the reference to this value:
+	 * If (flags & REF_HAVE_NEW), set the reference to this value
+	 * (or delete it, if `new_oid` is `null_oid`).
 	 */
 	struct object_id new_oid;
 
 	/*
 	 * If (flags & REF_HAVE_OLD), check that the reference
-	 * previously had this value:
+	 * previously had this value (or didn't previously exist, if
+	 * `old_oid` is `null_oid`).
 	 */
 	struct object_id old_oid;
 
 	/*
-	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
-	 * REF_DELETING, REF_ISPRUNING, REF_LOG_ONLY,
-	 * REF_UPDATE_VIA_HEAD, REF_NEEDS_COMMIT, and
-	 * REF_DELETED_LOOSE:
+	 * One or more of REF_NODEREF, REF_FORCE_CREATE_REFLOG,
+	 * REF_HAVE_NEW, REF_HAVE_OLD, or backend-specific flags.
 	 */
 	unsigned int flags;
 
-- 
2.14.1

