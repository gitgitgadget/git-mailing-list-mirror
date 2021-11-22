Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DDDC433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhKVSlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:41:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:36552 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240330AbhKVSlH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:41:07 -0500
Received: (qmail 21996 invoked by uid 109); 22 Nov 2021 18:37:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 18:37:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23521 invoked by uid 111); 22 Nov 2021 18:37:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 13:37:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 13:37:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Message-ID: <YZvjhF+KM/gzu7vN@coredump.intra.peff.net>
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
 <xmqqfsrplz3z.fsf@gitster.g>
 <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
 <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
 <20211122164635.6zrqjqow4xa7idnn@cyberdelia>
 <xmqqk0h0gjnh.fsf@gitster.g>
 <xmqq35nogijg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35nogijg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 10:19:15AM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I know $GIT_PAGER trumps core.pager, which indicates between
> > equivalents, environment is taken as a stronger wish.  But I do not
> > mind if the order were updated to pager.<cmd> trumps $GIT_PAGER,
> > which in turn trumps core.pager, which in turn trumps $PAGER.
> 
> If such a precedence order makes it impossible to override a
> configured pager.<cmd> value at runtime, then it is a bad idea.  But
> luckily, we can do
> 
>     git -c "pager.<cmd>=<this one-shot pager>" cmd ...
> 
> to override a configured one, so perhaps it is OK.
> 
> I tend to agree with opinions I read elsewhere in this thread that
> it would be better not to do the fallback in the first place, but
> in this case, what I said I am OK with is when pager.<cmd> is
> defined, we do not even look at $GIT_PAGER or later choices, which
> is orthogonal.

FWIW, I also scratched my head while looking at this topic over seeing
$GIT_PAGER take precedence over a command-specific pager.

I do wonder if changing the override behavior would end up breaking some
scripted uses, though. E.g., imagine some program which does custom
markup of Git output, and ships with a wrapper script like:

  $ cat pretty-git
  #!/bin/sh
  GIT_PAGER='markup-git-output | less' "$@"

  $ pretty-git log -p

which would now behave differently if the user has pager.log set.

I dunno. That is perhaps a bit far-fetched. Most tools that I know of
like that (diff-highlight and diff-so-fancy) just tell you to set up
pager.log in the first place.

Just grepping around on GitHub, I don't see many uses, but this one[1] for
example might get confused:

  export GIT_PAGER=cat # disable pager when running interactively

So I dunno. It is probably unlikely to have much fallout. On the other
hand, I kind of wonder if the benefit is worth changing now.

-Peff

[0] https://github.com/node-inspector/node-inspector/blob/79e01c049286374f86dd560742a614019c02402f/tools/git-changelog.sh#L38
