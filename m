From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] pack-revindex: radix-sort the revindex
Date: Thu, 11 Jul 2013 07:03:33 -0400
Message-ID: <20130711110332.GA6015@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
 <20130710115557.GJ21963@sigill.intra.peff.net>
 <CALkWK0=_6-RN2dHrhMdKu8nTyj1iwVe388Y57pOac17xhbqn5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 13:03:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxEf2-0002TD-TH
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 13:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab3GKLDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 07:03:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:57005 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab3GKLDj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 07:03:39 -0400
Received: (qmail 25936 invoked by uid 102); 11 Jul 2013 11:04:55 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Jul 2013 06:04:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jul 2013 07:03:33 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=_6-RN2dHrhMdKu8nTyj1iwVe388Y57pOac17xhbqn5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230084>

On Wed, Jul 10, 2013 at 06:47:49PM +0530, Ramkumar Ramachandra wrote:

> > For a 64-bit off_t, using 16-bit "digits" gives us k=4.
> 
> Wait, isn't off_t a signed data type?  Did you account for that in
> your algorithm?

It is signed, but the values we are storing in the revindex are all
positive file offsets. Right-shifting a positive signed type is
explicitly allowed in C.

> > -static int cmp_offset(const void *a_, const void *b_)
> > +/*
> > + * This is a least-significant-digit radix sort.
> > + */
> 
> Any particular reason for choosing LSD, and not MSD?

Simplicity. An MSD implementation should have the same algorithmic
complexity and in theory, one can do MSD in-place. I'm happy enough with
the speedup here, but if you want to take a stab at beating my times
with MSD, please feel free.

The other "usual" downside of MSD is that it is typically not stable,
but we don't care about that here. We know that our sort keys are
unique.

> > +#define DIGIT_SIZE (16)
> > +#define BUCKETS (1 << DIGIT_SIZE)
> 
> Okay, NUMBER_OF_BUCKETS = 2^RADIX, and you choose a hex radix.  Is
> off_t guaranteed to be fixed-length though?  I thought only the ones
> in stdint.h were guaranteed to be fixed-length?

I'm not sure what you mean by fixed-length. If you mean does it have the
same size on every platform, then no. It will typically be 32-bit on
platforms without largefile support, and 64-bit elsewhere. But it
shouldn't matter. We'll first sort the entries by the lower 16 bits, and
then if we have more bits, by the next 16 bits, and so on. We quit when
the maximum value to sort (which we know ahead of time from the size of
the packfile) is smaller than the 16-bits we are on. So we don't need to
know the exact size of off_t, only the maximum value in our list (which
must, by definition, be smaller than what can be represented by off_t).

> > +       /*
> > +        * We want to know the bucket that a[i] will go into when we are using
> > +        * the digit that is N bits from the (least significant) end.
> > +        */
> > +#define BUCKET_FOR(a, i, bits) (((a)[(i)].offset >> (bits)) & (BUCKETS-1))
> 
> Ouch!  This is unreadable.  Just write an inline function instead?  A
> % would've been easier on the eyes, but you chose base-16.

I specifically avoided an inline function because they are subject to
compiler settings. This isn't just "it would be a bit faster if this got
inlined, and OK otherwise" but "this would be horribly slow if not
inlined".

I'm also not sure that

  static inline unsigned bucket_for(const struct revindex *a,
                                    unsigned i,
                                    unsigned bits)
  {
          return a[i].offset >> bits & (BUCKETS-1);
  }

is actually any more readable.

I'm not sure what you mean by base-16. No matter the radix digit size,
as long as it is an integral number of bits, we can mask it off, which
is more efficient than modulo. A good compiler should see that it
is a constant and convert it to a bit-mask, but I'm not sure I agree
that modular arithmetic is more readable. This is fundamentally a
bit-twiddling operation, as we are shifting and masking.

I tried to explain it in the comment; suggestions to improve that are
welcome.

> > +       /*
> > +        * We need O(n) temporary storage, so we sort back and forth between
> > +        * the real array and our tmp storage. To keep them straight, we always
> > +        * sort from "a" into buckets in "b".
> > +        */
> > +       struct revindex_entry *tmp = xcalloc(n, sizeof(*tmp));
> 
> Shouldn't this be sizeof (struct revindex_entry), since tmp hasn't
> been declared yet?

No, the variable is declared (but uninitialized) in its initializer.
Despite its syntax, sizeof() is not a function and does not care about
the state of the variable, only its type.

> Also, s/n/revindex_nr/, and something more appropriate for tmp?

What name would you suggest be be more appropriate for tmp?

