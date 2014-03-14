From: Jeff King <peff@peff.net>
Subject: Re: No progress from push when using bitmaps
Date: Fri, 14 Mar 2014 11:29:40 -0400
Message-ID: <20140314152939.GA6186@sigill.intra.peff.net>
References: <CAJo=hJth1YB+u2Y9S0X3xk7s2-HcPP4_k03qprHBU4A9721i8g@mail.gmail.com>
 <20140313212626.GA23618@sigill.intra.peff.net>
 <CAJo=hJu1WscibwectWzrUcoOV4-9xk4hBm1JA+RjONmgvZTXwQ@mail.gmail.com>
 <20140313220754.GA20173@sigill.intra.peff.net>
 <5322CF58.6060506@alum.mit.edu>
 <CACsJy8BZd0uL2M8NHO+sFcWfkmoyuVnU1Mh2eKZ2OXm=Y-Ge5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 16:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOU3Q-0004bA-Hn
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 16:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbaCNP3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 11:29:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:39502 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753644AbaCNP3n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 11:29:43 -0400
Received: (qmail 2896 invoked by uid 102); 14 Mar 2014 15:29:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Mar 2014 10:29:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 11:29:40 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BZd0uL2M8NHO+sFcWfkmoyuVnU1Mh2eKZ2OXm=Y-Ge5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244091>

On Fri, Mar 14, 2014 at 05:21:59PM +0700, Duy Nguyen wrote:

> On Fri, Mar 14, 2014 at 4:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > Would it be practical to change it to a percentage of bytes written?
> > Then we'd have progress info that is both convenient *and* truthful.
> 
> I agreed for a second, then remembered that we don't know the final
> pack size until we finish writing it.. Not sure if we could estimate
> (cheaply) with a good accuracy though.

Right. I'm not sure what Michael meant by "it". We can send a percentage
of bytes written for the reused pack (my option 2), but we do not know
the total bytes for the rest of the objects. So we'd end up with two
progress meters (one for the reused pack, and one for everything else),
both counting up to different endpoints. And it would require quite a
few changes to the progress code.

> If an object is reused, we already know its compressed size. If it's
> not reused and is a loose object, we could use on-disk size. It's a
> lot harder to estimate an not-reused, deltified object. All we have is
> the uncompressed size, and the size of each delta in the delta chain..
> Neither gives a good hint of what the compressed size would be.

Hmm. I think we do have the compressed delta size after having run the
compression phase (because that is ultimately what we compare to find
the best delta). Loose objects are probably the hardest here, as we
actually recompress them (IIRC, because packfiles encode the type/size
info outside of the compressed bit, whereas it is inside for loose
objects; the "experimental loose" format harmonized this, but it never
caught on).

Without doing that recompression, any value you came up with would be an
estimate, though it would be pretty close (not off by more than a few
bytes per object). However, you can't just run through the packing list
and add up the object sizes; you'd need to do a real "dry-run" through
the writing phase. There are probably more I'm missing, but you need at
least to figure out:

  1. The actual compressed size of a full loose object, as described
     above.

  2. The variable-length headers for each object based on its type and
     size.

  3. The final form that the object will take based on what has come
     before. For example, if there is a max pack size, we may split an
     object from its delta base, in which case we have to throw away the
     delta. We don't know where those breaks will be until we walk
     through the whole list.

  4. If an object we attempt to reuse turns out to be corrupted, we
     fall back to the non-reuse code path, which will have a different
     size. So you'd need to actually check the reused object CRCs during
     the dry-run (and for local repacks, not transfers, we actually
     inflate and check the zlib, too, for safety).

So I think it's _possible_. But it's definitely not trivial. For now, I
think it makes sense to go with something like the patch I posted
earlier (which I'll re-roll in a few minutes). That fixes what is IMHO a
regression in the bitmaps case. And it does not make it any harder for
somebody to later convert us to a true byte-counter (i.e., it is the
easy half already).

-Peff
