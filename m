Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368A31F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 07:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfACHQf (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 02:16:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:53586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728613AbfACHQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 02:16:35 -0500
Received: (qmail 24845 invoked by uid 109); 3 Jan 2019 07:16:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 07:16:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8504 invoked by uid 111); 3 Jan 2019 07:16:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 03 Jan 2019 02:16:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2019 02:16:33 -0500
Date:   Thu, 3 Jan 2019 02:16:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     randall.s.becker@rogers.com, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 1/4] transport-helper: use xread instead of read
Message-ID: <20190103071632.GB24149@sigill.intra.peff.net>
References: <20181228233556.5704-1-randall.s.becker@rogers.com>
 <xmqqbm4ykcdk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbm4ykcdk.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 02, 2019 at 12:55:51PM -0800, Junio C Hamano wrote:

> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  transport-helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/transport-helper.c b/transport-helper.c
> > index bf225c698f..a290695a12 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -1225,7 +1225,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
> >  		return 0;	/* No space for more. */
> >  
> >  	transfer_debug("%s is readable", t->src_name);
> > -	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> > +	bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> > - 	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
> > - 		errno != EINTR) {
> > + 	if (bytes < 0 && errno != EINTR) {
> >  		error_errno(_("read(%s) failed"), t->src_name);
> 
> Can't we also lose EINTR check, though?  When read() returns
> negative, we check errno and if it is EINTR, continue the loop.

Yes.

I also wondered if this caller might actually be relying on the current
non-looping behavior, but it looks like I already traced through and
determined this was OK:

  https://public-inbox.org/git/20180111063110.GB31213@sigill.intra.peff.net/

(the cleanup is correct either way, but that is what makes the
conversion to xread() OK).

We may want to just take the xread() conversion and then do the patch
that I linked above on top, since it also cleans up the xwrite() spot,
too.

-Peff
