Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AE1720401
	for <e@80x24.org>; Wed, 14 Jun 2017 06:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbdFNGgR (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 02:36:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:39737 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbdFNGgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 02:36:16 -0400
Received: (qmail 3015 invoked by uid 109); 14 Jun 2017 06:36:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 06:36:15 +0000
Received: (qmail 8714 invoked by uid 111); 14 Jun 2017 06:36:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 02:36:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 02:36:14 -0400
Date:   Wed, 14 Jun 2017 02:36:14 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] add: warn when adding an embedded repository
Message-ID: <20170614063614.a34ovimjpz2g24qe@sigill.intra.peff.net>
References: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
 <20170613092408.db22ygki6wg2t23d@sigill.intra.peff.net>
 <CAGZ79kbbTwQicVkRs51fV91R_7ZhDtC+FR8Z-SQzRpF2cjFfag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbbTwQicVkRs51fV91R_7ZhDtC+FR8Z-SQzRpF2cjFfag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 10:07:43AM -0700, Stefan Beller wrote:

> > I also waffled on whether we should ask the submodule code
> > whether it knows about a particular path. Technically:
> >
> >   git config submodule.foo.path foo
> >   git config submodule.foo.url git://...
> >   git add foo
> >
> > is legal, but would still warn with this patch. I don't know
> > how much we should care (it would also be easy to do on
> > top).
> 
> And here I was thinking this is not legal, because you may override
> anything *except* submodule.*.path in the config. That is because
> all the other settings (such as url, active flag, branch,
> shallow recommendation) are dependent on the use case, the user,
> changes to the environment (url) or such. The name<->path mapping
> however is only to be changed via changes to the tracked content.
> That is why it would make sense to disallow overriding the path
> outside the tracked content.

It was probably a mistake to use normal config as the example. Junio
mentioned it as a case that could work if you communicate the submodule
URL to somebody else out-of-band. My understanding was that you could
set whatever you like in the regular config, but I think that is just
showing my ignorance of submodules.

Pretend like I said "-f .gitmodules" in each line above. ;)

> In my ideal dream world of submodules we would have the following:
> 
>   $ cat .gitmodules
>   [submodule "sub42"]
>     path = foo
>   # path only in tree!

TBH, I am not sure why we need "path"; couldn't we just use the
subsection name as an implicit path?

> > +       OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
> > +                       N_("warn when adding an embedded repository")),
> 
> We do not have a lot of OPT_HIDDEN_BOOLs throughout the code base.
> We should use them more often.
> 
> It makes sense though in this case.

Actually, my main reason is that it's nonsense to show
"--warn-embedded-repo" in the help, when it's already the default. I
would like to have written:

  OPT_NEGBOOL(0, "no-warn-embedded-repo", &warn_on_embedded_repo,
		N_("disable warning when adding an embedded repository"))

but we don't have such a thing (and the last discussion on it a few
months ago left a lot of open questions). So given that this really
isn't something I'd expect users to want, I figured hiding it was a good
idea. I mentioned it in the manpage for script writers, but it's really
not worth cluttering "git add -h".

> > +static const char embedded_advice[] = N_(
> > +"You've added another git repository inside your current repository.\n"
> > +"Clones of the outer repository will not also contain the contents of\n"
> > +"the embedded repository. If you meant to add a submodule, use:\n"
> 
> The "will not also" sounds a bit off to me. Maybe:
>   ...
>   Clones of the outer repository will not contain the contents
>   of the embedded repository and has no way of knowing how
>   to obtain the inner repo. If you meant to add a submodule ...

Yeah, I think we could just strike the "also" (I played around with the
wording here quite a bit and I think it was left from an earlier attempt
where it made more sense).

Your "no way of knowing" is probably a good thing to mention.

> > +"See \"git help submodule\" for more information."
> 
> Once the overhaul of the submodule documentation
> comes along[1], we rather want to point at
> "man 7 git-submodules", which explains the concepts and
> then tell you about commands how to use it. For now the
> git-submodule man page is ok.
> 
> [1] https://public-inbox.org/git/20170607185354.10050-1-sbeller@google.com/

Yeah, I poked around looking for a definitive "here's how submodules
work" intro. I'm happy one is in the works, and I agree this should
point there once it exists.

> > +++ b/t/t7414-submodule-mistakes.sh
> > @@ -0,0 +1,40 @@
> > +#!/bin/sh
> > +
> > +test_description='handling of common mistakes people may make with submodules'
> 
> That is one way to say it. Do we have other tests for
> "you think it is a bug, but it is features" ? ;)
> I like it though. :)

Heh. I didn't know how else to lump it together. Just "test git add on a
repository" felt like too little for its own script. I almost added it
to t7400, but I think that script is plenty long enough as it is (it's
also one of the longest-running scripts, I think).

> > +test_expect_success 'create embedded repository' '
> > +       git init embed &&
> > +       (
> > +               cd embed &&
> > +               test_commit one
> > +       )
> 
> shorter via:
> 
>   test_create_repo embed &&
>   test_commit -C embed one
> 
> (and saves a shell IIRC)

Right, I forgot we added -C there. Will change.

> Thanks for these tests.
> 
> This patch looks good to me, apart from the perceived wording nits.

Thanks. I'll re-roll with a few tweaks based on your feedback.

-Peff
