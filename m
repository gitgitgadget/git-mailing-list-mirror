Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A53AC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A776023F
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhJLUoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:44:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:38004 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232986AbhJLUoE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 16:44:04 -0400
Received: (qmail 1606 invoked by uid 109); 12 Oct 2021 20:42:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 20:42:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16371 invoked by uid 111); 12 Oct 2021 20:42:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Oct 2021 16:42:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Oct 2021 16:42:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Waite <alex@waite.eu>, git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
Message-ID: <YWXzGeiUSMeq5Key@coredump.intra.peff.net>
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0ii3zl6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 10:47:01AM -0700, Junio C Hamano wrote:

> "Alex Waite" <alex@waite.eu> writes:
> 
> >   This works for all tested subdomains /except/ for those which contain an
> >   underscore.
> >
> >   authenticates without prompting:
> >     git clone https://testA.example.com
> >     git clone https://test-b.example.com
> >
> >   prompts for authentication:
> >     git clone https://test_c.example.com
> 
> Hmph, given that hostnames cannot have '_' (cf. RFC1123 2.1 "Host
> Names and Numbers", for example), the third URL seems invalid.  Is
> this even a bug?

That may be so for hostnames in general, but URLs seem to allow it. RFC
3986 says:

      host        = IP-literal / IPv4address / reg-name
      reg-name    = *( unreserved / pct-encoded / sub-delims )
      unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"

So underscore is definitely allowed in the host portion. Our code
complains during url_normalize(), in this code:

          if (allow_globs)
                  spanned = strspn(url, URL_HOST_CHARS "*");
          else
                  spanned = strspn(url, URL_HOST_CHARS);
  
          if (spanned < colon_ptr - url) {
                  /* Host name has invalid characters */
                  if (out_info) {
                          out_info->url = NULL;
                          out_info->err = _("invalid characters in host name");
                  }
                  strbuf_release(&norm);
                  return NULL;
          }

because earlier we define URL_HOST_CHARS without underscore:

  #define URL_HOST_CHARS URL_ALPHADIGIT ".-[:]" /* IPv6 literals need [:] */

I'm not sure why, given that this otherwise seems to match according to
the rfc. This code comes from 3402a8dc48 (config: add helper to
normalize and match URLs, 2013-07-31), but there's no mention of
underscore there. Possibly it came from earlier rules (rfc1738, for
example, has a stricter grammar that allows only alphabit and dashes).

I can't imagine it would cause any problems to allow it here (as noted,
we're perfectly happy to use the name in other contexts, and I don't
think there any syntactic gotchas here).

Adding "_" to that #define does make it work as expected.

-Peff
