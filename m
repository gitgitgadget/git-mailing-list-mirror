Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE207C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E0B23AC0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbhAVWzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:55:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:35970 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbhAVWzI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 17:55:08 -0500
Received: (qmail 15061 invoked by uid 109); 22 Jan 2021 22:54:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Jan 2021 22:54:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20065 invoked by uid 111); 22 Jan 2021 22:54:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Jan 2021 17:54:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Jan 2021 17:54:18 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev'
 files
Message-ID: <YAtXmie2kHNrcBwY@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 05:28:06PM -0500, Taylor Blau wrote:

> (Numbers taken in the kernel after cheating and using the next patch to
> generate a reverse index). There are a couple of approaches to improve
> cold cache performance not pursued here:
> 
>   - We could include the object offsets in the reverse index format.
>     Predictably, this does result in fewer page faults, but it triples
>     the size of the file, while simultaneously duplicating a ton of data
>     already available in the .idx file. (This was the original way I
>     implemented the format, and it did show
>     `--batch-check='%(objectsize:disk)'` winning out against `--batch`.)
> 
>     On the other hand, this increase in size also results in a large
>     block-cache footprint, which could potentially hurt other workloads.
> 
>   - We could store the mapping from pack to index position in more
>     cache-friendly way, like constructing a binary search tree from the
>     table and writing the values in breadth-first order. This would
>     result in much better locality, but the price you pay is trading
>     O(1) lookup in 'pack_pos_to_index()' for an O(log n) one (since you
>     can no longer directly index the table).
> 
> So, neither of these approaches are taken here. (Thankfully, the format
> is versioned, so we are free to pursue these in the future.) But, cold
> cache performance likely isn't interesting outside of one-off cases like
> asking for the size of an object directly. In real-world usage, Git is
> often performing many operations in the revindex,

I think you've nicely covered the arguments for and against the extra
offset here. This final paragraph ends in a comma, which makes me wonder
if you wanted to say something more. I'd guess it is along the lines
that most commands will be looking up more than one object, so that
cold-cache effort is amortized.

Or another way of thinking about it: 17ms versus 25ms in the cold-cache
for a _single_ object is not that big a deal, because the extra 8ms does
not scale as we ask about more objects. Here's an actual argument in
numbers (test repo is linux.git after building a .rev file using your
series):

For a single object, the extra cold-cache costs give --batch a slight
edge:

  $ git rev-parse HEAD >obj
  $ hyperfine -p 'echo 3 | sudo tee /proc/sys/vm/drop_caches' \
                 'git cat-file --buffer --batch-check="%(objectsize:disk)" <obj' \
                 'git cat-file --buffer --batch <obj'

  Benchmark #1: git cat-file --buffer --batch-check="%(objectsize:disk)" <obj
    Time (mean ± σ):      37.2 ms ±   8.3 ms    [User: 2.6 ms, System: 4.6 ms]
    Range (min … max):    28.5 ms …  55.6 ms    10 runs
   
  Benchmark #2: git cat-file --buffer --batch <obj
    Time (mean ± σ):      27.4 ms ±   3.4 ms    [User: 2.9 ms, System: 2.5 ms]
    Range (min … max):    23.2 ms …  37.1 ms    51 runs
   
  Summary
    'git cat-file --buffer --batch <obj' ran
      1.36 ± 0.35 times faster than 'git cat-file --buffer --batch-check="%(objectsize:disk)" <obj'

But with even a moderate number of objects, that's reversed:

  $ git cat-file --batch-all-objects --batch-check='%(objectname)' |
    shuffle | head -1000 >obj-1000
  $ hyperfine -p 'echo 3 | sudo tee /proc/sys/vm/drop_caches' \
                 'git cat-file --buffer --batch-check="%(objectsize:disk)" <obj-1000' \
		 'git cat-file --buffer --batch <obj-1000'
  
  Benchmark #1: git cat-file --buffer --batch-check="%(objectsize:disk)" <obj-1000
    Time (mean ± σ):      1.599 s ±  0.285 s    [User: 22.4 ms, System: 334.5 ms]
    Range (min … max):    0.816 s …  1.762 s    10 runs
   
  Benchmark #2: git cat-file --buffer --batch <obj-1000
    Time (mean ± σ):      1.972 s ±  0.225 s    [User: 343.5 ms, System: 404.2 ms]
    Range (min … max):    1.691 s …  2.283 s    10 runs
   
  Summary
    'git cat-file --buffer --batch-check="%(objectsize:disk)" <obj-1000' ran
      1.23 ± 0.26 times faster than 'git cat-file --buffer --batch <obj-1000'


Of course this isn't exactly an apples-to-apples comparison in the first
place, since the --batch one is doing a lot more. So "winning" with
objectsize:disk is not much of an accomplishment. A more interesting
comparison would be the same operation on a repo with your series,
versus one with the offset embedded in the .rev file, as the number of
objects grows.

But since we don't have that readily available, another interesting
comparison is stock git (with no .rev file) against your new .rev file,
with a cold cache.

