Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F97EC433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 11:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59DAB61957
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 11:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhCaLGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 07:06:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:38482 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235122AbhCaLGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 07:06:11 -0400
Received: (qmail 28582 invoked by uid 109); 31 Mar 2021 11:06:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Mar 2021 11:06:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3283 invoked by uid 111); 31 Mar 2021 11:06:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Mar 2021 07:06:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Mar 2021 07:06:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 4/4] usage.c: add a non-fatal bug() function to go with
 BUG()
Message-ID: <YGRXomWwRYPdXZi3@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
 <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com>
 <xmqqh7kvolgn.fsf@gitster.g>
 <YGAtkW2YWNbcAn8m@coredump.intra.peff.net>
 <87tuoum6ru.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tuoum6ru.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 03:25:09PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Yeah, this seems like it is missing the point of BUG() completely.  I
> > took a peek at patch 5/5 of the follow-on, which uses bug(). It looks
> > like it should really be an error() return or similar. The root cause
> > would be open_istream() on a loose object failing (which might be
> > corruption, or might even be a transient OS error!).
> 
> I don't feel strongly about this bug() thing, I'll drop it if you two
> don't like it.
> 
> But that's not why I added it, yes you can now carefully read the code
> and reason that this code is unreachable now, as I think it is.
> 
> But it may not stay that way, refactoring how we handle I/O errors
> etc. further down the stack is the sort of thing that if this bug()
> wasn't there would cause us to otherwise silently lose the
> error. I.e. does check_object_signature() always promise to return
> non-zero *only* if the signature isn't OK?
> 
> So maybe we are happy to just make that promise, in which case yes, this
> should/could be an error() in this case.

I didn't dig into what check_object_signature() promises, but I don't
think it matters for my argument. If the case you are looking at can be
triggered by bad on-disk data, transient OS errors, etc, then it should
be an error() or a die(), or whatever is appropriate for the code. If it
is meant to be an invariant of the code that it should never trigger,
then it should be a BUG(), so that we loudly inform people that the
code's assumption has been violated.

But I do not see any point in a bug() that does not abort(). The point
of BUG() is that nobody is supposed to see it, and we should be as loud
as possible if we do.

And if there is a call site that is in doubt about what it may be fed,
then it should just be an error() or die().

> But isn't this also useful for multi-threaded code? E.g. let's say fsck
> learns to map-reduce its fsck-ing of objects across threads. One of them
> encounters a BUG(). Do we want to hard kill the whole thing or try to
> limp ahead and report partial results from the other thread(s)?

Yes, we want to hard kill. The point of BUG() is that it is not supposed
to happen, and there is no point in limping further.

-Peff
