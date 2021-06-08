Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EC9C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735F161249
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFHGPZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Jun 2021 02:15:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:48566 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhFHGPX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:15:23 -0400
Received: (qmail 27911 invoked by uid 109); 8 Jun 2021 06:13:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 06:13:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6653 invoked by uid 111); 8 Jun 2021 06:13:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 02:13:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 02:13:30 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: make -v useful
Message-ID: <YL8KiiGXF8LdGmQ2@coredump.intra.peff.net>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
 <60be41f6473e2_39c0a208f6@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <60be41f6473e2_39c0a208f6@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 10:57:42AM -0500, Felipe Contreras wrote:

> Jeff King wrote:
> > On Sat, Jun 05, 2021 at 10:18:14PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > 
> > > As for the proposal, I don't use "branch -v" all that much much, so I
> > > don't have strong knee-jerk feelings on it, but just considering it now
> > > I'd think that the current default is a fundamentally better
> > > approximation of what most users would like as a default.
> > > 
> > > I.e. I think it's fair to say that to the extent that most users have
> > > topic branches they're part of some pull-request workflow where they're
> > > always tracking the one upstream they always care about, usually
> > > origin/master.
> > 
> > I'm in the same boat. I don't use "branch -v" either, but showing the
> > upstream name wouldn't be at all helpful to me, since it they would all
> > just be "origin/master".
> 
> But this patch is not for you, it's for the majority of git users.

In the quoted text above, Ævar mentioned that many users will have a
pull-request workflow tracking one upstream. So no, I don't think it's
just for me, but anybody with that workflow.

But of course i also mentioned other workflows, like...

> > (This will vary based on workflow, but the
> > other common workflow would probably just show "topic" being based on
> > "origin/topic").
> 
> Based on what evidence?
> 
> As I showed in [1], all the top results when googling "upstream branch"
> show the upstream branch being used in the opposite way: it's set to the
> place you push to:
> 
>   git push --set-upstream @ github/my-pull-request

That's exactly what I was talking about in the quoted text above.  If
you use --set-upstream, then your local "topic" will track something
like "origin/topic".

> > So we could document them as: behave as if "--format=..." was given on
> > the command line (unfortunately "..." here is a complex set of %(if)
> > mechanisms, but it would mostly be for reference; nobody would need to
> > type it).
> 
> You mean like this?
> 
>   %(if:notequals=refs/remotes)%(refname:rstrip=-2)%(then)%(if)%(HEAD)%(then)* [32m%(else)%(if)%(worktreepath)%(then)+ [36m%(else)  %(end)%(end)%(align:34,left)%(refname:lstrip=2)%(end)[m %(objectname:short) %(if)%(upstream:track)%(then)%(upstream:track) %(end)%(contents:subject)%(else)  [31m%(align:34,left)remotes/%(refname:lstrip=2)%(end)[m%(if)%(symref)%(then) -> %(symref:short)%(else) %(objectname:short) %(contents:subject)%(end)%(end)
> 
> I don't think that's particularly useful to anyone.

I agree it's hard to follow. It's probably only useful for people who
want to modify it to create a custom format (and any documentation could
certainly explain it in human-readable terms and then make a mention of
the actual code).

> > And then it is not a far leap to change that to: behave as if --format
> > was set to the value of branch.verboseFormat, and the default of that
> > config option is "...". And then anybody can make "branch -v" behave
> > however they like.
> 
> I don't think telling users to do `git command --code="type here the
> code you want git to do"` is very user friendly.

I'm not quite sure what you think I'm proposing, but it's certainly not
that people would type in that code on the command line. It's that "-v"
would be documented to behave _as if_ that code had been used with
--format.  And then extended to use another format of the user's choice
from a config variable (which could be based on that format, if they so
chose).

Of course they can do that already with an alias. The only thing I'm
actually suggesting is making "-v" configurable.

> But even if that was implemented, the whole point of this patch is about
> what the default value of branch.verboseFormat should be.

I'm saying that I find your proposed value for that default to be
useless, and I suspect many other users will, too. Which is why making
it configurable may actually help people.

> Do I need to produce a list of the top 10 Google results of
> "git branch -v" vs. "git branch -vv", to show that most people don't
> find the output of -v useful?
> 
> Or what kind of evidence would satisfy you?

Don't bother on my account. I have generally found that going more than
one round deep of discussion with you does not lead anywhere productive,
and I don't intend to continue this thread.

-Peff