At 1000 objects, the old code has a slight win, because it has less to
fault in from the disk (instead it's recreating the same data in RAM).
"git.compile" is your branch below; "git" is a stock build of "next":

  Benchmark #1: git cat-file --buffer --batch-check="%(objectsize:disk)" <obj-1000
    Time (mean ± σ):      1.483 s ±  0.260 s    [User: 148.9 ms, System: 301.2 ms]
    Range (min … max):    0.792 s …  1.725 s    10 runs
   
  Benchmark #2: git.compile cat-file --buffer --batch-check="%(objectsize:disk)" <obj-1000
    Time (mean ± σ):      1.820 s ±  0.138 s    [User: 27.7 ms, System: 399.3 ms]
    Range (min … max):    1.610 s …  2.012 s    10 runs
   
  Summary
    'git cat-file --buffer --batch-check="%(objectsize:disk)" <obj-1000' ran
      1.23 ± 0.23 times faster than 'git.compile cat-file --buffer --batch-check="%(objectsize:disk)" <obj-1000'

But that edge drops to 1.08x at 10,000 objects, and then at 100,000
objects your code is a win (by 1.16x). And of course it's a giant win
when the cache is already warm.

And in a cold cache, we'd expect a .rev file with offsets in it to be
much worse, since there's many more bytes to pull from the disk.

All of which is a really verbose way of saying: you might want to add a
few words after the comma:

  In real-world usage, Git is often performing many operations in the
  revindex (i.e., rather than asking about a single object, we'd
  generally ask about a range of history).

:) But hopefully it shows that including the offsets is not really
making things better for the cold cache anyway.

>  Documentation/technical/pack-format.txt |  17 ++++
>  builtin/repack.c                        |   1 +
>  object-store.h                          |   3 +
>  pack-revindex.c                         | 112 +++++++++++++++++++++---
>  pack-revindex.h                         |   7 +-
>  packfile.c                              |  13 ++-
>  packfile.h                              |   1 +
>  tmp-objdir.c                            |   4 +-
>  8 files changed, 145 insertions(+), 13 deletions(-)

Oh, there's a patch here, too. :)

It mostly looks good to me. I agree with Junio that "compute" is a
better verb than "load" for generating the in-memory revindex.

> +static int load_pack_revindex_from_disk(struct packed_git *p)
> +{
> +	char *revindex_name;
> +	int ret;
> +	if (open_pack_index(p))
> +		return -1;
> +
> +	revindex_name = pack_revindex_filename(p);
> +
> +	ret = load_revindex_from_disk(revindex_name,
> +				      p->num_objects,
> +				      &p->revindex_map,
> +				      &p->revindex_size);
> +	if (ret)
> +		goto cleanup;
> +
> +	p->revindex_data = (char *)p->revindex_map + 12;

Junio mentioned once spot where we lose constness through a cast. This
is another. I wonder if revindex_map should just be a "char *" to make
pointer arithmetic easier without having to cast.

But also...

> +	if (p->revindex)
> +		return p->revindex[pos].nr;
> +	else
> +		return get_be32((char *)p->revindex_data + (pos * sizeof(uint32_t)));

If p->revindex_data were "const uint32_t *", then this line would just
be:

  return get_be32(p->revindex_data + pos);

Not a huge deal either way since the whole point is to abstract this
behind a function where it only has to be written once. I don't think
there is any downside from the compiler's view (and we already use this
trick for the bitmap name-hash cache).

> diff --git a/packfile.c b/packfile.c
> index 7bb1750934..b04eac9286 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -324,11 +324,21 @@ void close_pack_index(struct packed_git *p)
>  	}
>  }
>  
> +void close_pack_revindex(struct packed_git *p) {
> +	if (!p->revindex_map)
> +		return;
> +
> +	munmap((void *)p->revindex_map, p->revindex_size);
> +	p->revindex_map = NULL;
> +	p->revindex_data = NULL;
> +}
> +
>  void close_pack(struct packed_git *p)
>  {
>  	close_pack_windows(p);
>  	close_pack_fd(p);
>  	close_pack_index(p);
> +	close_pack_revindex(p);
>  }

Thinking out loud a bit: a .rev file means we're spending an extra map
per pack (but not a descriptor, since we close after mmap). And like the
.idx files (but unlike .pack file maps), we don't keep track of these
and try to close them when under memory pressure. I think that's
probably OK in terms of bytes. It may mean running up against operating
system number-of-mmap limits more quickly when you have a very large
number of packs, as mentioned in:

  https://lore.kernel.org/git/20200601044511.GA2529317@coredump.intra.peff.net/

But this is probably bumping the number of problematic packs from 30k to
20k. Both are sufficiently ridiculous that I don't think it matters in
practice.

> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index 42ed4db5d3..da414df14f 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -187,7 +187,9 @@ static int pack_copy_priority(const char *name)
>  		return 2;
>  	if (ends_with(name, ".idx"))
>  		return 3;
> -	return 4;
> +	if (ends_with(name, ".rev"))
> +		return 4;
> +	return 5;
>  }

Probably not super important, but: should the .idx file still come last
here? Simultaneous readers won't start using the pack until the .idx
file is present. We'd probably prefer they see the whole thing
atomically, than see a .idx missing its .rev (they won't ever produce a
wrong answer, but they'll generate the in-core revindex on the fly when
they don't need to).

I guess one could argue that .bitmap files should get similar treatment,
but we'd not generally see those in the quarantine objdir anyway, so
nobody ever gave it much thought.

-Peff
