From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2 1/6] decorate: allow storing values instead of
 pointers
Date: Wed, 13 Jul 2011 16:08:15 -0400
Message-ID: <20110713200814.GD31965@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713065700.GA18566@sigill.intra.peff.net>
 <20110713175250.GA1448@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 22:08:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh5jL-0008N6-E9
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 22:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362Ab1GMUIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 16:08:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58319
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177Ab1GMUIR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 16:08:17 -0400
Received: (qmail 28612 invoked by uid 107); 13 Jul 2011 20:08:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 16:08:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 16:08:15 -0400
Content-Disposition: inline
In-Reply-To: <20110713175250.GA1448@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177074>

On Wed, Jul 13, 2011 at 12:52:50PM -0500, Jonathan Nieder wrote:

> > +void dump_longs(void)
> > +{
> > +	int i;
> > +	for (i = 0; i < longs.size; i++) {
> > +		struct object_decoration *e = decoration_slot(&longs, i);
> > +		unsigned long *value = (unsigned long *)e->decoration;
> > +
> > +		/* empty hash slot */
> > +		if (!e->base)
> > +			continue;
> > +
> > +		printf("%s -> %lu\n", sha1_to_hex(e->base->sha1), *value);
> 
> ... a cast is needed to use it.  Makes some sense.
> 
> What alignment guarantees are there for the field, if any?  I'm
> especially worried about platforms like sparc32 where the pointer
> width is 32 bits but some types need to be aligned to 64 bits.

We're packing these structs into a heap-allocated byte array. Each
struct takes up the size of the struct as defined by the compiler, plus
$width bytes. So with a 32-bit pointer and 32-bit data, you are probably
looking at data fields offset by 32-bits. Which might be wrong on
sparc32.

The result of malloc is guaranteed to be aligned for any type. But for
arrays, I'm not sure how that is handled. The only thing that makes
sense to me is that a sparc compiler with something like:

  struct foo {
    struct bar *pointer; /* pointers are 32-bits */
    double value; /* assume doubles need to be 64-bit aligned */
  };

would have to actually put in 32-bits of padding to meet the alignment
goals (and possibly some padding at the end so that the followup struct
in an array is aligned properly). But I don't know how this is handled,
so I'm just guessing.

And if that is the case, then yeah, there may well be an alignment issue
here. It gets even worse if you try to store something with an odd
alignment, like a 3-byte sequence.

So perhaps the safest thing would be to always memcpy into a real,
properly aligned destination. I'd have to tweak the get_value interface
a little bit, but it's not a big deal. It's going to be a little bit
slower, of course, but I doubt the extra few instructions will be
measurable.

I have to say, though, between the alignment issues and the strict
aliasing, I am tempted to scrap this whole approach and just use macros
to define the few functions we need. It's not like these containers are
heterogenous, or that we have a ton of types. Right now we want to map
"void *" and "uint32_t". In the future, I'd like to map a 20-byte sha1.

Doing something like:

  #define DECLARE_DECORATION(name, type) \
    void decoration_get_##name(struct decoration_##name *, \
                               struct object *, \
                               type value); \
    int decoration_set_##name(struct decoration_##name *, \
                              struct object *, \
                              type *value);

  DECLARE_DECORATION(void, void *);
  DECLARE_DECORATION(uint32, uint32_t);

  /* and then do an IMPLEMENT_DECORATION macro inside decorate.c */

is tempting. Writing your functions inside macros like this is ugly, but
then we know it's right, because the compiler knows what the sizes are
at compile time. And the optimizer can do its job properly, because
we're not fiddling the types at runtime.

