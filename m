Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EBCB201A7
	for <e@80x24.org>; Tue, 16 May 2017 00:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbdEPAeT (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 20:34:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:52287 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbdEPAeT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 20:34:19 -0400
Received: (qmail 11463 invoked by uid 109); 16 May 2017 00:34:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 00:34:18 +0000
Received: (qmail 23165 invoked by uid 111); 16 May 2017 00:34:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 20:34:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 20:34:15 -0400
Date:   Mon, 15 May 2017 20:34:15 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
Message-ID: <20170516003414.yliltu5fsaudfhyu@sigill.intra.peff.net>
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
 <20170516002214.tlqkk4zrwdzcdjha@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170516002214.tlqkk4zrwdzcdjha@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 12:22:14AM +0000, brian m. carlson wrote:

> On Mon, May 15, 2017 at 03:13:44PM -0400, Ben Peart wrote:
> > +	istate->last_update = (time_t)ntohll(*(uint64_t *)index);
> > +	index += sizeof(uint64_t);
> > +
> > +	ewah_size = ntohl(*(uint32_t *)index);
> > +	index += sizeof(uint32_t);
> 
> To answer the question you asked in your cover letter, you cannot write
> this unless you can guarantee (((uintptr_t)index & 7) == 0) is true.
> Otherwise, this will produce a SIGBUS on SPARC, Alpha, MIPS, and some
> ARM systems, and it will perform poorly on PowerPC and other ARM
> systems[0].
> 
> If you got that pointer from malloc and have only indexed multiples of 8
> on it, you're good.  But if you're not sure, you probably want to use
> memcpy.  If the compiler can determine that it's not necessary, it will
> omit the copy and perform a direct load.

I think get_be32() does exactly what we want for the ewah_size read. For
the last_update one, we don't have a get_be64() yet, but it should be
easy to make based on the 16/32 versions.

(I note also that time_t is not necessarily 64-bits in the first place,
but David said something about this not really being a time_t).

-Peff
