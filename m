From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 10/10] pack-revindex: radix-sort the revindex
Date: Wed, 10 Jul 2013 18:47:49 +0530
Message-ID: <CALkWK0=_6-RN2dHrhMdKu8nTyj1iwVe388Y57pOac17xhbqn5Q@mail.gmail.com>
References: <20130710113447.GA20113@sigill.intra.peff.net> <20130710115557.GJ21963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 10 15:18:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwuI1-0005So-K5
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 15:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab3GJNSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 09:18:33 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:42619 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab3GJNSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 09:18:30 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so15812276ied.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=s5fbwi+miYH+7Cfmap/UyoWEReDQE3lmCdkraKAJA9w=;
        b=vPjrN7Se6AHq14FakeUBSFrjRDsO9veCjWMpWgmXNejk6x/y/BMi8Hk7+y05gV3Rgt
         WXovAbKld1rxDlQuGphJ5uAbMnZtZx57ZONETyZU9aouWDUSD7Y4+g1NrA1bw/7uVG9B
         2KNs0Sad2Sq0SPEf3SKW9IjfSNJlSqF/JVhyKk2nkxcRhTWRYIfADYzv2hEgasEzWfPZ
         nQhNVEb99idcgXmk66vMU7hyjLCa3jYeBCdTRqZz4Fh8Ni8ABriMbiYQ5s75xtQ+a4Sy
         CWAECR+ZLIfoT7M82yvDKh1dJjm86/lp3zS0GLCN4vQJSTYiw0iPJmOOOI2jrBQjDTss
         sOQQ==
X-Received: by 10.50.47.12 with SMTP id z12mr11670458igm.50.1373462309672;
 Wed, 10 Jul 2013 06:18:29 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Wed, 10 Jul 2013 06:17:49 -0700 (PDT)
In-Reply-To: <20130710115557.GJ21963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230054>

Jeff King wrote:
> That does O(n log n) offset comparisons, and profiling shows
> that we spend most of our time in cmp_offset. However, since
> we are sorting on a simple off_t, we can use numeric sorts
> that perform better. A radix sort can run in O(k*n), where k
> is the number of "digits" in our number. For a 64-bit off_t,
> using 16-bit "digits" gives us k=4.

Wait, isn't off_t a signed data type?  Did you account for that in
your algorithm?

> On the linux.git repo, with about 3M objects to sort, this
> yields a 400% speedup. Here are the best-of-five numbers for
> running "echo HEAD | git cat-file --batch-disk-size", which
> is dominated by time spent building the pack revindex:

Okay.

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

Any particular reason for choosing LSD, and not MSD?

> +#define DIGIT_SIZE (16)
> +#define BUCKETS (1 << DIGIT_SIZE)

Okay, NUMBER_OF_BUCKETS = 2^RADIX, and you choose a hex radix.  Is
off_t guaranteed to be fixed-length though?  I thought only the ones
in stdint.h were guaranteed to be fixed-length?

> +       /*
> +        * We want to know the bucket that a[i] will go into when we are using
> +        * the digit that is N bits from the (least significant) end.
> +        */
> +#define BUCKET_FOR(a, i, bits) (((a)[(i)].offset >> (bits)) & (BUCKETS-1))

Ouch!  This is unreadable.  Just write an inline function instead?  A
% would've been easier on the eyes, but you chose base-16.

> +       /*
> +        * We need O(n) temporary storage, so we sort back and forth between
> +        * the real array and our tmp storage. To keep them straight, we always
> +        * sort from "a" into buckets in "b".
> +        */
> +       struct revindex_entry *tmp = xcalloc(n, sizeof(*tmp));

Shouldn't this be sizeof (struct revindex_entry), since tmp hasn't
been declared yet?  Also, s/n/revindex_nr/, and something more
appropriate for tmp?

> +       struct revindex_entry *a = entries, *b = tmp;

It's starting to look like you have something against descriptive names ;)

> +       int bits = 0;
> +       unsigned *pos = xmalloc(BUCKETS * sizeof(*pos));

sizeof(unsigned int), for clarity, if not anything else.  You picked
malloc over calloc here, because you didn't want to incur the extra
cost of zero-initializing the memory?  Also, pos is the actual buckets
array, I presume (hence unsigned, because there can't be a negative
number of keys in any bucket)?

> +       while (max >> bits) {

No clue what max is.  Looked at the caller and figured out that it's
the pack-size, although I'm still clueless about why it's appearing
here.

> +               struct revindex_entry *swap;
> +               int i;
> +
> +               memset(pos, 0, BUCKETS * sizeof(*pos));

Ah, so that's why you used malloc there.  Wait, shouldn't this be
memset(pos, 0, sizeof(*pos))?

> +               for (i = 0; i < n; i++)
> +                       pos[BUCKET_FOR(a, i, bits)]++;

Okay, so you know how many numbers are in each bucket.

> +               for (i = 1; i < BUCKETS; i++)
> +                       pos[i] += pos[i-1];

Cumulative sums; right.

> +               for (i = n - 1; i >= 0; i--)
> +                       b[--pos[BUCKET_FOR(a, i, bits)]] = a[i];

Classical queue.  You could've gone for something more complex, but I
don't think it would have been worth the extra complexity.

> +               swap = a;
> +               a = b;
> +               b = swap;

Wait a minute: why don't you just throw away b?  You're going to
rebuild the queue in the next iteration anyway, no?  a is what is
being sorted.

> +               /* And bump our bits for the next round. */
> +               bits += DIGIT_SIZE;

I'd have gone for a nice for-loop.

> +       /*
> +        * If we ended with our data in the original array, great. If not,
> +        * we have to move it back from the temporary storage.
> +        */
> +       if (a != entries)
> +               memcpy(entries, tmp, n * sizeof(*entries));

How could a be different from entries?  It has no memory allocated for
itself, no?  Why did you even create a, and not directly operate on
entries?

> +       free(tmp);
> +       free(pos);

Overall, I found it quite confusing :(

> +#undef BUCKET_FOR

Why not DIGIT_SIZE and BUCKETS too, while at it?
