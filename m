Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479E4C4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 19:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2699961262
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 19:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhHVT3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 15:29:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:55626 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhHVT3j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 15:29:39 -0400
Received: (qmail 4499 invoked by uid 109); 22 Aug 2021 19:28:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Aug 2021 19:28:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22662 invoked by uid 111); 22 Aug 2021 19:28:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Aug 2021 15:28:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Aug 2021 15:28:56 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Daniel P." <danpltile@gmail.com>, git@vger.kernel.org
Subject: Re: Git is removing . from the last part of user.name
Message-ID: <YSKleNynVrWWyyML@coredump.intra.peff.net>
References: <CAL-s8C7makcRT_ufsv4THSrKeDkXfhFoAXSBKSiK5w0anMvZag@mail.gmail.com>
 <YSJuS1OoYsqgpF3j@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YSJuS1OoYsqgpF3j@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 22, 2021 at 03:33:31PM +0000, brian m. carlson wrote:

> On 2021-08-22 at 14:19:33, Daniel P. wrote:
> > If user.name's  value has a . as the last character of the last part
> > of the name, git is removing it from commit operations. But git-config
> > shows the .
> > 
> > example:
> > 
> > in .gitconfig:
> > 
> > [user]
> >     name = Daniel P.
> > 
> > 
> > `git config user.name`:
> > 
> > user.name=Daniel P.
> > 
> > 
> > from `git show`:
> > 
> > Author: Daniel P <danpltile@gmail.com>
> 
> Yes, it does appear we do that.  We consider a period to be "crud" and
> strip off trailing crud.  I think we should probably change that, since
> in some places people write their family name first, and so a name like
> “carlson brian m.” might be a thing people might want to write, in
> addition to this particular case.
> 
> In any event, it's not very polite to "correct" people's names for them.
> I myself have certainly run into that often enough.

A lot of this name-cleanup code came from an era where we were inferring
names from gecos fields or from hacky email parsing.

I agree that if somebody has given us a definite name via config, we
should mostly leave it intact (the exception being syntactic elements
like <>). But we may still want to keep some of the "crud" cleanup when
we are pulling from those other sources.

OTOH, this crud stuff goes all the way back to 5e5128ed1c (Remove
extraneous ',' ';' and '.' characters from the full name gecos field.,
2005-04-17). We warn in pretty big letters these days about pulling an
ident from gecos, and our rfc822 parsing is more robust than it once
was. So it may be time to just retire most of it. The unfortunate thing
is we won't know how many people complain until it's released.

On a somewhat lesser note, I'm tempted to say that "." probably was
never that useful (compared to say, comma, which is the gecos
separator), and we could probably just drop it from the crud list.

-Peff
