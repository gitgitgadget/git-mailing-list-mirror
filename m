Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1801120705
	for <e@80x24.org>; Wed,  7 Sep 2016 06:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754746AbcIGGiY (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 02:38:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:39140 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754591AbcIGGiX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 02:38:23 -0400
Received: (qmail 4083 invoked by uid 109); 7 Sep 2016 06:38:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 06:38:21 +0000
Received: (qmail 774 invoked by uid 111); 7 Sep 2016 06:38:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 02:38:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 02:38:19 -0400
Date:   Wed, 7 Sep 2016 02:38:19 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: support folding in rfc2822 footer
Message-ID: <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
References: <1472846322-5592-1-git-send-email-jonathantanmy@google.com>
 <xmqqy439rabb.fsf@gitster.mtv.corp.google.com>
 <29cb0f55-f729-80af-cdca-64e927fa97c0@google.com>
 <fbdda11c-c53e-f9fc-8b3a-934810215c5f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbdda11c-c53e-f9fc-8b3a-934810215c5f@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 06, 2016 at 04:30:24PM -0700, Jonathan Tan wrote:

> On 09/06/2016 03:08 PM, Jonathan Tan wrote:
> > On 09/02/2016 07:23 PM, Junio C Hamano wrote:
> > > A slightly related tangent.  An unconditionally good change you
> > > could make is to allow folding of in-body headers.  I.e. you can
> > > have e.g.
> > > 
> > >     -- >8 --
> > >     Subject: [PATCH] sequencer: support in-body headers that are
> > >          folded according to RFC2822 rules
> > > 
> > >     The first paragraph after the above long title begins
> > >     here...
> > > 
> > > in the body of the msssage, and I _think_ we do not fold it properly
> > > when applying such a patch.  We should, as that is something that
> > > appears in format-patch output (i.e. something Git itself produces,
> > > unlike the folded "footer").
> > 
> > OK, I'll take a look at this.
> 
> It turns out that Git seems to already do this, at least for Subject.

Right, because "Subject" is actually a real RFC 2822 header in the
generated email message. Not only do we expect things like mail readers
to handle this, but we _have_ to wrap at a certain point to meet the
standard[1].

I don't think any part of Git ever shunts "Subject" to an in-body
header, though I'd guess people do it manually all the time. 

> $ git format-patch HEAD^
> 0001-this-is-a-very-long-subject-to-test-line-wrapping-th.patch
> $ cat 0001-this-is-a-very-long-subject-to-test-line-wrapping-th.patch
> <snip>
> Subject: [PATCH] this is a very long subject to test line wrapping this is a
>  very long subject to test line wrapping
> <snip>

So the interesting bit is what happens with:

  git checkout master^
  git am 0001-*

and with:

  perl -lpe '
    # Bump subject down to in-body header.
    if (/^Subject:/) {
	print "Subject: real subject";
	print "";
    }
  ' 0001-* >patch
  git checkout master^
  git am patch

It looks like we get the first one right, but not the second.

-Peff

[1] A careful reader may note that arbitrarily-long body lines,
    including in-body headers and footers, may _also_ run afoul of
    the body line-length limits. The "right" solution there is
    probably quoted-printable, but it's ugly enough that I wouldn't do
    so unless we see a real-world case where the line lengths are a
    problem.
