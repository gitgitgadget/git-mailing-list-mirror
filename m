From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 08/16] ewah: compressed bitmap implementation
Date: Tue, 25 Jun 2013 08:38:25 -0700
Message-ID: <874nclnadu.fsf@linux-k42r.v.cablecom.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-9-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:33:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urarv-0004xJ-0D
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab3FYVdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 17:33:39 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:54788 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab3FYVdi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 17:33:38 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 25 Jun
 2013 23:33:33 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.210.110) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 25 Jun 2013 23:33:35 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.210.110]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228996>

Vicent Marti <tanoku@gmail.com> writes:

> The library is re-licensed under the GPLv2 with the permission of Daniel
> Lemire, the original author.

This says "GPLv2", but the license blurbs all say "or (at your option)
any later version".  IANAL, does this cause any problems?  If so, can
they be GPLv2-only instead?

>  Makefile           |    6 +
>  ewah/bitmap.c      |  229 +++++++++++++++++
>  ewah/ewah_bitmap.c |  703 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  ewah/ewah_io.c     |  199 +++++++++++++++
>  ewah/ewah_rlw.c    |  124 +++++++++
>  ewah/ewok.h        |  194 +++++++++++++++
>  ewah/ewok_rlw.h    |  114 +++++++++

Can we have a Documentation/technical/api-ewah.txt?

(Maybe if you insert all the comments I ask for in the below, it's not
necessary, but it would still be nice to have some central place where
the formats are documented.)

[...]
> +struct ewah_bitmap *bitmap_to_ewah(struct bitmap *bitmap)
> +{
> +	struct ewah_bitmap *ewah = ewah_new();
> +	size_t i, running_empty_words = 0;
> +	eword_t last_word = 0;
> +
> +	for (i = 0; i < bitmap->word_alloc; ++i) {
> +		if (bitmap->words[i] == 0) {
> +			running_empty_words++;
> +			continue;
> +		}
> +
> +		if (last_word != 0) {
> +			ewah_add(ewah, last_word);
> +		}

There are a lot of "noisy" braces -- like in this instance -- if you
apply the git style to the files in ewah/.  I assume we'll give the
directory its own style, so that it should always use braces even on
one-line blocks.

[...]
> +	ewah_add(ewah, last_word);
> +	return ewah;
> +}
> +
> +struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah)
> +{
> +	struct bitmap *bitmap = bitmap_new();
> +	struct ewah_iterator it;
> +	eword_t blowup;
> +	size_t i = 0;
> +
> +	ewah_iterator_init(&it, ewah);
> +
> +	while (ewah_iterator_next(&blowup, &it)) {
> +		if (i >= bitmap->word_alloc) {
> +			bitmap->word_alloc *= 1.5;

Any reason that this uses a scale factor of 1.5, while the bitmap_set
operation above uses 2?

> +			bitmap->words = ewah_realloc(
> +				bitmap->words, bitmap->word_alloc * sizeof(eword_t));
> +		}
[...]
> +
> +void bitmap_each_bit(struct bitmap *self, ewah_callback callback, void *data)
> +{
[...]
> +			for (offset = 0; offset < BITS_IN_WORD; ++offset) {
> +				if ((word >> offset) == 0)
> +					break;
> +
> +				offset += __builtin_ctzll(word >> offset);

Here and in the rest, you use __builtin_* within the code.  This needs
to be either in a separate helper that reimplements the function in
terms of C if it is not available (i.e. you don't use GCC).
(Alternatively, the whole series could be conditional on some
HAVE_GCC_BUILTINS macro.  I'd think that would be a bad tradeoff
though.)

> +				callback(pos + offset, data);
> +			}
> +			pos += BITS_IN_WORD;
> +		}
> +	}
> +}
[...]

> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
[...]
> +void ewah_free(struct ewah_bitmap *bitmap)
> +{
> +	if (bitmap->alloc_size)
> +		free(bitmap->buffer);
> +
> +	free(bitmap);
> +}

Maybe first if (!bitmap) return, so that it behaves like other free()s?

> diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
[...]
> +int ewah_serialize_native(struct ewah_bitmap *self, int fd)
> +{
> +	uint32_t write32;
> +	size_t to_write = self->buffer_size * 8;
> +
> +	/* 32 bit -- bit size fr the map */

You cut&pasted the typo ("for") throughout the file :-)

[...]
> +	/** 32 bit -- number of compressed 64-bit words */
> +	write32 = (uint32_t)self->buffer_size;
> +	if (write(fd, &write32, 4) != 4)
> +		return -1;
> +
> +	if (write(fd, self->buffer, to_write) != to_write)
> +		return -1;

Shouldn't you use our neat write_in_full() and read_in_full() helpers,
throughout the file?

[...]
> diff --git a/ewah/ewok.h b/ewah/ewok.h
[...]
> +#ifndef __EWOK_BITMAP_C__
> +#define __EWOK_BITMAP_C__

_H_?

> +#ifndef ewah_malloc
> +#	define ewah_malloc malloc
> +#endif
> +#ifndef ewah_realloc
> +#	define ewah_realloc realloc
> +#endif
> +#ifndef ewah_calloc
> +#	define ewah_calloc calloc
> +#endif

I see you later #define them to the corresponding x*alloc version in
pack-bitmap.h.  Good.

> +
> +typedef uint64_t eword_t;

I assume this isn't ifdef'd to help 32bit platforms because the on-disk
format depends on it?

> +#define BITS_IN_WORD (sizeof(eword_t) * 8)
> +
> +struct ewah_bitmap {
> +	eword_t *buffer;
> +	size_t buffer_size;
> +	size_t alloc_size;
> +	size_t bit_size;
> +	eword_t *rlw;
> +};
> +
> +typedef void (*ewah_callback)(size_t pos, void *);
> +
> +struct ewah_bitmap *ewah_pool_new(void);
> +void ewah_pool_free(struct ewah_bitmap *bitmap);

How do the pool versions differ from the non-pool versions below?  I
would have expected a memory pool argument somewhere.

> +
> +/**
> + * Allocate a new EWAH Compressed bitmap
> + */
> +struct ewah_bitmap *ewah_new(void);
> +
> +/**
> + * Clear all the bits in the bitmap. Does not free or resize
> + * memory.
> + */
> +void ewah_clear(struct ewah_bitmap *bitmap);
> +
> +/**
> + * Free all the memory of the bitmap
> + */
> +void ewah_free(struct ewah_bitmap *bitmap);
> +
> +int ewah_serialize(struct ewah_bitmap *self, int fd);
> +int ewah_serialize_native(struct ewah_bitmap *self, int fd);
> +
> +int ewah_deserialize(struct ewah_bitmap *self, int fd);
> +int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len);
> +int ewah_read_mmap_native(struct ewah_bitmap *self, void *map, size_t len);

