Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8941FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 20:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753835AbcLNUfV (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 15:35:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:56650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753085AbcLNUfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 15:35:20 -0500
Received: (qmail 21036 invoked by uid 109); 14 Dec 2016 20:33:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 20:33:52 +0000
Received: (qmail 28776 invoked by uid 111); 14 Dec 2016 20:34:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 15:34:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 15:33:49 -0500
Date:   Wed, 14 Dec 2016 15:33:49 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v9 5/5] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161214203349.6ym3v2ny2gonovx2@sigill.intra.peff.net>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-6-git-send-email-bmwill@google.com>
 <20161214164050.uxk434kzhw6au4c2@sigill.intra.peff.net>
 <20161214201323.GC20063@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214201323.GC20063@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 12:13:23PM -0800, Brandon Williams wrote:

> > I find it unlikely that anybody would ever care, but at least we'd do
> > the safe thing. I dunno. Maybe I am just being lazy.
> 
> Well, that's unfortunate!  It does sound like a more full-proof solution
> to these dumb http alternates could be involved.  I don't think your
> simple "lazy" solution may be enough to not just die by default.
> 
> By default ftp/ftps will have a policy of "user only" which means they
> will be set by the call to get_curl_allowed_protocol(-1) but not set by
> get_curl_allowed_protocol(0).  This would result in the call to
> check_alternates_protocol_restrictions failing all the time unless the
> user explicitly sets ftp/ftps to "always" or "never".  If that is the
> desired behavior then your proposed solution would be fine, otherwise we
> may have to do the more involved approach.

Oh, hrm, you're right. I was definitely meaning for this to kick in only
when you had explicitly configured a protocol to "user" (they'd still
need to enable redirects, but that's much more likely).

Arguably ftp should be on the "safe" list, since it's implemented via
the exact same code as https. That list comes originally from 33cfccbbf
(submodule: allow only certain protocols for submodule fetches,
2015-09-16), but that was just based on what I thought was reasonable at
the time.

I find it hard to believe anybody actually uses git-over-ftp these days,
let alone as a protocol redirect via http-alternates. But AFAIK it does
work.

One other "simple" fix is at the moment we parse http-alternates, to
parse the URL ourself and check the policy. Like:

  const char *protocols[] = {
	"http", "https", "ftp", "ftps"
  };

  for (i = 0; i < ARRAY_SIZE(protocols); i++) {
	const char *end;
	if (skip_prefix(url, protocols[i], end) && starts_with(end, "://"))
		break;
  }

  if (i >= ARRAY_SIZE(protocols))
	warning("ignoring alternate with unknown protocol: %s", url);
  else if (!is_transport_allowed(protocols[i], 0))
	warning("ignoring alternate with restricted protocol: %s", url);
  else {
	/* actually set up the alt struct */
  }

That keeps the logic nicely contained. The downside is that if our
interpretation of the URL is ever different than curl's, it could create
a security problem. The bit above seems fairly foolproof, though,
because it functions as a whitelist. So it doesn't matter if you can
trigger an http request via curl with exotic syntax; it matters whether
curl will trigger anything _besides_ an http syntax if the string starts
with "http://". Which seems unlikely.

I may have convinced myself this is a reasonable approach.

-Peff
