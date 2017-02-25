Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68623201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbdBYUsp (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:48:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:34180 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbdBYUso (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:48:44 -0500
Received: (qmail 5272 invoked by uid 109); 25 Feb 2017 20:48:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 20:48:44 +0000
Received: (qmail 11684 invoked by uid 111); 25 Feb 2017 20:48:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 15:48:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 15:48:41 -0500
Date:   Sat, 25 Feb 2017 15:48:41 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: release fallback base's memory in
 unpack_entry()
Message-ID: <20170225204841.hvrhbgrv42437b4r@sigill.intra.peff.net>
References: <fe07ed70-0b93-8b2c-59f9-967d3dc1313f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe07ed70-0b93-8b2c-59f9-967d3dc1313f@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 11:02:28AM +0100, René Scharfe wrote:

> If a pack entry that's used as a delta base is corrupt, unpack_entry()
> marks it as unusable and then searches the object again in the hope that
> it can be found in another pack or in a loose file.  The memory for this
> external base object is never released.  Free it after use.

This looks good. I wondered if there were any tricks with passing the
resulting base to the delta-base cache. But I don't think so. We add to
the cache right _before_ the fallback check we're looking at here. And
the "base" variable does not persist to the next loop.

Arguably, one could do the fallback first and then add the result to the
delta base cache, but it probably isn't worth the trouble. However we
read the object via read_object() would hopefully have done so already.

-Peff
