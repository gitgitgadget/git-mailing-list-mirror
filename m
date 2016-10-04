Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075971F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 11:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbcJDLoc (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 07:44:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:51863 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752557AbcJDLoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 07:44:32 -0400
Received: (qmail 13581 invoked by uid 109); 4 Oct 2016 11:44:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 11:44:31 +0000
Received: (qmail 3147 invoked by uid 111); 4 Oct 2016 11:44:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 07:44:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 07:44:28 -0400
Date:   Tue, 4 Oct 2016 07:44:28 -0400
From:   Jeff King <peff@peff.net>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Slow pushes on 'pu' - even when up-to-date..
Message-ID: <20161004114428.4wyq54afd4td3epp@sigill.intra.peff.net>
References: <CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com>
 <20161004111845.GA20309@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161004111845.GA20309@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 01:18:45PM +0200, Heiko Voigt wrote:

> On Mon, Oct 03, 2016 at 02:11:36PM -0700, Linus Torvalds wrote:
> > This seems to be because I'm now on 'pu' as of a day or two ago in
> > order to test the abbrev logic, but lookie here:
> > 
> >     time git ls-remote ra.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux
> >     .. shows all the branches and tags ..
> >     real 0m0.655s
> >     user 0m0.011s
> >     sys 0m0.004s
> > 
> > so the remote is fast to connect to, and with network connection
> > overhead and everything, it's just over half a second. But then:
> > 
> >     time git push ra.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux
> 
> The reason behind this is when pushing to an address we do not easily
> have the remote refs to compare available. When pushing an existing ref
> it would be easy and could get a shortcut but it gets more complicated
> for new refs. Currently we fall back to walking the whole history since
> that is "the most correct way" we have. But obviously it is not a
> practical solution in any way.
> 
> I mentioned this fact when discussing the current state and my patches
> to make this check less painful. So we still need to think about a
> solution for this check when passing an address.
> 
> IMO: It's definitely not ready to be switched on as default, unless we
> find something a lot cheaper for the above case.
> 
> My idea of a solution goes like this:
>   * collect all SHA1's of the remotes refs
>   * check if we have them locally
>   * if not we abort and tell the user to fetch them somehow into local
>     refs or disable the check
>   * when we have them locally we proceed passing those SHA1's as bases
>     instead of --remotes=<name>

As I argued in [1], I think it's not just "this must be cheaper" but
"this must not be enabled if submodules are not in use at all".  Most
repositories don't have submodules enabled at all, so anything that
cause any extra traversal, even of a portion of the history, is going to
be a net negative for a lot of people.

I think the only sane default is going to be some kind of heuristic that
says "submodules are probably in use". Something like "is there a
.gitmodules file" is not perfect (you can have gitlink entries without
it), but it's a really cheap constant-time check.

-Peff

[1] Quoted in
    http://public-inbox.org/git/xmqqh9aaot49.fsf@gitster.mtv.corp.google.com/
