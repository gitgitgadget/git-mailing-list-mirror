Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84174C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F77B64E65
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 23:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBPXSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 18:18:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:35142 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhBPXSW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 18:18:22 -0500
Received: (qmail 15375 invoked by uid 109); 16 Feb 2021 23:17:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 23:17:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30566 invoked by uid 111); 16 Feb 2021 23:17:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 18:17:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 18:17:40 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 2/8] revision: learn '--no-kept-objects'
Message-ID: <YCxSlNK4Ug2exDbv@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <ddc2896caa13b9f1cdccb2f0a5892143fa98237c.1612411123.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddc2896caa13b9f1cdccb2f0a5892143fa98237c.1612411123.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 10:58:57PM -0500, Taylor Blau wrote:

> @@ -3797,6 +3807,11 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
>  		return commit_ignore;
>  	if (revs->unpacked && has_object_pack(&commit->object.oid))
>  		return commit_ignore;
> +	if (revs->no_kept_objects) {
> +		if (has_object_kept_pack(&commit->object.oid,
> +					 revs->keep_pack_cache_flags))
> +			return commit_ignore;
> +	}

OK, so this has the same "problems" as --unpacked, which is that we can
miss some objects (i.e., things that are reachable but not-kept may not
be reported). But it should be OK in this version of the series, because
we will not be relying on it for selection of objects, but only to fill
in ordering / namehash fields.

Should we warn people about that, either as a comment or in the commit
message?

> +--no-kept-objects[=<kind>]::
> +	Halts the traversal as soon as an object in a kept pack is
> +	found. If `<kind>` is `on-disk`, only packs with a corresponding
> +	`*.keep` file are ignored. If `<kind>` is `in-core`, only packs
> +	with their in-core kept state set are ignored. Otherwise, both
> +	kinds of kept packs are ignored.

Likewise, I wonder whether we need to expose this mode to users.
Normally I'm a fan of doing so, because it allows scripted callers
access to more of the internals, but:

  - the semantics are kind of weird about where we draw the line between
    performance and absolute correctness

  - the "in-core" thing is a bit weird for callers of rev-list; how do I
    as a caller mark a pack as kept-in-core? I think it's only an
    internal pack-objects thing.

Once we support this in rev-list, we'll have to do it forever (or deal
with deprecation, etc). If we just need it internally, maybe it's wise
to leave it as a something you ask for by manipulating rev_info
directly. Or perhaps leave it as an undocumented interface we use for
testing, and not something we promise to keep working.

> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -338,6 +338,13 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
>  			ctx->show_object(obj, name, ctx->show_data);
>  			continue;
>  		}
> +		if (ctx->revs->no_kept_objects) {
> +			struct pack_entry e;
> +			if (find_kept_pack_entry(ctx->revs->repo, &obj->oid,
> +						 ctx->revs->keep_pack_cache_flags,
> +						 &e))
> +				continue;
> +		}

This hunk is interesting.

There is no similar check for revs->unpacked in list-objects.c to cut
off the traversal. And indeed, running "rev-list --unpacked" will
generally look at the _whole_ tree for a commit that is unpacked, even
if all of the tree entries are packed. That's something we might
consider changing in the name of performance (though it does increase
the number of cases where --unpacked will fail to find an unpacked but
reachable object).

But this is a funny place to put it. If I understand it correctly, it is
cutting off the traversal at the very top of the tree. I.e., if we had a
commit that is not-kept, we'd queue it's root tree. And then we might
find that the root tree is kept, and avoid traversing it. But if we _do_
traverse it, we would look at every subtree it contains, even if they
are kept! That's because we recurse the tree via the recursive
process_tree(), not by queueing more objects in the pending array here.

So this check seems to exist in a funny middle ground. I think it's
unlikely to catch anything useful (usually commits have a unique root
tree; it's all of the untouched parts of the subtrees that will be in
the kept packs). IMHO we should either drop it (and act like
"--unpacked", accepting that we may traverse some extra tree objects),
or we should go all-in on performance and cut it off in the top of
process_tree().

-Peff
