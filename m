From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 4/4] pack-revindex: radix-sort the revindex
Date: Mon, 8 Jul 2013 13:50:41 -0700
Message-ID: <CA+sFfMfQcnx+OGNd+v7NJC5zSXg2OR1QiLyRSqDjXD0zb4mvtA@mail.gmail.com>
References: <20130707100133.GA18717@sigill.intra.peff.net>
	<20130707101438.GD19143@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 08 22:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwIOd-00014n-Bd
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 22:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab3GHUuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 16:50:44 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:63861 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab3GHUun (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 16:50:43 -0400
Received: by mail-wi0-f169.google.com with SMTP id c10so10480782wiw.4
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hhkkgGmtIL2PHByxLq6biVn8AKG6ZThJvgVyKqo4/p4=;
        b=XyQLtK/uzExumJ3cQlursXjAk8ZnT6nhFg7n+1+MqmSC8ctWb1HR7srMccDB9ifv89
         pcifZ4PiOGNhjFdOZ8IWv+Gz8wJ/y3fHouJDh3/yi6GNNJKMnzFthRkMgSCP3YEvwIo4
         af1Z9mgBSUw5y8x4u+wSsYI47RxvrmVml99p+wj4s+VHVqT9KGkodLPzQodlyZ/Zhl+I
         NT4Ks6E5mhWCjzVl3KpgoKePpLu0CwLcbHnQydIaVnCx9fw9wEl+W35lOr1ctmrjNRtO
         zxtxg/3b42DXoYg4BGX/vEMkJsKUIWWyNJfRrwoHOErUbnU1QyAdpG403CUeXFtry8qe
         PI3g==
X-Received: by 10.194.78.110 with SMTP id a14mr13295339wjx.84.1373316641622;
 Mon, 08 Jul 2013 13:50:41 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Mon, 8 Jul 2013 13:50:41 -0700 (PDT)
In-Reply-To: <20130707101438.GD19143@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229891>

On Sun, Jul 7, 2013 at 3:14 AM, Jeff King <peff@peff.net> wrote:
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
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I think there are probably still two potential issues here:
>
>   1. My while() loop termination probably has issues when we have to use
>      all 64 bits to represent the pack offset (not likely, but...)
>
>   2. We put "int pos[65536]" on the stack. This is a little big, but is
>      probably OK, as I think the usual small stack problems we have seen
>      are always in threaded code. But it would not be a big deal to heap
>      allocate it (it would happen once per radix step, which is only 4
>      times for the whole sort).
>
>  pack-revindex.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 72 insertions(+), 5 deletions(-)
>
> diff --git a/pack-revindex.c b/pack-revindex.c
> index 77a0465..d2adf36 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -59,11 +59,78 @@ static int cmp_offset(const void *a_, const void *b_)
>         /* revindex elements are lazily initialized */
>  }
>
> -static int cmp_offset(const void *a_, const void *b_)
> +/*
> + * This is a least-significant-digit radix sort using a 16-bit "digit".
> + */
> +static void sort_revindex(struct revindex_entry *entries, int n, off_t max)

If 'n' is the number of objects in the pack, shouldn't it be unsigned?

The data type for struct packed_git.num_objects is uint32_t.  Looks
like create_pack_revindex uses the wrong datatype when it captures
num_objects in the int num_ent and passes it to sort_revindex.  So, it
looks like that function needs to be updated too.

>  {
> -       const struct revindex_entry *a = a_;
> -       const struct revindex_entry *b = b_;
> -       return (a->offset < b->offset) ? -1 : (a->offset > b->offset) ? 1 : 0;
> +       /*
> +        * We need O(n) temporary storage, so we sort back and forth between
> +        * the real array and our tmp storage. To keep them straight, we always
> +        * sort from "a" into buckets in "b".
> +        */
> +       struct revindex_entry *tmp = xcalloc(n, sizeof(*tmp));
> +       struct revindex_entry *a = entries, *b = tmp;
> +       int digits = 0;
> +
> +       /*
> +        * We want to know the bucket that a[i] will go into when we are using
> +        * the digit that is N bits from the (least significant) end.
> +        */
> +#define BUCKET_FOR(a, i, digits) ((a[i].offset >> digits) & 0xffff)
> +
> +       while (max / (((off_t)1) << digits)) {

Is there any reason this shouldn't be simplified to just:

       while (max >> digits) {

I glanced briefly at the assembly and it appears that gcc does
actually emit a divide instruction to accomplish this, which I think
we can avoid by just rearranging the operation.

> +               struct revindex_entry *swap;
> +               int i;
> +               int pos[65536] = {0};
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
> +                       pos[BUCKET_FOR(a, i, digits)]++;
> +               for (i = 1; i < ARRAY_SIZE(pos); i++)
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
> +                       b[--pos[BUCKET_FOR(a, i, digits)]] = a[i];
> +
> +               /*
> +                * Now "b" contains the most sorted list, so we swap "a" and
> +                * "b" for the next iteration.
> +                */
> +               swap = a;
> +               a = b;
> +               b = swap;
> +
> +               /* And bump our digits for the next round. */
> +               digits += 16;
> +       }
> +
> +       /*
> +        * If we ended with our data in the original array, great. If not,
> +        * we have to move it back from the temporary storage.
> +        */
> +       if (a != entries) {
> +               int i;
> +               for (i = 0; i < n; i++)
> +                       entries[i] = tmp[i];

I think I recall that somebody investigated whether a for loop like
you have above was faster for copying structures than memcpy.  I
forget whether it was conclusive.  Did you happen to compare them?

<snip>

-Brandon
