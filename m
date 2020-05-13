Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4E4C2D0FE
	for <git@archiver.kernel.org>; Wed, 13 May 2020 04:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B5D206D6
	for <git@archiver.kernel.org>; Wed, 13 May 2020 04:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgEMEuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 00:50:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:45048 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725898AbgEMEuC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 00:50:02 -0400
Received: (qmail 1144 invoked by uid 109); 13 May 2020 04:50:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 May 2020 04:50:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18341 invoked by uid 111); 13 May 2020 04:50:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2020 00:50:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 May 2020 00:50:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] http, imap-send: stop using CURLOPT_VERBOSE
Message-ID: <20200513045001.GA65110@coredump.intra.peff.net>
References: <cover.1589218693.git.jonathantanmy@google.com>
 <1df9e9deb7831b32694ea453759bf5d21952e165.1589218693.git.jonathantanmy@google.com>
 <20200512231331.GA6605@camp.crustytoothpaste.net>
 <xmqqwo5gwv7z.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo5gwv7z.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 12, 2020 at 05:10:24PM -0700, Junio C Hamano wrote:

> > On 2020-05-11 at 17:43:10, Jonathan Tan wrote:
> >> Whenever GIT_CURL_VERBOSE is set, teach Git to behave as if
> >> GIT_TRACE_CURL=1 and GIT_TRACE_CURL_NO_DATA=1 is set, instead of setting
> >> CURLOPT_VERBOSE.
> >> 
> >> This is to prevent inadvertent revelation of sensitive data. In
> >> particular, GIT_CURL_VERBOSE redacts neither the "Authorization" header
> >> nor any cookies specified by GIT_REDACT_COOKIES.
> >
> > I actually use GIT_CURL_VERBOSE to debug authentication problems from
> > time to time, so I'd like to keep an option to produce full, unredacted
> > output.  Since everyone uses HTTPS, it's not possible to perform this
> > debugging using a tool like Wireshark unless you use a MITM CA cert,
> > which seems excessive.
> 
> Hmm, that is a valid concern.  Introducing yet another environment
> feels a bit yucky, but something like GIT_NO_REDACT that disables
> any redacting, not limited to curl but in all codepaths, might turn
> out to be a useful escape hatch.
> 
> Opinions?

Having an environment variable was my first thought, as well. I do
think it's key that the default be to redact. That makes life slightly
harder for people debugging auth problems, but prevents people from
accidentally leaking private info.

Regarding the name:

  - should it be under GIT_TRACE_CURL_* to make its impact clear? Or do
    we imagine it might eventually be applied elsewhere?

  - doing GIT_TRACE_REDACT would get rid of the negative (and it could
    just default to "true")

-Peff
