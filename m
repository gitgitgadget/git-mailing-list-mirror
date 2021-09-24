Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BD5C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C861660F26
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346501AbhIXSnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:43:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:54664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231919AbhIXSnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:43:06 -0400
Received: (qmail 19129 invoked by uid 109); 24 Sep 2021 18:41:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:41:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11152 invoked by uid 111); 24 Sep 2021 18:41:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:41:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:41:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 10/16] refs: add DO_FOR_EACH_OMIT_DANGLING_SYMREFS flag
Message-ID: <YU4b3LxHdQiVGtWW@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the DO_FOR_EACH_INCLUDE_BROKEN flag is used, we include both actual
corrupt refs (illegal names, missing objects), but also symrefs that
point to nothing. This latter is not really a corruption, but just
something that may happen normally. For example, the symref at
refs/remotes/origin/HEAD may point to a tracking branch which is later
deleted. (The local HEAD may also be unborn, of course, but we do not
access it through ref iteration).

Most callers of for_each_ref() etc, do not care. They don't pass
INCLUDE_BROKEN, so don't see it at all. But for those which do pass it,
this somewhat-normal state causes extra warnings (e.g., from
for-each-ref) or even aborts operations (destructive repacks with
GIT_REF_PARANOIA set).

This patch just introduces the flag and the mechanism; there are no
callers yet (and hence no tests). Two things to note on the
implementation:

  - we actually skip any symref that does not resolve to a ref. This
    includes ones which point to an invalidly-named ref. You could argue
    this is a more serious breakage than simple dangling. But the
    overall effect is the same (we could not follow the symref), as well
    as the impact on things like REF_PARANOIA (either way, a symref we
    can't follow won't impact reachability, because we'll see the ref
    itself during iteration). The underlying resolution function doesn't
    distinguish these two cases (they both get REF_ISBROKEN).

  - we change the iterator in refs/files-backend.c where we check
    INCLUDE_BROKEN. There's a matching spot in refs/packed-backend.c,
    but we don't know need to do anything there. The packed backend does
    not support symrefs at all.

The resulting set of flags might be a bit easier to follow if we broke
this down into "INCLUDE_CORRUPT_REFS" and "INCLUDE_DANGLING_SYMREFS".
But there are a few reasons not do so:

  - adding a new OMIT_DANGLING_SYMREFS flag lets us leave existing
    callers intact, without changing their behavior (and some of them
    really do want to see the dangling symrefs; e.g., t5505 has a test
    which expects us to report when a symref becomes dangling)

  - they're not actually independent. You cannot say "include dangling
    symrefs" without also including refs whose objects are not
    reachable, because dangling symrefs by definition do not have an
    object. We could tweak the implementation to distinguish this, but
    in practice nobody wants to ask for that. Adding the OMIT flag keeps
    the implementation simple and makes sure we don't regress the
    current behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c | 5 +++++
 refs/refs-internal.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 74c0385873..1148c0cf09 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -744,6 +744,11 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
 			continue;
 
+		if ((iter->flags & DO_FOR_EACH_OMIT_DANGLING_SYMREFS) &&
+		    (iter->iter0->flags & REF_ISSYMREF) &&
+		    (iter->iter0->flags & REF_ISBROKEN))
+			continue;
+
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
 		    !ref_resolves_to_object(iter->iter0->refname,
 					    iter->iter0->oid,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2c4e1739f2..96911fb26e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -268,6 +268,12 @@ enum do_for_each_ref_flags {
 	 * per-worktree refs.
 	 */
 	DO_FOR_EACH_PER_WORKTREE_ONLY = (1 << 1),
+
+	/*
+	 * Omit dangling symrefs from output; this only has an effect with
+	 * INCLUDE_BROKEN, since they are otherwise not included at all.
+	 */
+	DO_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
 };
 
 /*
-- 
2.33.0.1071.gb37e412355

