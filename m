Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80602C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 06:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64495613B1
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 06:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbhDMGlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 02:41:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:50676 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhDMGlC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 02:41:02 -0400
Received: (qmail 28345 invoked by uid 109); 13 Apr 2021 06:40:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 06:40:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22587 invoked by uid 111); 13 Apr 2021 06:40:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 02:40:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 02:40:41 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: GSoC Git Proposal Draft - ZheNing Hu
Message-ID: <YHU86dPKODAPDXY0@coredump.intra.peff.net>
References: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
 <CAOLTT8RTA0inxgxbd3qDToKYxwgXGKvJikXWsXg7oQ4asFj+HQ@mail.gmail.com>
 <CAOLTT8SW0n=x3HBL=php0aC1nhP7eU-MHFLustC3H0opxGRV1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8SW0n=x3HBL=php0aC1nhP7eU-MHFLustC3H0opxGRV1w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 11, 2021 at 11:34:35PM +0800, ZheNing Hu wrote:

> > Why is Olga’s solution rejected?
> > 1. Olga's solution is to let `git cat-file` use the `ref-filter` interface,
> > the performance of `cat-file` appears to be degraded due "very eager to
> > allocate lots of separate strings" in `ref-filter` and other reasons.
> 
> I am thinking today whether we can directly append some object information
> directly to `&state->stack->output`, Instead of assigning to `v->s` firstly.

Yes, that's the direction I think we'd want to go.

> But in `cmp_ref_sorting()` we will use `get_ref_atom_value()`, It is possible
> to compare `v->s` of two different refs, I must goto fill object info in `v->s`.
> 
> So I think this is one of the reasons why `ref-filter` desires to
> allocate a large
> number of strings, right?

Yeah, I think sorting in general is a bit tricky, because it inherently
requires collecting the value for each item. Just thinking about what
properties an ideal solution would have (which we might not be able to
get all of):

  - if we're sorting by something numeric (e.g., an committer
    timestamp), we should avoid forming it into a string at all

  - if the sort item requires work to extract that overlaps with the
    output format (e.g., sorting by authordate and showing author name
    in the format, both of which require parsing the author ident line
    of a commit), ideally we'd just do that work once per ref/object.

  - if we are sorting, obviously we have to hold some amount of data for
    each item in memory all at once (since we have to get data on the
    sort properties for each, and then sort the result). So we'd
    probably need at least some allocation per ref anyway, and an extra
    string isn't too bad. But if we're not sorting, then it would be
    nice to consider one ref/object at a time, which lets us keep our
    peak memory usage lower, reuse output buffers, etc.

I think some of those are in competition with each other. Minimizing
work shared between the sorting and format steps means keeping more data
in memory. So it might be sensible to just treat them totally
independently, and not worry about sharing work (I haven't looked at how
ref-filter does this now).  TBH, I care a lot less about making the
"sorting" case fast than I do about making sure that if we _aren't_
sorting, we go as fast as possible.

-Peff