The whole file is so neatly commented, and then you skimp on these? :-)

In particular, it would be nice to have a comment here on what the
_native distinction means, and what (if any) the constraints are if you
want to use _mmap.  Also, if you read or deserialize, does the 'self'
have to be initialized first?

[...]
> +/**
> + * Set a given bit on the bitmap.
> + *
> + * The bit at position `pos` will be set to true. Because of the
> + * way that the bitmap is compressed, a set bit cannot be unset
> + * later on.
> + *
> + * Furthermore, since the bitmap uses streaming compression, bits
> + * can only set incrementally.

I'm not a native speaker, but does 'incrementally' also mean 'in order
of increasing indexes'?  That's what the example seems to say.

> + *
> + * E.g.
> + *		ewah_set(bitmap, 1); // ok
> + *		ewah_set(bitmap, 76); // ok
> + *		ewah_set(bitmap, 77); // ok
> + *		ewah_set(bitmap, 8712800127); // ok
> + *		ewah_set(bitmap, 25); // failed, assert raised
> + */
> +void ewah_set(struct ewah_bitmap *self, size_t i);
> +
[...]
> +struct ewah_bitmap * bitmap_to_ewah(struct bitmap *bitmap);

Style (around the *).

> +struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah);
> +
> +void bitmap_and_not_inplace(struct bitmap *self, struct bitmap *other);
> +void bitmap_or_inplace(struct bitmap *self, struct ewah_bitmap *other);

Why does one of them take an ewah_bitmap for 'other', but the other
takes a straight 'bitmap'?

> +
> +void bitmap_each_bit(struct bitmap *self, ewah_callback callback, void *data);
> +size_t bitmap_popcount(struct bitmap *self);
> +
> +#endif
> diff --git a/ewah/ewok_rlw.h b/ewah/ewok_rlw.h
> new file mode 100644
> index 0000000..2e31836
> --- /dev/null
> +++ b/ewah/ewok_rlw.h
> @@ -0,0 +1,114 @@
[...]
> +#define RLW_RUNNING_BITS (sizeof(eword_t) * 4)
> +#define RLW_LITERAL_BITS (sizeof(eword_t) * 8 - 1 - RLW_RUNNING_BITS)

It would be nice to have some minimal documentation of the word format
here (or in ewok.h), in particular because you snip off 1 bit here for a
reason that is not immediately obvious.

> +#define RLW_LARGEST_RUNNING_COUNT (((eword_t)1 << RLW_RUNNING_BITS) - 1)
> +#define RLW_LARGEST_LITERAL_COUNT (((eword_t)1 << RLW_LITERAL_BITS) - 1)
> +
> +#define RLW_LARGEST_RUNNING_COUNT_SHIFT (RLW_LARGEST_RUNNING_COUNT << 1)
> +
> +#define RLW_RUNNING_LEN_PLUS_BIT (((eword_t)1 << (RLW_RUNNING_BITS + 1)) - 1)

This one is doubly strange.  The name claims it's a bit(?), but the
definition (if you expand the preceding macros) effectively makes it
0x1ffffffff, i.e., a mask for RLW_RUNNING_BITS+1 number of bits.

> +static inline void rlw_xor_run_bit(eword_t *word)
> +{
> +	if (*word & 1) {
> +		*word &= (eword_t)(~1);
> +	} else {
> +		*word |= (eword_t)1;
> +	}
> +}

Why is this called xor?  Looks a lot like a negation to me.

> +static bool rlw_get_run_bit(const eword_t *word)
> +{
> +	return *word & (eword_t)1;
> +}
[...]
> +static inline void rlw_set_running_len(eword_t *word, eword_t l)
> +{
> +	*word |= RLW_LARGEST_RUNNING_COUNT_SHIFT;
> +	*word &= (l << 1) | (~RLW_LARGEST_RUNNING_COUNT_SHIFT);
> +}
> +
> +static inline void rlw_set_literal_words(eword_t *word, eword_t l)
> +{
> +	*word |= ~RLW_RUNNING_LEN_PLUS_BIT;
> +	*word &= (l << (RLW_RUNNING_BITS + 1)) | RLW_RUNNING_LEN_PLUS_BIT;
> +}

>From these I gather that the layout is, LSB first:

  1 bit:   bit that will be repeated
  32 bits: length of the run
  31 bits: number of literal words to be read after the run

Is that correct?  This took some figuring out for me, please add a
comment.

And then from there I would extrapolate that the data format requires
one such "specifier" word in between of chunks of stuff, but it's not
clear how exactly.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
