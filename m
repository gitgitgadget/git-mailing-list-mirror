Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B9BC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 04:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242752AbjD0E4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 00:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjD0E4p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 00:56:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44CE3AB6
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 21:56:44 -0700 (PDT)
Received: (qmail 19376 invoked by uid 109); 27 Apr 2023 04:56:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 04:56:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16100 invoked by uid 111); 27 Apr 2023 04:56:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 00:56:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 00:56:43 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Adam Majer <adamm@zombino.com>,
        git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
Message-ID: <20230427045643.GB982277@coredump.intra.peff.net>
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g>
 <xmqq355euj2i.fsf@gitster.g>
 <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
 <xmqqcz3ry2sw.fsf@gitster.g>
 <20230426105134.GA130148@coredump.intra.peff.net>
 <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 08:40:48PM +0000, brian m. carlson wrote:

> On 2023-04-26 at 10:51:34, Jeff King wrote:
> > We could send a capabilities^{} line, which Git has supported on the
> > client side since eb398797cd (connect: advertized capability is not a
> > ref, 2016-09-09). So sending it should not break even old clients
> > (though we would have to check what alternate implementations like
> > libgit2 or dulwich do; we know JGit supports it).
> 
> I have a patch which does exactly this, which I will be sending shortly.
> I've confirmed that libgit2 and JGit support it, which is unsurprising,
> since all of the implementations, Git included, share the same code.  In
> addition, this is the behaviour we document as supporting, so all
> implementations should support it.

Yeah, I was worried about how accurate that "should" is. :)

Since you checked the others, I peeked at dulwich's code, and it appears
to support it, too (I didn't actually run a test, but the code is pretty
clear). It doesn't support sha256 at all, but that's OK. What I'd be
concerned about is breaking clients when there is no useful capability
to advertise (though of course we could decide to send capabilities^{}
only when there is something useful to say).

> > However, the object-format support here was broken until the very recent
> > 13e67aa39b (v0 protocol: fix sha1/sha256 confusion for capabilities^{},
> > 2023-04-14), so it would only be useful going forward (before then we'd
> > die(), but maybe that is preferable to having the wrong object format?).
> 
> I think it's better to die than to silently have the wrong object
> format, and it also prevents the problem if other clients using v0 or v1
> (which effectively have to be supported for compatibility, while v2 is
> optional) try to clone from a fixed server.

OK, good. So we can ignore that recently fixed bug (which only affects
the case where older versions are cloning something whose hash format
does not match theirs).

> > I'm not sure it's worth the effort, though. If you want to use sha256
> > everywhere and tell the other side about it, you need a modern client
> > anyway, and that means the ability to speak v2. So this would only
> > matter if for some reason the v2 probe was being ignored (e.g., proxies
> > eating it, ssh refusing environment variable, etc), which itself are
> > things that ideally would be fixed (and can maybe one day even go away
> > if we optimistically default to v2).
> 
> Using v2 everywhere is difficult because many SSH servers still don't
> pass GIT_PROTOCOL by default, meaning that we're stuck with v0 and v1.
> In retrospect, sending an environment variable here was not a great
> decision, but we're stuck with it now.

True (I even got bit by this at one point, not realizing that I wasn't
using v2 with one of my personal servers). I certainly don't have an
objection if you're willing to do the work.

It would also allow us to fix the long-broken "unborn HEAD" problem for
v0 in an empty repo (though I am also fine if we don't go that far).

-Peff
