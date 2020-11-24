Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFD2C64E7A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 07:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9816C20684
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 07:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgKXHTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 02:19:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:39866 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729951AbgKXHTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 02:19:55 -0500
Received: (qmail 32508 invoked by uid 109); 24 Nov 2020 07:19:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 07:19:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11967 invoked by uid 111); 24 Nov 2020 07:19:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Nov 2020 02:19:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Nov 2020 02:19:53 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Pick the right default and stop warn on `git pull`
Message-ID: <X7y0GbBQa0a5Alh0@coredump.intra.peff.net>
References: <20201123202003.GB132317@mit.edu>
 <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
 <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
 <X7xWSs3/vVqKl6sK@coredump.intra.peff.net>
 <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
 <X7xgow4pchnhf2iY@coredump.intra.peff.net>
 <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
 <X7xw0xb9UnGKbS8m@coredump.intra.peff.net>
 <CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 09:41:05PM -0600, Felipe Contreras wrote:

> What we really need is something like:
> 
> 1. git pull # fail by default unless it's a fast-forward
> 2. git pull --merge # force a merge (unless it's a fast-forward,
> depending on pull.ff)
> 3. git pull --rebase # force a rebase (unless it's a fast-forward,
> depending on pull.ff)
> 
> Therefore, what we really want is "git pull --rebase" *ignore*
> "pull.ff=only" (a possible default) or ignore "pull.rebase=ff-only"
> (also another possible default).

Yep. After reading the first half of your mail, I started to respond
with the exact same thing. The key thing is letting the command-line
options override all of the related config. But I guess after reading to
the end that you don't actually like this. ;)

I do agree it would be more clear in the long run with a single option
(config and command-line) that makes it clear the values are mutually
exclusive. I'm just not sure if it's painful to get there without
breaking compatibility or introducing confusion in the meantime.

> It would be possible to do something like:
> 
>   if (!opt_rebase && (!opt_ff || !strcmp(opt_ff, "--ff-only")))
>     turn_default_behavior = 1;
> 
> But then how would we distinguish between "git pull", and "git pull
> --no-rebase" (aka. "git pull --merge" / "pull.rebase=false")?

I'm not sure what you mean. We can tell the difference between those
based on what we saw on the command-line option. I.e., your
"!opt_rebase" is really a tri-state, which allows something like:

  if (opt_rebase == REBASE_UNSET) {
          if (opt_ff == FF_UNSET)
	          opt_ff = ff_default; /* from config or baked-in */
	  }
	  opt_rebase = rebase_default;
  }

but I didn't look at the logic in git-pull.

That said...

> This is just too much unnecessary complication There's no need to
> entertain a dozen possible heuristics to avoid "pull.mode", none of
> which avoid breaking existing behavior.
> 
> Let's just accept we need push.mode, and then we can have everything:
> default, ff-only, merge, rebase.

I think it could be possible for the documentation to make clear the
interactions, especially if the feature is designed with eventual
deprecation of other options (e.g., if it says "pull.mode=ff-only" means
that pull.ff won't be examined, and there's no need to ever use it
anymore).

-Peff
