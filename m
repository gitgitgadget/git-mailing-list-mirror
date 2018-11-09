Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CEE51F453
	for <e@80x24.org>; Fri,  9 Nov 2018 10:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeKIT7Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 14:59:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:45946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727537AbeKIT7P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 14:59:15 -0500
Received: (qmail 30310 invoked by uid 109); 9 Nov 2018 10:19:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Nov 2018 10:19:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16324 invoked by uid 111); 9 Nov 2018 10:18:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Nov 2018 05:18:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2018 05:19:18 -0500
Date:   Fri, 9 Nov 2018 05:19:18 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
Message-ID: <20181109101918.GC7410@sigill.intra.peff.net>
References: <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
 <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
 <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org>
 <20181107204142.GA30078@sigill.intra.peff.net>
 <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org>
 <20181107220320.GA8970@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811081408310.39@tvgsbejvaqbjf.bet>
 <CACsJy8AdRqKKFFO80p8jdMGaH6+Pj833nUEd7Xe6SWLQB=80UQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1811081639210.39@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1811081639210.39@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 08, 2018 at 04:45:16PM +0100, Johannes Schindelin wrote:

> > One thing I had in mind when proposing $VARIABLE is that it opens up a
> > namespace for us to expand more things (*) for example $GIT_DIR (from
> > ~/.gitconfig).
> > 
> > (*) but in a controlled way, it may look like an environment variable,
> > but we only accept a selected few. And it's only expanded at the
> > beginning of a path.
> 
> I understand that desire, and I even agree. But the fact that it looks
> like an environment variable, but is not, is actually a point in favor of
> *not* doing this. It would violate the principle of least astonishment.

I agree that it is potentially surprising. OTOH, it is at least pretty
obvious when you see in the wild something like:

  [core]
  foo = $RUNTIME_PREFIX/bar

what it is _trying_ to do. My big concern with "~"-based things is that
they're kind of subtle. If I saw:

  [core]
  foo = ~~/bar

I'm not sure what I would think it does. ;)

> The form `<RUNTIME_PREFIX>/abc/def` would not be confused with anything
> that it is not, I would think. The only thing against this form (at least
> that I can think of) is that some people use this way to talk about paths
> that vary between different setups, with the implicit assumption that the
> reader will "interpolate" this *before* applying. So for example, when I
> tell a user to please edit their <GIT_DIR>/config, I implicitly assume
> that they know to not type out, literally, <GIT_DIR> but instead fill in
> the correct path.

So yeah, some alternative syntax that is verbose but distinct makes
sense to me. We use %-substitution elsewhere. Could we do something with
that? "%RUNTIME_PREFIX%" gives me too many flashbacks, but something
like "%(RUNTIME_PREFIX)" matches our formatting language.

I dunno. I actually do not think "$FOO" is so bad, as long as we clearly
document that:

  - we do not allow arbitrary $FOO from the environment (though I am
    actually not all that opposed to doing so)

  - we add some special $FOOs that are not actually environment
    variables

-Peff
