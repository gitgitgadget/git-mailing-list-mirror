Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 346C1208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 08:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbdHTI7R (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 04:59:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:43918 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752722AbdHTI7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 04:59:16 -0400
Received: (qmail 24630 invoked by uid 109); 20 Aug 2017 08:59:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 08:59:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12773 invoked by uid 111); 20 Aug 2017 08:59:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 04:59:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 04:59:14 -0400
Date:   Sun, 20 Aug 2017 04:59:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Tom G. Christensen" <tgc@jupiterrise.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] http: Fix handling of missing CURLPROTO_*
Message-ID: <20170820085913.w6pxal3hlpwbio74@sigill.intra.peff.net>
References: <cover.1502462884.git.tgc@jupiterrise.com>
 <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com>
 <cover.1502462884.git.tgc@jupiterrise.com>
 <4d29d43d458f61c6dabca093f591ad8698ca2ceb.1502462884.git.tgc@jupiterrise.com>
 <xmqqo9rly6dx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9rly6dx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 05:30:34PM -0700, Junio C Hamano wrote:

> > -#if LIBCURL_VERSION_NUM >= 0x071304
> > +#ifdef CURLPROTO_HTTP
> >  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
> >  			 get_curl_allowed_protocols(0));
> >  	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
> 
> This may make the code to _compile_, but is it sensible to let the
> code build and be used by the end users without the "these protocols
> are safe" filter, I wonder?  
> 
> Granted, ancient code was unsafe and people were happily using it,
> but now we know better, and more importantly, we have since added
> users of transport (e.g. blindly fetch submodules recursively) that
> may _rely_ on this layer of the code safely filtering unsafe
> protocols, so...

I don't think Tom's patch changes this in any meaningful way. The
"fallback to skipping the safety and showing a warning" dates back to
the original introduction of the feature.

But FWIW, that is exactly the kind of thing that led me to wanting to
implement a hard cutoff in the first place. The warning is small
consolation if Git allows an attack through anyway. Or worse, you don't
even see the warning because it's an automated process that is being
exploited.

There's a good chance if you have such an antique curl that it is also
riddled with other curl-specific bugs that have since been fixed. And
that would argue that we don't need to care that much anyway; people
running old curl have decided that it's not worth caring about the
security implications.

But in the case of RHEL, in theory they are patching security bugs in
curl but just not implementing new features. So if we have a
vulnerability introduced by using an old version of curl, we really are
making things worse. And that argues for having a hard cutoff.

But as Tom's series demonstrates, they are backporting _some_ features
(presumably ones needed by other programs like Git to fix security
bugs). Which argues for having #ifdefs that handle those backports,
which in theory gives us a secure Git on systems that do careful
backporting, and gives us an insecure-but-not-worse-than-it-already-was
Git on systems that don't do backporting.

I dunno. There were a lot of assumptions and mental gymnastics there.
I'm still tempted to target curl >= 7.19.4 just based on timing and
RHEL5's support life-cycle.

-Peff
