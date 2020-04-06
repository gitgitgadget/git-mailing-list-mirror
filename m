Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2865BC2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 15:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFA023105
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 15:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgDFPa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:30:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:34408 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728777AbgDFPa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 11:30:29 -0400
Received: (qmail 24286 invoked by uid 109); 6 Apr 2020 15:30:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Apr 2020 15:30:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10713 invoked by uid 111); 6 Apr 2020 15:40:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Apr 2020 11:40:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Apr 2020 11:30:28 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Emma Brooks <me@pluvano.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: teach --no-encode-headers
Message-ID: <20200406153028.GA14775@coredump.intra.peff.net>
References: <20200405231109.8249-1-me@pluvano.com>
 <20200406030444.GG6369@camp.crustytoothpaste.net>
 <20200406133040.GB1276@coredump.intra.peff.net>
 <20200406151734.GH6369@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406151734.GH6369@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 03:17:34PM +0000, brian m. carlson wrote:

> > I did wonder if there are any standards around 8bit headers. Certainly
> > the de facto standard for local tools (e.g., mutt reading a message
> > you've edited in vim) is that they can be treated like a stream of
> > ASCII-compatible bytes, and that works pretty well in practice. But if
> > there's an IETF-endorsed method for 8bit headers, it would be nice to
> > use it. For 8bit bodies, we're able to give a content-transfer-encoding
> > and a content-type with the charset. But I don't know of an equivalent
> > for headers.
> 
> That's RFC 6532, Internationalized Email Headers, the companion document
> to RFC 6531.  (The RFC editor has cleverly kept the last digits in sync
> between the RFC 532x and 653x series).

Ah, thanks, that's exactly what I was looking for.

> The basic summary is that header field names are not internationalized,
> but the field values do allow UTF-8 if they contain unstructured text
> (e.g., Subject), anything using atoms (e.g., Message-ID), quoted strings
> (e.g., local-parts of an email address), domains, and a few other
> constructs.  RFC 2047 (MIME encoded words) is allowed "only in a subset
> of the places allowed by" RFC 6532, so just not encoding should be safe
> here, as long as it's UTF-8.

That makes sense. It looks like such messages are technically
message/global rather than message/rfc822. But since there's no
content-type given for the outermost message of an mbox, I guess that
just becomes implied.

The utf8 thing means that doing:

  git format-patch --encoding=iso8859-1 --no-encode-headers

violates the standard. But I think that's OK. If you really prefer that
charset for your local use, it does what you want. And if you try to
send it over SMTP and somebody complains, I think that falls under "if
it hurts, don't do that".

-Peff
