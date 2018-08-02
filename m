Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE92C208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 19:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeHBU7M (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:59:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:40732 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726177AbeHBU7M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:59:12 -0400
Received: (qmail 22965 invoked by uid 109); 2 Aug 2018 19:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 19:06:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26929 invoked by uid 111); 2 Aug 2018 19:06:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 15:06:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 15:06:44 -0400
Date:   Thu, 2 Aug 2018 15:06:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180802190644.GE23690@sigill.intra.peff.net>
References: <20180730152756.15012-1-pclouds@gmail.com>
 <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
 <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
 <20180731192931.GD3372@sigill.intra.peff.net>
 <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
 <20180731203746.GA9442@sigill.intra.peff.net>
 <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com>
 <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
 <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
 <xmqqpnz03f9o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnz03f9o.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 09:27:31AM -0700, Junio C Hamano wrote:

> > OK so we're going back to the original way of checking that we check
> > out the different files on the same place (because fs is icase) and
> > try to collect all paths for reporting, yes? I can give it another go
> > (but of course if anybody else steps up, I'd very gladly hand this
> > over)
> 
> Detect and report, definitely yes; I am not sure about collect all
> (personally I am OK if we stopped at reporting "I tried to check out
> X but your project tree has something else that is turned to X by
> your pathname-smashing filesystem" without making it a requirement
> to report what the other one that conflict with X is.  Of course,
> reporting the other side _is_ nicer and I'd be happier if we can do
> so without too much ugly code, but I do not think it is a hard
> requirement.

Yeah, I think it would be OK to issue the warning for the conflicted
path, and then if we _can_ produce the secondary list of colliding
paths, do so. Even on a system with working inodes, we may not come up
with a match (e.g., if it wasn't us who wrote the file, but rather we
raced with some other process).

I also wonder if Windows could return some other file-unique identifier
that would work in place of an inode here. That would be pretty easy to
swap in via an #ifdef's helper function. I'd be OK shipping without that
and letting Windows folks fill it in later (as long as we do not do
anything too stupid until then, like claim all of the inode==0 files are
the same).

-Peff

PS It occurs to me that doing this naively (re-scan the entries already
   checked out when we see a collision) ends up quadratic over the
   number of entries in the worst case. That may not matter. You'd only
   have a handful of collisions normally, and anybody malicious can
   already git-bomb your checkout anyway. If we care, an alternative
   would be to set a flag for "I saw some collisions", and then follow
   up with a single pass putting entries into a hashmap of
   inode->filename.
