Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F857C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56129613D1
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhE0ODh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 10:03:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:38758 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236144AbhE0ODf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 10:03:35 -0400
Received: (qmail 4741 invoked by uid 109); 27 May 2021 14:02:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 May 2021 14:02:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3103 invoked by uid 111); 27 May 2021 14:02:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 May 2021 10:02:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 May 2021 10:02:01 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Yuri <yuri@rawbw.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
Message-ID: <YK+mWZP+sl3zXECx@coredump.intra.peff.net>
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
 <xmqq35u9ax5j.fsf@gitster.g>
 <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
 <20210527045628.uvesihyhtqrfyfae@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210527045628.uvesihyhtqrfyfae@tb-raspi4>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 27, 2021 at 06:56:28AM +0200, Torsten Bögershausen wrote:

> On Wed, May 26, 2021 at 04:41:38PM -0700, Yuri wrote:
> > On 5/26/21 4:32 PM, Junio C Hamano wrote:
> > > "git config core.quotepath no"?
> >
> >
> > I didn't have the 'core.quotepath' value set. 'git config core.quotepath no'
> > changed the behavior to no quoting.
> >
> > So it looks like the default value of 'core.quotepath' is incorrect: it
> > should be based on terminal capabilities.
> >
> 
> This are 2 different things.
> If you are in a project where only ASCII names are allowed (for whatever reason),
> you may want `git config core.quotepath no`, regardless what the terminal can do.
> 
> (Beside that, are ther terminals that don't handle UTF-8 these days?)

I don't think core.quotepath is just about UTF-8. It is agnostic to the
encoding of the paths, so it is really a question of whether to just
pass through bytes with the high bit set.

So I think the more accurate question is: do the paths in your
repositories generally contain bytes that your terminal can interpret
sensibly?  I'd guess the answer is usually yes, even if you are using
latin1 or similar (or else "ls" would show you mojibake, too).

But there's a follow-on, too: do all the other things which consume
quoted path output likewise handle it? Setting core.quotepath will
impact all parts of Git, including plumbing. So a script that parses
diff-tree output, for example, will see a difference.

I'd guess that most text-processing tools these days are reasonably
happy with high-bit chars. But if we were to flip the default, we might
see regressions with:

  - very old / obscure systems (I'd guess even old versions of GNU tools
    are good, but who knows what Solaris sed will do)

  - some scripting languages (like perl and ruby) have internal strings
    that are encoding-aware, and so they are picky about reading
    high-bit input from a descriptor, especially if it isn't utf8.
    The fix is usually easy-ish, but may be a surprise for some folks
    (OTOH, I can imagine it fixes bugs in sloppily-written scripts which
    did not anticipate the incoming filenames being quoted ;) ).

As Git is used more and more internationally, I suspect the value of
defaulting core.quotepath=no increases. And as time goes on and people
tend to standardize on utf8-aware tools and environments, the risk of
doing so decreases. So while core.quotepath=yes was a conservative
choice in 2007, it might be time to look at switching.

> Any, if you prefer UTF-8 as a default,
> 
> git config --global core.quotepath yes
> 
> is your friend (like mine)

Just a nit/clarification for other readers, but I think you have yes/no
flipped here and earlier in your message.

-Peff
