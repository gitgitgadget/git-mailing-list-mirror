From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] sha1: use char type for temporary work buffer
Date: Wed, 12 Sep 2012 17:04:56 -0400
Message-ID: <20120912210455.GA30679@sigill.intra.peff.net>
References: <cover.1347442430.git.ydroneaud@opteya.com>
 <a8c30a998cad6a7b38bd983e7689a628567a8176.1347442430.git.ydroneaud@opteya.com>
 <20120912183833.GA20795@sigill.intra.peff.net>
 <1347482230.1961.4.camel@test.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 23:05:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBu7U-0001eM-TY
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 23:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab2ILVFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 17:05:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42811 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901Ab2ILVFC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 17:05:02 -0400
Received: (qmail 29095 invoked by uid 107); 12 Sep 2012 21:05:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Sep 2012 17:05:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Sep 2012 17:04:56 -0400
Content-Disposition: inline
In-Reply-To: <1347482230.1961.4.camel@test.quest-ce.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205339>

On Wed, Sep 12, 2012 at 10:37:10PM +0200, Yann Droneaud wrote:

> > > diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
> > > index b864df6..d29ff6a 100644
> > > --- a/block-sha1/sha1.h
> > > +++ b/block-sha1/sha1.h
> > > @@ -9,7 +9,7 @@
> > >  typedef struct {
> > >  	unsigned long long size;
> > >  	unsigned int H[5];
> > > -	unsigned int W[16];
> > > +	unsigned char W[64];
> > >  } blk_SHA_CTX;
> > 
> > Wouldn't this break all of the code that is planning to index "W" by
> > 32-bit words (see the definitions of setW in block-sha1/sha1.c)?
> > 
> That's not the same "W" ... This part of the code is indeed unclear.

Sorry, you're right, that's a different work array (though it has the
identical issue, no?). But the point still stands.  Did you audit the
block-sha1 code to make sure nobody is ever indexing the W array? If you
didn't, then your change is not safe. If you did, then you should really
mention that in the commit message.

> > If that is indeed the problem, wouldn't the simplest fix be using
> > uint32_t instead of "unsigned int"?
> 
> It's another way to fix this oddity, but not simpler.

It is simpler in the sense that it does not have any side effects (like
changing how every user of the data structure needs to index it).

> > Moreover, would that be sufficient to run on such a platform? At the
> > very least, "H" above would want the same treatment. And I would not be
> > surprised if some of the actual code in block-sha1/sha1.c needed
> > updating, as well.
> 
> ctx->H is actually used as an array of integer, so it would benefits of
> being declared uint32_t for an ILP64 system. This fix would also be
> required for blk_SHA1_Block() function.

So...if we are not ready to run on an ILP system after this change, then
what is the purpose?

-Peff
