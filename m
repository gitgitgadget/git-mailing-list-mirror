Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C3F1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 13:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbcGTNtV (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 09:49:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:47479 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752499AbcGTNtU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 09:49:20 -0400
Received: (qmail 10583 invoked by uid 102); 20 Jul 2016 13:49:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:49:19 -0400
Received: (qmail 20735 invoked by uid 107); 20 Jul 2016 13:49:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:49:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 07:49:16 -0600
Date:	Wed, 20 Jul 2016 07:49:16 -0600
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: Looking for help to understand external filter driver code
Message-ID: <20160720134916.GB19359@sigill.intra.peff.net>
References: <67D9AC88-550E-4549-9AFD-2401B70B363B@gmail.com>
 <xmqqbn1th5qn.fsf@gitster.mtv.corp.google.com>
 <xmqqlh0xfoho.fsf@gitster.mtv.corp.google.com>
 <7B44C694-7CB2-411D-9CC6-7334CCBAD20B@gmail.com>
 <xmqqr3ape2ju.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr3ape2ju.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 02:33:09PM -0700, Junio C Hamano wrote:

> > Git writes --> 4 byte content length
> > Git writes --> content string
> > Git reads <-- 4 byte filtered content length
> > Git reads <-- filtered content
> 
> Do you really need to force the sender to know the length in
> advance?  Together with the sequential nature of the above exchange,
> i.e. the filter is forbidden from producing even a single byte of
> its output before reading everything Git feeds it, you are making it
> impossible to use filters that perform streaming conversion.

Another option: use pkt-lines with a flush packet to indicate
end-of-input. That allows arbitrary sized data, with streaming, and
reuses existing concepts from git. There is proportional overhead, but
it's only 4 bytes per 64k, which is a tiny percent.

It does make some implementations easier if they know the size ahead of
time, though, so if we are _sure_ that nobody will want streaming later,
it may not be a good tradeoff. If we do print a size ahead of time, the
"normal" thing in git would be to do so in base-10 ascii followed by a
newline (e.g., as found in "cat-file --batch", or fast-import's "data"
command).

-Peff
