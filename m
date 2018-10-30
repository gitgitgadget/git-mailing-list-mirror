Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42DC1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJaHva (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:51:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:33456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726077AbeJaHva (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:51:30 -0400
Received: (qmail 28059 invoked by uid 109); 30 Oct 2018 22:56:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Oct 2018 22:56:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5097 invoked by uid 111); 30 Oct 2018 22:55:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Oct 2018 18:55:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2018 18:56:03 -0400
Date:   Tue, 30 Oct 2018 18:56:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Infinite loop regression in git-fsck in v2.12.0
Message-ID: <20181030225603.GA5889@sigill.intra.peff.net>
References: <20170113175944.tdbfqx3e4xhris7m@sigill.intra.peff.net>
 <878t2fkxrn.fsf@evledraar.gmail.com>
 <20181030213505.GA11319@sigill.intra.peff.net>
 <xmqq4ld3134f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4ld3134f.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 07:28:00AM +0900, Junio C Hamano wrote:

> > So we need to distinguish those cases. I think this is the simplest fix:
> >
> > diff --git a/sha1-file.c b/sha1-file.c
> > index dd0b6aa873..a7ff5fe25d 100644
> > --- a/sha1-file.c
> > +++ b/sha1-file.c
> > @@ -2199,6 +2199,7 @@ static int check_stream_sha1(git_zstream *stream,
> >  	 * see the comment in unpack_sha1_rest for details.
> >  	 */
> >  	while (total_read <= size &&
> > +	       stream->avail_in > 0 &&
> >  	       (status == Z_OK || status == Z_BUF_ERROR)) {
> >  		stream->next_out = buf;
> >  		stream->avail_out = sizeof(buf);
> 
> Hmph.  If the last round consumed the final input byte and needed
> output space of N bytes, but only M (< N) bytes of the output space
> was available, then it would have reduced both avail_in and
> avail_out down to zero and yielded Z_BUF_ERROR, no?  Or would zlib
> refrain from consuming that final byte (leaving avail_in to at least
> one) and give us Z_BUF_ERROR in such a case?

Hmm, yeah, good thinking. I think zlib could consume that final byte
into its internal buffer.

As part of my digging, I looked at how the loose streaming code handles
this. It checks that when we see Z_BUF_ERROR, we actually did run out of
output bytes (so if we didn't, then we know it's not the case we
expected to be looping on).

I have some patches almost ready to send; I'll use that technique.

-Peff
