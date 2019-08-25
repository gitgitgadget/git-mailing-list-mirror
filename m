Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E50E1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 07:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfHYHUk (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 03:20:40 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:36506 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfHYHUj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 03:20:39 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1i1mpD-0005cU-QD; Sun, 25 Aug 2019 16:20:31 +0900
Date:   Sun, 25 Aug 2019 16:20:31 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] fast-import: Reinitialize command_buf rather than detach
 it.
Message-ID: <20190825072031.2m2go6ssshww6tup@glandium.org>
References: <20190825041348.31835-1-mh@glandium.org>
 <20190825065747.GA23806@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825065747.GA23806@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 02:57:48AM -0400, Jeff King wrote:
> On Sun, Aug 25, 2019 at 01:13:48PM +0900, Mike Hommey wrote:
> 
> > command_buf.buf is also stored in cmd_hist, so instead of
> > strbuf_release, the current code uses strbuf_detach in order to
> > "leak" the buffer as far as the strbuf is concerned.
> > 
> > However, strbuf_detach does more than "leak" the strbuf buffer: it
> > possibly reallocates it to ensure a terminating nul character. And when
> > that happens, what is already stored in cmd_hist may now be a free()d
> > buffer.
> > 
> > In practice, though, command_buf.buf is most of the time a nul
> > terminated string, meaning command_buf.len < command_buf.alloc, and
> > strbuf_detach is a no-op. BUT, when it's not (e.g. on the first call),
> > command_buf.buf is &strbuf_slopbuf. In that case, strbuf_detach does
> > allocate a 1 byte buffer to store a nul character in it, which is then
> > leaked.
> 
> I think this is stronger than just "most of the time". It's an invariant
> for strbufs to have a NUL, so the only case where detaching isn't a noop
> is the empty slopbuf case you mention.

If it's an invariant, why does detach actively tries to realloc and set
the nul terminator as if it can happen in more cases than when using the
slopbuf?

> Splitting hairs, perhaps, but I think with that explanation, we could
> probably argue that this case will never come up: strbuf_getline will
> either have allocated a buffer or will have returned EOF.

Note that the slopbuf case _does_ come up, and we always leak a 1 byte
buffer.

> That said, I do think it's quite confusing and is worth fixing, both for
> readability and for future-proofing. But...
(...)

I do agree the way fast-import works between cmd_hist and command_buf is
very brittle, as you've shown. I didn't feel like digging into it
though. Thanks for having gone further than I did.

Mike
