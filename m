Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD7B20986
	for <e@80x24.org>; Tue,  4 Oct 2016 12:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbcJDME2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 08:04:28 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:50977 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbcJDME2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 08:04:28 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1brOSN-0002w8-24; Tue, 04 Oct 2016 14:04:23 +0200
Date:   Tue, 4 Oct 2016 14:04:21 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re: Slow pushes on 'pu' - even when up-to-date..
Message-ID: <20161004120421.GA20701@book.hvoigt.net>
References: <CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com>
 <20161004111845.GA20309@book.hvoigt.net>
 <20161004114428.4wyq54afd4td3epp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161004114428.4wyq54afd4td3epp@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 07:44:28AM -0400, Jeff King wrote:
> > My idea of a solution goes like this:
> >   * collect all SHA1's of the remotes refs
> >   * check if we have them locally
> >   * if not we abort and tell the user to fetch them somehow into local
> >     refs or disable the check
> >   * when we have them locally we proceed passing those SHA1's as bases
> >     instead of --remotes=<name>
> 
> As I argued in [1], I think it's not just "this must be cheaper" but
> "this must not be enabled if submodules are not in use at all".  Most
> repositories don't have submodules enabled at all, so anything that
> cause any extra traversal, even of a portion of the history, is going to
> be a net negative for a lot of people.
> 
> I think the only sane default is going to be some kind of heuristic that
> says "submodules are probably in use". Something like "is there a
> .gitmodules file" is not perfect (you can have gitlink entries without
> it), but it's a really cheap constant-time check.

I agree. We are adding convenience for submodules, so we can also say a
checked out ".gitmodules" file is a must to have convenience.

I am not sure if I agree on another layer of options for this as
suggested in your post. More options mean more implementation
complexity and more confusion on the users side.

How about we choose our defaults based on the existence of a checked out
.gitmodules file? So the default would only be --recurse-submodules=check
if there is a .gitmodules file in the worktree. All other users need to
either pass or explicitly configure it.

Cheers Heiko

> [1] Quoted in
>     http://public-inbox.org/git/xmqqh9aaot49.fsf@gitster.mtv.corp.google.com/