> >  	for (i = 0; i < idnums.size; i++) {
> > +		struct object_decoration *deco = decoration_slot(&idnums, i);
> >  		if (deco->base && deco->base->type == 1) {
> > -			mark = ptr_to_mark(deco->decoration);
> > -			if (fprintf(f, ":%"PRIu32" %s\n", mark,
> > +			uint32_t *mark = (uint32_t *)deco->decoration;
> > +			if (fprintf(f, ":%"PRIu32" %s\n", *mark,
> >  				sha1_to_hex(deco->base->sha1)) < 0) {
> 
> Is this okay according to strict aliasing rules?  Maybe it would be
> safer to write
> 
> 			uint32_t mark;
> 			memcpy(&mark, deco->decoration, sizeof(mark));
> 
> which generates the same code in current versions of gcc on x86 if I
> remember correctly.

I guess you didn't read my comments on v1 of the patch. :)

I'm not sure if it's OK or not. Curiously, doing this:

  uint32_t mark = *(uint32_t *)deco->decoration;

generates a warning under -fstrict-aliasing, but:

  uint32_t *mark = (uint32_t *)deco->decoration;
  /* now use *mark */;

does not. I'm not sure if there's a subtlety in the strict aliasing
rules that makes the latter OK, or if it is simply a bug that it doesn't
trigger the compiler warning.

Using memcpy would be the safest thing, both from an alignment and a
strict-aliasing point of view.

> > --- a/decorate.c
> > +++ b/decorate.c
> > @@ -14,44 +14,48 @@ static unsigned int hash_obj(const struct object *obj, unsigned int n)
> >  	return hash % n;
> >  }
> >  
> > -static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
> > +static int insert_decoration(struct decoration *n, const struct object *base,
> > +			     const void *decoration, void *old)
> >  {
> >  	int size = n->size;
> > -	struct object_decoration *hash = n->hash;
> > +	unsigned long width = decoration_width(n);
> 
> Micronit: why not size_t?

No reason.

> >  	unsigned int j = hash_obj(base, size);
> >  
> > -	while (hash[j].base) {
> > -		if (hash[j].base == base) {
> > -			void *old = hash[j].decoration;
> > -			hash[j].decoration = decoration;
> > -			return old;
> > +	while (1) {
> 
> Microoptimization: the modulo operation can avoid the conditional (j >= size):
> 
> 	for (j = hash_obj(base, size); ; j = (j + 1) % size) {
> 	}

Yeah, that would work. I doubt the performance is measurable. I couldn't
even get a measurable difference in iterating using pointers versus
using indices and converting them to pointers during each run through
the loop. So I suspect we simply don't actually go through this loop
very many times (i.e., the hash is doing its job and entries are spread
out appropriately). So micro-optimizing is probably not worth it.

> By the way, how do we know this loop will terminate?  Is it because
> the insertion function is careful to make sure the table never gets
> filled?

Exactly. See grow_decoration. I had the same question when I looked at
the loop (the termination condition is part of the original code, which
is Linus's).

> > +void *lookup_decoration(const struct decoration *n, const struct object *obj)
> > +{
> > +	void **v;
> > +
> > +	v = lookup_decoration_value(n, obj);
> > +	if (!v)
> > +		return NULL;
> > +	return *v;
> > +}
> 
> Maybe memcpy to avoid alignment problems?
> 
> 	unsigned char *p;
> 	void *v;
> 
> 	p = lookup_decoration_value(n, obj);
> 	if (!p)
> 		return NULL;
> 	memcpy(v, p, sizeof(v));
> 	return v;

Yeah, that would solve it.

> > +void *lookup_decoration_value(const struct decoration *n,
> > +			      const struct object *obj)
> >  {
> >  	unsigned int j;
> >  
> > @@ -77,7 +101,7 @@ void *lookup_decoration(struct decoration *n, const struct object *obj)
> >  		return NULL;
> >  	j = hash_obj(obj, n->size);
> >  	for (;;) {
> > -		struct object_decoration *ref = n->hash + j;
> > +		struct object_decoration *ref = decoration_slot(n, j);
> >  		if (ref->base == obj)
> >  			return ref->decoration;
> 
> I worry that this could have alignment trouble anyway.

I don't think it has alignment problems with the value inside the
struct, since we are just passing a pointer back to it as a void *; it
is the caller who will dereference it. We could pass it back as an
unsigned char *, to make it clear to the caller that they need to
memcpy.

But if you mean there might be an alignment issue looking at the ->base
field of the "struct object_decoration", then yeah, I am not sure of
that.

> >  struct object_decoration {
> >  	const struct object *base;
> > -	void *decoration;
> > +	unsigned char decoration[FLEX_ARRAY];
> >  };
> 
> On some platforms, this becomes
> 
> 	struct object_decoration {
> 		const struct object *base;
> 		unsigned char decoration[];
> 	};
> 
> which I hope would create a type with the alignment of a pointer
> (generally sufficient except in odd cases like sparc32).  But on
> old-fashioned platforms, it is
> 
> 	struct object_decoration {
> 		const struct object *base;
> 		unsigned char decoration[1];
> 	};
> 
> Will that be a problem, or is it standard for compilers to be smart
> enough to pad to a nice alignment?

I don't know. Thanks for mentioning it; it was another issue I had
noticed while writing, but forgot to bring up when I posted the patches.

> If we're willing to incur the cost of a copy that assumes unaligned
> objects, perhaps
> 
> 	extern int lookup_decoration_value(const struct decoration *n,
> 				const struct object *obj,
> 				void *result, size_t width);
> 
> would be safer.

Agreed.

> Aside from the alignment and strict-aliasing worries, this looks very
> nice.  Thanks for writing it.

Thanks for the review. When I wrote it, and even now, I'm still very
unsure that the alignment and aliasing issues are right. It seems to
work so far for me, but:

  1. I'm on x86_64, which is not one of the more oddball platforms for
     alignment issues.

  2. I'm putting in "void *" and "uint32_t" values. Those are about as
     vanilla as you can get. But I don't want to leave a time bomb for
     somebody who tries to store a 3-byte sequence.

So it makes me a bit nervous, and why I'm very tempted by the ugly macro
solution.

-Peff
