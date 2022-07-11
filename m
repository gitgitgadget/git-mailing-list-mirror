Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBFFC433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 13:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiGKNjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 09:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiGKNjH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 09:39:07 -0400
Received: from dalaran.tastycake.net (dalaran.tastycake.net [IPv6:2001:ba8:0:1c0::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4BA41D10
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 06:39:05 -0700 (PDT)
Received: from c.a.1.d.d.f.6.c.f.8.d.f.b.e.b.6.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:de15:20ad:6beb:fd8f:c6fd:d1ac] helo=lucy.dinwoodie.org)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <adam@dinwoodie.org>)
        id 1oAtcr-00051s-TD; Mon, 11 Jul 2022 14:39:01 +0100
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1oAtcq-001o94-Ta; Mon, 11 Jul 2022 14:39:01 +0100
Date:   Mon, 11 Jul 2022 14:39:00 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: t0301-credential-cache test failure on cygwin
Message-ID: <CA+kUOak29RkU-ooMgOz8yCg9-q6vb1VfdP8_VLay_V650ttwjA@mail.gmail.com>
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
 <xmqqtu7t30uv.fsf@gitster.g>
 <4529b11a-e514-6676-f427-ffaec484e8f1@ramsayjones.plus.com>
 <CA+kUOakjnOxs_FGojdZXaiaY4+68pvyBHsbue+AQHp7PLXqNJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+kUOakjnOxs_FGojdZXaiaY4+68pvyBHsbue+AQHp7PLXqNJw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 11 Jul 2022 at 08:50, Adam Dinwoodie <adam@dinwoodie.org> wrote:
>
> On Thu, 7 Jul 2022 at 16:17, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> > [
> > Jeff: sorry for not CC:-ing you on the original email - I had intended
> > to do just that, but forgot! :(
> >
> > See: https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/
> > ]
> >
> > On 07/07/2022 07:15, Junio C Hamano wrote:
> > > Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> > >
> > >> However, I had some time to kill tonight, so I decided to take a _quick_ look
> > >> to see if there was something that could be done ... (famous last words).
> > >> ...
> > >>   diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
> > >>   index 78c02ad531..84fd513c62 100644
> > >>   --- a/builtin/credential-cache.c
> > >>   +++ b/builtin/credential-cache.c
> > >>   @@ -27,7 +27,7 @@ static int connection_fatally_broken(int error)
> > >>
> > >>    static int connection_closed(int error)
> > >>    {
> > >>   -  return (error == ECONNRESET);
> > >>   +  return (error == ECONNRESET) || (error == ECONNABORTED);
> > >>    }
> > >
> > > This feels like papering over the problem.
> >
> > Agreed, ... which is what I really meant by "(Well, it side-steps the
> > problem, really)."
> >
> > >> Having noticed that the 'timeout' test was not failing, I decided to try
> > >> making the 'action=exit' code-path behave more like the timeout code, as
> > >> far as exiting the server is concerned. Indeed, you might ask why the
> > >> timeout code doesn't just 'exit(0)' as well ...
> > >>
> > >> Anyway, the following patch does that, and it also provides a 'fix' for this
> > >> issue!
> > >
> > > If this codepath was written like this (i.e. [PATCH 1C]) from the
> > > beginning, I would have found it very sensible (i.e. instead of
> > > caling exit() in the middle of the infinite client serving loop,
> > > exiting the loop cleanly is easier to follow and maintain), even if
> > > we didn't know the issue on Cygwin you investigated.
> >
> > Yep, apart from the variable name, I quite like the approach taken by
> > the 1C patch.
> >
> > All three of these patches were really just "showing my working" and
> > allowing anyone to "follow along" without the hassle of trying to
> > scrape the diffs from the email.
> >
> > As I said, I don't think we can determine a suitable fix without first
> > finding the cygwin commit which caused this test failure. But if we
> > can't determine this, for whatever reason, then I would favour a patch
> > to git based on the 1C patch. (Writing the commit message to justify the
> > change, without mentioning this cygwin issue, may be more challenging! :)
>
> I've been trying to dig into this; I've essentially never played with
> the code for Cygwin itself until now, but I suspect I'm probably one of
> the best-placed folks to actually do that investigation.
>
> Unfortunately, I've gone as far back as 18 December 2020 in the code for
> the Cygwin DLL itself, and I'm still seeing t0301 failing in exactly the
> same way.  There's a few possible explanations for that, but my guess is
> either (a) the issue isn't in the Cygwin DLL itself but in some other
> library that was updated around the same time, or (b) I'm not managing
> as clean a build as I'm aiming for, and my builds of the old Cygwin
> commits are being polluted by something in my current environment.
>
> Either way I think I can make progress: my next step is to (temporarily)
> give up on bisecting by commit in the repository that tracks the Cygwin
> DLL, and instead bisect by time using the Cygwin Time Machine, which
> should let me get an entire Cygwin environment as it would have been at
> some point in the past.

Minor progress update: I've now confirmed the failure was introduced by
a change in the Cygwin library between the binaries for Cygwin versions
3.2.0-1 and 3.3.1-1. Specifically, the test passes with Cygwin from the
27 October 2021 package archive[0], and fails with Cygwin from the 28
October 2021 archive[1], and the only difference between the two that
has any chance of being relevant is that bump in the Cygwin release.

Having confirmed that, I'll go back to trying to get the Cygwin builds
to work for me, so I can bisect the commit history between those
releases.

[0]: http://ctm.crouchingtigerhiddenfruitbat.org/pub/cygwin/circa/64bit/2021/10/27/155642/index.html
[1]: http://ctm.crouchingtigerhiddenfruitbat.org/pub/cygwin/circa/64bit/2021/10/28/174906/index.html
