Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F796207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 21:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755022AbcIPVqq (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 17:46:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:44431 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754074AbcIPVqp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 17:46:45 -0400
Received: (qmail 17343 invoked by uid 109); 16 Sep 2016 21:46:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Sep 2016 21:46:44 +0000
Received: (qmail 20783 invoked by uid 111); 16 Sep 2016 21:46:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Sep 2016 17:46:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Sep 2016 14:46:41 -0700
Date:   Fri, 16 Sep 2016 14:46:41 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH 1/3] mailinfo: refactor commit message processing
Message-ID: <20160916214641.ib7khsl3fbtn6smg@sigill.intra.peff.net>
References: <cover.1474047135.git.jonathantanmy@google.com>
 <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
 <cover.1474047135.git.jonathantanmy@google.com>
 <7dbb4bc0659056211b27f0033c73f0d558efdb54.1474047135.git.jonathantanmy@google.com>
 <xmqqoa3nk6a5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa3nk6a5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 12:12:50PM -0700, Junio C Hamano wrote:

> > +static int check_header_raw(struct mailinfo *mi,
> > +			    char *buf, size_t len,
> > +			    struct strbuf *hdr_data[], int overwrite) {
> > +	const struct strbuf sb = {0, len, buf};
> > +	return check_header(mi, &sb, hdr_data, overwrite);
> > +}
> 
> IIUC, this is a helper for callers that do not have a strbuf but
> instead have <buf, len> pair to perform the same check_header() the
> callers that have strbuf can do.
> 
> As check_header() uses the strbuf as a read-only entity, wrapping
> the <buf, len> pair in a temporary strbuf like this is safe.
> 
> The incoming <buf> should conceptually be "const char *", but it's
> OK.

I think the "right" way to do this would be to continue taking a "char
*", and then strbuf_attach() it. That saves us from unexpectedly
violating any strbuf invariants.

If our assumption that check_header() does not touch the
contents turns out to be wrong, neither strategy would inform our
caller, though. I think you'd want something like:

  assert(sb.buf == buf);

after check_header() returns (though I guess we are in theory protected
by the "const").

That being said...

> If check_header() didn't call any helper function that gets passed
> &sb as a strbuf, or if convertiong the helper function to take a
> <buf, len> pair instead, I would actually suggest refactoring this
> the other way around, though.  That is, move the implementation of
> check_header() to this function, updating its reference to line->buf
> and line->len to reference to <buf> and <len>, and then make
> check_header() a thin wrapper that does
> 
>         check_header(mi, const struct strbuf *line,
>                      struct strbuf *hdr_data[], int overwrite)
>         {
>                 return check_header_raw(mi, line->buf, line->len,
>                                         hdr_data, overwrite);
>         }

This is _way_ better, and it looks like check_header() could handle it
easily. Looking at it, I also suspect the cascading if in that function
could be made more pleasant by modeling cmp_header()'s interface after
skip_prefix_mem(), but that is totally orthogonal and optional.

-Peff
