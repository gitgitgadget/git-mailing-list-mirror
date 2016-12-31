Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CB2A2070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754645AbcLaDN0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:26 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47943 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754570AbcLaDNV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:21 -0500
X-AuditID: 1207440e-7c7ff700000009ec-1d-5867224edaca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id C0.C9.02540.E4227685; Fri, 30 Dec 2016 22:13:19 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6u1010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:17 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/23] lock_ref_sha1_basic(): use raceproof_create_file()
Date:   Sat, 31 Dec 2016 04:12:47 +0100
Message-Id: <0145c9444cf7eb9e9897e420c9b38ddbe76d4562.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsUixO6iqOuvlB5h8P25jkXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mrp2rGIseCVU8XPNBeYGxmX8XYycHBICJhKbP5xi7WLk4hASuMwo8fPePyYI5ziTxP9r
        e1hBqtgEdCUW9TQzgdgiAmoSE9sOsYAUMQtMZJSYtuUSWEJYwEdi9c9nzF2MHBwsAqoSN87a
        g5i8AlES0xuFIZbJSVza9oUZxOYUsJBY/KkPrFNIwFxi3c5LzBMYeRYwMqxilEvMKc3VzU3M
        zClOTdYtTk7My0st0jXWy80s0UtNKd3ECAkcvh2M7etlDjEKcDAq8fB2XEuLEGJNLCuuzD3E
        KMnBpCTKa2mZGiHEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHehXHqEEG9KYmVValE+TEqag0VJ
        nFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgnehIlCjYFFqempFWmZOCUKaiYMTZDgP0PBekBre
        4oLE3OLMdIj8KUZFKXHetQpACQGQREZpHlwvLLJfMYoDvSLMuwuknQeYFOC6XwENZgIarJaT
        DDK4JBEhJdXAOMvtWFj/17PJJTc8Ih937uy4muDzjXVmVcTR3bVb3Ha/yXvL13jZdFrtEt1c
        vleCTPopU9uZ5X/NvLVUYsOiA0WHeJdYTFmzJGX9Ldfo1K8m8z2045vDVTfePLNg7RyzTwdK
        +rRPLa5amH7apS/X/QpLusnZhpULJdh/zuHXyesrjb+//omFkhJLcUaioRZzUXEiACPCnb/H
        AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of coding the retry loop inline, use raceproof_create_file() to
make lock acquisition safe against directory creation/deletion races.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7d4658a..74de289 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1985,6 +1985,13 @@ static int remove_empty_directories(struct strbuf *path)
 	return remove_dir_recursively(path, REMOVE_DIR_EMPTY_ONLY);
 }
 
+static int create_reflock(const char *path, void *cb)
+{
+	struct lock_file *lk = cb;
+
+	return hold_lock_file_for_update(lk, path, LOCK_NO_DEREF) < 0 ? -1 : 0;
+}
+
 /*
  * Locks a ref returning the lock on success and NULL on failure.
  * On failure errno is set to something meaningful.
@@ -2002,7 +2009,6 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	int last_errno = 0;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
-	int attempts_remaining = 3;
 	int resolved;
 
 	assert_main_repository(&refs->base, "lock_ref_sha1_basic");
@@ -2067,35 +2073,12 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 
 	lock->ref_name = xstrdup(refname);
 
- retry:
-	switch (safe_create_leading_directories_const(ref_file.buf)) {
-	case SCLD_OK:
-		break; /* success */
-	case SCLD_VANISHED:
-		if (--attempts_remaining > 0)
-			goto retry;
-		/* fall through */
-	default:
+	if (raceproof_create_file(ref_file.buf, create_reflock, lock->lk)) {
 		last_errno = errno;
-		strbuf_addf(err, "unable to create directory for '%s'",
-			    ref_file.buf);
+		unable_to_lock_message(ref_file.buf, errno, err);
 		goto error_return;
 	}
 
-	if (hold_lock_file_for_update(lock->lk, ref_file.buf, LOCK_NO_DEREF) < 0) {
-		last_errno = errno;
-		if (errno == ENOENT && --attempts_remaining > 0)
-			/*
-			 * Maybe somebody just deleted one of the
-			 * directories leading to ref_file.  Try
-			 * again:
-			 */
-			goto retry;
-		else {
-			unable_to_lock_message(ref_file.buf, errno, err);
-			goto error_return;
-		}
-	}
 	if (verify_lock(lock, old_sha1, mustexist, err)) {
 		last_errno = errno;
 		goto error_return;
-- 
2.9.3

