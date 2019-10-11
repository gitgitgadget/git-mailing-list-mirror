Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783A11F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 06:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfJKGM6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 02:12:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:45402 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727211AbfJKGM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 02:12:58 -0400
Received: (qmail 13172 invoked by uid 109); 11 Oct 2019 06:12:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 06:12:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30545 invoked by uid 111); 11 Oct 2019 06:15:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 02:15:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 02:12:57 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] send-pack: never fetch when checking exclusions
Message-ID: <20191011061257.GD20094@sigill.intra.peff.net>
References: <xmqqzhibnahi.fsf@gitster-ct.c.googlers.com>
 <20191008183739.194714-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008183739.194714-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 08, 2019 at 11:37:39AM -0700, Jonathan Tan wrote:

> When building the packfile to be sent, send_pack() is given a list of
> remote refs to be used as exclusions. For each ref, it first checks if
> the ref exists locally, and if it does, passes it with a "^" prefix to
> pack-objects. However, in a partial clone, the check may trigger a lazy
> fetch.
> 
> The additional commit ancestry information obtained during such fetches
> may show that certain objects that would have been sent are already
> known to the server, resulting in a smaller pack being sent. But this is
> at the cost of fetching from many possibly unrelated refs, and the lazy
> fetches do not help at all in the typical case where the client is
> up-to-date with the upstream of the branch being pushed.
> 
> Ensure that these lazy fetches do not occur.

That makes sense. For similar reasons, should we be using
OBJECT_INFO_QUICK here? If the other side has a bunch of ref tips that
we don't have, we'll end up re-scanning the pack directory over and over
(which is _usually_ pretty quick, but can be slow if you have a lot of
packs locally). And it's OK if we racily miss out on an exclusion due to
somebody else repacking simultaneously.

-Peff