> > +       int bits = 0;
> > +       unsigned *pos = xmalloc(BUCKETS * sizeof(*pos));
> 
> sizeof(unsigned int), for clarity, if not anything else.

I disagree; in general, I prefer using sizeof(*var) rather than
sizeof(type), because it avoids repeating ourselves, and there is no
compile-time check that you have gotten it right.

In the initializer it is less important, because the type is right
there. But when you are later doing:

  memset(pos, 0, BUCKETS * sizeof(*pos));

this is much more robust. If somebody changes the type of pos, the
memset line does not need changed. If you used sizeof(unsigned), then
the code is now buggy (and the compiler cannot notice).

> You picked malloc over calloc here, because you didn't want to incur
> the extra cost of zero-initializing the memory?

Yes. We have to zero-initialize in each loop, so there is no point
spending the extra effort on calloc.

We could also xcalloc inside each loop iteration, but since we need the
same-size allocation each time, I hoisted the malloc out of the loop.

> Also, pos is the actual buckets array, I presume (hence unsigned,
> because there can't be a negative number of keys in any bucket)?

Exactly. I called it "pos" rather than "buckets" because the goal is to
get the start-position of each bucket (as explained in the comment in
the loop).

> > +       while (max >> bits) {
> 
> No clue what max is.  Looked at the caller and figured out that it's
> the pack-size, although I'm still clueless about why it's appearing
> here.

It's larger than the largest sort key in the array. On an LSD radix
sort, we can stop sorting when we are looking at a radix digit whose
value is larger than the max, because we know all of the entries will
simply have "0" in that digit.

So even if off_t is 64-bit, we can quit after the 32nd bit (i.e., k=2)
if the packfile is smaller than 4G.

An MSD radix sort could do the same trick, but would obviously skip the
zero digits at the beginning rather than the end.

> > +               struct revindex_entry *swap;
> > +               int i;
> > +
> > +               memset(pos, 0, BUCKETS * sizeof(*pos));
> 
> Ah, so that's why you used malloc there.  Wait, shouldn't this be
> memset(pos, 0, sizeof(*pos))?

No, that would zero only the first entry of the array. We allocated
BUCKETS * sizeof(*pos) bytes, and we want to zero them all.

> > +               swap = a;
> > +               a = b;
> > +               b = swap;
> 
> Wait a minute: why don't you just throw away b?  You're going to
> rebuild the queue in the next iteration anyway, no?  a is what is
> being sorted.

For each iteration, we need to sort into temporary storage. So you can
do it like:

  1. sort entries into tmp

  2. copy tmp back into entries

  3. bump radix digit and goto 1

But you can eliminate the copy in step 2 if you instead go back and
forth, like:

  1. sort entries into tmp

  2. bump radix digit

  3. sort tmp into entries

  ...etc

To do that in a loop, we need an alias for "the thing we are sorting
from" and "the thing we are sorting to". Hence the "a" and "b" pointers.
Perhaps these comments make more sense now:

+       /*
+        * We need O(n) temporary storage, so we sort back and forth between
+        * the real array and our tmp storage. To keep them straight, we always
+        * sort from "a" into buckets in "b".
+        */
+       struct revindex_entry *tmp = xcalloc(n, sizeof(*tmp));
+       struct revindex_entry *a = entries, *b = tmp;
[...]
+               /*
+                * Now "b" contains the most sorted list, so we swap "a" and
+                * "b" for the next iteration.
+                */

> > +               /* And bump our bits for the next round. */
> > +               bits += DIGIT_SIZE;
> 
> I'd have gone for a nice for-loop.

Yeah, that would look like:

  for (bits = 0; max >> bits; bits += DIGIT_SIZE) {
     ...
  }

I don't really find one more readable than the other.

> > +       /*
> > +        * If we ended with our data in the original array, great. If not,
> > +        * we have to move it back from the temporary storage.
> > +        */
> > +       if (a != entries)
> > +               memcpy(entries, tmp, n * sizeof(*entries));
> 
> How could a be different from entries?  It has no memory allocated for
> itself, no?  Why did you even create a, and not directly operate on
> entries?

See the back-and-forth explanation above.

> > +       free(tmp);
> > +       free(pos);
> 
> Overall, I found it quite confusing :(

Clearly. It was confusing to write (especially because there are a
number of optimizations, and because radix sort is not well known, at
least to me), which is why I tried to comment profusely. It seems quite
a few of them didn't help, as the answers to your questions were there.
If you have suggestions for improvement to the comments, I'm all ears.

> > +#undef BUCKET_FOR
> 
> Why not DIGIT_SIZE and BUCKETS too, while at it?

I forgot.  I added them later (they were originally magic numbers in the
code). Will add.

-Peff
