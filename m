Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF9D20196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbcGNSQn (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:16:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:44760 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751098AbcGNSQl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 14:16:41 -0400
Received: (qmail 8445 invoked by uid 102); 14 Jul 2016 18:16:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:16:41 -0400
Received: (qmail 6675 invoked by uid 107); 14 Jul 2016 18:17:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:17:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 14:16:38 -0400
Date:	Thu, 14 Jul 2016 14:16:38 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 3/5] archive-tar: write extended headers for file
 sizes >= 8GB
Message-ID: <20160714181637.GA16497@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090916.GC17463@sigill.intra.peff.net>
 <ac016bb4-9f69-7e03-bc99-7a5bbc1a1a33@kdbg.org>
 <xmqq60s8rvpl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60s8rvpl.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 10:11:18AM -0700, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 30.06.2016 um 11:09 schrieb Jeff King:
> >> +/*
> >> + * This is the max value that a ustar size header can specify, as it is fixed
> >> + * at 11 octal digits. POSIX specifies that we switch to extended headers at
> >> + * this size.
> >> + */
> >> +#define USTAR_MAX_SIZE 077777777777UL
> >
> > This is too large by one bit for our 32-bit unsigned long on Windows:
> >
> > archive-tar.c: In function 'write_tar_entry':
> > archive-tar.c:295: warning: integer constant is too large for
> > unsigned long' type
> > archive-tar.c: In function 'write_global_extended_header':
> > archive-tar.c:332: warning: integer constant is too large for
> > unsigned long' type
> > archive-tar.c:335: warning: integer constant is too large for
> > unsigned long' type
> > archive-tar.c:335: warning: overflow in implicit constant conversion
> 
> Yikes.  I guess we need ULL here, and it cascade to all the
> variables used to interact with this constant, but not everybody has
> "long long", so....

On 32-bit systems, I suspect the tar limits are a non-issue. For real
filesystem operations, tar on such a system would use off_t. But we use
"unsigned long" internally for object sizes, so I imagine that objects
larger than 4G are simply impossible on such systems.

So one option would be to simply "#if"-out these checks on 32-bit
systems.

I think it would also be OK to just set USTAR_MAX_SIZE to ULONG_MAX on
such a system, too (which effectively eliminates the check, but keeps
the conditional bits contained).

-Peff
