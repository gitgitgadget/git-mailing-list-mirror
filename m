From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/16] pack-objects: use a faster hash table
Date: Tue, 25 Jun 2013 22:14:17 -0400
Message-ID: <20130626021417.GB21212@sigill.intra.peff.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-4-git-send-email-tanoku@gmail.com>
 <87a9mdnae3.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 26 04:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrfFZ-0001xz-HL
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 04:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab3FZCOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 22:14:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:53205 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab3FZCOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 22:14:20 -0400
Received: (qmail 29667 invoked by uid 102); 26 Jun 2013 02:15:24 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 25 Jun 2013 21:15:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Jun 2013 22:14:17 -0400
Content-Disposition: inline
In-Reply-To: <87a9mdnae3.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229020>

On Tue, Jun 25, 2013 at 04:03:22PM +0200, Thomas Rast wrote:

> > The big win here, however, is in the massively reduced amount of hash
> > collisions (as you can see from the huge reduction of time spent in
> > `hashcmp` after the change). These greatly improved lookup times
> > will result critical once we implement the writing algorithm for bitmap
> > indxes in a later patch of this series.
> 
> Is that reduction in collisions purely because it uses quadratic
> probing, or is there some other magic trick involved?  Is the same also
> applicable to the other users of the "big" object hash table?  (I assume
> Peff has already tried applying it there, but I'm still curious...)

I haven't done any actual timings yet.

The general code is quite similar to our object.c hash table, with the
exception that it does quadratic probing.  I did try quadratic probing
on our object.c hash once and didn't see much improvement (similarly,
Junio tried cuckoo hashing, but the numbers were not that exciting).

It's possible that the hash table in pack-objects did not behave as well
as the one in object.c. It looks like we grow it when the table is 3/4
full, which is a little high (we grow at 1/2 in object.c).  Quadratic
probing should help when the hash table is close to full, so it would
probably help. However, I also note that khash keeps its hash tables
only half full, so that may be the real source of the performance
improvement.

So I suspect two things (but as I said, haven't verified):

  1. You could speed up pack-objects just by keeping the table half full
     rather than 3/4 full.

  2. You would see little to no speedup by moving object.c to khash, as
     it is adding only quadratic probing. With quadratic probing, you
     could potentially tweak the kh_put_* to resize less aggressively
     (say, 2/3) and save some memory without loss of performance.

-Peff
