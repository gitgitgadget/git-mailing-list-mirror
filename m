Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4175C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 11:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70036193A
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 11:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhC2Lgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 07:36:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:35382 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230520AbhC2LgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 07:36:25 -0400
Received: (qmail 10383 invoked by uid 109); 29 Mar 2021 11:36:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 11:36:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12940 invoked by uid 111); 29 Mar 2021 11:36:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 07:36:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 07:36:21 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 04/16] builtin/multi-pack-index.c: split sub-commands
Message-ID: <YGG7tWBzo5NGl2+g@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <d084f90466813597feb27975654e57de36eb62a4.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d084f90466813597feb27975654e57de36eb62a4.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:04:49PM -0500, Taylor Blau wrote:

> Handle sub-commands of the 'git multi-pack-index' builtin (e.g.,
> "write", "repack", etc.) separately from one another. This allows
> sub-commands with unique options, without forcing cmd_multi_pack_index()
> to reject invalid combinations itself.
> 
> This comes at the cost of some duplication and boilerplate. Luckily, the
> duplication is reduced to a minimum, since common options are shared
> among sub-commands due to a suggestion by Ævar. (Sub-commands do have to
> retain the common options, too, since this builtin accepts common
> options on either side of the sub-command).
> 
> Roughly speaking, cmd_multi_pack_index() parses options (including
> common ones), and stops at the first non-option, which is the
> sub-command. It then dispatches to the appropriate sub-command, which
> parses the remaining options (also including common options).
> 
> Unknown options are kept by the sub-commands in order to detect their
> presence (and complain that too many arguments were given).

Makes sense, and the implementation looks pretty clean.

A few small nits:

> +static struct option *add_common_options(struct option *prev)
>  {
> -	static struct option builtin_multi_pack_index_options[] = {
> -		OPT_FILENAME(0, "object-dir", &opts.object_dir,
> -		  N_("object directory containing set of packfile and pack-index pairs")),
> -		OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"), MIDX_PROGRESS),
> +	struct option *with_common = parse_options_concat(common_opts, prev);
> +	free(prev);
> +	return with_common;
> +}

This free(prev) pattern is copied from builtin/checkout.c, where we have
multiple layers of options, each added by a function. So it requires
that callers duplicate the base set of options, and each subsequent
"add_foo_options()" concatenates that and frees the old one.

But here, we only have one layer, so in the caller which uses it:

> +static int cmd_multi_pack_index_repack(int argc, const char **argv)
> +{
> [..]
> +	options = parse_options_dup(builtin_multi_pack_index_repack_options);
> +	options = add_common_options(options);

we do a rather pointless dup() followed by free(). Perhaps not that big
a deal, and this would naturally extend to adding other option sets, so
it may even be considered future-proofing. But it did confuse me for a
moment.

However, we do end up leaking the return value from add_common_options()
at the end of the function:

> +	options = parse_options_dup(builtin_multi_pack_index_repack_options);
> +	options = add_common_options(options);
> +
> +	argc = parse_options(argc, argv, NULL,
> +			     options,
> +			     builtin_multi_pack_index_repack_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +	if (argc)
> +		usage_with_options(builtin_multi_pack_index_repack_usage,
> +				   options);
> +
> +	return midx_repack(the_repository, opts.object_dir,
> +			   (size_t)opts.batch_size, opts.flags);
> +}

This is definitely a harmless leak in the sense that we are going to
exit the program after midx_repack() returns anyway. But it might be
worth keeping things tidy, as we've recently seen a renewed effort to do
some leak-checking of the test suite. I _think_ we can just free the
options struct (even though we are still using the values themselves, we
don't care about the "struct options" anymore). But even if not, an
UNLEAK(options) annotation would do it.

(This doesn't apply to the other functions, because they just use
common_opts directly).

-Peff
