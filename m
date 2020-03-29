Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570D3C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345FF20733
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgC2Ow0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:52:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:54930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727167AbgC2Ow0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 10:52:26 -0400
Received: (qmail 2197 invoked by uid 109); 29 Mar 2020 14:52:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 29 Mar 2020 14:52:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9231 invoked by uid 111); 29 Mar 2020 15:02:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Mar 2020 11:02:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 29 Mar 2020 10:52:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib-functions: make packetize() more efficient
Message-ID: <20200329145224.GA15400@coredump.intra.peff.net>
References: <20200327080210.GA604725@coredump.intra.peff.net>
 <20200327080300.GA605934@coredump.intra.peff.net>
 <xmqq1rpdhaid.fsf@gitster.c.googlers.com>
 <20200328112010.GC639140@coredump.intra.peff.net>
 <xmqqh7y8c94g.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7y8c94g.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 05:11:59PM -0700, Junio C Hamano wrote:

> >  - we do use it in t9010, which is /bin/sh (and have since 2010). I
> >    thought it might not be run on obscure platforms because it's
> >    svn-related, but I think it doesn't actually require svn.
> 
> I do not think I ran git-svn stuff myself for the past 10 years,
> though, after a few projects that matter to me migrated away from
> svn ;-)

Me either. I don't even run the git-svn tests, usually. t9010 is about
the svn fast-importer, though. We've all been running its tests for
years, even though AFAIK it's not really used for anything.

> The largest issue (which is not that large, though) I felt with the
> approach when I saw the patch for the first time was that we need
> the big warning comment before the helper, i.e.
> 
> > +# Note that data containing NULs must be given on stdin,...
> 
> But after thinking about it a bit more, I think it is probably OK.
> I do not think you can assign a string with NUL in it to a variable
> and you can use "$(command substitution)" as an argument to the
> helper to pass such a string, either (not portably anyway).  If such
> a string cannot be made into "$*", ${#packet} won't have to worry
> about counting bytes in a string with NUL in it to begin with, so
> the above note won't even be necessary (it would have to say "you
> cannot pass data containing NULs as arguments---you are welcome to
> try, but you won't be able to do so, not portably anyway"), anyway
> ;-).

Yes. You could probably screw yourself with:

  packetize "$(printf "0020git-upload-pack\0host=example.com")"

but presumably you'd quickly notice when your test fails (both dash and
bash just drop the NUL byte entirely, and bash even issues a warning).

-Peff
