From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCHv2 1/6] decorate: allow storing values instead of
 pointers
Date: Wed, 13 Jul 2011 12:52:50 -0500
Message-ID: <20110713175250.GA1448@elie>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713065700.GA18566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 19:53:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh3cW-00044m-1S
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 19:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281Ab1GMRxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 13:53:06 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42324 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197Ab1GMRxF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 13:53:05 -0400
Received: by iyb12 with SMTP id 12so5750332iyb.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AcuxvGodpbQZ66KST7+c0npKYAid6ISAJ7NGRpBu/Ek=;
        b=AdGnYBfrb3LUdSzp1vr/0bpykVVYsV3Yam1RcunLk1IBgPehsOrNzRvd+LzFqxJJAG
         WVvARB67f7SedfD9vzPusVJBwHuLnD2jtZzMdQdgYA2qFwKQeIZMyXWfaKKAdc+r9X92
         0oTfvcVVmX/G+RnfV183SIsdpG3DCirl9UtSQ=
Received: by 10.231.141.207 with SMTP id n15mr1232353ibu.72.1310579583929;
        Wed, 13 Jul 2011 10:53:03 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id e23sm9020315ibe.40.2011.07.13.10.53.00
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 10:53:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110713065700.GA18566@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177066>

(+cc: David Barr)
Hi,

Jeff King wrote:

> The decorate API provides a mapping of objects to arbitrary
> values. Until now, it did this by allowing you to store a
> void pointer, which could point to other storage. This has
> two problems:
[...]
> This patch lets you store fixed-size values directly in the
> hash table without allocating them elsewhere.

Nice idea.

> --- a/Documentation/technical/api-decorate.txt
> +++ b/Documentation/technical/api-decorate.txt
> @@ -1,6 +1,166 @@
>  decorate API
>  ============
>  
> -Talk about <decorate.h>
> +The decorate API is a system for efficiently mapping objects to values

Thanks for filling in the API docs!  That's awesome.

> +`struct object_decoration`::
> +
> +	A structure representing the decoration of a single object.
> +	Callers will not normally need to use this object unless they
> +	are iterating all elements in the decoration hash. The `base`
> +	field points to the object being mapped (or `NULL` if it is
> +	an empty hash slot). The `decoration` field stores the mapped
> +	value as a sequence of bytes; use the `width` field in `struct
> +	decoration` to know the exact size.

So the `decoration` field is an array rather than a pointer now,
hence...

