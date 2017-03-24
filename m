Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C50471FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936171AbdCXPhH (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:37:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:51027 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757241AbdCXPhF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:37:05 -0400
Received: (qmail 8962 invoked by uid 109); 24 Mar 2017 15:36:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 15:36:19 +0000
Received: (qmail 17755 invoked by uid 111); 24 Mar 2017 15:36:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 11:36:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 11:36:17 -0400
Date:   Fri, 24 Mar 2017 11:36:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] read-cache: call verify_hdr() in a background thread
Message-ID: <20170324153617.smmzju5mygqt5vux@sigill.intra.peff.net>
References: <1490362071-46932-1-git-send-email-git@jeffhostetler.com>
 <1490362071-46932-2-git-send-email-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490362071-46932-2-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 01:27:51PM +0000, git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teash do_read_index() in read-cache.c to call verify_hdr()
> in a background thread while the forground thread parses
> the index and builds the_index.
> 
> This is a performance optimization to reduce the overall
> time required to get the index into memory.
> 
> Testing on Windows (using the OpenSSL SHA1 routine) showed
> that parsing the index and computing the SHA1 take almost
> equal time, so this patch effectively reduces the startup
> time by 1/2.

Have you considered just skipping the sha1 check on read (possibly with
an option)?

Its purpose is to detect disk bit-rot. Checking it for every single
operation may be a bit excessive, especially because it gets rewritten a
lot. Nobody really cared until now because they don't have index files
that are hundreds of megabytes.

-Peff
