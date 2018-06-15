Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30E091F403
	for <e@80x24.org>; Fri, 15 Jun 2018 17:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936294AbeFOR06 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 13:26:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:45964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S936223AbeFOR06 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 13:26:58 -0400
Received: (qmail 22126 invoked by uid 109); 15 Jun 2018 17:26:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 17:26:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23168 invoked by uid 111); 15 Jun 2018 17:27:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 13:27:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 13:26:56 -0400
Date:   Fri, 15 Jun 2018 13:26:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Luat Nguyen <root@l4w.io>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] ewah_read_mmap: bounds-check mmap reads
Message-ID: <20180615172656.GB3067@sigill.intra.peff.net>
References: <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615033112.GA20390@sigill.intra.peff.net>
 <xmqqsh5o0yl5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsh5o0yl5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 10:05:42AM -0700, Junio C Hamano wrote:

> > -	memcpy(self->buffer, ptr, self->buffer_size * sizeof(eword_t));
> > -	ptr += self->buffer_size * sizeof(eword_t);
> 
> 
> > +	data_len = st_mult(self->buffer_size, sizeof(eword_t));
> 
> This is a faithful conversion from the original, but I somehow would
> have appreciated if the latter were not sizeof(eword_t) but rather
> sizeof(self->buffer_size[0]), especially as I wondered ...

I actually thought about going the _other_ way. The sizeof(eword_t) is
not something we can change, but is actually decided by the on-disk
format.  So I wondered if this should be much more clearly "hey, this is
8 bytes". Possibly with an assert(sizeof(*self->buffer_size) == 8).

And yes, I think having the on-disk format specify the size in 8-byte
double words is vaguely crazy. Blame JGit. ;) Or maybe even blame the
original EWAH authors, this may have originated even earlier (I didn't
dig).

> > +	if (len < data_len)
> > +		return error("corrupt ewah bitmap: eof in data "
> > +			     "(%"PRIuMAX" bytes short)",
> > +			     (uintmax_t)(data_len - len));
> > +	memcpy(self->buffer, ptr, data_len);
> > +	ptr += data_len;
> > +	len -= data_len;
> >  
> >  	for (i = 0; i < self->buffer_size; ++i)
> >  		self->buffer[i] = ntohll(self->buffer[i]);
> 
> ... what individual datum one iteration of this loop is copying, and
> then realized "buffer_size" is a misleading field name (anything that 
> claims to be size and not measuring in bytes is misleading to me ;-).

Yeah, it confused me at first, too. I don't mind changing these kinds of
cosmetics, but I'd like to do it in a separate patch from this fix.

> > -	return (3 * 4) + (self->buffer_size * 8);
> > +	return ptr - (const uint8_t *)map;
> 
> Much nicer; I needed to wonder what these 12 and 8 in the original are.

Me too. ;)

> >  int ewah_deserialize(struct ewah_bitmap *self, int fd);
> > -int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len);
> > +ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len);
> 
> I double checked all the callers and made sure that they are already
> prepared to react sensibly to error returns, which is good.

Yep, modulo the int/ssize_t thing from the fourth patch.

-Peff
