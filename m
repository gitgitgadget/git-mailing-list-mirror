Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1327C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 07:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882676141B
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 07:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348805AbhI3Hs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 03:48:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:58140 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348782AbhI3Hs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 03:48:26 -0400
Received: (qmail 22325 invoked by uid 109); 30 Sep 2021 07:46:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Sep 2021 07:46:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24341 invoked by uid 111); 30 Sep 2021 07:46:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Sep 2021 03:46:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Sep 2021 03:46:43 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Message-ID: <YVVrY0/kXfWHCWJ1@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
 <CABPp-BFuj3W20J-aKU4BL9cqgA-GPZ2prEbAebY_kR0adaGzHw@mail.gmail.com>
 <YVVmssXlaFM6yD5W@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVVmssXlaFM6yD5W@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 03:26:42AM -0400, Jeff King wrote:

> > > If you remove the tmp_objdir as the primary as soon as you're done with
> > > the merge, but before you run the diff, you might be OK, though.
> > 
> > It has to be after I run the diff, because the diff needs access to
> > the temporary files to diff against them.
> 
> Right, of course. I was too fixated on the object-write part, forgetting
> that the whole point of the exercise is to later read them back. :)

Ah, no, I remember what I was trying to say here. The distinction is
between "remove the tmp_objdir" and "remove it as the primary".

I.e., if you do this:

  1. create tmp_objdir

  2. make tmp_objdir primary for writes

  3. run the "merge" half of remerge-diff, writing objects into the
     temporary space

  4. stop having tmp_objdir as the primary; instead make it an alternate

  5. run the diff

  6. remove tmp_objdir totally

Then step 5 can't accidentally write objects into the temporary space,
but it can still read them. So it's not entirely safe, but it's safer,
and it would be a much smaller change.

Some ways it could go wrong:

  - is it possible for the merge code to ever write an object? I kind of
    wonder if we'd ever do any cache-able transformations as part of a
    content-level merge. I don't think we do now, though.

  - in step 5, write_object_file() may still be confused by the presence
    of the to-be-thrown-away objects in the alternate. This is pretty
    unlikely, as it implies that the remerge-diff wrote a blob or tree
    that is byte-identical to something that the diff wants to write.

-Peff
