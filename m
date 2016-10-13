Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B050C20989
	for <e@80x24.org>; Thu, 13 Oct 2016 14:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753217AbcJMOuL (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 10:50:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:56997 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752063AbcJMOuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 10:50:09 -0400
Received: (qmail 21864 invoked by uid 109); 13 Oct 2016 14:50:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 14:50:08 +0000
Received: (qmail 30278 invoked by uid 111); 13 Oct 2016 14:50:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 10:50:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2016 10:50:06 -0400
Date:   Thu, 13 Oct 2016 10:50:06 -0400
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Huge performance bottleneck reading packs
Message-ID: <20161013145006.mouzqmz3fssrjad4@sigill.intra.peff.net>
References: <ea8db41f-2ea4-b37b-e6f8-1f1d428aea5d@oracle.com>
 <xmqqpon5190s.fsf@gitster.mtv.corp.google.com>
 <1d5dd36b-7a9e-ac00-352a-d71e0e277002@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d5dd36b-7a9e-ac00-352a-d71e0e277002@oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2016 at 09:17:34AM +0200, Vegard Nossum wrote:

> Oops. I disabled gc a while ago; one reason I did that is that it takes
> a long time to run and it has a tendency to kick in at the worst time. I
> guess I should really put it in cron then.
> 
> I'm not sure if this is related, but I also had a problem with GitPython
> and large pack files in the past (" ValueError: Couldn't obtain fanout
> table or warning: packfile ./objects/pack/....pack cannot be accessed")

Sounds like they didn't correctly implement the extra index fanout that
happens for pack above 2G. The old Grit library had a similar bug.

> and I have pack.packSizeLimit set to 512m to fix that.
> Although the whole repo is 17G so I guess it shouldn't be necessary to
> have that many pack files.

Using packSizeLimit does "solve" that problem, but it comes with its own
set of issues. There is a very good chance that your repository would be
much smaller than 17G as a single packfile, because Git does not allow
deltas across packs, and it does not optimize the placement of objects
to keep delta-related objects in a single pack. So you'll quite often be
storing full copies of objects that could otherwise be stored as a tiny
delta.

You might want to compare the resulting size for a full repack with and
without pack.packSizeLimit.

But I agree that is not the cause of your thousand packs. They are more
likely the accumulated cruft of a thousand fetches.

-Peff
