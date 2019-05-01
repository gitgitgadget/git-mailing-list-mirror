Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A121F453
	for <e@80x24.org>; Wed,  1 May 2019 18:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfEASoG (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:44:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:46124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726079AbfEASoG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:44:06 -0400
Received: (qmail 23658 invoked by uid 109); 1 May 2019 18:44:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 18:44:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21087 invoked by uid 111); 1 May 2019 18:44:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 14:44:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 14:44:03 -0400
Date:   Wed, 1 May 2019 14:44:03 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Make fread/fwrite-like functions in http.c more like
 fread/fwrite.
Message-ID: <20190501184403.GG4109@sigill.intra.peff.net>
References: <20190501085635.7125-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190501085635.7125-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 05:56:35PM +0900, Mike Hommey wrote:

> The fread/fwrite-like functions in http.c, namely fread_buffer,
> fwrite_buffer, fwrite_null, fwrite_sha1_file all return the
> multiplication of the size and number of items they are being given.
> 
> Practically speaking, it doesn't matter, because in all contexts where
> those functions are used, size is 1.

Wow, this is a long-standing bug. :)

I think it's further confused by curl's documentation. E.g.,
CURLOPT_WRITEFUNCTION says:

  Your callback should return the number of bytes actually taken care of.

To me, "number of bytes" implies implies size * nmemb. But earlier it
says:

  ptr points to the delivered data, and the size of that data is nmemb;
  size is always 1.

So I think they just use "nmemb" and "bytes" interchangeably. Which is
correct, but misleading if you didn't read the whole thing.

At any rate, I think your patch is worth applying. It should have no
impact when used with curl, and is one less gotcha for somebody trying
to use these elsewhere.

Another option would be to actually assert(eltsize == 1), and then just
use nmemb consistently. That might make the logic a little easier to
follow, but I doubt it matters much either way.

-Peff