[...]
> +void dump_longs(void)
> +{
> +	int i;
> +	for (i = 0; i < longs.size; i++) {
> +		struct object_decoration *e = decoration_slot(&longs, i);
> +		unsigned long *value = (unsigned long *)e->decoration;
> +
> +		/* empty hash slot */
> +		if (!e->base)
> +			continue;
> +
> +		printf("%s -> %lu\n", sha1_to_hex(e->base->sha1), *value);

... a cast is needed to use it.  Makes some sense.

What alignment guarantees are there for the field, if any?  I'm
especially worried about platforms like sparc32 where the pointer
width is 32 bits but some types need to be aligned to 64 bits.

> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
[...]

Nice.

> @@ -547,15 +534,15 @@ static void export_marks(char *file)
>  		die_errno("Unable to open marks file %s for writing.", file);
>  
>  	for (i = 0; i < idnums.size; i++) {
> +		struct object_decoration *deco = decoration_slot(&idnums, i);
>  		if (deco->base && deco->base->type == 1) {
> -			mark = ptr_to_mark(deco->decoration);
> -			if (fprintf(f, ":%"PRIu32" %s\n", mark,
> +			uint32_t *mark = (uint32_t *)deco->decoration;
> +			if (fprintf(f, ":%"PRIu32" %s\n", *mark,
>  				sha1_to_hex(deco->base->sha1)) < 0) {

Is this okay according to strict aliasing rules?  Maybe it would be
safer to write

			uint32_t mark;
			memcpy(&mark, deco->decoration, sizeof(mark));

which generates the same code in current versions of gcc on x86 if I
remember correctly.

> --- a/decorate.c
> +++ b/decorate.c
> @@ -14,44 +14,48 @@ static unsigned int hash_obj(const struct object *obj, unsigned int n)
>  	return hash % n;
>  }
>  
> -static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
> +static int insert_decoration(struct decoration *n, const struct object *base,
> +			     const void *decoration, void *old)
>  {
>  	int size = n->size;
> -	struct object_decoration *hash = n->hash;
> +	unsigned long width = decoration_width(n);

Micronit: why not size_t?

>  	unsigned int j = hash_obj(base, size);
>  
> -	while (hash[j].base) {
> -		if (hash[j].base == base) {
> -			void *old = hash[j].decoration;
> -			hash[j].decoration = decoration;
> -			return old;
> +	while (1) {

Microoptimization: the modulo operation can avoid the conditional (j >= size):

	for (j = hash_obj(base, size); ; j = (j + 1) % size) {
	}

By the way, how do we know this loop will terminate?  Is it because
the insertion function is careful to make sure the table never gets
filled?

[...]
>  static void grow_decoration(struct decoration *n)
>  {
>  	int i;
>  	int old_size = n->size;
> -	struct object_decoration *old_hash = n->hash;
> +	unsigned char *old_hash = n->hash;
>  
>  	n->size = (old_size + 1000) * 3 / 2;
> -	n->hash = xcalloc(n->size, sizeof(struct object_decoration));
> +	n->hash = xcalloc(n->size, decoration_stride(n));
>  	n->nr = 0;
>  
>  	for (i = 0; i < old_size; i++) {
> -		const struct object *base = old_hash[i].base;
> -		void *decoration = old_hash[i].decoration;
> -
> -		if (!base)
> -			continue;
> -		insert_decoration(n, base, decoration);
> +		struct object_decoration *e =
> +			(struct object_decoration *)
> +			(old_hash + i * decoration_stride(n));
> +		if (e->base)
> +			insert_decoration(n, e->base, e->decoration, NULL);

I'm worried about alignment here, too.

[...]
> @@ -60,15 +64,35 @@ static void grow_decoration(struct decoration *n)
[...]
>  /* Lookup a decoration pointer */
> -void *lookup_decoration(struct decoration *n, const struct object *obj)
> +void *lookup_decoration(const struct decoration *n, const struct object *obj)
> +{
> +	void **v;
> +
> +	v = lookup_decoration_value(n, obj);
> +	if (!v)
> +		return NULL;
> +	return *v;
> +}

Maybe memcpy to avoid alignment problems?

	unsigned char *p;
	void *v;

	p = lookup_decoration_value(n, obj);
	if (!p)
		return NULL;
	memcpy(v, p, sizeof(v));
	return v;

But:

> +
> +void *lookup_decoration_value(const struct decoration *n,
> +			      const struct object *obj)
>  {
>  	unsigned int j;
>  
> @@ -77,7 +101,7 @@ void *lookup_decoration(struct decoration *n, const struct object *obj)
>  		return NULL;
>  	j = hash_obj(obj, n->size);
>  	for (;;) {
> -		struct object_decoration *ref = n->hash + j;
> +		struct object_decoration *ref = decoration_slot(n, j);
>  		if (ref->base == obj)
>  			return ref->decoration;

I worry that this could have alignment trouble anyway.

> --- a/decorate.h
> +++ b/decorate.h
> @@ -3,16 +3,47 @@
>  
>  struct object_decoration {
>  	const struct object *base;
> -	void *decoration;
> +	unsigned char decoration[FLEX_ARRAY];
>  };

On some platforms, this becomes

	struct object_decoration {
		const struct object *base;
		unsigned char decoration[];
	};

which I hope would create a type with the alignment of a pointer
(generally sufficient except in odd cases like sparc32).  But on
old-fashioned platforms, it is

	struct object_decoration {
		const struct object *base;
		unsigned char decoration[1];
	};

Will that be a problem, or is it standard for compilers to be smart
enough to pad to a nice alignment?

>  struct decoration {
>  	const char *name;
> +	/* width of data we're holding; must be set before adding */
> +	const unsigned int width;

Makes sense.

>  	unsigned int size, nr;
> -	struct object_decoration *hash;
> +	/*
> +	 * The hash contains object_decoration structs, but we don't know their
> +	 * size until runtime. So we store is as a pointer to characters to
> +	 * make pointer arithmetic easier.
> +	 */
> +	unsigned char *hash;
>  };
[...]
> +extern int add_decoration_value(struct decoration *n,
> +				const struct object *obj,
> +				const void *decoration,
> +				void *old);
> +extern void *lookup_decoration_value(const struct decoration *n,
> +				     const struct object *obj);

If we're willing to incur the cost of a copy that assumes unaligned
objects, perhaps

	extern int lookup_decoration_value(const struct decoration *n,
				const struct object *obj,
				void *result, size_t width);

would be safer.

Aside from the alignment and strict-aliasing worries, this looks very
nice.  Thanks for writing it.

Regards,
Jonathan
