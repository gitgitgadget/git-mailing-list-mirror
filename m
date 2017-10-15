Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6BC420445
	for <e@80x24.org>; Sun, 15 Oct 2017 20:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbdJOUGq (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 16:06:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:53256 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751321AbdJOUGm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 16:06:42 -0400
Received: (qmail 8600 invoked by uid 109); 15 Oct 2017 20:06:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 15 Oct 2017 20:06:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5829 invoked by uid 111); 15 Oct 2017 20:06:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 15 Oct 2017 16:06:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Oct 2017 16:06:35 -0400
Date:   Sun, 15 Oct 2017 16:06:35 -0400
From:   Jeff King <peff@peff.net>
To:     Joris Valette <joris.valette@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: Consider escaping special characters like 'less' does
Message-ID: <20171015200635.e2u4qkxlz2xwpfov@sigill.intra.peff.net>
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
 <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat>
 <87zi8sxvkg.fsf@linux-m68k.org>
 <CA+o7MD8fcD5-SFeQsX84Etu68ov7yy48OO4dV=gXMp5xY8s9Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+o7MD8fcD5-SFeQsX84Etu68ov7yy48OO4dV=gXMp5xY8s9Rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 15, 2017 at 06:39:45PM +0200, Joris Valette wrote:

> > It's your MUA's fault that you get a ?, the mail didn't contain any.
> 
> Actually, the original mail contained the special BOM sequence but
> it's generally invisible. His MUA shows it with a '?', mine doesn't
> show anything, neither does Firefox on the mailing list page.
> 
> The question remains: could escaping be done?

Git's diff generation will never do such escaping by default, because it
means creating a patch that cannot be applied to get back the original
content.

There _are_ already options to create diffs that cannot be applied, like
--textconv. So it would be possible to add a similar option for
escaping. But I don't think we really need or want a separate option,
when you can already do one of:

  1. If your files have special binary characters that are hard to see,
     you can use the existing textconv system to do whatever escaping
     you like. And then the Git will diff the result of the escaping,
     which means you get readable diffs when they change.

  2. Put the raw output of git's diff through a filter that escapes. We
     already do this most of the time by piping through less. The most
     noticeable exception is "add --patch". There you can set up a
     program to filter as well. There's more information in a recent
     thread here:

       https://public-inbox.org/git/20171012184736.rglkbyryauwuvn2a@sigill.intra.peff.net/

It doesn't seem out of the question to me to have an out-of-the-box
default for interactive.diffFilter which does some basic escaping (we
could even implement it inside the perl script for efficiency).

-Peff
