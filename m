From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 10/10] pack-revindex: radix-sort the revindex
Date: Wed, 10 Jul 2013 10:10:16 -0700
Message-ID: <CA+sFfMeL1a1cQXj+3OXvp5hxLXz8Qc70U_+MMg4LOHcvuH4wcw@mail.gmail.com>
References: <20130710113447.GA20113@sigill.intra.peff.net>
	<20130710115557.GJ21963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 10 19:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwxuL-0003VL-BZ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 19:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371Ab3GJRKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 13:10:19 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:38438 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110Ab3GJRKS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 13:10:18 -0400
Received: by mail-we0-f169.google.com with SMTP id n57so6170241wev.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1edvi7IQVyZPvVLS86/QWP0vnJYQcFwRCJWRVAz+uqQ=;
        b=ZHQfKowgrHBhMWLMszUt22nsexRAc5mc0MWlHOPL/G1DHOw8VFiVe9IL7sVwrgJ8o9
         0hLe4HDvN2hGPaWGqRkMCsf3hN2SFpP/vtoiAaDOahtGxUYzfK1n0S0DNrURgWPxgZe9
         W3MEQ3v0QD6jUywq94kBxt5VEPGcZmlENyhhcUUykcFNZ9pi9xaWcUjXJ19OnNoEt2i0
         11AX3cEVnfeLsE3CHo/1vU1FHLHMBfBR5FYmQ39RWB+ibYzFQAAvC9HgLkF29tL4K2da
         4fKmc17H9Gu0oMdXkItY32V6QRf9G/BhUehjihhCqU1eTiXDan2gMV1Pr/BcY7UotgnZ
         BSzQ==
X-Received: by 10.194.234.100 with SMTP id ud4mr18730381wjc.44.1373476216769;
 Wed, 10 Jul 2013 10:10:16 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Wed, 10 Jul 2013 10:10:16 -0700 (PDT)
In-Reply-To: <20130710115557.GJ21963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230060>

On Wed, Jul 10, 2013 at 4:55 AM, Jeff King <peff@peff.net> wrote:
> The pack revindex stores the offsets of the objects in the
> pack in sorted order, allowing us to easily find the on-disk
> size of each object. To compute it, we populate an array
> with the offsets from the sha1-sorted idx file, and then use
> qsort to order it by offsets.
>
> That does O(n log n) offset comparisons, and profiling shows
> that we spend most of our time in cmp_offset. However, since
> we are sorting on a simple off_t, we can use numeric sorts
> that perform better. A radix sort can run in O(k*n), where k
> is the number of "digits" in our number. For a 64-bit off_t,
> using 16-bit "digits" gives us k=4.
>
> On the linux.git repo, with about 3M objects to sort, this
> yields a 400% speedup. Here are the best-of-five numbers for
> running "echo HEAD | git cat-file --batch-disk-size", which
> is dominated by time spent building the pack revindex:
>
>           before     after
>   real    0m0.834s   0m0.204s
>   user    0m0.788s   0m0.164s
>   sys     0m0.040s   0m0.036s
>
> On a smaller repo, the radix sort would not be
> as impressive (and could even be worse), as we are trading
> the log(n) factor for the k=4 of the radix sort. However,
> even on git.git, with 173K objects, it shows some
> improvement:
>
>           before     after
>   real    0m0.046s   0m0.017s
>   user    0m0.036s   0m0.012s
>   sys     0m0.008s   0m0.000s

k should only be 2 for git.git.  I haven't packed in a while, but I
think it should all fit within 4G.  :)  The pathological case would be
a pack file with very few very very large objects, large enough to
push the pack size over the 2^48 threshold so we'd have to do all four
radixes.

