Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079C6C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 00:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73C760C51
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 00:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbhHFArI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 20:47:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:40952 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhHFArI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 20:47:08 -0400
Received: (qmail 13643 invoked by uid 109); 6 Aug 2021 00:46:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Aug 2021 00:46:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8623 invoked by uid 111); 6 Aug 2021 00:46:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Aug 2021 20:46:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Aug 2021 20:46:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] refs: drop unused "flags" parameter to lock_ref_oid_basic()
Message-ID: <YQyGe9qOPRA0nf5v@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 1578215dab (refs/files: remove unused REF_DELETING in
lock_ref_oid_basic(), 2021-07-20), dropped the last use of this flag
parameter.

All of the callers do pass REF_NO_DEREF, but that has been ignored
completely since 7a418f3a17 (lock_ref_sha1_basic(): only handle
REF_NODEREF mode, 2016-04-22).

So we can simply get rid of the parameter entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of ab/refs-files-cleanup, which is in 'next'. I notice that
hn/refs-errno-cleanup is based on that branch, but I think it is OK for
them to diverge. This is pure cleanup on top that does not conflict
textually or semantically.

 refs/files-backend.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5d12003471..9a20d2bfc6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -876,8 +876,7 @@ static int create_reflock(const char *path, void *cb)
  * On failure errno is set to something meaningful.
  */
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
-					   const char *refname,
-					   unsigned int flags, int *type,
+					   const char *refname, int *type,
 					   struct strbuf *err)
 {
 	struct strbuf ref_file = STRBUF_INIT;
@@ -1345,7 +1344,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	logmoved = log;
 
-	lock = lock_ref_oid_basic(refs, newrefname, REF_NO_DEREF, NULL, &err);
+	lock = lock_ref_oid_basic(refs, newrefname, NULL, &err);
 	if (!lock) {
 		if (copy)
 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
@@ -1367,7 +1366,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	goto out;
 
  rollback:
-	lock = lock_ref_oid_basic(refs, oldrefname, REF_NO_DEREF, NULL, &err);
+	lock = lock_ref_oid_basic(refs, oldrefname, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1774,7 +1773,7 @@ static int files_create_symref(struct ref_store *ref_store,
 	struct ref_lock *lock;
 	int ret;
 
-	lock = lock_ref_oid_basic(refs, refname, REF_NO_DEREF, NULL, &err);
+	lock = lock_ref_oid_basic(refs, refname, NULL, &err);
 	if (!lock) {
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -2992,7 +2991,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_oid_basic(refs, refname, REF_NO_DEREF, &type, &err);
+	lock = lock_ref_oid_basic(refs, refname, &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
-- 
2.33.0.rc0.523.g07fb5e6bbb
