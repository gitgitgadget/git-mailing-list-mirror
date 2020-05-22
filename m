Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A034C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 15:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2263E20663
	for <git@archiver.kernel.org>; Fri, 22 May 2020 15:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgEVPyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 11:54:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:54478 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbgEVPyL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 11:54:11 -0400
Received: (qmail 21446 invoked by uid 109); 22 May 2020 15:54:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 May 2020 15:54:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7143 invoked by uid 111); 22 May 2020 15:54:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 May 2020 11:54:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 May 2020 11:54:10 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 9/9] fixup! remote-curl: error on incomplete packet
Message-ID: <20200522155410.GA2146293@coredump.intra.peff.net>
References: <cover.1589885479.git.liu.denton@gmail.com>
 <4364b38bd027c219d41282bad3f8476daec936f9.1590154401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4364b38bd027c219d41282bad3f8476daec936f9.1590154401.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 22, 2020 at 09:33:47AM -0400, Denton Liu wrote:

> In the CGI scripts which emulate a connection being prematurely
> terminated, it doesn't make sense for there to be a trailing newline
> after the simulated connection cut. Remove these newlines.

Ah, good catch. I think in the first one it doesn't matter:

> -printf "%s%s\n" "0079" "45"
> +printf "%s%s" "0079" "45"

because we have a too-short packet, so the fact that it is 3 bytes and
not 2 does not change that.

I agree it's clearer without the newline, though. I wonder if:

  printf "0079" "fewer than 0x79 bytes"

would make it even more self-documenting. :)

> -printf "%s\n" "00"
> +printf "%s" "00"

This one is a behavior improvement: we were probably hitting "oops,
newline isn't a valid line-length character" before, and now we're
really hitting the truncated packet.

I don't know if it's worth adding an extra test with a bogus
line-length. I'm OK with with it either way.

-Peff
