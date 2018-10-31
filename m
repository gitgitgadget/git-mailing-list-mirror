Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF891F453
	for <e@80x24.org>; Wed, 31 Oct 2018 04:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeJaN1P (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 09:27:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:33784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728467AbeJaN1P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 09:27:15 -0400
Received: (qmail 7794 invoked by uid 109); 31 Oct 2018 04:30:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Oct 2018 04:30:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7199 invoked by uid 111); 31 Oct 2018 04:30:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 31 Oct 2018 00:30:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2018 00:30:51 -0400
Date:   Wed, 31 Oct 2018 00:30:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/3] check_stream_sha1(): handle input underflow
Message-ID: <20181031043051.GA5601@sigill.intra.peff.net>
References: <20181030231232.GA6141@sigill.intra.peff.net>
 <20181030232312.GB32038@sigill.intra.peff.net>
 <xmqqpnvqyc9x.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnvqyc9x.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 01:23:54PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The bug comes from commit f6371f9210 (sha1_file: add
> > read_loose_object() function, 2017-01-13), which
> > reimplemented some of the existing loose object functions.
> > So it's worth checking if this bug was inherited from any of
> > those. The answers seems to be no. The two obvious
> > candidates are both OK:
> >
> >   1. unpack_sha1_rest(); this doesn't need to loop on
> >      Z_BUF_ERROR at all, since it allocates the expected
> >      output buffer in advance (which we can't do since we're
> >      explicitly streaming here)
> >
> >   2. check_object_signature(); the streaming path relies on
> >      the istream interface, which uses read_istream_loose()
> >      for this case. That function uses a similar "is our
> >      output buffer full" check with Z_BUF_ERROR (which is
> >      where I stole it from for this patch!)
> 
> See 692f0bc7 to find who did the fix you stole from, and for what
> kind of breakage the original fix was made.

Heh. I did not dig into it, but actually thought "I'll bet Junio had to
get this right when he wrote the streaming code. No wonder he spotted my
mistake so quickly!".

> By the way, a very similar loop for pack_non_delta istream iterates
> while total_read is smaller than sz, but it does not have the same
> check upon BUF_ERROR to see if we've read everything.

Indeed. Did you find that one by inspection, or did you peek at:

  https://public-inbox.org/git/20130325202114.GD16019@sigill.intra.peff.net/

? :)

-Peff
