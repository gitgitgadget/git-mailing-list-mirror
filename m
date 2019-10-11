Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 873B61F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 16:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfJKQPG (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 12:15:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:45862 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726692AbfJKQPG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 12:15:06 -0400
Received: (qmail 15609 invoked by uid 109); 11 Oct 2019 16:15:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 16:15:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2535 invoked by uid 111); 11 Oct 2019 16:18:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 12:18:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 12:15:05 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2] send-pack: never fetch when checking exclusions
Message-ID: <20191011161504.GB19741@sigill.intra.peff.net>
References: <xmqqzhibnahi.fsf@gitster-ct.c.googlers.com>
 <20191008183739.194714-1-jonathantanmy@google.com>
 <20191011061257.GD20094@sigill.intra.peff.net>
 <a87cf3ce-fbff-ef4e-941e-bd2da0bf182f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a87cf3ce-fbff-ef4e-941e-bd2da0bf182f@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 08:31:30AM -0400, Derrick Stolee wrote:

> >> Ensure that these lazy fetches do not occur.
> > 
> > That makes sense. For similar reasons, should we be using
> > OBJECT_INFO_QUICK here? If the other side has a bunch of ref tips that
> > we don't have, we'll end up re-scanning the pack directory over and over
> > (which is _usually_ pretty quick, but can be slow if you have a lot of
> > packs locally). And it's OK if we racily miss out on an exclusion due to
> > somebody else repacking simultaneously.
> 
> That's a good idea. We can hint to the object store that we don't expect
> misses to be due to a concurrent repack, so we don't want to reprepare
> pack-files.

As a general rule (and why I'm raising this issue in reply to Jonathan's
patch), I think most or all sites that want OBJECT_INFO_QUICK will want
SKIP_FETCH_OBJECT as well, and vice versa. The reasoning is generally
the same:

  - it's OK to racily have a false negative (we'll still be correct, but
    possibly a little less optimal)

  - it's expected and normal to be missing the object, so spending time
    double-checking the pack store wastes measurable time in real-world
    cases

-Peff
