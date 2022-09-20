Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CACC6FA8B
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 19:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiITT2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiITT2l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 15:28:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B2067469
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 12:28:38 -0700 (PDT)
Received: (qmail 30736 invoked by uid 109); 20 Sep 2022 19:28:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Sep 2022 19:28:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13827 invoked by uid 111); 20 Sep 2022 19:28:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Sep 2022 15:28:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Sep 2022 15:28:37 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, derrickstolee@github.com
Subject: Re: [PATCH] midx.c: use `pack-objects --stdin-packs` when repacking
Message-ID: <YyoUZb90HeJnOuAV@coredump.intra.peff.net>
References: <9195a9ecd11a19f2c7fb1c70136d2d13fa308010.1663639662.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9195a9ecd11a19f2c7fb1c70136d2d13fa308010.1663639662.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 10:08:35PM -0400, Taylor Blau wrote:

> This patch replaces the pre-`--stdin-packs` invocation (where each
> object is given to `pack-objects` one by one) with the more modern
> `--stdin-packs` option.
> 
> This allows us to avoid some CPU cycles serializing and deserializing
> every object ID in all of the packs we're aggregating. It also avoids us
> having to send a potentially large amount of data down to
> `pack-objects`.

Makes sense. Just playing devil's advocate for a moment: is there any
way that getting the list of packs could be worse? I'm thinking
particularly of a race condition where a pack goes away while we're
running, but if we had the actual object list, we could fall back to
finding it elsewhere.

I think that could only happen if we had two gc's running
simultaneously, which is something we try to avoid already. And the
worst case would be that one would say "oops, this pack went away" and
bail, and not any kind of corruption.

So I think it's fine, but just trying to talk through any unexpected
implications.

> But more importantly, it generates slightly higher quality (read: more
> tightly compressed) packs, because of the reachability traversal that
> `--stdin-packs` does after the fact in order to gather namehash values
> which seed the delta selection process.

I think we _could_ do that same traversal even in objects mode. Or do
--stdin-packs without it. If we were starting from scratch, it might be
nice for the two features to be orthogonal so we could evaluate the
changes independently. But I don't think it's worth going back and
trying to split them out now. Although...

> In practice, this seems to add a slight amount of overhead (on the order
> of a few seconds for git.git broken up into ~100 packs), in exchange for
> a modest reduction (on the order of ~3.5%) in the resulting pack size.

Hmm. I thought we'd have some code to reuse the cached name-hashes in
the .bitmap file, if one is present. But I don't see any such code in
the stdin-packs feature. I think for "repack --geometric" it doesn't
matter. There the "main" pack with the bitmap would also be excluded
from the rollup (unless we are rolling all-into-one, in which case we do
the full from-scratch repack with a traversal).

Is that true also of "multi-pack-index repack"? I guess it would depend
on how you invoke it. I admit I don't think I've ever used it myself,
since the new "repack --geometric --write-midx" approach matches my
mental model. I'm not sure when you'd actually run the "multi-pack-index
repack" command. But if you did it with --batch-size=0 (the default), I
think we'd end up traversing every object in history.

>  midx.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

The patch itself is mostly as expected, but I did have one question:

> @@ -2026,17 +2027,17 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
> 
>  	cmd_in = xfdopen(cmd.in, "w");
> 
> -	for (i = 0; i < m->num_objects; i++) {
> -		struct object_id oid;
> -		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
> +	for (i = 0; i < m->num_packs; i++) {
> +		strbuf_reset(&scratch);

The old code went in object order within the midx. Is this sorted by
sha1, or the pack pseudo-order? If the former, then that will yield a
different order of objects inside pack-objects (since it is seeing the
packs in order of our m->pack_names array). I don't _think_ it matters,
but I just wanted to double check.

-Peff
