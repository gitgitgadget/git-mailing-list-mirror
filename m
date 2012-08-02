From: Jeff King <peff@peff.net>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Thu, 2 Aug 2012 18:58:44 -0400
Message-ID: <20120802225843.GA29208@sigill.intra.peff.net>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <7vfw87isx1.fsf@alter.siamese.dyndns.org>
 <20120801004238.GA15428@sigill.intra.peff.net>
 <7v8vdzgngo.fsf@alter.siamese.dyndns.org>
 <20120801215414.GC16233@sigill.intra.peff.net>
 <7vipd2e00g.fsf@alter.siamese.dyndns.org>
 <20120802223733.GA28217@sigill.intra.peff.net>
 <7v6290di1m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:58:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx4M4-00042K-RR
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab2HBW6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:58:52 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49205 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab2HBW6v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:58:51 -0400
Received: (qmail 19674 invoked by uid 107); 2 Aug 2012 22:58:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Aug 2012 18:58:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2012 18:58:44 -0400
Content-Disposition: inline
In-Reply-To: <7v6290di1m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202811>

On Thu, Aug 02, 2012 at 03:51:17PM -0700, Junio C Hamano wrote:

> > On Wed, Aug 01, 2012 at 03:10:55PM -0700, Junio C Hamano wrote:
> > ...
> >> When you move porn/0001.jpg in the preimage to naughty/00001.jpg in
> >> the postimage, they both can hit "*.jpg contentid=jpeg" line in the
> >> top-level .gitattribute file, and the contentid driver for jpeg type
> >> may strip exif and hash the remainder bits in the image to come up
> >> with a token you can use in a similar way as object ID is used in
> >> the exact rename detection phase.
> >> 
> >> Just thinking aloud.
> >
> > Ah, I see. That still feels like way too specific a use case to me. A
> > much more general use case to me would be a contentid driver which
> > splits the file into multiple chunks (which can be concatenated to
> > arrive at the original content), and marks chunks as "OK to delta" or
> > "not able to delta".  In other words, a content-specific version of the
> > bup-style splitting that people have proposed.
> >
> > Assuming we split a jpeg into its EXIF bits (+delta) and its image bits
> > (-delta), then you could do a fast rename or pack-objects comparison
> > between two such files (in fact, with chunked object storage,
> > pack-objects can avoid looking at the image parts at all).
> >
> > However, it may be the case that such "smart" splitting is not
> > necessary, as stupid and generic bup-style splitting may be enough. I
> > really need to start playing with the patches you wrote last year that
> > started in that direction.
> 
> I wasn't interested in "packing split object representation",
> actually.  The idea was still within the context of "rename".

But it would work for rename, too. If you want to compare two files, the
driver would give you back { sha1_exif (+delta), sha1_image (-delta) }
for each file. You know the size of each chunk and the size of the total
file.

Then you would just compare sha1_image for each entry. If they match,
then you have a lower bound on similarity of image_chunk_size /
total_size. If they don't, then you have an upper bound of similarity of
1-(image_chunk_size/total_size). In the former case, you can get the
exact similarity by doing a real delta on the sha1_exif content. In the
latter case, you can either exit early (if you are already below the
similarity threshold, which is likely), or possibly do the delta on the
sha1_exif content to get an exact value.

But either way, you never had to do a direct comparison between the big
image data; you only needed to know the sha1s. And as a bonus, if you
did want to cache results, you can have an O(# of blobs) cache of the
chunked sha1s of the chunked form (because the information is immutable
for a given sha1 and content driver). Whereas by caching the result of
estimate_similarity, our worst-case cache is the square of that (because
we are storing sha1 pairs).

-Peff
