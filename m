From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] strbuf_split_buf(): use ALLOC_GROW()
Date: Thu, 8 Nov 2012 11:38:03 -0500
Message-ID: <20121108163803.GE15560@sigill.intra.peff.net>
References: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
 <1352011614-29334-2-git-send-email-mhagger@alum.mit.edu>
 <20121104114101.GA336@sigill.intra.peff.net>
 <5098C21F.6030803@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 08 17:38:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWV7V-00012Q-7O
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 17:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756356Ab2KHQiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 11:38:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36425 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756357Ab2KHQiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 11:38:07 -0500
Received: (qmail 30608 invoked by uid 107); 8 Nov 2012 16:38:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 11:38:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 11:38:03 -0500
Content-Disposition: inline
In-Reply-To: <5098C21F.6030803@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209171>

On Tue, Nov 06, 2012 at 08:54:07AM +0100, Michael Haggerty wrote:

> > I suspect this was not used originally because ALLOC_GROW relies on
> > alloc_nr, which does fast growth early on. At (x+16)*3/2, we end up with
> > 24 slots for the first allocation. We are typically splitting 1 or 2
> > values.
> > 
> > It probably doesn't make a big difference in practice, though, as we're
> > talking about wasting less than 200 bytes on a 64-bit platform, and we
> > do not tend to keep large numbers of split lists around.
> 
> I did a little bit of archeology, and found out that
> 
> * ALLOC_GROW() did indeed exist when this code was developed, so it
>   *could have* been used.
> 
> * OTOH, I didn't find any indication on the mailing list that the
>   choice not to use ALLOC_GROW() was a conscious decision.
> 
> So history doesn't give us much guidance.

Thanks for digging.

> If the size of the initial allocation is a concern, then I would suggest
> adding a macro like ALLOC_SET_SIZE(ary,nr,alloc) that could be called to
> initialize the size to some number less than 24.  Such a macro might be
> useful elsewhere, too.  It wouldn't, of course, slow the growth rate
> *after* the first allocation.

I think we are getting into premature optimization territory. Let's
take your series as a cleanup, and we can worry about micro-optimizing
the allocation if and when it ever becomes an issue.

-Peff
