Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A8971F462
	for <e@80x24.org>; Tue,  4 Jun 2019 17:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfFDRWm (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 13:22:42 -0400
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:50432 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbfFDRWl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jun 2019 13:22:41 -0400
Received: from resomta-po-16v.sys.comcast.net ([96.114.154.240])
        by resqmta-po-11v.sys.comcast.net with ESMTP
        id YCyAhjGhs1WmwYD8zhH5YD; Tue, 04 Jun 2019 17:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559668961;
        bh=yb/3bmCxfkmp9qCibnaQ+8/mKsilzE0ZV2Cal8MECdc=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=w6y5SmR1RBU4SLxp9Wq1EWQmWXC8C07Qrohowb+sfW56mAC1EbJsjM+p7nGXSLDfY
         aAm1r318RhNFQqD/Qd0cNd5usy+wcBAplBp9WAI6A0cABBk1S6eqid1X/gTOasUi6D
         iphRxxjMnlzNCD235X1VbexmIu3i7s9uQyeutzsB8SHl+ij7G1qMwOLJ5BvrRXZMBH
         6n/J/XTNnLY12Z/wyh3ulS2EGH64ZMlTZUH/oexbZ2i/3XW4T16rNUzLdA8ke9sgJx
         fptQYPs2MptiVALd5veJGvfiX+0C7S4/ExJz8++9uVtLge5WTub45n+ZBPdxeL3hH1
         GhWzsk/bmSveQ==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:f95f:aa00:d2b2:a5dd])
        by resomta-po-16v.sys.comcast.net with ESMTPSA
        id YD8whldunsSGLYD8yh4Pvd; Tue, 04 Jun 2019 17:22:40 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Tue, 4 Jun 2019 10:22:38 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jeffhost@microsoft.com, gitster@pobox.com, spearce@spearce.org,
        jrn@google.com, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] url: do not read past end of buffer
Message-ID: <20190604172238.GJ4641@comcast.net>
References: <20190603204526.7723-1-matvore@google.com>
 <20190603204526.7723-2-matvore@google.com>
 <18ab56e2-3b25-8cfd-438d-72f49145adc4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18ab56e2-3b25-8cfd-438d-72f49145adc4@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 07:00:34AM +0200, René Scharfe wrote:
> Am 03.06.19 um 22:45 schrieb Matthew DeVore:
> > url_decode_internal could have been tricked into reading past the length
> > of the **query buffer if there are fewer than 2 characters after a % (in
> > a null-terminated string, % would have to be the last character).
> > Prevent this from happening by checking len before decoding the %
> > sequence.
> >
> > Signed-off-by: Matthew DeVore <matvore@google.com>
> > ---
> >  url.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/url.c b/url.c
> > index 25576c390b..c0bb4e23c3 100644
> > --- a/url.c
> > +++ b/url.c
> > @@ -39,21 +39,21 @@ static char *url_decode_internal(const char **query, int len,
> >  		unsigned char c = *q;
> >
> >  		if (!c)
> >  			break;
> >  		if (stop_at && strchr(stop_at, c)) {
> >  			q++;
> >  			len--;
> >  			break;
> >  		}
> >
> > -		if (c == '%') {
> > +		if (c == '%' && len >= 3) {
> 
> Tricky.  hex2chr() makes sure to not run over the end of NUL-terminated
> strings, but url_decode_internal() is supposed to honor the parameter
> len as well.  Your change disables %-decoding for the two callers that
> pass -1 as len, though.  So perhaps like this?
> 
> 		if (c == '%' && (len < 0 || len >= 3)) {

I've applied this and will include it in the next roll-up. Thank you for
catching it. (I'm disappointed that I missed it and that there were no tests to
catch the mistake.)
