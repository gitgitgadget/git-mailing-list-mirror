Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FBBC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbjELVpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbjELVpp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:45:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6A37A81
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:45:43 -0700 (PDT)
Received: (qmail 14502 invoked by uid 109); 12 May 2023 21:45:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 May 2023 21:45:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26357 invoked by uid 111); 12 May 2023 21:45:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 May 2023 17:45:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 12 May 2023 17:45:42 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <20230512214542.GB2495860@coredump.intra.peff.net>
References: <cover.1683847221.git.me@ttaylorr.com>
 <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
 <20230512212456.GA2495860@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230512212456.GA2495860@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 05:24:56PM -0400, Jeff King wrote:

> > This patch introduces a new configuration, `pack.recentObjectsHook`
> > which allows the caller to specify a program (or set of programs) whose
> > output is treated as a set of objects to treat as recent, regardless of
> > their true age.
> 
> I was going to complain about putting this in the "pack" section,
> because I thought by touching reachable.c, we'd also affect git-prune.
> But I don't think we do, because it does its own direct mtime check on
> the loose objects.
> 
> But I'm not sure that's the right behavior.
> 
> It feels like even before your patch, this is a huge gap in our
> object-retention strategy.  During repacking, we try to avoid dropping
> objects which are reachable from recent-but-unreachable things we're
> keeping (since otherwise it effectively corrupts those recent objects,
> making them less valuable to keep). But git-prune will happily drop them
> anyway!
> 
> And I think the same thing would apply to your hook. If the hook says
> "object XYZ is precious even if unreachable, keep it", then git-prune
> ignoring that seems like it would be a source of errors.
> 
> I suspect both could be fixed by having git-prune trigger the same
> add_unseen_recent_objects_to_traversal() call either as part of
> the perform_reachability_traversal() walk, or maybe in its own walk (I
> think maybe it has to be its own because the second walk should avoid
> complaining about missing objects).

<phew> I am happy to say that I was wrong here, and git-prune behaves as
it should, courtesy of d3038d22f9 (prune: keep objects reachable from
recent objects, 2014-10-15). The magic happens in mark_reachable_objects(),
which handles walking the recent objects by calling...you guessed it,
add_unseen_recent_objects_to_traversal().

So it does the right thing now, and your patch should kick in
automatically for git-prune, too. But I think we'd want two things:

  1. Should the config variable name be made more generic to match?
     Maybe "core" is too broad (though certainly I'd expect it to apply
     anywhere in Git where we check recent-ness of objects), but perhaps
     "gc" would make sense (even though it is not strictly part of the
     gc command, it is within that realm of concepts).

  2. We probably want a test covering git-prune in this situation.

The thing that confused me when looking at the code earlier is that
git-prune itself checks the mtime of the objects, too, even if they were
not mentioned in the recent-but-reachable walk. That seems redundant to
me, but somehow it isn't. If I do:

diff --git a/builtin/prune.c b/builtin/prune.c
index 5dc9b20720..22b7ce4b10 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -92,7 +92,7 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 		return 0;
 	}
 	if (st.st_mtime > expire)
-		return 0;
+		BUG("object should have been saved via is_object_reachable!");
 	if (show_only || verbose) {
 		enum object_type type = oid_object_info(the_repository, oid,
 							NULL);

then t5304 shows some failures. I'm not quite sure what is going on, but
_if_ that mtime check in prune_object() is important, then it probably
should also respect the hook mechanism. So there may be a (3) to add to
your patch there.

-Peff
