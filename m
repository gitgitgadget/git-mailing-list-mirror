Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C5021F803
	for <e@80x24.org>; Thu, 10 Jan 2019 06:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfAJGkd (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 01:40:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:60386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726776AbfAJGkd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 01:40:33 -0500
Received: (qmail 2054 invoked by uid 109); 10 Jan 2019 06:40:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Jan 2019 06:40:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29402 invoked by uid 111); 10 Jan 2019 06:40:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 Jan 2019 01:40:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jan 2019 01:40:31 -0500
Date:   Thu, 10 Jan 2019 01:40:31 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] tree-walk object_id refactor
Message-ID: <20190110064030.GB20497@sigill.intra.peff.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110042551.915769-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 04:25:46AM +0000, brian m. carlson wrote:

> There are a small number of places in our codebase where we cast a
> buffer of unsigned char to a struct object_id pointer. When we have
> GIT_MAX_RAWSZ set to 32 (because we have SHA-256), one of these places
> (the buffer for tree objects) can lead to us copying too much data when
> using SHA-1 as the hash, since there are only 20 bytes to read.
> 
> This was not expected to be a problem before future code was introduced,
> but due to a combination of series the issue became noticeable.
> 
> This series introduces a refactor to avoid referencing the struct
> object_id directly from a buffer and instead storing an additional
> struct object_id (and an int) in struct name_entry and referring to
> that.

I think this is really the only safe and sane solution. We resisted it
because of the cost of the extra copies (especially the
update_tree_entry() one). But I don't know that anybody actually
measured it. Do you have any performance numbers before/after this
series?

-Peff
