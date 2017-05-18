Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4F7201A7
	for <e@80x24.org>; Thu, 18 May 2017 04:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754219AbdEREwM (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 00:52:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:54044 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754021AbdEREwL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 00:52:11 -0400
Received: (qmail 673 invoked by uid 109); 18 May 2017 04:52:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 04:52:10 +0000
Received: (qmail 14622 invoked by uid 111); 18 May 2017 04:52:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 00:52:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 May 2017 00:52:07 -0400
Date:   Thu, 18 May 2017 00:52:07 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Ben Peart <peartben@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        pclouds@gmail.com, johannes.schindelin@gmx.de,
        David.Turner@twosigma.com
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
Message-ID: <20170518045207.gd26sq5qdbxg6vnm@sigill.intra.peff.net>
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
 <20170516002214.tlqkk4zrwdzcdjha@genre.crustytoothpaste.net>
 <20170516003414.yliltu5fsaudfhyu@sigill.intra.peff.net>
 <2d965a87-36da-23b4-4bc5-97de47f3d7f7@gmail.com>
 <29122818-71fb-5af9-59b1-03387f014151@gmail.com>
 <134ea57f-3a64-f7b5-67dd-8b14ff3cc04a@kdbg.org>
 <0a3f38b7-788b-b364-3fef-83191e4b9bea@gmail.com>
 <2e5ea82d-3b8f-f508-e2af-5f193241a573@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e5ea82d-3b8f-f508-e2af-5f193241a573@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 08:15:03PM +0200, Johannes Sixt wrote:

> Am 17.05.2017 um 16:26 schrieb Ben Peart:
> > On 5/16/2017 3:13 PM, Johannes Sixt wrote:
> > > Am 16.05.2017 um 19:17 schrieb Ben Peart:
> > > > OK, now I'm confused as to the best path for adding a get_be64.  This
> > > > one is trivial:
> > > > 
> > > > #define get_be64(p)    ntohll(*(uint64_t *)(p))
> > > 
> > > I cringe when I see a cast like this. Unless you can guarantee that p is
> > > char* (bare or signed or unsigned), you fall pray to strict aliasing
> > > violations, aka undefined behavior. And I'm not even mentioning correct
> > > alignment, yet.
> > 
> > Note, this macro is only used where the CPU architecture is OK with
> > unaligned memory access.
> 
> I'm not worried about the unaligned memory access: It either works, or we
> get a SIGBUS. The undefined behavior is more worrisome because the code may
> work or not, and we can never be sure which it is.

I don't think there's much we can do, though. That's how all of the
get_be* macros are designed to work (and there's really no point in
using them on something that isn't a char pointer).

I agree it would be nice to have some type safety there if we can get
it, though. I wonder if:

  static inline uint32_t get_be32(unsigned char *p)
  {
	return ntohl(*(unsigned int *)p);
  }

would generate the same code. It does mean we may have problems between
signed/unsigned buffers, though.

-Peff
