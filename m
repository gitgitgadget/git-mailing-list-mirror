Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1435DC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 04:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjD0Eqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 00:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjD0Eqg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 00:46:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877035AF
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 21:46:34 -0700 (PDT)
Received: (qmail 19291 invoked by uid 109); 27 Apr 2023 04:46:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 04:46:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16039 invoked by uid 111); 27 Apr 2023 04:46:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 00:46:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 00:46:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
Message-ID: <20230427044633.GA982277@coredump.intra.peff.net>
References: <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g>
 <xmqq355euj2i.fsf@gitster.g>
 <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
 <xmqqcz3ry2sw.fsf@gitster.g>
 <ZEhuMML6n8F+cNLg@tapette.crustytoothpaste.net>
 <20230426112508.GB130148@coredump.intra.peff.net>
 <xmqqcz3qwuj7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz3qwuj7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 08:08:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It sounds from your description that your test is running in a mode
> > where the client defaults to sha256 (though I'm not sure how, since we
> > explicitly document that GIT_DEFAULT_HASH should not affect clone), and
> > then you clone an empty sha256 repository via v0, expecting the result
> > to be sha256.
> 
> Thanks for coming up with an excellent guess that helped come up
> with a reproduction.
> 
> With Brian's patch a bit tweaked (attached below), the test does
> fail with the current 'master' and passes before the merge in
> question.  And the trace clearly shows that without being told
> anything about the object format via the capability, the client
> chooses to honor GIT_DEFAULT_HASH to initialize the new repository
> with sha256.

Ah, OK. The fact that we do respect GIT_DEFAULT_HASH there solves my
remaining confusion. And in retrospect it makes sense, because clone is
going to use the equivalent of "git init" under the hood. So we'll start
with _something_, and then adjust it based on what we read from the
other side. And that "something" respects GIT_DEFAULT_HASH.

Sort of a side note:

  This behavior is somewhat due to the fact that clone is implemented as
  "init, then fetch into the new repository". It could also conceptually
  be "talk to the remote, then init, then actually fetch". It never
  mattered before, but with options like object-format, the "init" step
  may be affected by things the remote said.

  So in our world, clone has to "fix up" parts of the repository that
  were initialized by tweaking the object-format config of the live
  repo. In a world where the very first thing it did was talk to the
  remote, then it would pass the option along to init in the first
  place.

  It's probably not worth trying to re-architect clone, though (not just
  in terms of work, but who knows what other subtle assumptions are
  baked into the current ordering). And it's not like it _solves_ this
  issue. It just might have made finding it a little less confusing.

> [Footnote]
> 
> * ... but I think it was misguided.  What it says there is this:
> 
>     And we also don't want to initialize the repository as SHA-1
>     initially, since that means if we're cloning an empty
>     repository, we'll have failed to honor the GIT_DEFAULT_HASH
>     variable and will end up with a SHA-1 repository, not a SHA-256
>     repository.
> 
> If this were "When we're cloning an empty repository, we'd have
> failed to honor the object format the other side has chosen and will
> end up with a SHA-1 repository, not a SHA-256 repository.", then it
> is very much in line with the reality before the patch under
> discussion and also in line with the official stance that "clone"
> should not honor GIT_DEFAULT_HASH.
> 
> Where the original description breaks down is when the other side is
> SHA-1 and this side has GIT_DEFAULT_HASH set to SHA-256.  If we
> honored the variable, we'd create a SHA-256 repository that will
> talk to SHA-1 repository before the rest of the system is ready.

Exactly. We are (and always have been) wrong 50% of the time in an empty
repo for v0. Your recent patch fixed v2 in an empty repo, but in doing
so flipped which halves of v0 were wrong.

-Peff
