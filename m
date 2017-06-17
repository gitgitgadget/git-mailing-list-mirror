Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2516820282
	for <e@80x24.org>; Sat, 17 Jun 2017 12:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbdFQMTh (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 08:19:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:42001 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752967AbdFQMTg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 08:19:36 -0400
Received: (qmail 19196 invoked by uid 109); 17 Jun 2017 12:19:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 17 Jun 2017 12:19:36 +0000
Received: (qmail 13798 invoked by uid 111); 17 Jun 2017 12:19:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 17 Jun 2017 08:19:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Jun 2017 08:19:34 -0400
Date:   Sat, 17 Jun 2017 08:19:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] sha1_file: consolidate storage-agnostic object fns
Message-ID: <20170617121934.a6onn7f2luhkuuym@sigill.intra.peff.net>
References: <cover.1497387713.git.jonathantanmy@google.com>
 <cover.1497035376.git.jonathantanmy@google.com>
 <cover.1497387713.git.jonathantanmy@google.com>
 <33a75a60b1d4298ec0af21c0df19e12bb0e43e2d.1497387714.git.jonathantanmy@google.com>
 <xmqq7f0d2l8p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f0d2l8p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 10:50:46AM -0700, Junio C Hamano wrote:

> >  	if (!find_pack_entry(real, &e)) {
> >  		/* Most likely it's a loose object. */
> > -		if (!sha1_loose_object_info(real, oi, flags)) {
> > +		if (oi && !sha1_loose_object_info(real, oi, flags)) {
> >  			oi->whence = OI_LOOSE;
> >  			return 0;
> >  		}
> > +		if (!oi && has_loose_object(real))
> > +			return 0;
> 
> This conversion is not incorrect per-se.  
> 
> We can see that has_sha1_file_with_flags() after this patch still
> calls has_loose_object().  But it bothers me that there is no hint
> to future developers to warn that a rewrite of the above like this
> is incorrect:
> 
>         if (!find_pack_entry(read, &e)) {
>                 /* Most likely it's a loose object. */
>        +        struct object_info dummy_oi;
>        +        if (!oi) {
>        +                memset(&dummy_oi, 0, sizeof(dummy_oi);
>        +                oi = &dummy_oi;
>        +        }
>        -        if (oi && !sha1_loose_object_info(real, oi, flags)) {
>        +        if (!sha1_loose_object_info(real, oi, flags)) {
>                         oi->whence = OI_LOOSE;
>                         return 0;
>                 }
>        -        if (!oi && has_loose_object(real))
>        -                return 0;
> 
> It used to be very easy to see that has_sha1_file_with_flags() will
> call has_loose_object() when it does not find the object in a pack,
> which will result in the loose object file freshened.  In the new
> code, it is very subtle to see that---it will happen when the caller
> passes oi == NULL, and has_sha1_file_with_flags() is such a caller,
> but it is unclear if there are other callers of this "consolidated"
> sha1_object_info_extended() that passes oi == NULL, and if they do
> also want to freshen the loose object file when they do so.

I also found this quite subtle. However, I don't think that
has_sha1_file() actually freshens. It's a bit confusing because
has_loose_object() reuses the check_and_freshen() function to do the
lookup, but it actually sets the "freshen" flag to false.

That's why in 33d4221c7 (write_sha1_file: freshen existing objects,
2014-10-15), which introduced the freshening functions and converted
has_loose_object(), the actual write_sha1_file() function switched to
using the freshening functions directly (and obviously sets the freshen
parameter to true).

I actually think all of that infrastructure could become part of
Jonathan's consolidated lookup, too. We would just need:

  1. A QUICK flag to avoid re-reading objects/pack when we don't find
     anything (which it looks like he already has).

  2. A FRESHEN flag to update the mtime of any item that we do find.

I suspect we may also need something like ONLY_LOOSE and ONLY_NONLOCAL
to meet all the callers (e.g., has_loose_object_nonlocal). Those should
be easy to implement, I'd think.

> I would have preferred to see the new variable not to be called 'f',
> as that makes it unclear what it is (is that a callback function
> pointer?).  In this case, uyou are forcing the flag bits passed
> down, so perhaps you can reuse the same variable?  
> 
> If you allocated a separate variable because
> has_sha1_file_with_flags() and sha1_object_info_extended() take flag
> bits from two separate vocabularies, that is a valid reasoning, but
> if that is the case, then I would have named 'f' to reflect that
> fact that this is different from parameter 'flag' that is defined in
> the has_sha1_file_with_flags() world, but a different thing that is
> defined in sha1_object_info_extended() world, e.g. "soie_flag" or
> something like that.

I had the same thoughts (both on the name and the "vocabularies"). IMHO
we should consider allocating the bits from the same set. There's only
one HAS_SHA1 flag, and it has an exact match in OBJECT_INFO_QUICK.

I think this patch might be a bit easier to review if it were broken
down more in a sequence of:

  1. Add features to the consolidated function to support everything
     that function X supports.

  2. Preparatory cleanup around X (e.g., pointing HAS_SHA1_QUICK at
     OBJECT_INFO_QUICK).

  3. Convert X to use the consolidated function.

  4. Repeat for each X we wish to consolidate.

That's going to end up with probably 12 patches instead of one, but I
think it may be a lot easier to communicate the reason for the various
design decisions.

-Peff
