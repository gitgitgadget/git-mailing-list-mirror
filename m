Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BA9C4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2295E20735
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgKEVRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:17:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:49372 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbgKEVRi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:17:38 -0500
Received: (qmail 17591 invoked by uid 109); 5 Nov 2020 21:17:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Nov 2020 21:17:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27535 invoked by uid 111); 5 Nov 2020 21:17:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Nov 2020 16:17:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Nov 2020 16:17:36 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 00/13] Add struct strmap and associated utility
 functions
Message-ID: <20201105211736.GA134274@coredump.intra.peff.net>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
 <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
 <20201105132909.GB91972@coredump.intra.peff.net>
 <xmqq8sbfk0ut.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sbfk0ut.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 05, 2020 at 12:25:14PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Subject: [PATCH] shortlog: drop custom strset implementation
> >
> > We can use the strset recently added in strmap.h instead. Note that this
> > doesn't have a "check_and_add" function. We can easily write the same
> > thing using separate "contains" and "adds" calls. This is slightly less
> > efficient, in that it hashes the string twice, but for our use here it
> > shouldn't be a big deal either way.
> >
> > I did leave it as a separate helper function, though, since we use it in
> > three separate spots (some of which are in the middle of a conditional).
> 
> It makes sense, but check_dup() sounds like its use pattern would be
> 
> 	if (check_dup(it) == NO_DUP)
> 		add(it);
> 
> where it is more like "add it but just once".

Hmph. I picked that name (versus just "contains") hoping it be general
enough to cover the dual operation.  Better name suggestions are
welcome. Though...

> By the way, is a strset a set or a bag?  If it makes the second add
> an no-op, perhaps your check_dup() is what strset_add() should do
> itself?  What builtin/shortlog.c::check_dup() does smells like it is
> a workaround for the lack of a naturally-expected feature.

Yes, if strset_add() returned an integer telling us whether the item was
already in the set, then we could use it directly. It's slightly
non-trivial to do, though, as it's built around strmap_put(), which
returns a pointer to the old value. But since we're a set and not a map,
that value is always NULL; we can't tell the difference between "I was
storing an old value which was NULL" and "I was not storing any value".

If strset were built around strintmap it could store "1" for "present in
the set". It somehow feels hacky, though, to induce extra value writes
just for the sake of working around the API.

Since strset is defined within strmap.c, perhaps it wouldn't be too bad
for it to be more intimate with the details here. I.e., to use
find_strmap_entry() directly, and if the value is not present, to create
a new hashmap entry. That would require hacking up strmap_put() into a
few helpers, but it's probably not too bad.

-Peff
