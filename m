Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F55C11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD44B2084E
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgBXSMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:12:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:52838 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726208AbgBXSMF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:12:05 -0500
Received: (qmail 8557 invoked by uid 109); 24 Feb 2020 18:12:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 18:12:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11474 invoked by uid 111); 24 Feb 2020 18:21:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2020 13:21:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Feb 2020 13:12:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 07/24] t6300: abstract away SHA-1-specific constants
Message-ID: <20200224181204.GA2130083@coredump.intra.peff.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
 <20200222201749.937983-8-sandals@crustytoothpaste.net>
 <xmqqsgizrhjv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgizrhjv.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 10:01:08AM -0800, Junio C Hamano wrote:

> > -test_atom head objectsize 171
> > -test_atom head objectsize:disk 138
> > -test_atom head deltabase 0000000000000000000000000000000000000000
> > +test_atom head objectsize $((131 + hexlen))
> 
> 171 == 131 + 40 and that is because we are looking at the initial
> commit, whose contents has a single object name (i.e. its tree).

I wonder if it would be more readable to just pipe "cat-file" through
"wc -c", rather than hard-coding. Then there's no magic number at all.

> > +test_atom head objectsize:disk $disklen

Likewise for $disklen, if it's a loose object we could just get the
information from the filesystem. That would stop us caring about the
hash, _and_ it would make us robust to random changes in the zlib
compression.

I'm not sure if we also check packed objects. If so, you can compute the
size from the output of show-index, which gives the offsets of each
object. That's also how Git does it internally, though, so I'm not sure
if that is getting too close to just testing nothing (but IMHO the thing
we're really covering here is the format routines).

-Peff
