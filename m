Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D537F2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 09:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759539AbcHEJew (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 05:34:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:55235 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759486AbcHEJeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 05:34:50 -0400
Received: (qmail 14546 invoked by uid 102); 5 Aug 2016 09:34:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 05:34:51 -0400
Received: (qmail 25010 invoked by uid 107); 5 Aug 2016 09:28:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 05:28:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 05:28:05 -0400
Date:	Fri, 5 Aug 2016 05:28:05 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] more archives of this list
Message-ID: <20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net>
References: <20160710004813.GA20210@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160710004813.GA20210@dcvr.yhbt.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 12:48:13AM +0000, Eric Wong wrote:

> Very much a work-in-progress, but NNTP and HTTP/HTTPS sorta work
> based on stuff that is on gmane and stuff I'm accumulating by
> being a subscriber.

I checked this out when you posted it, and have been using it the past
few weeks. I really like it. I find the URL structure much easier to
navigate than gmane.

I do find it visually a little harder to navigate through threads,
because there's not much styling there, and the messages seem to run
into one another. I don't know if a border around the divs or something
would help. I'm really terrible at that kind of visual design.

> HTTP URLs are clonable, but I've generated the following fast-export dump:
> 
> 	https://public-inbox.org/.temp/git.vger.kernel.org-6c38c917e55c.gz
> 	(362M)
> [...]
> In contrast, bundles and packs delta poorly and only get down
> around 750-800M with aggressive packing

I pulled this down. It is indeed rather huge, and git doesn't perform
all that well with it. All the usual "git is not a database" things
apply, I think.

I noticed in particular that traversing the object graph is _really_
slow. This is very sensitive to the "branchiness" of the tree. I notice
that you use a single level of hash (e.g., d4/9a37e4974...). Since there
almost 300K messages, the average 2nd-level tree has over 1000 entries
in it, and each commit changes exactly one entry.

So what happens during a traversal is that we see some tree A, look at
all of its entries, and see each of its blobs. Then we see A', the same
tree with one entry different, and we still have to walk each of those
thousand entries, looking up each in a hash only to find "yep, we
already saw that blob".

Whereas if your tree is more tree-like (rather than list-like), you can
cull unchanged sub-trees more frequently. The tradeoff, though, is the
extra overhead in storing the sha1 for the extra level of tree
indirection.

Here are some timing and size results for various incarnations of the
packfile. The sizes come from:

  git cat-file --batch-all-objects \
               --batch-check='%(objectsize:disk) %(objecttype)' |
  perl -lne '
    /(\d+) (.*)/; $count{$2}++; $size{$2} += $1;
    END { print "$size{$_} ($count{$_}) $_" for sort(keys(%count))
  }'

And the timings are just "git rev-list --objects --all".

Here's the initial sizes after fast-import:

  536339725 (291113) blob
   63767736 (291154) commit
  929164567 (582290) tree

Yikes, fast-import does a really terrible job of tree deltas (actually,
I'm not even sure it finds tree deltas at all). Notice that blob
contents are bigger than the fast-import stream (which contains all of
those contents!). That's unfortunate, but comes from the fact that we
zlib deflate the objects individually. Whereas the fast-import stream
was compressed as a whole, so the common elements between the emails get
a really good compression ratio.

There was discussion a long time ago about storing a common zlib
dictionary in the packfile and using it for all of the objects. I don't
recall whether there were any patches, though. It does create some
complications with serving clones/fetches, as they may ask for a subset
of the objects (so you have to send them the whole dictionary, which may
be a lot of overhead if you're only fetching a few objects).

Anyway, here are numbers after an aggressive repack:

  628307898 (291113) blob
   63209416 (291154) commit
   44342440 (582290) tree

Much better trees. Ironically the blobs got worse. I think there are
just too many with similar names and sizes for our heuristics to do a
good job of finding deltas.

Here's what running rev-list looks like:

  real    6m4.933s
  user    6m4.124s
  sys     0m0.616s

Yow, that's pretty painful. Without bitmaps, that's an operation that
every single clone would need to run.

Here's what it looks like with an extra level of hashing (so storing
"12/34/abcd..." instead of "12/34abcd..."):

  628308433 (291113) blob
   63207951 (291154) commit
   60654550 (873339) tree

We're storing a lot more trees, and spending 16MB extra on tree storage.
But here's the rev-list time:

  real    0m55.120s
  user    0m55.016s
  sys     0m0.096s

I didn't try doing an extra level of hashing on top of that (i.e.,
"12/34/ab/cd..."). It might help, but I suspect it's diminishing returns
versus the cost of accessing the extra trees.

The other thing that would probably make a big difference is avoiding
the one-commit-per-message pattern. The commit objects aren't that big,
but each one involves 2 new trees (one with ~1000 entries, and one with
256 entries). If you batched them into blocks of, say, 10 minutes, that
drops the number of commits by half.

Which I computed with:

  git log --reverse --format=%at |
  sort -n |
  perl -lne '
	if (!@block) {
		@block = ($_);
	} else {
		my $diff = $_ - $block[0];
		if ($diff >= 0 && $diff < 600) {
			push @block, $_;
		} else {
			print join(" ", @block);
			@block = ($_);
		}
	}
	END { print join(" ", @block) }
  '

Of course that means your mirror lags by 10 minutes. And you lose the
cool property of "git log --author=peff", though of course that
information is redundant with what is in the blobs. I haven't looked at
the public-inbox code but I would imagine it's mostly operating on the
tip tree.

If you're willing to give up the cool commits, we could also just squash
the whole archive into a single base commit, and start building there.
We'd run into problems in another 10 years, I guess, but it would be
pretty efficient to start with, at least. :)

> Additional mirrors or forks (perhaps different UIs) are very welcome,
> as I expect none of my servers or network connections to be reliable.

I'm tempted to host a mirror at GitHub, but I'm wary of the Git storage.
I don't think it really scales all that well. Bitmaps help with the cost
of a clone, but they're not magic. We still have to do traversals for a
lot of operations (including repacks).

-Peff
