Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75DF1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 23:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeJaIID (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 04:08:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:33494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727430AbeJaIID (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 04:08:03 -0400
Received: (qmail 28679 invoked by uid 109); 30 Oct 2018 23:12:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Oct 2018 23:12:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5245 invoked by uid 111); 30 Oct 2018 23:11:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Oct 2018 19:11:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2018 19:12:32 -0400
Date:   Tue, 30 Oct 2018 19:12:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Infinite loop regression in git-fsck in v2.12.0
Message-ID: <20181030231232.GA6141@sigill.intra.peff.net>
References: <20170113175944.tdbfqx3e4xhris7m@sigill.intra.peff.net>
 <878t2fkxrn.fsf@evledraar.gmail.com>
 <20181030213505.GA11319@sigill.intra.peff.net>
 <xmqq4ld3134f.fsf@gitster-ct.c.googlers.com>
 <20181030225603.GA5889@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181030225603.GA5889@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 06:56:03PM -0400, Jeff King wrote:

> > >  	while (total_read <= size &&
> > > +	       stream->avail_in > 0 &&
> > >  	       (status == Z_OK || status == Z_BUF_ERROR)) {
> > >  		stream->next_out = buf;
> > >  		stream->avail_out = sizeof(buf);
> > 
> > Hmph.  If the last round consumed the final input byte and needed
> > output space of N bytes, but only M (< N) bytes of the output space
> > was available, then it would have reduced both avail_in and
> > avail_out down to zero and yielded Z_BUF_ERROR, no?  Or would zlib
> > refrain from consuming that final byte (leaving avail_in to at least
> > one) and give us Z_BUF_ERROR in such a case?
> 
> Hmm, yeah, good thinking. I think zlib could consume that final byte
> into its internal buffer.
> 
> As part of my digging, I looked at how the loose streaming code handles
> this. It checks that when we see Z_BUF_ERROR, we actually did run out of
> output bytes (so if we didn't, then we know it's not the case we
> expected to be looping on).
> 
> I have some patches almost ready to send; I'll use that technique.

And here they are.

  [1/3]: t1450: check large blob in trailing-garbage test
  [2/3]: check_stream_sha1(): handle input underflow
  [3/3]: cat-file: handle streaming failures consistently

 builtin/cat-file.c | 16 ++++++++++++----
 sha1-file.c        |  3 ++-
 t/t1450-fsck.sh    | 23 +++++++++++++++++++++--
 3 files changed, 35 insertions(+), 7 deletions(-)

-Peff
