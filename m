Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B61FC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 21:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE3020CC7
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 21:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgA0VTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:19:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:45700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725955AbgA0VTe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 16:19:34 -0500
Received: (qmail 3661 invoked by uid 109); 27 Jan 2020 21:19:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Jan 2020 21:19:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1172 invoked by uid 111); 27 Jan 2020 21:27:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jan 2020 16:27:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jan 2020 16:19:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] avoid computing zero offsets from NULL pointer
Message-ID: <20200127211933.GA3794@coredump.intra.peff.net>
References: <20200125053542.GA744596@coredump.intra.peff.net>
 <20200125053834.GB744673@coredump.intra.peff.net>
 <xmqq7e1cbr9w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e1cbr9w.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 12:03:55PM -0800, Junio C Hamano wrote:

> > diff --git a/xdiff-interface.c b/xdiff-interface.c
> > index 8509f9ea22..2f1fe48512 100644
> > --- a/xdiff-interface.c
> > +++ b/xdiff-interface.c
> > @@ -84,8 +84,8 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b)
> >  {
> >  	const int blk = 1024;
> >  	long trimmed = 0, recovered = 0;
> > -	char *ap = a->ptr + a->size;
> > -	char *bp = b->ptr + b->size;
> > +	char *ap = a->ptr ? a->ptr + a->size : a->ptr;
> > +	char *bp = b->ptr ? b->ptr + b->size : b->ptr;
> >  	long smaller = (a->size < b->size) ? a->size : b->size;
> >  
> >  	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {
> 
> Isn't it a bug for a->ptr or b->ptr to be NULL here?  Even if we
> manage to assign ap = a->ptr = NULL without complaints, how would
> that memcmp work?
> 
> Is it that the corresponding .size would always be 0 if .ptr is NULL
> that protects us?
> 
> A bit puzzled.

Yes, that's what's happening; all of the cases in this first patch are
dealing with "NULL + 0". Which isn't to say somebody couldn't pass in an
mmfile_t with NULL and a non-zero size, but obviously that would be a
bug. Before my patch that would be a segfault, but afterwards we'd
quietly treat it as if the size were zero.

If we want to be more defensive, we could do something like this:

  /* dual inline/macro magic to avoid evaluating ptr twice but knowing
   * enough about the type of *ptr to get the size. */
  #define SAFE_END_PTR(ptr, len) safe_end_ptr(ptr, len, sizeof(*ptr))
  static inline void *safe_end_ptr(void *ptr, size_t nr, size_t elem_size)
  {
	if (!ptr) {
		if (nr)
			BUG("non-zero size coupled with NULL pointer");
		return NULL;
	}
	return (char *)ptr + nr * elem_size;
  }

  ...
  char *ap = SAFE_END_PTR(a->ptr, a->size);

I'm not sure if it's worth it, though.

Yet another alternative is to consider it a bug to use an mmfile_t with
a NULL pointer, figure out where that's being set up, and fix it.

As an aside, I also wondered whether we could run into problems with
"memcmp(NULL, ..., 0)", which is also undefined behavior. But we don't
here because the first half of the while() condition wouldn't trigger.

-Peff
