Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8357520954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbdLGV1j (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:27:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:51484 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752418AbdLGV1i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:27:38 -0500
Received: (qmail 31752 invoked by uid 109); 7 Dec 2017 21:27:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Dec 2017 21:27:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26630 invoked by uid 111); 7 Dec 2017 21:27:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 07 Dec 2017 16:27:59 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Dec 2017 16:27:36 -0500
Date:   Thu, 7 Dec 2017 16:27:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
Message-ID: <20171207212735.GD12850@sigill.intra.peff.net>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 09:22:49PM +0100, René Scharfe wrote:

> Use string_list_append_nodup() instead of string_list_append() to hand
> over ownership of a detached strbuf and thus avoid leaking its memory.

Looks obviously correct (though one thing missing from the diff context
is whether "subjects" is set to DUP -- it is, which is good).

Grepping for "list_append.*detach" shows a few other possible cases in
transport-helper.c, which I think are leaks.

I wondered if it would be possible to write a coccinelle rule for this,
but I think it's not possible. Whether this is right depends on the
strdup_strings flag, which could change at runtime (though in practice
it doesn't).

-Peff
