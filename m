Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC50B1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733169AbfHZSmy (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:42:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:56216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727687AbfHZSmy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:42:54 -0400
Received: (qmail 6701 invoked by uid 109); 26 Aug 2019 18:42:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Aug 2019 18:42:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22564 invoked by uid 111); 26 Aug 2019 18:44:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Aug 2019 14:44:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Aug 2019 14:42:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Mike Hommey <mh@glandium.org>, Elijah Newren <newren@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/2] fast-import: duplicate into history rather than
 passing ownership
Message-ID: <20190826184252.GC23399@sigill.intra.peff.net>
References: <20190825080640.GA31453@sigill.intra.peff.net>
 <20190825081055.GB31824@sigill.intra.peff.net>
 <20190825100213.fssjydohathfhhe5@glandium.org>
 <248c5f9f-ba44-6dec-6f30-f7d193bc22bb@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <248c5f9f-ba44-6dec-6f30-f7d193bc22bb@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 04:21:54PM +0200, René Scharfe wrote:

> > You could xstrndup(command_buf.buf, command_buf.len), which would avoid
> > a hidden strlen.
> 
> xstrndup() also searches for NUL, albeit with memchr(3).  xmemdupz()
> would copy without checking.
> 
> I suspect the simplicity of xstrdup() outweighs the benefits of the
> alternatives, but didn't do any measurements..

Yep. I actually started to write xmemdupz() originally then decided it
was unnecessarily verbose and a premature optimization.

I wondered after this exchange whether something like:

  char *strbuf_dup(const struct strbuf *sb)
  {
	return xmemdupz(sb->buf, sb->len);
  }

would be a useful general helper. Grepping around it doesn't seem like
there are a lot of candidates.

If we really wanted to micro-optimize, we could have cmd_hist store
strbufs, and then we could reuse the same buffers over and over without
re-allocating. And use strbuf_addbuf(&cmd_hist.buf, &command_buf). :)

-Peff
