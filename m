Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F12C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A39D60184
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbhHDU7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 16:59:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:39042 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230407AbhHDU7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 16:59:54 -0400
Received: (qmail 7438 invoked by uid 109); 4 Aug 2021 20:59:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Aug 2021 20:59:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28483 invoked by uid 111); 4 Aug 2021 20:59:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Aug 2021 16:59:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Aug 2021 16:59:40 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: speed up loading of refs via commit graph
Message-ID: <YQr/vLNjZomIe1ME@coredump.intra.peff.net>
References: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 04, 2021 at 03:56:11PM +0200, Patrick Steinhardt wrote:

> When doing reference negotiation, git-fetch-pack(1) is loading all refs
> from disk in order to determine which commits it has in common with the
> remote repository. This can be quite expensive in repositories with many
> references though: in a real-world repository with around 2.2 million
> refs, fetching a single commit by its ID takes around 44 seconds.
> 
> Dominating the loading time is decompression and parsing of the objects
> which are referenced by commits. Given the fact that we only care about
> commits (or tags which can be peeled to one) in this context, there is
> thus an easy performance win by switching the parsing logic to make use
> of the commit graph in case we have one available. Like this, we avoid
> hitting the object database to parse these commits but instead only load
> them from the commit-graph. This results in a significant performance
> boost when executing git-fetch in said repository with 2.2 million refs:
> 
>     Benchmark #1: HEAD~: git fetch $remote $commit
>       Time (mean ± σ):     44.168 s ±  0.341 s    [User: 42.985 s, System: 1.106 s]
>       Range (min … max):   43.565 s … 44.577 s    10 runs
> 
>     Benchmark #2: HEAD: git fetch $remote $commit
>       Time (mean ± σ):     19.498 s ±  0.724 s    [User: 18.751 s, System: 0.690 s]
>       Range (min … max):   18.629 s … 20.454 s    10 runs
> 
>     Summary
>       'HEAD: git fetch $remote $commit' ran
>         2.27 ± 0.09 times faster than 'HEAD~: git fetch $remote $commit'

Nice. I've sometimes wondered if parse_object() should be doing this
optimization itself. Though we'd possibly still want callers (like this
one) to give us more hints, since we already know the type is
OBJ_COMMIT. Whereas parse_object() would have to discover that itself
(though we already incur the extra type lookup there to handle blobs).

I wonder where the remaining 20s is going. Do you have a lot of tags in
your repository? We'll still parse all of those, which could be
expensive. There might be some benefit to using peel_iterated_ref(),
which will make us of packed-ref's peel hints, but:

  - you'd want to double check that we always call this during ref
    iteration (it looks like we do, and I think peel_iterated_ref()
    falls back to a normal peel otherwise)

  - for a tag-of-tag-of-X, that will give us the complete peel to X. But
    it looks like deref_without_lazy_fetch() marks intermediate tags
    with the COMPLETE flag, too. I'm not sure how important that is
    (i.e., is it necessary for correctness, or just an optimization, in
    which case we might be better off guessing that tags are
    single-layer, as it's by far the common case).

If we don't go that route, there's another possible speedup: after
parsing a tag, the type of tag->tagged (if it is not NULL) will be known
from the tag's contents, and we can avoid the oid_object_info_extended()
type lookup. It might need some extra surgery to convince the tag-parse
not to fetch promisor objects, though.

I'm not sure it would make that big a difference, though. If we save one
type-lookup per parsed tag, then the tag parsing is likely to dwarf it.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index b0c7be717c..0bf7ed7e47 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -137,8 +137,14 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
>  			break;
>  		}
>  	}
> -	if (type == OBJ_COMMIT)
> -		return (struct commit *) parse_object(the_repository, oid);
> +
> +	if (type == OBJ_COMMIT) {
> +		struct commit *commit = lookup_commit(the_repository, oid);
> +		if (!commit || repo_parse_commit(the_repository, commit))
> +			return NULL;
> +		return commit;
> +	}

Looks correct. You're using lookup_commit(), so we'll auto-create the
struct as necessary. If there's any kind of type mismatch (say,
previously we saw that oid as a non-commit), we'll get NULL there and
bail, which makes sense. I think the original code could produce
undefined behavior there if parse_object() found something other than
"type", though in practice that is quite unlikely (since
oid_object_info() would have just gone to the on-disk odb to get the
type itself).

-Peff
