Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C80C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572BD22257
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgJOBUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:20:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:60546 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgJOBUz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:20:55 -0400
Received: (qmail 19273 invoked by uid 109); 15 Oct 2020 01:20:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 01:20:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23693 invoked by uid 111); 15 Oct 2020 01:20:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 21:20:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 21:20:54 -0400
From:   Jeff King <peff@peff.net>
To:     Nipunn Koorapati <nipunn1313@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Partial clone fails with file:/// URI
Message-ID: <20201015012054.GA384995@coredump.intra.peff.net>
References: <CAN8Z4-XgctFZxZoTWRpD1V9NFr34ObzG2dxUoAfuJ4NOsBDdtg@mail.gmail.com>
 <20201014165607.GA2044338@nand.local>
 <CAN8Z4-XGbb_z3vmJYATONmBkxBcfxwyC-_4XEOkP0sxsdT9wxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN8Z4-XGbb_z3vmJYATONmBkxBcfxwyC-_4XEOkP0sxsdT9wxw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 06:04:18PM +0100, Nipunn Koorapati wrote:

> I've been building git from source and directly using the executable. Roughly
> ```
> cd git
> make
> cd ..
> git/git clone --filter=blob:none file://$(pwd)/git a_clone_of_git
> ```

Note that running a built copy directly without installing may end up
running a different version of Git under the hood. Your initial
"git/git" will run the newly built version, but it will put the
to-be-installed exec-path at the front of $PATH (probably
~/libexec/git-core if you haven't configured anything). But since you
haven't installed anything there, that won't do anything, and instead
any git subprocesses it runs (including the server-side upload-pack and
any child fetches it runs to get the blobs) will be done with whatever
version of git is in your $PATH already.

Try:

  git/bin-wrappers/git clone ...

which is a shell script that sets up the exec-path properly for running
out of the build directory.

When I run your commands, I get:

  error: Server does not allow request for unadvertised object d16e5f041f5d3ad91129c4fe6713c71727895e9c
  error: unable to read sha1 file of Documentation/RelNotes/2.1.4.txt (d16e5f041f5d3ad91129c4fe6713c71727895e9c)

and so on for each object. Some older versions of Git did not correctly
handle this situation (they asked for the object even though the server
did not claim to allow it). It was fixed in 2b69d3116f (Merge branch
'mm/fetch-show-error-message-on-unadvertised-object' into maint,
2017-03-28), I think, in v2.21.3. If your system Git is older than that,
this might be the culprit.

> This is what I was missing:
> git config uploadpack.allowanysha1inwant true

Note that you shouldn't need to do that starting with v2.29, because the
v2 protocol is the default (which always allows any sha1 to be
requested).

> If this is not set, then the checkout fails w/ a
> 
> fatal: protocol error: bad pack header
> 
> Perhaps the error message and/or docs could be improved here to
> something with more detail than "bad pack header"?

The problem is that the client is hanging up when we are trying to read
the pack header. I think in newer versions of Git this is better, as
well (the server is better about sending an over-the-wire ERR packet,
and the client is better about reading and relaying it, though there are
still some races around write() errors here).

-Peff
