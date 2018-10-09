Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E751F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 03:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbeJIKWu (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 06:22:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:46862 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725749AbeJIKWu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 06:22:50 -0400
Received: (qmail 7525 invoked by uid 109); 9 Oct 2018 03:08:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 03:08:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10380 invoked by uid 111); 9 Oct 2018 03:07:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 08 Oct 2018 23:07:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Oct 2018 23:08:03 -0400
Date:   Mon, 8 Oct 2018 23:08:03 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
Message-ID: <20181009030803.GA6250@sigill.intra.peff.net>
References: <87o9cbglez.fsf@evledraar.gmail.com>
 <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
 <87lg7ehnps.fsf@evledraar.gmail.com>
 <20181003185156.GA20709@sigill.intra.peff.net>
 <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
 <20181003191805.GB16666@sigill.intra.peff.net>
 <20181008164141.GZ23446@szeder.dev>
 <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181008181015.GA23446@szeder.dev>
 <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 08, 2018 at 02:29:47PM -0400, Derrick Stolee wrote:

> > > > But I'm afraid it will take a while until I get around to turn it into
> > > > something presentable...
> > > Do you have the code pushed somewhere public where one could take a look? I
> > > Do you have the code pushed somewhere public where one could take a
> > > look? I could provide some early feedback.
> > Nah, definitely not...  I know full well how embarassingly broken this
> > implementation is, I don't need others to tell me that ;)
> There are two questions that I was hoping to answer by looking at your code:
> 
> 1. How do you store your Bloom filter? Is it connected to the commit-graph
> and split on a commit-by-commit basis (storing "$path" as a key), or is it
> one huge Bloom filter (storing "$commitid:$path" as key)?

I guess you've probably thought all of this through for your
implementation, but let me pontificate.

I'd have done it as one fixed-size filter per commit. Then you should be
able to hash the path keys once, and apply the result as a bitwise query
to each individual commit (I'm assuming that it's constant-time to
access the filter for each, as an index into an mmap'd array, with the
offset coming from a commit-graph entry we'd be able to look up anyway).

I think it would also be easier to deal with maintenance, since each
filter is independent (IIRC, you cannot delete from a bloom filter
without re-adding all of the other keys).

The obvious downside is that it's O(commits) storage instead of O(1).

Now let me ponder a bit further afield. A bloom filter lets us answer
the question "did this commit (probably) touch these paths?". But it
does not let us answer "which paths did this commit touch?".

That second one is less useful than you might think, because we almost
always care about not just the names of the paths, but their actual
object ids. Think about a --raw diff, or even traversing for
reachability (where if we knew the tree-diff cheaply, we could avoid
asking "have we seen this yet?" on most of the tree entries). The names
alone can make that a bit faster, but in the worst case you still have
to walk the whole tree to find their entries.

But there's also a related question: how do we match pathspec patterns?
For a changed path like "foo/bar/baz", I imagine a bloom filter would
mark all of "foo", "foo/bar", and "foo/bar/baz". But what about "*.c"? I
don't think a bloom filter can answer that.

At least not by itself. If we imagine that the commit-graph also had an
alphabetized list of every path in every tree, then it's easy: apply the
glob to that list once to get a set of concrete paths, and then query
the bloom filters for those. And that list actually isn't too big. The
complete set of paths in linux.git is only about 300k gzipped (I think
that's the most relevant measure, since it's an obvious win to avoid
repeating shared prefixes of long paths).

Imagine we have that list. Is a bloom filter still the best data
structure for each commit? At the point that we have the complete
universe of paths, we could give each commit a bitmap of changed paths.
That lets us ask "did this commit touch these paths" (collect the bits
from the list of paths, then check for 1's), as well as "what paths did
we touch" (collect the 1 bits, and then index the path list).  Those
bitmaps should compress very well via EWAH or similar (most of them
would be huge stretches of 0's punctuated by short runs of 1's).

So that seems promising to me (or at least not an obvious dead-end). I
do think maintenance gets to be a headache, though. Adding new paths
potentially means reordering the bitmaps, which means O(commits) work to
"incrementally" update the structure. (Unless you always add the new
paths at the end, but then you lose fast lookups in the list; that might
be an acceptable tradeoff).

And finally, there's one more radical option: could we actually store a
real per-commit tree-diff cache? I.e., imagine that each commit had the
equivalent of a --raw diff easily accessible, including object ids. That
would allow:

  - fast pathspec matches, including globs

  - fast --raw output (and faster -p output, since we can skip the tree
    entirely)

  - fast reachability traversals (we only need to bother to look at the
    objects for changed entries)

where "fast" is basically O(size of commit's changes), rather than
O(size of whole tree). This was one of the big ideas of packv4 that
never materialized. You can _almost_ do it with packv2, since after all,
we end up storing many trees as deltas. But those deltas are byte-wise
so it's hard for a reader to convert them directly into a pure-tree
diff (they also don't mention the "deleted" data, so it's really only
half a diff).

So let's imagine we'd store such a cache external to the regular object
data (i.e., as a commit-graph entry). The "log --raw" diff of linux.git
has 1.7M entries. The paths should easily compress to a single 32-bit
integer (e.g., as an index into a big path list). The oids are 20 bytes.
Add a few bytes for modes. That's about 80MB. Big, but not impossibly
so. Maybe pushing it for true gigantic repos, though.

Those numbers are ignoring merges, too. The meaning of "did this commit
touch that path" is a lot trickier for a merge commit, and I think may
depend on context. I'm not sure how even a bloom filter solution would
handle that (I was assuming we'd mostly punt and let merges fall back to
opening up the trees).

Phew. That was a lot. I don't want to derail any useful work either of
you is doing. These are just things I've been thinking over (or even in
some cases experimenting with), and I think it's worth laying all the
options on the table. I won't be surprised if you'd considered and
rejected any of these alternate approaches, but I'd be curious to hear
the counter-arguments. :)

-Peff
