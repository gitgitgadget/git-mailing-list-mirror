Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D6311F42D
	for <e@80x24.org>; Tue, 29 May 2018 21:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966722AbeE2VPg (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 17:15:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:55718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933907AbeE2VPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 17:15:25 -0400
Received: (qmail 3116 invoked by uid 109); 29 May 2018 21:15:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 May 2018 21:15:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30727 invoked by uid 111); 29 May 2018 21:15:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 May 2018 17:15:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2018 17:15:23 -0400
Date:   Tue, 29 May 2018 17:15:23 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
Message-ID: <20180529211523.GA7964@sigill.intra.peff.net>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
 <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com>
 <20180524192214.GA21535@sigill.intra.peff.net>
 <20180524193105.GB21535@sigill.intra.peff.net>
 <ae75f388-edbc-8f00-e98c-825027a58c1c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae75f388-edbc-8f00-e98c-825027a58c1c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 27, 2018 at 12:15:40AM +0530, Kaartic Sivaraam wrote:

> > Hmm, actually, I suppose the true value of the warning is to help people
> > doing "git branch -l foo", and it would still work there. The "more
> > extreme" from your suggested patch would only affect "branch -l".
> > 
> > Still, I think I prefer the gentler version that we get by keeping it as
> > a warning even in the latter case.
> >
> 
> I never wanted to suppress the warning message in the latter case. I
> just wanted to avoid listing the branches. Actually the patch I sent in
> one the previous threads[1] that avoids listing the branches has the
> following behaviour,
> 
> $ git branch -l
> warning: the '-l' alias for '--create-reflog' is deprecated;
> warning: it will be removed in a future version of Git
> usage: git branch [<options>] [-r | -a] [--merged | --no-merged]
>    or: git branch [<options>] [-l] [-f] <branch-name> [<start-point>]
>    or: git branch [<options>] [-r] (-d | -D) <branch-name>...
>    or: git branch [<options>] (-m | -M) [<old-branch>] <new-branch>
>    or: git branch [<options>] (-c | -C) [<old-branch>] <new-branch>
>    or: git branch [<options>] [-r | -a] [--points-at]
>    or: git branch [<options>] [-r | -a] [--format]
> 
> 
> So, the warning message isn't lost. It just prevents the listing of
> branches.

Right, what I meant by "gentler" is that we continue to perform the same
behavior as the old version, alongside the warning. It's arguable here
because running "git branch -l" has _always_ been wrong. It's just wrong
in a way that happens to do what the user wants. ;)

> Wait, maybe I'm misunderstanding what you mean by "warning". You're
> probably meaning something related to the way Git exits in both cases.
> With your patch "git branch -l" prints a warning, lists the branches and
> has an exit status of 0. With my patch it prints the warning, the usage
> specifications with exit status 128. In that case, I still don't think
> it's bad to turn "git branch -l" into an error now as it's been
> incorrect for a long time now and it's not wrong if we correct it now.
> 
> Anyways, if you think it mustn't turn into an error now and only in the
> next stage, a suggestion follows in another thread.

I don't think "mustn't", but I have a slight preference for what I
posted, as I think it is a little friendlier during the transition (at
the risk of somebody missing the warning, but then step 2 turns it into
a hard error anyway, so they'll certainly find out then).

-Peff
