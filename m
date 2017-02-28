Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82B1202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbdB1VeR (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:34:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:36041 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbdB1VeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:34:15 -0500
Received: (qmail 21083 invoked by uid 109); 28 Feb 2017 20:32:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 20:32:32 +0000
Received: (qmail 29975 invoked by uid 111); 28 Feb 2017 20:32:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 15:32:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 15:32:30 -0500
Date:   Tue, 28 Feb 2017 15:32:30 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Dmitry Neverov <dmitry.neverov@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: 'git submodules update' ignores credential.helper config of the
 parent repository
Message-ID: <20170228203230.bclfbjp6agufdymr@sigill.intra.peff.net>
References: <CAC+L6n0YeX_n_AysCLtBWkA+jPHwg7HmOWq2PLj75byxOZE=qQ@mail.gmail.com>
 <CAGZ79ka8saQMKeutE415WxOQ71MnEw1A4uV3b0Pa4gcehx8pdw@mail.gmail.com>
 <20170228143710.smbzo6b7wefjc62r@sigill.intra.peff.net>
 <CAGZ79kb8F9_9fd9uhfPpHVPQj-zm99qt5Tr=3TUhpe=K6JknEg@mail.gmail.com>
 <20170228200821.iojdzntjslwgrzcb@sigill.intra.peff.net>
 <CAGZ79kZ8ANzjauzJAbPh7m7zYoBrB=ZjgDXHxNb57_H=RYm8cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ8ANzjauzJAbPh7m7zYoBrB=ZjgDXHxNb57_H=RYm8cQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 12:21:57PM -0800, Stefan Beller wrote:

> > I'm still open to the idea that we simply improve the documentation to
> > make it clear that per-repo config really is per-repo, and is not shared
> > between super-projects and submodules. And then something like Duy's
> > proposed conditional config lets you set global config that flexibly
> > covers a set of repos.
> 
> How would the workflow for that look like?
> My naive thought on that is:
> 
>   (1)  $EDIT .git/config_to_be_included
>   (2)  $ git config add-config-inclusion .git/config_to_be_included
>   (3)  $ git submodule foreach git config add-inclusion-config
> .git/config_to_be_included
> 
> which sounds a bit cumbersome to me.
> So I guess we'd want some parts of that as part of another command, e.g.
> (3) could be part of (2).

I think it would be more like:

  (1) $EDIT ~/.gitconfig-super
  (2) git config --global \
        includeIf.gitdir:/path/to/super.path .gitconfig-super

I know that is probably a bit more cumbersome to figure out than
treating the super/sub relationship in a special way. But I suspect for
a lot of cases that it actually ends up even better, because the
situation is more like:

  (1) $EDIT ~/.gitconfig-work
  (2) git config --global includeIf.gitdir:~/work.path .gitconfig-work

and then it covers all of your projects in ~/work, whether they are
super-projects, submodules, or regular repos.

> I am also open and willing to document this better; but were would
> we want to put documentation? Obviously we would not want to put it
> alongside each potentially useful config option to be inherited to
> submodules. (that would imply repeating ourselves quite a lot in
> the config man page).
> 
> I guess putting it into "man gitmodules" that I was writing tentatively
> would make sense.

Yeah, I think it is worth mentioning in "gitmodules", and probably in
git-config where we define per-repo config.

It may also be worth calling it out especially for url.insteadOf, just
because it is not clear there when the URL rewriting happens (it's not
insane to think that it happens in the super-project, that just doesn't
happen to be how it's implemented).

-Peff
