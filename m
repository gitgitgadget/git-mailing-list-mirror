Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35AB1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 21:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbeHBXVS (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 19:21:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:41026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727260AbeHBXVS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 19:21:18 -0400
Received: (qmail 28957 invoked by uid 109); 2 Aug 2018 21:28:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 21:28:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28262 invoked by uid 111); 2 Aug 2018 21:28:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 17:28:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 17:28:19 -0400
Date:   Thu, 2 Aug 2018 17:28:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180802212819.GA32538@sigill.intra.peff.net>
References: <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
 <20180731192931.GD3372@sigill.intra.peff.net>
 <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
 <20180731203746.GA9442@sigill.intra.peff.net>
 <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com>
 <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
 <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
 <xmqqpnz03f9o.fsf@gitster-ct.c.googlers.com>
 <20180802190644.GE23690@sigill.intra.peff.net>
 <xmqqmuu4zd1l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmuu4zd1l.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 02:14:30PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I also wonder if Windows could return some other file-unique identifier
> > that would work in place of an inode here. That would be pretty easy to
> > swap in via an #ifdef's helper function. I'd be OK shipping without that
> > and letting Windows folks fill it in later (as long as we do not do
> > anything too stupid until then, like claim all of the inode==0 files are
> > the same).
> 
> Yeah, but such a useful file-unique identifier would probably be
> used in place of inum in their (l)stat emulation already, if exists,
> no?

Maybe. It might not work as ino_t. Or it might be expensive to get.  Or
maybe it's simply impossible. I don't know much about Windows. Some
searching implies that NTFS does have a "file index" concept which is
supposed to be unique.

At any rate, until we have an actual plan for Windows, I think it would
make sense only to split the cases into "has working inodes" and
"other", and make sure "other" does something sensible in the meantime
(like mention the conflict, but skip trying to list duplicates).

When somebody wants to work on Windows support, then we can figure out
if it just needs to wrap the "get unique identifier" operation, or if it
would use a totally different algorithm.

-Peff
