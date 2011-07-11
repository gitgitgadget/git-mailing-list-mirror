From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] decorate: allow storing values instead of pointers
Date: Mon, 11 Jul 2011 12:39:59 -0400
Message-ID: <20110711163959.GA29781@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161649.GA10418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 18:40:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgJWi-00014V-Aq
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 18:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758110Ab1GKQkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 12:40:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59561
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758102Ab1GKQkB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 12:40:01 -0400
Received: (qmail 3063 invoked by uid 107); 11 Jul 2011 16:40:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jul 2011 12:40:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2011 12:39:59 -0400
Content-Disposition: inline
In-Reply-To: <20110711161649.GA10418@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176869>

On Mon, Jul 11, 2011 at 12:16:50PM -0400, Jeff King wrote:

> diff --git a/decorate.h b/decorate.h
> index e732804..b75054a 100644
> --- a/decorate.h
> +++ b/decorate.h
> @@ -3,16 +3,32 @@
>  
>  struct object_decoration {
>  	const struct object *base;
> -	void *decoration;
> +	unsigned char decoration[FLEX_ARRAY];
>  };
>  
>  struct decoration {
>  	const char *name;
> +	/* width of data we're holding; must be set before adding */
> +	unsigned int width;
>  	unsigned int size, nr;
> -	struct object_decoration *hash;
> +	/*
> +	 * The hash contains object_decoration structs, but we don't know their
> +	 * size until runtime. So we store is as a pointer to characters to
> +	 * make pointer arithmetic easier.
> +	 */
> +	unsigned char *hash;
> +	unsigned int stride; /* size of a single record */
> +	unsigned char *end; /* end of the hash array */
>  };

As you can see here, there's a bit of C magic here. We don't know what
we're storing in the object_decoration struct, so it has a variable
size. So there were two subtle things I was concerned about:

  1. Not violating alignment rules when accessing items.

  2. Not violating strict aliasing rules.

I think (1) is OK via the add/lookup interface. It takes void pointers
to objects to store and to retrieve into (and knows the width via the
width field above). And then we memcpy() into and out of the flex-array.
Which means you never access the bytes in the flex array as an "int" or
whatever; you memcpy them into an _actual_ int, and then access them.

I don't think we have to worry about strict aliasing, for two reasons:

  1. Pointers to char (or unsigned char) are assumed to be aliases for
     other things by gcc's strict aliasing rules. Because they are the
     only way to do byte-level pointer arithmetic, which makes them
     useful for stuff like this.

  2. The pointer accesses are hidden across function call boundaries,
     anyway, so I suspect the optimizer has to assume the worst.

What's slightly worrisome to me is the iteration code in fast-export.c
that touches the decoration struct more directly:

> +	for (p = idnums.hash; p < idnums.end; p += idnums.stride) {
> +		struct object_decoration *deco = (struct object_decoration *)p;
>  		if (deco->base && deco->base->type == 1) {
> -			mark = ptr_to_mark(deco->decoration);
> -			if (fprintf(f, ":%"PRIu32" %s\n", mark,
> +			uint32_t *mark = (uint32_t *)deco->decoration;
> +			if (fprintf(f, ":%"PRIu32" %s\n", *mark,
>  				sha1_to_hex(deco->base->sha1)) < 0) {

Here we're directly casting the bytes to a uint32 and accessing them.
I'm not sure if this can create alignment issues. The bytes are in a
struct which is in an array of such packed structs. I suspect in
practice that a uint32_t is not a problem, as the data bytes will always
be on a 4-byte boundary. It might matter for other types, though.

As for strict aliasing, I thought that the "pointer to char can be an
alias" rule would save us. But actually, from my reading, the rule is "a
pointer to char can be an alias to another object" but not necessarily
that "a pointer to another object can be an alias to char". What has me
confused is that gcc complains about type-punning under -O3 (which turns
on -fstrict-aliasing) with this:

  struct object_decoration *deco = (struct object_decoration *)p;
  uint32_t mark = *(uint32_t *)deco->decoration;
  fprintf("%"PRIu32, mark);

but not with the code in the patch:

  struct object_decoration *deco = (struct object_decoration *)p;
  uint32_t *mark = (uint32_t *)deco->decoration;
  fprintf("%"PRIu32, *mark);

so there may be something I'm not understanding.

But I wonder if the safest thing for both alignment and aliasing would
just be:

  struct object_decoration *deco = (struct object_decoration *)p;
  uint32_t mark;
  memcpy(&mark, deco->decoration, sizeof(mark));

Which is probably a little slower, but I'm not sure it's worth
micro-optimizing this loop[1].

-Peff

[1] Actually, if you read the rest of the patch, you will note that what
    used to be assignment to or reading from a void pointer in the
    original decorate.[ch] is now a memcpy, as well. The original
    probably compiled to a single assignment instruction, and now we
    loop via memcpy. That's the price of run-time flexibility. I doubt
    that the extra few instructions are a big deal, considering we by
    definition have just done a lookup in a hash table.
