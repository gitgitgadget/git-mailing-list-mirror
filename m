From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] pack-revindex: radix-sort the revindex
Date: Wed, 10 Jul 2013 06:52:44 -0400
Message-ID: <20130710105244.GA9724@sigill.intra.peff.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
 <20130707101438.GD19143@sigill.intra.peff.net>
 <CA+sFfMfQcnx+OGNd+v7NJC5zSXg2OR1QiLyRSqDjXD0zb4mvtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 12:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uws11-0002XL-SR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 12:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab3GJKww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 06:52:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:47408 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754393Ab3GJKwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 06:52:51 -0400
Received: (qmail 22787 invoked by uid 102); 10 Jul 2013 10:54:07 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 05:54:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 06:52:44 -0400
Content-Disposition: inline
In-Reply-To: <CA+sFfMfQcnx+OGNd+v7NJC5zSXg2OR1QiLyRSqDjXD0zb4mvtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230035>

On Mon, Jul 08, 2013 at 01:50:41PM -0700, Brandon Casey wrote:

> > +static void sort_revindex(struct revindex_entry *entries, int n, off_t max)
> 
> If 'n' is the number of objects in the pack, shouldn't it be unsigned?

Yes. I inherited that bug from the rest of the revindex code.

> The data type for struct packed_git.num_objects is uint32_t.  Looks
> like create_pack_revindex uses the wrong datatype when it captures
> num_objects in the int num_ent and passes it to sort_revindex.  So, it
> looks like that function needs to be updated too.

Yep. And the binary search in find_pack_revindex, too (which even has an
integer overflow!). I'll add a patch to my series to fix it (and switch
mine).

> > +       while (max / (((off_t)1) << digits)) {
> 
> Is there any reason this shouldn't be simplified to just:
> 
>        while (max >> digits) {

No, yours is much more readable. In case you are wondering how I ended
up with that monstrosity, I originally did not keep the "digits" field
as a number of bits, but rather a running total that bit-shifted 16 bits
each time through the loop. I'll change it in the re-roll.

> I glanced briefly at the assembly and it appears that gcc does
> actually emit a divide instruction to accomplish this, which I think
> we can avoid by just rearranging the operation.

Yep, although it almost certainly doesn't matter. We hit that loop
condition check at most 5 times for a 64-bit integer. I'm more concerned
with readability.

> > +       if (a != entries) {
> > +               int i;
> > +               for (i = 0; i < n; i++)
> > +                       entries[i] = tmp[i];
> 
> I think I recall that somebody investigated whether a for loop like
> you have above was faster for copying structures than memcpy.  I
> forget whether it was conclusive.  Did you happen to compare them?

It was me, actually, but the comparison was for memcmp rather than an
open-coded loop. And the conclusion was that memcmp is way faster on
glibc 2.13 and higher.

I think memcpy probably is going to be faster (especially in recent
versions of glibc), given the size of the array (the other memcmp
discussion was for 20-byte hashes, where the function call and setup
time was much more relevant).

But I don't think this was even timed at all in my tests. Since we go
back-and-forth between the original array and the tmp storage, we have a
"50%" chance of not needing to swap back anyway. So for packfiles up to
64K, we do the swap (but they are not that interesting to measure), and
then from 64K to 4G, we do not.

Note that we also use struct assignment in the sort itself to drop
elements into their buckets. That could potentially use memcpy, though I
would expect the compiler to generate pretty decent instructions for
such a small struct.

-Peff
