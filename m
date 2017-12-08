Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99AD21FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 21:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbdLHVLk (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 16:11:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:52868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752718AbdLHVLk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 16:11:40 -0500
Received: (qmail 29633 invoked by uid 109); 8 Dec 2017 21:11:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 21:11:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6110 invoked by uid 111); 8 Dec 2017 21:12:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 16:12:01 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 16:11:38 -0500
Date:   Fri, 8 Dec 2017 16:11:38 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
Message-ID: <20171208211137.GA7355@sigill.intra.peff.net>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
 <20171207212735.GD12850@sigill.intra.peff.net>
 <e1daa2b6-004b-ad66-b84d-84fa70a44baf@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1daa2b6-004b-ad66-b84d-84fa70a44baf@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 06:29:31PM +0100, René Scharfe wrote:

> Am 07.12.2017 um 22:27 schrieb Jeff King:
> > Grepping for "list_append.*detach" shows a few other possible cases in
> > transport-helper.c, which I think are leaks.
> 
> -- >8 --
> Subject: [PATCH] transport-helper: plug strbuf and string_list leaks
> 
> Transfer ownership of detached strbufs to string_lists of the
> duplicating variety by calling string_list_append_nodup() instead of
> string_list_append() to avoid duplicating and then leaking the buffer.

Thanks, this part looks obviously correct.

> While at it make sure to release the string_list when done;
> push_refs_with_export() already does that.

This one takes a bit more digging. I've been bitten before in Git's code
by freeing what appeared to be a leak only to find out that we had
passed the pointers off to some other data structure which expected them
to persist.

Here we feed them to set_helper_option(), which passes them to
quote_c_style(), which makes a copy into a strbuf. So I think all is
well.

-Peff
