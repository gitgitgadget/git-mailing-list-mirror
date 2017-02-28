Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4C23202CC
	for <e@80x24.org>; Tue, 28 Feb 2017 21:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdB1V7l (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:59:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:36080 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbdB1V7k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:59:40 -0500
Received: (qmail 26711 invoked by uid 109); 28 Feb 2017 21:59:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 21:59:39 +0000
Received: (qmail 31540 invoked by uid 111); 28 Feb 2017 21:59:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 16:59:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 16:59:37 -0500
Date:   Tue, 28 Feb 2017 16:59:37 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peartben@gmail.com, benpeart@microsoft.com
Subject: Re: [PATCH 1/3] revision: unify {tree,blob}_objects in rev_info
Message-ID: <20170228215937.yd4juycjf7y3vish@sigill.intra.peff.net>
References: <cover.1487984670.git.jonathantanmy@google.com>
 <cover.1487984670.git.jonathantanmy@google.com>
 <06a84f8c77924b275606384ead8bb2fd7d75f7b6.1487984670.git.jonathantanmy@google.com>
 <xmqq1suij8kr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1suij8kr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 01:42:44PM -0800, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > It could be argued that in the future, Git might need to distinguish
> > tree_objects from blob_objects - in particular, a user might want
> > rev-list to print the trees but not the blobs. 
> 
> That was exactly why these bits were originally made to "appear
> independent but in practice nobody sets only one and leaves others
> off".  
> 
> And it didn't happen in the past 10 years, which tells us that we
> should take this patch.

I actually have a patch which uses the distinction. It's for
upload-archive doing reachability checks (which seems rather familiar to
what's going on here).

The whole series (from 2013!) is at:

  git://github.com/peff/git jk/archive-reachability

but the relevant commits are below.

I don't think the same logic holds for this case, though, because
somebody actually can ask for a single blob.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Wed, 5 Jun 2013 17:57:02 -0400
Subject: [PATCH] list-objects: optimize "revs->blob_objects = 0" case

If we are traversing trees during a "--objects"
traversal, we may skip blobs if the "blob_objects" field of
rev_info is not set. But we do so as the first thing in
process_blob(), only after we have actually created the
"struct blob" object, incurring a hash lookup. We can
optimize out this no-op call completely.

This does not actually affect any current code, as all of
the current traversals always set blob_objects when looking
at objects, anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects.c b/list-objects.c
index f3ca6aafb..58ad69557 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -117,7 +117,7 @@ static void process_tree(struct rev_info *revs,
 			process_gitlink(revs, entry.oid->hash,
 					show, base, entry.path,
 					cb_data);
-		else
+		else if (revs->blob_objects)
 			process_blob(revs,
 				     lookup_blob(entry.oid->hash),
 				     show, base, entry.path,
-- 
2.12.0.359.gd4c8c42e9

-- >8 --
From: Jeff King <peff@peff.net>
Date: Wed, 5 Jun 2013 18:02:42 -0400
Subject: [PATCH] archive: ignore blob objects when checking reachability

We cannot create an archive from a blob object, so we would
not expect anyone to provide one to us. And if they do, we
will fail anyway just after the reachability check.  We can
therefore optimize our reachability check to ignore blobs
completely, and not even create a "struct blob" for them.

Depending on the repository size and the exact place we find
the reachable object in the traversal, this can save 20-25%,
a we can avoid many lookups in the object hash.

The downside of this is that a blob provided to a remote
archive process will fail with "no such object" rather than
"object is not a tree" (we could organize the code to retain
the old message, but since we no longer know whether the
blob is reachable or not, we would potentially be leaking
information about the existence of unreachable objects).

Signed-off-by: Jeff King <peff@peff.net>
---
 archive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/archive.c b/archive.c
index ef89b2556..489115f9f 100644
--- a/archive.c
+++ b/archive.c
@@ -383,6 +383,7 @@ static int object_is_reachable(const unsigned char *sha1)
 	save_commit_buffer = 0;
 	init_revisions(&data.revs, NULL);
 	setup_revisions(ARRAY_SIZE(argv) - 1, argv, &data.revs, NULL);
+	data.revs.blob_objects = 0;
 	if (prepare_revision_walk(&data.revs))
 		return 0;
 
-- 
2.12.0.359.gd4c8c42e9