It's probably worth mentioning here and/or in the code that k is
dependent on the pack file size and that we can jump out early for
small pack files.  That's my favorite part of this code by the way. :)

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I changed a few things from the original, including:
>
>   1. We take an "unsigned" number of objects to match the fix in the
>      last patch.
>
>   2. The 16-bit "digit" size is factored out to a single place, which
>      avoids magic numbers and repeating ourselves.
>
>   3. The "digits" variable is renamed to "bits", which is more accurate.
>
>   4. The outer loop condition uses the simpler "while (max >> bits)".
>
>   5. We use memcpy instead of an open-coded loop to copy the whole array
>      at the end. The individual bucket-assignment is still done by
>      struct assignment. I haven't timed if memcpy would make a
>      difference there.
>
>   6. The 64K*sizeof(int) "pos" array is now heap-allocated, in case
>      there are platforms with a small stack.
>
> I re-ran my timings to make sure none of the above impacted them; it
> turned out the same.
>
>  pack-revindex.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 79 insertions(+), 5 deletions(-)
>
> diff --git a/pack-revindex.c b/pack-revindex.c
> index 1aa9754..9365bc2 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -59,11 +59,85 @@ static int cmp_offset(const void *a_, const void *b_)
>         /* revindex elements are lazily initialized */
>  }
>
> -static int cmp_offset(const void *a_, const void *b_)
> +/*
> + * This is a least-significant-digit radix sort.
> + */
> +static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
>  {
> -       const struct revindex_entry *a = a_;
> -       const struct revindex_entry *b = b_;
> -       return (a->offset < b->offset) ? -1 : (a->offset > b->offset) ? 1 : 0;
> +       /*
> +        * We use a "digit" size of 16 bits. That keeps our memory
> +        * usage reasonable, and we can generally (for a 4G or smaller
> +        * packfile) quit after two rounds of radix-sorting.
> +        */
> +#define DIGIT_SIZE (16)
> +#define BUCKETS (1 << DIGIT_SIZE)
> +       /*
> +        * We want to know the bucket that a[i] will go into when we are using
> +        * the digit that is N bits from the (least significant) end.
> +        */
> +#define BUCKET_FOR(a, i, bits) (((a)[(i)].offset >> (bits)) & (BUCKETS-1))
> +
> +       /*
> +        * We need O(n) temporary storage, so we sort back and forth between
> +        * the real array and our tmp storage. To keep them straight, we always
> +        * sort from "a" into buckets in "b".
> +        */
> +       struct revindex_entry *tmp = xcalloc(n, sizeof(*tmp));

Didn't notice it the first time I read this, but do we really need
calloc here?  Or will malloc do?

> +       struct revindex_entry *a = entries, *b = tmp;
> +       int bits = 0;
> +       unsigned *pos = xmalloc(BUCKETS * sizeof(*pos));
> +
> +       while (max >> bits) {
> +               struct revindex_entry *swap;
> +               int i;

You forgot to make i unsigned.  See below too...

> +
> +               memset(pos, 0, BUCKETS * sizeof(*pos));
> +
> +               /*
> +                * We want pos[i] to store the index of the last element that
> +                * will go in bucket "i" (actually one past the last element).
> +                * To do this, we first count the items that will go in each
> +                * bucket, which gives us a relative offset from the last
> +                * bucket. We can then cumulatively add the index from the
> +                * previous bucket to get the true index.
> +                */
> +               for (i = 0; i < n; i++)
> +                       pos[BUCKET_FOR(a, i, bits)]++;
> +               for (i = 1; i < BUCKETS; i++)
> +                       pos[i] += pos[i-1];
> +
> +               /*
> +                * Now we can drop the elements into their correct buckets (in
> +                * our temporary array).  We iterate the pos counter backwards
> +                * to avoid using an extra index to count up. And since we are
> +                * going backwards there, we must also go backwards through the
> +                * array itself, to keep the sort stable.
> +                */
> +               for (i = n - 1; i >= 0; i--)
> +                       b[--pos[BUCKET_FOR(a, i, bits)]] = a[i];

...which is why the above loop still works.

> +
> +               /*
> +                * Now "b" contains the most sorted list, so we swap "a" and
> +                * "b" for the next iteration.
> +                */
> +               swap = a;
> +               a = b;
> +               b = swap;
> +
> +               /* And bump our bits for the next round. */
> +               bits += DIGIT_SIZE;
> +       }
> +
> +       /*
> +        * If we ended with our data in the original array, great. If not,
> +        * we have to move it back from the temporary storage.
> +        */
> +       if (a != entries)
> +               memcpy(entries, tmp, n * sizeof(*entries));
> +       free(tmp);
> +       free(pos);
> +
> +#undef BUCKET_FOR
>  }
>
>  /*
> @@ -108,7 +182,7 @@ static void create_pack_revindex(struct pack_revindex *rix)
>          */
>         rix->revindex[num_ent].offset = p->pack_size - 20;
>         rix->revindex[num_ent].nr = -1;
> -       qsort(rix->revindex, num_ent, sizeof(*rix->revindex), cmp_offset);
> +       sort_revindex(rix->revindex, num_ent, p->pack_size);
>  }
>
>  struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
> --
> 1.8.3.rc3.24.gec82cb9
