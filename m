Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D717B1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967482AbdAFQXe (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:34 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:44603 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966898AbdAFQXN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:13 -0500
X-AuditID: 12074411-fbbff700000009b7-02-586fc46a04e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id DC.E6.02487.A64CF685; Fri,  6 Jan 2017 11:23:06 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmWw023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:04 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 08/23] lock_ref_sha1_basic(): use raceproof_create_file()
Date:   Fri,  6 Jan 2017 17:22:28 +0100
Message-Id: <f3048a56ed5e273ac42964fd2345d67db6e7ddbe.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqJt1JD/CoPeskkXXlW4mi4beK8wW
        uxf3M1vcXjGf2WLJw9fMFj9aepgtOqfKOrB7/H3/gclj56y77B7Ll65j9OhqP8Lm8ax3D6PH
        xUvKHp83yQWwR3HZpKTmZJalFunbJXBldO1YxVjwSqji55oLzA2My/i7GDk4JARMJPbPyexi
        5OIQErjMKLHq3wMWCOcEk8SfV1uYuhg5OdgEdCUW9TSD2SICahIT2w6BFTELfGCU+NU5ix0k
        ISzgI3Hq4F6wIhYBVYkjEyGaeQWiJB5t/MMKYksIyElc2vaFGcTmFLCQaNz1jRHEFhIwl/g0
        8TDzBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfVyM0v0UlNKNzFCAkxwB+OMk3KH
        GAU4GJV4eCO88iKEWBPLiitzDzFKcjApifKGOeZHCPEl5adUZiQWZ8QXleakFh9ilOBgVhLh
        tTsElONNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfD+AWkULEpNT61I
        y8wpQUgzcXCCDOcBGi54GGR4cUFibnFmOkT+FKOilDjvFpBmAZBERmkeXC8sAbxiFAd6RZhX
        GKSdB5g84LpfAQ1mAhnsCTa4JBEhJdXAOF+Is2QX076vTd2zztgsOdd3TOjc8scXD73f8fX8
        jDOdtaU1TB86/hjHiLLMsIg5dIR3geTrS95FhVWsJlHPXIS/Z6UcUGWaI1W+cfE0szb5zl83
        r5lcyq5r0X3BmVW1/PDD+sfJ4mtDXdurV77x2NRxdmZcyZ2W+ZXrntYLTZw0eYfL48NKUkos
        xRmJhlrMRcWJADtRUo7bAgAA
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

