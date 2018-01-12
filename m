Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0701F406
	for <e@80x24.org>; Fri, 12 Jan 2018 15:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933997AbeALPVB (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 10:21:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:42252 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933926AbeALPVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 10:21:01 -0500
Received: (qmail 8847 invoked by uid 109); 12 Jan 2018 15:21:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 15:21:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31731 invoked by uid 111); 12 Jan 2018 15:21:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 10:21:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 10:20:59 -0500
Date:   Fri, 12 Jan 2018 10:20:59 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/9] object: add clear_commit_marks_all()
Message-ID: <20180112152058.GA10210@sigill.intra.peff.net>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
 <ec45f9a8-292a-53e2-52b6-44d744cb6c36@web.de>
 <20180110075838.GD16315@sigill.intra.peff.net>
 <a0ca86b8-e258-2588-1c99-a30e8e60fdbd@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0ca86b8-e258-2588-1c99-a30e8e60fdbd@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 07:57:42PM +0100, René Scharfe wrote:

> > Is it worth having:
> > 
> >    void clear_object_flags_from_type(int type, unsigned flags);
> > 
> > rather than having two near-identical functions? I guess we'd need some
> > way of saying "all types" to reimplement clear_object_flags() as a
> > wrapper (OBJ_NONE, I guess?).
> 
> I don't know if there is a demand.  Perhaps the two callers of
> clear_object_flags() should be switched to clear_commit_marks_all()?
> They look like they only care about commits as well.  Or is it safe to
> stomp over the flags of objects of other types?  Then we'd only need
> to keep clear_object_flags()..

I'd worry that the call in reset_revision_walk() might want to clear
non-commits if the revisions have "--objects" passed to them.

I do suspect that clearing flags from all objects would just work in the
general case (since we're limiting ourselves to only a particular set of
flags). But it's probably not worth the risk of unintended fallout,
since there's not much benefit after your series.

> > The run-time check is maybe a little bit slower in the middle of a tight
> > loop, but I'm not sure it would matter much (I'd actually be curious if
> > this approach is faster than the existing traversal code, too).
> 
> I don't know how to measure this properly.  With 100 runs each I get
> this for the git repo and the silly test program below, which measures
> the duration of the respective function call:
> 
>    mean        stddev method
>    ----------- ------ ----------------------
>    5.89763e+06 613106 clear_commit_marks
>    2.72572e+06 507689 clear_commit_marks_all
>    1.96582e+06 494753 clear_object_flags
> 
> So these are noisy numbers, but kind of in the expected range.

That's about what I'd expect. The "bad" case for looking at all objects
is when there are a bunch of objects loaded that _weren't_ part of this
particular traversal. I have no idea how often that happens, but we can
guess at the impact in the worst case: having done a previous --objects
traversal in the process and then traversing all of the commits a second
time, we'd probably have about 5-10x as many objects to look through for
that second path. So clear_commit_marks() would win there.

The absolute numbers are small enough that it probably doesn't matter
either way.

-Peff
