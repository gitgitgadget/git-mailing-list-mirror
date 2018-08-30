Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5A51F404
	for <e@80x24.org>; Thu, 30 Aug 2018 08:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeH3MNA (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 08:13:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:33692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727574AbeH3MNA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 08:13:00 -0400
Received: (qmail 14397 invoked by uid 109); 30 Aug 2018 08:12:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 08:12:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24676 invoked by uid 111); 30 Aug 2018 08:12:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 04:12:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 04:12:03 -0400
Date:   Thu, 30 Aug 2018 04:12:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc-diff: always use oids inside worktree
Message-ID: <20180830081202.GA10224@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The doc-diff script immediately resolves its two endpoints
to actual object ids, so that we can reuse cached results
even if they appear under a different name. But we still use
the original name the user fed us when running "git
checkout" in our temporary worktree. This can lead to
confusing results:

  - the namespace inside the worktree is different than the
    one outside. In particular, "./doc-diff origin HEAD"
    will resolve HEAD inside the worktree, whose detached
    HEAD will be pointing at origin! As a result, such a
    diff would always be empty.

  - worse, we will store this result under the oid we got by
    resolving HEAD in the main worktree, thus polluting our
    cache

  - we didn't pass --detach, which meant that using a branch
    name would cause us to actually check out that branch,
    making it unavailable to other worktrees.

We can solve this by feeding the already-resolved object id
to git-checkout. That naturally forces a detached HEAD, but
just to make clear our expectation, let's explicitly pass
--detach.

Signed-off-by: Jeff King <peff@peff.net>
---
Another fixup for jk/diff-rendered-docs, noticed when trying it out on
Eric's worktree series (which, btw, rendered as expected once I fixed
this bug ;) ).

 Documentation/doc-diff | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 6e285e648c..c430fe7c99 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -82,7 +82,7 @@ generate_render_makefile () {
 	done
 }
 
-# render_tree <dirname> <committish>
+# render_tree <committish_oid>
 render_tree () {
 	# Skip install-man entirely if we already have an installed directory.
 	# We can't rely on make here, since "install-man" unconditionally
@@ -92,7 +92,7 @@ render_tree () {
 	# through.
 	if ! test -d "$tmp/installed/$1"
 	then
-		git -C "$tmp/worktree" checkout "$2" &&
+		git -C "$tmp/worktree" checkout --detach "$1" &&
 		make -j$parallel -C "$tmp/worktree" \
 			GIT_VERSION=omitted \
 			SOURCE_DATE_EPOCH=0 \
@@ -112,6 +112,6 @@ render_tree () {
 	fi
 }
 
-render_tree $from_oid "$from" &&
-render_tree $to_oid "$to" &&
+render_tree $from_oid &&
+render_tree $to_oid &&
 git -C $tmp/rendered diff --no-index "$@" $from_oid $to_oid
-- 
2.19.0.rc1.9.gf8a776330b
