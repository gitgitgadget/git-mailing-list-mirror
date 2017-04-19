Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72551207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 01:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758065AbdDSBcS (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 21:32:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:35665 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757936AbdDSBcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 21:32:17 -0400
Received: (qmail 24695 invoked by uid 109); 19 Apr 2017 01:32:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Apr 2017 01:32:17 +0000
Received: (qmail 17750 invoked by uid 111); 19 Apr 2017 01:32:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 21:32:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Apr 2017 21:32:15 -0400
Date:   Tue, 18 Apr 2017 21:32:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] diffcore-rename: speed up register_rename_src
Message-ID: <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
References: <20170418194421.22453-1-git@jeffhostetler.com>
 <20170418194421.22453-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170418194421.22453-2-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 07:44:21PM +0000, git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach register_rename_src() to see if new file pair
> can simply be appended to the rename_src[] array before
> performing the binary search to find the proper insertion
> point.

I guess your perf results show some minor improvement. But I suspect
this is because your synthetic repo does not resemble the real world
very much. You're saving a few strcmps, but for each of those files
you're potentially going to have actually zlib inflate the object
contents and do similarity analysis.

So "absurd number of files doing 100% exact renames" is the absolute
best case, and it saves a few percent.

I dunno. It is not that much code _here_, but I'm not excited about the
prospect of sprinkling this same "check the last one" optimization all
over the code base. I wonder if there's some way to generalize it.

-Peff
