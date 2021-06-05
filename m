Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D4BC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EE46139A
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFEWhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 18:37:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:47008 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhFEWhX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 18:37:23 -0400
Received: (qmail 16386 invoked by uid 109); 5 Jun 2021 22:35:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Jun 2021 22:35:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20262 invoked by uid 111); 5 Jun 2021 22:35:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Jun 2021 18:35:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 5 Jun 2021 18:35:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: make -v useful
Message-ID: <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czt059sn.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 05, 2021 at 10:18:14PM +0200, Ævar Arnfjörð Bjarmason wrote:

> As for the proposal, I don't use "branch -v" all that much much, so I
> don't have strong knee-jerk feelings on it, but just considering it now
> I'd think that the current default is a fundamentally better
> approximation of what most users would like as a default.
> 
> I.e. I think it's fair to say that to the extent that most users have
> topic branches they're part of some pull-request workflow where they're
> always tracking the one upstream they always care about, usually
> origin/master.

I'm in the same boat. I don't use "branch -v" either, but showing the
upstream name wouldn't be at all helpful to me, since it they would all
just be "origin/master". (This will vary based on workflow, but the
other common workflow would probably just show "topic" being based on
"origin/topic").

> The -v output showing the ahead/behind relationship to that branch
> without naming it is thus the best use of the limited space we have, and
> with a bit more verbosity under -vv we'd show the (usually the same for
> all of those) upstream name.

The notion of what to show for a verbose format may depend on workflow,
or even what the user's currently interested in. These days we have
--format to give much more flexible output.

The "-v" and "-vv" options predate --format, but these days are
implemented on top of it (they literally build a format string that's
passed into ref-filter.c's interpreter).

So we could document them as: behave as if "--format=..." was given on
the command line (unfortunately "..." here is a complex set of %(if)
mechanisms, but it would mostly be for reference; nobody would need to
type it).

And then it is not a far leap to change that to: behave as if --format
was set to the value of branch.verboseFormat, and the default of that
config option is "...". And then anybody can make "branch -v" behave
however they like.

It would break scripts that parse "branch -v", of course, but we've been
pretty explicit that this is porcelain (and the plumbing option is
for-each-ref).

> For what it's worth I remember some past discussion where it was
> discussed to have some human-readable cut-off so instead of saying:
> 
>     ahead 2, behind 38741
> 
> We'd just fall back on saying "behind lots" once your number of behind
> reached some limit (which could dynamically compute as a heuristic based
> on repo size, just like the abbrev length)..

There's some discussion in the sub-thread starting here:

  https://lore.kernel.org/git/7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com/

I do like that direction, but it sounds like there's some complexity
(maybe less these days if we can rely on having commit-graphs with
generation numbers). There is an AHEAD_BEHIND_QUICK flag, but I think it
can only be triggered via "git status --no-ahead-behind" (and it's kind
of unsatisfying, as it only tells you whether the two tips are identical
or not).

-Peff
