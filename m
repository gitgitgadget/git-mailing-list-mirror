From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] pack-revindex: radix-sort the revindex
Date: Thu, 11 Jul 2013 07:17:15 -0400
Message-ID: <20130711111705.GB6015@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
 <20130710115557.GJ21963@sigill.intra.peff.net>
 <CA+sFfMeL1a1cQXj+3OXvp5hxLXz8Qc70U_+MMg4LOHcvuH4wcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 13:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxEsL-0006yR-2b
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 13:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301Ab3GKLRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 07:17:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:57134 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932127Ab3GKLRY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 07:17:24 -0400
Received: (qmail 26577 invoked by uid 102); 11 Jul 2013 11:18:41 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Jul 2013 06:18:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jul 2013 07:17:15 -0400
Content-Disposition: inline
In-Reply-To: <CA+sFfMeL1a1cQXj+3OXvp5hxLXz8Qc70U_+MMg4LOHcvuH4wcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230085>

On Wed, Jul 10, 2013 at 10:10:16AM -0700, Brandon Casey wrote:

> > On the linux.git repo, with about 3M objects to sort, this
> > yields a 400% speedup. Here are the best-of-five numbers for
> > running "echo HEAD | git cat-file --batch-disk-size", which
> > is dominated by time spent building the pack revindex:
> >
> >           before     after
> >   real    0m0.834s   0m0.204s
> >   user    0m0.788s   0m0.164s
> >   sys     0m0.040s   0m0.036s
> >
> > On a smaller repo, the radix sort would not be
> > as impressive (and could even be worse), as we are trading
> > the log(n) factor for the k=4 of the radix sort. However,
> > even on git.git, with 173K objects, it shows some
> > improvement:
> >
> >           before     after
> >   real    0m0.046s   0m0.017s
> >   user    0m0.036s   0m0.012s
> >   sys     0m0.008s   0m0.000s
> 
> k should only be 2 for git.git.  I haven't packed in a while, but I
> think it should all fit within 4G.  :)  The pathological case would be
> a pack file with very few very very large objects, large enough to
> push the pack size over the 2^48 threshold so we'd have to do all four
> radixes.

Yeah, even linux.git fits into k=2. And that does more or less explain
the numbers in both cases.

For git.git, With 173K objects, log(n) is ~18, so regular sort is 18n.
With a radix sort of k=2, which has a constant factor of 2 (you can see
by looking at the code that we go through the list twice per radix), we
have 4n. So there should be a 4.5x speedup. We don't quite get that,
which is probably due to the extra bookkeeping on the buckets.

For linux.git, with 3M objects, log(n) is ~22, so the speedup we hope
for is 5.5x. We end up with 4x.

> It's probably worth mentioning here and/or in the code that k is
> dependent on the pack file size and that we can jump out early for
> small pack files.  That's my favorite part of this code by the way. :)

Yeah, I agree it is probably worth mentioning along with the numbers; it
is where half of our speedup is coming from. I think the "max >> bits"
loop condition deserves to be commented, too. I'll add that.

Also note that my commit message still refers to "--batch-disk-size"
which does not exist anymore. :) I didn't update the timings in the
commit message for my re-roll, but I did confirm that they are the same.

> > +       /*
> > +        * We need O(n) temporary storage, so we sort back and forth between
> > +        * the real array and our tmp storage. To keep them straight, we always
> > +        * sort from "a" into buckets in "b".
> > +        */
> > +       struct revindex_entry *tmp = xcalloc(n, sizeof(*tmp));
> 
> Didn't notice it the first time I read this, but do we really need
> calloc here?  Or will malloc do?

No, a malloc should be fine. I doubt it matters much, but there's no
reason not to go the cheap route.

> > +       struct revindex_entry *a = entries, *b = tmp;
> > +       int bits = 0;
> > +       unsigned *pos = xmalloc(BUCKETS * sizeof(*pos));
> > +
> > +       while (max >> bits) {
> > +               struct revindex_entry *swap;
> > +               int i;
> 
> You forgot to make i unsigned.  See below too...

Oops. Thanks for catching.

> > +               /*
> > +                * Now we can drop the elements into their correct buckets (in
> > +                * our temporary array).  We iterate the pos counter backwards
> > +                * to avoid using an extra index to count up. And since we are
> > +                * going backwards there, we must also go backwards through the
> > +                * array itself, to keep the sort stable.
> > +                */
> > +               for (i = n - 1; i >= 0; i--)
> > +                       b[--pos[BUCKET_FOR(a, i, bits)]] = a[i];
> 
> ...which is why the above loop still works.

Since we are iterating by ones, I guess I can just compare to UINT_MAX.

-Peff
