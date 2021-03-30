Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A542C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D7D6198A
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhC3HEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:04:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:36708 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231340AbhC3HEe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 03:04:34 -0400
Received: (qmail 18024 invoked by uid 109); 30 Mar 2021 07:04:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Mar 2021 07:04:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21931 invoked by uid 111); 30 Mar 2021 07:04:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Mar 2021 03:04:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Mar 2021 03:04:32 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 04/16] builtin/multi-pack-index.c: split sub-commands
Message-ID: <YGLNgBcWgCOYTxMv@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <d084f90466813597feb27975654e57de36eb62a4.1615482270.git.me@ttaylorr.com>
 <YGG7tWBzo5NGl2+g@coredump.intra.peff.net>
 <YGI6ySogGoYZi66A@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGI6ySogGoYZi66A@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 04:38:33PM -0400, Taylor Blau wrote:

> On Mon, Mar 29, 2021 at 07:36:21AM -0400, Jeff King wrote:
> > This is definitely a harmless leak in the sense that we are going to
> > exit the program after midx_repack() returns anyway. But it might be
> > worth keeping things tidy, as we've recently seen a renewed effort to do
> > some leak-checking of the test suite. I _think_ we can just free the
> > options struct (even though we are still using the values themselves, we
> > don't care about the "struct options" anymore). But even if not, an
> > UNLEAK(options) annotation would do it.
> 
> I see what you're saying. Let me make sure that I got the right idea in
> mind after reading your email. I'm thinking of squashing the following
> diff into this patch. For what it's worth, it causes 'valgrind
> --leak-check=full ./git-multi-pack-index repack' to exit cleanly (when
> it didn't before).
> 
> Does this match your expectations?

Yes, though...

> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 23e51dfeb4..a78640c061 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -56,9 +56,7 @@ static struct option common_opts[] = {
> 
>  static struct option *add_common_options(struct option *prev)
>  {
> -	struct option *with_common = parse_options_concat(common_opts, prev);
> -	free(prev);
> -	return with_common;
> +	return parse_options_concat(common_opts, prev);
>  }

This simplification is orthogonal to the leak, and I'd be OK if you
wanted to retain it as it was before (because it future-proofs against
adding more add_foo_options() later, though for now it is a useless
dup/free pair).

> @@ -123,6 +120,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
>  		usage_with_options(builtin_multi_pack_index_repack_usage,
>  				   options);
> 
> +	FREE_AND_NULL(options);
> +

And this is the leak fix I care about. We'd want the same thing in the
later caller that adds another use of add_common_options(), of course.

-Peff
