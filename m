Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335921FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 13:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbcLFNhO (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 08:37:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:52370 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753157AbcLFNhM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 08:37:12 -0500
Received: (qmail 16951 invoked by uid 109); 6 Dec 2016 13:36:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 13:36:51 +0000
Received: (qmail 13274 invoked by uid 111); 6 Dec 2016 13:37:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 08:37:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 08:36:50 -0500
Date:   Tue, 6 Dec 2016 08:36:50 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
Message-ID: <20161206133650.t7gkg4f6wzw3zxki@sigill.intra.peff.net>
References: <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611281830040.117539@virtualbox>
 <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611292128340.117539@virtualbox>
 <xmqqshqadn0f.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611301325210.117539@virtualbox>
 <xmqqlgvz6x87.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1612051126320.117539@virtualbox>
 <xmqqy3zu43yk.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1612061411000.117539@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1612061411000.117539@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 02:16:35PM +0100, Johannes Schindelin wrote:

> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Seriously, do you really think it is a good idea to have
> > > git_config_get_value() *ignore* any value in .git/config?
> > 
> > When we do not know ".git/" directory we see is the repository we were
> > told to work on, then we should ignore ".git/config" file.  So allowing
> > git_config_get_value() to _ignore_ ".git/config" before the program
> > calls setup_git_directory() does have its uses.
> 
> I think you are wrong. This is yet another inconsistent behavior that
> violates the Law of Least Surprises.

There are surprises in this code any way you turn.  If we have not
called setup_git_directory(), then how does git_config_get_value() know
if we are in a repository or not?

Should it blindly look at ".git/config"? Now your program behaves
differently depending on whether you are in the top-level of the working
tree.

Should it speculatively do repo discovery, and use any discovered config
file? Now some commands respect config that they shouldn't (e.g.,
running "git init foo.git" from inside another repository will
accidentally pick up the value of core.sharedrepository from wherever
you happen to run it).

So I think the caller of the config code has to provide some kind of
context about how it is expecting to run and how the value will be used.

Right now if setup_git_directory() or similar hasn't been called, the
config code does not look. Ideally there would be a way for a caller to
say "I am running early and not even sure yet if we are in a repo;
please speculatively try to find repo config for me".

The pager code does this manually, and without great accuracy; see the
hack in pager.c's read_early_config(). I think the way forward is:

  1. Make that an optional behavior in git_config_with_options() so
     other spots can reuse it (probably alias lookup, and something like
     your difftool config).

  2. Make it more accurate. Right now it blindly looks in .git/config,
     but it should be able to do the usual repo-detection (_without_
     actually entering the repo) to try to find a possible config file.

-Peff
