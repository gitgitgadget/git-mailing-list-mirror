Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DDAC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 11:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031096190A
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 11:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhC2Lmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 07:42:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:35398 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231237AbhC2LmT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 07:42:19 -0400
Received: (qmail 10425 invoked by uid 109); 29 Mar 2021 11:42:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 11:42:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12972 invoked by uid 111); 29 Mar 2021 11:42:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 07:42:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 07:42:18 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 06/16] builtin/multi-pack-index.c: display usage on
 unrecognized command
Message-ID: <YGG9GogdjlijGxSF@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <f117e442c3460661dc88beba6f1853d6c388b0fd.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f117e442c3460661dc88beba6f1853d6c388b0fd.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:04:57PM -0500, Taylor Blau wrote:

> When given a sub-command that it doesn't understand, 'git
> multi-pack-index' dies with the following message:
> 
>     $ git multi-pack-index bogus
>     fatal: unrecognized subcommand: bogus
> 
> Instead of 'die()'-ing, we can display the usage text, which is much
> more helpful:
> 
>     $ git.compile multi-pack-index bogus
>     usage: git multi-pack-index [<options>] write
>        or: git multi-pack-index [<options>] verify
>        or: git multi-pack-index [<options>] expire
>        or: git multi-pack-index [<options>] repack [--batch-size=<size>]
> 
> 	--object-dir <file>   object directory containing set of packfile and pack-index pairs
> 	--progress            force progress reporting
> 
> While we're at it, clean up some duplication between the "no sub-command"
> and "unrecognized sub-command" conditionals.

I agree that it's much nicer to give the usage. But my preference in
general for cases like this is to _also_ explain what we found wrong
with the options we were given.

E.g., with a bogus option, we say so:

  $ git multi-pack-index --foo
  error: unknown option `foo'
  usage: git multi-pack-index [<options>] write [--preferred-pack=<pack>]
  [etc...]

but with a bogus sub-command, we get just the usage string:

  $ git multi-pack-index foo
  usage: git multi-pack-index [<options>] write [--preferred-pack=<pack>]
  [etc...]

Sometimes it is quote obvious what is wrong, but sometimes typos can be
hard to spot, especially because the usage message is so long.

I.e., I'd suggest changing this:

>  	else
> -		die(_("unrecognized subcommand: %s"), argv[0]);
> +usage:
> +		usage_with_options(builtin_multi_pack_index_usage,
> +				   builtin_multi_pack_index_options);

to:

  error(_("unrecognized subcommand: %s"), argv[0]);
  usage_with_options(...);

-Peff
