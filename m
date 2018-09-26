Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1DF1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeI0BDf (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 21:03:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:60498 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726107AbeI0BDf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 21:03:35 -0400
Received: (qmail 18755 invoked by uid 109); 26 Sep 2018 18:49:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Sep 2018 18:49:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21158 invoked by uid 111); 26 Sep 2018 18:48:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 26 Sep 2018 14:48:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2018 14:49:15 -0400
Date:   Wed, 26 Sep 2018 14:49:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
Message-ID: <20180926184914.GC30680@sigill.intra.peff.net>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 08:16:36AM -0700, Junio C Hamano wrote:

> > This introduces a help.followAlias config option that transparently
> > redirects to (the first word of) the alias text (provided of course it
> > is not a shell command), similar to the option for autocorrect of
> > misspelled commands.
> 
> While I do agree with you that it would sometimes be very handy if
> "git cp --help" behaved identically to "git cherry-pick --help" just
> like "git cp -h" behaves identically to "git cherry-pick -h" when
> you have "[alias] cp = cherry-pick", I do not think help.followAlias
> configuration is a good idea.  I may know, perhaps because I use it
> all the time, by heart that "cp" is aliased to "cherry-pick" and
> want "git cp --help" to directly give me the manpage, but I may not
> remember if "co" was commit or checkout and want to be concisely
> told that it is aliased to checkout without seeing the full manpage.
> Which means you'd want some way to command line override anyway, and
> having to say "git -c help.followAlias=false cp --help" is not a
> great solution.
> 
> If we expect users to use "git cp --help" a lot more often than "git
> help cp" (or the other way around), one way to give a nicer experience
> may be to unconditionally make "git cp --help" to directly show the
> manpage of cherry-pick, while keeping "git help cp" to never do
> that.  Then those who want to remember what "co" is aliased to can
> ask "git help co".

I like that direction much better. I also wondered if we could leverage
the "-h" versus "--help" distinction. The problem with printing the
alias definition along with "--help" is that the latter will start a
pager that obliterates what we wrote before (and hence all of this delay
trickery).

But for "-h" we generally expect the command to output a usage message.

So what if the rules were:

  - "git help cp" shows "cp is an alias for cherry-pick" (as it does
    now)

  - "git cp -h" shows "cp is an alias for cherry-pick", followed by
    actually running "cherry-pick -h", which will show the usage
    message. For a single-word command that does very little, since the
    usage message starts with "cherry-pick". But if your alias is
    actually "cp = cherry-pick -n", then it _is_ telling you extra
    information. And this could even work with "!" aliases: we define
    it, and then it is up to the alias to handle "-h" sensibly.

  - "git cp --help" opens the manpage for cherry-pick. We don't bother
    with the alias definition, as it's available through other means
    (and thus we skip the obliteration/timing thing totally).

    This really only works for non-! aliases. Those would continue to
    show the alias definition.


> If you have "[alias] cp = cherry-pick -n", split_cmdline discards
> "-n" and the follow-alias prompt does not even tell you that it did
> so, and you get "git help cherry-pick".  This code somehow expects
> you to know to jump to the section that describes the "--no-commit"
> option.  I do not think that is a reasonable expectation.
> 
> When you have "[alias] cp = cherry-pick -n", "git cp --help" should
> not do "git help cherry-pick".  Only a single word that exactly
> matches a git command should get this treatment.

I'm not sure I agree. A plausible scenario (under the rules I gave
above) is:

  $ git cp -h
  'cp' is aliased to 'cherry-pick -n'
  usage: git cherry-pick ...

  $ git cp --help

I.e., you already know the "-n" part, and now you want to dig further.
Of course one could just type "git cherry-pick --help" since you also
know that, too. But by that rationale, one could already do:

  $ git help cp
  $ git help cherry-pick

without this patch at all.

-Peff
