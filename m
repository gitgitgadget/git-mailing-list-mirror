Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A59C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0852173E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgJGSsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:48:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:52732 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgJGSsx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 14:48:53 -0400
Received: (qmail 21432 invoked by uid 109); 7 Oct 2020 18:48:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Oct 2020 18:48:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15323 invoked by uid 111); 7 Oct 2020 18:48:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Oct 2020 14:48:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Oct 2020 14:48:52 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
Message-ID: <20201007184852.GB222564@coredump.intra.peff.net>
References: <xmqqlfgi2axr.fsf@gitster.c.googlers.com>
 <20201007184143.1304267-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007184143.1304267-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 07, 2020 at 11:41:43AM -0700, Jonathan Tan wrote:

> > We seem to have removed find_unresolved_deltas() helper function in
> > that series, but there remains a mention to it in a comment, which
> > we would probably should rethink (it just may be the matter of
> > removing the mention, or if "just like in ..." may have been the
> > last example of doing what the comment suggests all code to do, it
> > may reveal a need for larger clean-up---I dunno).
> 
> Maybe the whole comment block should be deleted and replaced with
> something like:
> 
>  Ensure that this node has been uncompressed and return its contents.
> 
>  In the typical and best case, this node would already be uncompressed
>  (through the invocation to resolve_delta() in threaded_second_pass())
>  and it would not be pruned. However, if pruning of this node was
>  necessary due to reaching delta_base_cache_limit, this function will
>  find the closest ancestor with uncompressed data that has not been
>  pruned (or if there is none, the ultimate base object), and uncompress
>  each node in the delta chain in order to generate the uncompressed data
>  for this node.

FWIW, that is much clearer to me. Do you want to work that up as a
replacement for my patch 3?

> (I'm using "uncompress" here because I find the original "deflate" term
> confusing - I thought that "deflate" meant compress, and thus the
> "data" here would be the uncompressed form, and hence undeflated or
> inflated.)

Yeah, I think the original meant "inflated", not "deflated". Except that
it's really more than a zlib inflate, as we probably would have
reconstructed it by patching another delta. I guess you _could_ call
that inflation, too, but we usually don't. Maybe "reconstructed" would
be a better term to use in general (though I am happy enough with the
"uncompressed" you used above).

-Peff
