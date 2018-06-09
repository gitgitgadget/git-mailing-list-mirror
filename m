Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367D91F403
	for <e@80x24.org>; Sat,  9 Jun 2018 06:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeFIGYC (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 02:24:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:39812 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751505AbeFIGYB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 02:24:01 -0400
Received: (qmail 20020 invoked by uid 109); 9 Jun 2018 06:23:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Jun 2018 06:23:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 919 invoked by uid 111); 9 Jun 2018 06:24:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Jun 2018 02:24:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jun 2018 02:23:52 -0400
Date:   Sat, 9 Jun 2018 02:23:51 -0400
From:   Jeff King <peff@peff.net>
To:     Vitaly Potyarkin <sio.wtf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Truncating file names with Unicode characters
Message-ID: <20180609062351.GC30224@sigill.intra.peff.net>
References: <CA+v=Qh7eiLoN4YcnSdtjL4-wp8rTjCpA85BkQD2fRoG7u=9_Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+v=Qh7eiLoN4YcnSdtjL4-wp8rTjCpA85BkQD2fRoG7u=9_Fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 08, 2018 at 09:25:29PM +0300, Vitaly Potyarkin wrote:

> # Truncating file names with Unicode characters
> 
> When shortening file names that contain Unicode characters, git performs
> truncation without awareness of two-byte characters. That often leads to
> splitting a character in half and displaying a garbage byte that's left.
> 
> Unawareness of Unicode also means that filename length is calculated incorrectly
> and some output gets misaligned.

Yeah, I agree it would be nice for this to be more aware of multi-byte
glyphs.

Unfortunately, we don't actually know what encoding the paths are in
(and they might not even all be in the same encoding). But hopefully we
could at least make the common case work a bit better. If we know that
core.quotepath is off, then the user is expecting paths in their
terminal encoding. So possibly we could just rely on
i18n.logOutputEncoding at that point (which of course defaults to utf8).

If anyone is interested in working on it, the relevant code is in
diff.c:show_stats(). Looks like we do a straight strlen() to get the
width, which should become utf8_strwidth(). That would solve the
problem where we use the wrong width.

To deal with the broken code points, I think you'd need to copy the name
into a strbuf and use strbuf_utf8_replace() to truncate (it doesn't seem
to be well documented, but you can grep for a few other callers).

-Peff
