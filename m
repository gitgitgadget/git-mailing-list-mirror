From: Jeff King <peff@peff.net>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Thu, 2 Aug 2012 18:37:33 -0400
Message-ID: <20120802223733.GA28217@sigill.intra.peff.net>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <7vfw87isx1.fsf@alter.siamese.dyndns.org>
 <20120801004238.GA15428@sigill.intra.peff.net>
 <7v8vdzgngo.fsf@alter.siamese.dyndns.org>
 <20120801215414.GC16233@sigill.intra.peff.net>
 <7vipd2e00g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:37:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx41c-0006Jq-LV
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007Ab2HBWhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:37:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49182 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303Ab2HBWhl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:37:41 -0400
Received: (qmail 19368 invoked by uid 107); 2 Aug 2012 22:37:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Aug 2012 18:37:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2012 18:37:33 -0400
Content-Disposition: inline
In-Reply-To: <7vipd2e00g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202808>

On Wed, Aug 01, 2012 at 03:10:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jul 31, 2012 at 11:01:27PM -0700, Junio C Hamano wrote:
> > ...
> >> As we still have the pathname in this codepath, I am wondering if we
> >> would benefit from custom "content hash" that knows the nature of
> >> payload than the built-in similarity estimator, driven by the
> >> attribute mechanism (if the latter is the case, that is).
> >
> > Hmm. Interesting. But I don't think that attributes are a good fit here.
> > They are pathname based, so how do I apply anything related to
> > similarity of a particular version by pathname? IOW, how does it apply
> > in one tree but not another?
> 
> When you move porn/0001.jpg in the preimage to naughty/00001.jpg in
> the postimage, they both can hit "*.jpg contentid=jpeg" line in the
> top-level .gitattribute file, and the contentid driver for jpeg type
> may strip exif and hash the remainder bits in the image to come up
> with a token you can use in a similar way as object ID is used in
> the exact rename detection phase.
> 
> Just thinking aloud.

Ah, I see. That still feels like way too specific a use case to me. A
much more general use case to me would be a contentid driver which
splits the file into multiple chunks (which can be concatenated to
arrive at the original content), and marks chunks as "OK to delta" or
"not able to delta".  In other words, a content-specific version of the
bup-style splitting that people have proposed.

Assuming we split a jpeg into its EXIF bits (+delta) and its image bits
(-delta), then you could do a fast rename or pack-objects comparison
between two such files (in fact, with chunked object storage,
pack-objects can avoid looking at the image parts at all).

However, it may be the case that such "smart" splitting is not
necessary, as stupid and generic bup-style splitting may be enough. I
really need to start playing with the patches you wrote last year that
started in that direction.

-Peff
