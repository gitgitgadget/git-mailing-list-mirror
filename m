Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54EB51F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758476AbcHCVb3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:31:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:54235 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758462AbcHCVbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:31:18 -0400
Received: (qmail 18562 invoked by uid 102); 3 Aug 2016 21:24:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 17:24:37 -0400
Received: (qmail 6057 invoked by uid 107); 3 Aug 2016 21:25:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 17:25:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 17:24:33 -0400
Date:	Wed, 3 Aug 2016 17:24:33 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 07/12] run-command: add clean_on_exit_handler
Message-ID: <20160803212433.zzdino3ivyem5a2v@sigill.intra.peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-8-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803164225.46355-8-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 06:42:20PM +0200, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Some commands might need to perform cleanup tasks on exit. Let's give
> them an interface for doing this.
> 
> Please note, that the cleanup callback is not executed if Git dies of a
> signal. The reason is that only "async-signal-safe" functions would be
> allowed to be call in that case. Since we cannot control what functions
> the callback will use, we will not support the case. See 507d7804 for
> more details.

I'm not clear on why we want this cleanup filter. It looks like you use
it in the final patch to send an explicit shutdown to any filters we
start. But I see two issues with that:

  1. This shutdown may come at any time, and you have no idea what state
     the protocol conversation with the filter is in. You could be in
     the middle of sending another pkt-line, or in a sequence of non-command
     pkt-lines where "shutdown" is not recognized.

  2. If your protocol does bad things when it is cut off in the middle
     without an explicit shutdown, then it's a bad protocol. As you
     note, this patch doesn't cover signal death, nor could it ever
     cover something like "kill -9", or a bug which prevented git from
     saying "shutdown".

     You're much better off to design the protocol so that a premature
     EOF is detected as an error.  For example, if we're feeding file
     data to the filter, and we're worried it might be writing it to
     a data store (like LFS), we would not want it to see EOF and say
     "well, I guess I got all the data; time to store this!". Instead,
     it should know how many bytes are coming, or should have some kind
     of framing so that the sender says "and now you have seen all the
     bytes" (like a pkt-line flush).

     AFAIK, your protocol _does_ do those things sensibly, so this
     explicit shutdown isn't really accomplishing anything.

-Peff
