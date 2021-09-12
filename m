Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44A9C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD7B61039
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhILWUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:20:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:45682 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235898AbhILWUj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:20:39 -0400
Received: (qmail 17023 invoked by uid 109); 12 Sep 2021 22:19:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 12 Sep 2021 22:19:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2749 invoked by uid 111); 12 Sep 2021 22:19:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 12 Sep 2021 18:19:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 12 Sep 2021 18:19:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/7] strvec: use size_t to store nr and alloc
Message-ID: <YT586/CO7QsTb3TK@coredump.intra.peff.net>
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
 <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 02:15:48AM +0200, Ævar Arnfjörð Bjarmason wrote:

> This is what I'd been sitting on locally since that recent thread, I
> polished it up a bit since Jeff King posted his version.
> 
> The potential overflow bug I mentioned is in rebase.c. See
> 5/7. "Potential" because it's not a bug now, but that code
> intentionally considers a strvec, and then iterates it from nr-1 to 0,
> and if it reaches 0 intentionally counts down one more to -1 to
> indicate that it's visited all elements.
> 
> We then check that with i >= 0, except of course if it becomes
> unsigned that doesn't become -1, but rather it wraps around.

You can also just use ssize_t, or you can compare against SIZE_MAX to
catch the wraparound (there's some prior art in sort_revindex()). That
said, I don't mind rewriting loops to count up rather than down. It
usually makes them easier to follow (and in your patch 5, I do not see
any reason we would need to count down rather than up; we do not even
care where we find "-q", only that we found it.

> The rest of this is all changes to have that s/int/size_t/ radiate
> outwards, i.e. when we assign that value to a variable somewhere its
> now a "size_t" instead of an "int" etc.

I'm a little "meh" on some of these, for a few reasons:

 - anything calling into setup_revisions() eventually is just kicking
   the can anyway. And these are generally not buggy in the first place,
   since they're bounded argv creations.

 - passing a strvec instead of the broken-down pair is a less flexible
   interface. It's one thing if the callee benefits from seeing the
   strvec (say, because they may push more items onto it). But I think
   with strbufs, we have a general guideline that if a function _can_
   take the bare pointer, then it should. (Sorry, I don't have a
   succinct reference to CodingGuidelines or anything like that; I feel
   like this is wisdom we came up with on the list in the early days of
   strbufs).

 - if we are going to pass a strvec, it should almost certainly be
   const, to make it clear how we intend to use it.

So if we we wanted to try to reduce the int/size_t conversions here (and
I don't mind doing it, but am not altogether sure it is a good use of
time, because the rabbit hole runs deep), I think we ought to be
switching to size_t everywhere-ish along whole call chains. Or possibly
providing a checked size_to_int() which will safely catch and abort.
These cases are largely stupid things that real people would never come
across. The real goal is making sure we don't get hit with a memory
safety bug (under-allocation, converting a big size_t to a negative int,
etc).

-Peff
