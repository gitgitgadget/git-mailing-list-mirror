Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B49C636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 19:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjBVTee (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 14:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVTed (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 14:34:33 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71401259F
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 11:34:32 -0800 (PST)
Received: (qmail 14761 invoked by uid 109); 22 Feb 2023 19:34:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Feb 2023 19:34:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10517 invoked by uid 111); 22 Feb 2023 19:34:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Feb 2023 14:34:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Feb 2023 14:34:31 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
Message-ID: <Y/ZuR9zs3peUfO0g@coredump.intra.peff.net>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net>
 <CAJoAoZmMQ-ROdCp0=4oaFa836-PqxwYntnRSBSzzJc5chp16eQ@mail.gmail.com>
 <Y/ACqlhtLMjfgJFQ@tapette.crustytoothpaste.net>
 <CAJoAoZkMR9Acy7thVs-_e=Fz8wwjoDGDKb46wmwn8yxk0ODGow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZkMR9Acy7thVs-_e=Fz8wwjoDGDKb46wmwn8yxk0ODGow@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 02:49:51PM -0800, Emily Shaffer wrote:

> > Personally, I'd like to see some sort of standard error type (whether
> > integral or not) that would let us do more bubbling up of errors and
> > less die().  I don't know if that's in the cards, but I thought I'd
> > suggest it in case other folks are interested.
> 
> Yes!!! We have talked about this a lot internally - but this is one
> thing that will be difficult to introduce into Git without making
> parts of the codebase a little uglier. Since obviously C doesn't have
> an intrinsic to do this, we'll have to roll our own, which means that
> manipulating it consistently at function exits might end up pretty
> ugly. So hearing that there's interest outside of my team to come up
> with such a type makes me optimistic that we can figure out a
> neat-enough solution.

Here are some past discussions on what I thought would be a good
approach to error handling. The basic idea is to replace the "pass a
strbuf that people shove error messages into" approach with an error
context struct that has a callback. And that callback can then stuff
them into a strbuf, or report them directly, or even die.

This thread sketches out the idea, though sadly I no longer have the
more fleshed-out patches I mentioned there:

  https://lore.kernel.org/git/20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net/

And then the sub-thread starting here discusses a similar approach:

  https://lore.kernel.org/git/20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net/

It does mean passing a "struct error_context" just about everywhere.
Though since the context doesn't change very much and most calls are
just forwarding it along, it would probably also be reasonable to have a
thread-local global context, and push/pop from it (sort of a poor man's
dynamic scoping).

One thing that strategy doesn't help with, though, that your
libification might want: it's not very machine-readable. The error
reporters would still fundamentally be working with strings. So a
libified process can know "OK, writing this ref failed, and I have some
error messages in a buffer". But the calling code can't know specifics
like "it failed because we tried to open file 'foo' and it got EPERM".
We _could_ design an error context that stores individual errno values
or codes in a list, but having each caller report those specific errors
is a much bigger job (and ongoing maintenance burden as we catalogue and
give an identifier to each error).

-Peff
