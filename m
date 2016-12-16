Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57C61FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 21:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933240AbcLPVcT (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 16:32:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:57780 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933039AbcLPVcS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 16:32:18 -0500
Received: (qmail 10216 invoked by uid 109); 16 Dec 2016 21:32:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 21:32:18 +0000
Received: (qmail 14790 invoked by uid 111); 16 Dec 2016 21:32:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 16:32:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2016 16:32:14 -0500
Date:   Fri, 16 Dec 2016 16:32:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
Message-ID: <20161216213214.z3mzkp2xqnwrqkh2@sigill.intra.peff.net>
References: <1481922331.28176.11.camel@frank>
 <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 01:28:00PM -0800, Junio C Hamano wrote:

> > 2. I don't understand what would cause that message.  That is, what bad
> > thing am I doing that I should stop doing?  I've briefly skimmed the
> > code and commit message, but the answer isn't leaping out at me.
> 
> Enabling bitmap generation for incremental packing that does not
> cram everything into a single pack is triggering it, I would
> presume.  Perhaps we should ignore -b option in most of the cases
> and enable it only for "repack -a -d -f" codepath?  Or detect that
> we are being run from "gc --auto" and automatically disable -b?  I
> have a feeling that an approach along that line is closer to the
> real solution than tweaking report_last_gc_error() and trying to
> deduce if we are making any progress.

Ah, indeed. I was thinking in my other response that "git gc" would
always kick off an all-into-one repack. But "gc --auto" will not in
certain cases. And yes, in those cases you definitely would want
--no-write-bitmap-index. I think it would be reasonable for "git repack"
to disable bitmap-writing automatically when not doing an all-into-one
repack.

-Peff
