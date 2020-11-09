Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4020EC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA16E206BE
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKIWTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:19:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:51950 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgKIWTk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:19:40 -0500
Received: (qmail 4148 invoked by uid 109); 9 Nov 2020 22:19:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Nov 2020 22:19:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27916 invoked by uid 111); 9 Nov 2020 22:19:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2020 17:19:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Nov 2020 17:19:39 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: bash: support recursive aliases
Message-ID: <20201109221939.GA670413@coredump.intra.peff.net>
References: <20201109215248.461167-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201109215248.461167-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 03:52:48PM -0600, Felipe Contreras wrote:

> It is possible to have a recursive aliases like:
> 
>   l = log --oneline
>   lg = l --graph
> 
> So the completion should detect such aliases as well.

Yeah, agreed that it would be nice to handle this case.

>  __git_aliased_command ()
>  {
> [...]
> +	if [[ -n "$found" ]]; then
> +		local expansion=$(__git_aliased_command "$found")
> +		echo "${expansion:-$found}"
> +	fi

So if we expanded X to Y, we recurse and try to expand Y. That makes
sense, but just thinking of some possible drawbacks:

 - it's an extra process invocation for each alias lookup (to see "nope,
   this doesn't expand further"). That's probably OK, since this is
   triggered by human action.

   I don't think there's a way to avoid this with the current set of Git
   commands. "git help lg" isn't recursive, and anyway isn't suitable
   for general use (if there is no such alias, it tries to load the
   manpage!).

 - there's no limit on the recursion if we do see a cycle. Doing:

     git config alias.foo foo
     git foo <Tab>

   seems to fork-bomb the system with bash processes (well, perhaps not
   a true fork-bomb because they expand linearly rather than
   exponentially, but still...).

   That's obviously a broken and useless, but the outcome is less than
   ideal.  We could avoid it by looking for repeats in the chain. Doing
   so in posix shell is pretty painful, but perhaps bash associate
   arrays would make it not too painful.

We do have "git <cmd> --git-completion-helper" these days. I wonder if
something like "git --expand-alias-to-command" would be a useful
addition, as it would let us directly ask which Git command would be
executed (if any). And it would make both downsides go away.

I don't mind this solution in the meantime, though.

-Peff
