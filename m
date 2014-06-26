From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] add functions for memory-efficient bitmaps
Date: Thu, 26 Jun 2014 11:51:19 -0400
Message-ID: <20140626155119.GA10402@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
 <20140625234000.GD23146@sigill.intra.peff.net>
 <53AB9039.8040809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 26 17:51:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0BxQ-0007pX-1H
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 17:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbaFZPvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2014 11:51:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:51576 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752149AbaFZPvX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 11:51:23 -0400
Received: (qmail 19883 invoked by uid 102); 26 Jun 2014 15:51:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jun 2014 10:51:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jun 2014 11:51:19 -0400
Content-Disposition: inline
In-Reply-To: <53AB9039.8040809@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252501>

On Thu, Jun 26, 2014 at 05:15:05AM +0200, Torsten B=C3=B6gershausen wro=
te:

> > + */
> > +static inline int bitset_sizeof(int num_bits)
> > +{
> > +	return (num_bits + CHAR_BIT - 1) / CHAR_BIT;
> > +}
> Just a general question about the usage of "int" here (and at other p=
laces):
> Is there a special reason for new code to allow num_bits to be negati=
ve ?

No. I usually choose "int" when the word size is not likely to matter
(i.e., we do not expect it to overflow a 32-bit integer, nor to have so
many that I need to be careful not to waste space).

Probably "unsigned int" would be a more descriptive choice.

It may also help the compiler optimize better. Assuming CHAR_BIT is 8
(i.e., most everywhere), we get:

  (num_bits + 7) / 8

Presumably the compiler implements the division with a right-shift.
Marking num_bits as unsigned should let us do just a logical shift,
without worrying about the sign. And indeed, here are the signed and
unsigned versions produced by "gcc -S -O2" (for an equivalent
non-inlined function):

  [signed]
        leal    14(%rdi), %edx
        movl    %edi, %eax
        addl    $7, %eax
        cmovs   %edx, %eax
        sarl    $3, %eax
        ret

  [unsigned]
        leal    7(%rdi), %eax
        shrl    $3, %eax
        ret

Much simpler, though see below for practical considerations.

> To my knowledge all the size_t definitions these days are positive,
> because a size can not be negative.

size_t is perhaps a reasonable choice for the return value, given the n=
ame
"sizeof". But if you really care about using the whole range of bits th=
ere, you
need a data type for num_bits that is CHAR_BIT times larger.

> Should we use
> "unsigned" here ?
> or "unsigned int" ?

Yes, I think so. Both are the same to the compiler. I have a vague
recollection that we prefer one over the other, but grepping seems to
find many examples of each in our code.

I'm squashing in the patch below. I couldn't measure any speed
improvement. I'm guessing because the functions are all inlined, which
means we likely get away with calculating bitset_sizeof once outside of
our loop. I think the result is still more obvious to read, though.

-Peff

---
diff --git a/bitset.h b/bitset.h
index 5fbc956..268545b 100644
--- a/bitset.h
+++ b/bitset.h
@@ -45,7 +45,7 @@
  *
  *   bits =3D xcalloc(1, bitset_sizeof(nr));
  */
-static inline int bitset_sizeof(int num_bits)
+static inline unsigned bitset_sizeof(unsigned num_bits)
 {
 	return (num_bits + CHAR_BIT - 1) / CHAR_BIT;
 }
@@ -54,7 +54,7 @@ static inline int bitset_sizeof(int num_bits)
  * Set the bit at position "n". "n" is counted from zero, and must be
  * smaller than the num_bits given to bitset_sizeof when allocating th=
e bitset.
  */
-static inline void bitset_set(unsigned char *bits, int n)
+static inline void bitset_set(unsigned char *bits, unsigned n)
 {
 	bits[n / CHAR_BIT] |=3D 1 << (n % CHAR_BIT);
 }
@@ -62,7 +62,7 @@ static inline void bitset_set(unsigned char *bits, in=
t n)
 /*
  * Return the bit at position "n" (see bitset_set for a description of=
 "n").
  */
-static inline int bitset_get(unsigned char *bits, int n)
+static inline unsigned bitset_get(unsigned char *bits, unsigned n)
 {
 	return !!(bits[n / CHAR_BIT] & (1 << (n % CHAR_BIT)));
 }
@@ -75,9 +75,10 @@ static inline int bitset_get(unsigned char *bits, in=
t n)
  * "max" (we assume any bits beyond "max" up to the next CHAR_BIT boun=
dary are
  * zeroed padding).
  */
-static inline int bitset_equal(unsigned char *a, unsigned char *b, int=
 max)
+static inline int bitset_equal(unsigned char *a, unsigned char *b,
+			       unsigned max)
 {
-	int i;
+	unsigned i;
 	for (i =3D bitset_sizeof(max); i > 0; i--)
 		if (*a++ !=3D *b++)
 			return 0;
@@ -89,9 +90,10 @@ static inline int bitset_equal(unsigned char *a, uns=
igned char *b, int max)
  *
  * See bitset_equal for the definition of "max".
  */
-static inline void bitset_or(unsigned char *dst, const unsigned char *=
src, int max)
+static inline void bitset_or(unsigned char *dst, const unsigned char *=
src,
+			     unsigned max)
 {
-	int i;
+	unsigned i;
 	for (i =3D bitset_sizeof(max); i > 0; i--)
 		*dst++ |=3D *src++;
 }
@@ -101,9 +103,9 @@ static inline void bitset_or(unsigned char *dst, co=
nst unsigned char *src, int m
  *
  * See bitset_equal for the definition of "max".
  */
-static inline int bitset_empty(const unsigned char *bits, int max)
+static inline int bitset_empty(const unsigned char *bits, unsigned max=
)
 {
-	int i;
+	unsigned i;
 	for (i =3D bitset_sizeof(max); i > 0; i--, bits++)
 		if (*bits)
 			return 0;
