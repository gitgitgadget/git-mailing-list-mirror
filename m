Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91188C352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 12:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642EB20715
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 12:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGMpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:45:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:54762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726674AbgBGMpy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 07:45:54 -0500
Received: (qmail 30322 invoked by uid 109); 7 Feb 2020 12:45:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Feb 2020 12:45:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23280 invoked by uid 111); 7 Feb 2020 12:54:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Feb 2020 07:54:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Feb 2020 07:45:52 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2020, #01; Wed, 5)
Message-ID: <20200207124552.GA4440@coredump.intra.peff.net>
References: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD1ascbutL5RGSGC1-eWvOJDpbcZ=edSG+WCd7aAkCmn8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1ascbutL5RGSGC1-eWvOJDpbcZ=edSG+WCd7aAkCmn8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 07, 2020 at 07:42:52AM +0100, Christian Couder wrote:

> On Thu, Feb 6, 2020 at 12:36 AM Junio C Hamano <gitster@pobox.com> wrote:
> 
> > * jk/packfile-reuse-cleanup (2020-01-23) 12 commits
> >  - pack-bitmap: don't rely on bitmap_git->reuse_objects
> >  - pack-objects: add checks for duplicate objects
> >  - pack-objects: improve partial packfile reuse
> >  - builtin/pack-objects: introduce obj_is_packed()
> >  - pack-objects: introduce pack.allowPackReuse
> >  - csum-file: introduce hashfile_total()
> >  - pack-bitmap: simplify bitmap_has_oid_in_uninteresting()
> >  - pack-bitmap: uninteresting oid can be outside bitmapped packfile
> >  - pack-bitmap: introduce bitmap_walk_contains()
> >  - ewah/bitmap: introduce bitmap_word_alloc()
> >  - packfile: expose get_delta_base()
> >  - builtin/pack-objects: report reused packfile objects
> >
> >  The way "git pack-objects" reuses objects stored in existing pack
> >  to generate its result has been improved.
> >
> >  Will merge to 'next'?
> 
> I think that it would be indeed ok to merge to next if no one comments
> further following the v4 [1] and my last reply to Peff [2]
> 
> [1] https://lore.kernel.org/git/20191218112547.4974-1-chriscool@tuxfamily.org/
> [2] https://lore.kernel.org/git/CAP8UFD0h1TFVNqH7g823psaQzmEmzoz200CkZuDOV8GqNV7mrQ@mail.gmail.com/
> 
> According to Peff the code in this patch series has been running by
> GitHub for years. This patch series is also now used in a custom Git
> that has been running on gitlab.com for a few days. This custom Git is
> planned to be part of the GitLab 12.8 release later this month.

Yeah, I think the only lingering issue is that one I pointed out where
the big "initial chunk" reuse doesn't carefully check for any REF_DELTA
objects whose bases we're not including. But that exists in the current
scheme, and in what we've been running at GitHub for a long time. And is
probably OK by the reasoning I gave in the thread: these packs must have
bitmaps, and therefore we wrote them as non-thin, and therefore they
would have only OFS deltas. I think it would also be OK even if you
tried repacking without --delta-base-offset, because we always put bases
before their deltas (aside from --fix-thin, maybe?)

So I'd be OK to proceed with the series as-is, but it does give me a
slight worry. Both that this assumption could somehow be violated, but
also that the other parts of the code trying to handle REF_DELTAs are
probably not getting exercised at all. It would be kind of interesting
to cover this case with a test, but I'm not even sure there's a way that
you could generate such a pack with `pack-objects` because of the
bases-before-deltas ordering constraint.

-Peff
