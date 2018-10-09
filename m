Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16B41F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 21:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJJEdm (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 00:33:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:34692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726862AbeJJEdm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 00:33:42 -0400
Received: (qmail 9584 invoked by uid 109); 9 Oct 2018 21:14:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 21:14:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10099 invoked by uid 111); 9 Oct 2018 21:14:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Oct 2018 17:14:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Oct 2018 17:14:50 -0400
Date:   Tue, 9 Oct 2018 17:14:50 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bloom Filters (was Re: We should add a "git gc --auto" after
 "git clone" due to commit graph)
Message-ID: <20181009211449.GB9563@sigill.intra.peff.net>
References: <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
 <20181003191805.GB16666@sigill.intra.peff.net>
 <20181008164141.GZ23446@szeder.dev>
 <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181008181015.GA23446@szeder.dev>
 <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
 <20181009030803.GA6250@sigill.intra.peff.net>
 <f877020c-3098-e4c4-ad64-cca57f764b91@gmail.com>
 <20181009184647.GA7014@sigill.intra.peff.net>
 <ec3ca377-0434-322e-4ab9-49e27f96f4af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec3ca377-0434-322e-4ab9-49e27f96f4af@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 09, 2018 at 03:03:08PM -0400, Derrick Stolee wrote:

> > I wonder if Roaring does better here.
> 
> In these sparse cases, usually Roaring will organize the data as "array
> chunks" which are simply lists of the values. The thing that makes this
> still compressible is that we store two bytes per entry, as the entries are
> grouped by a common most-significant two bytes. SInce you say ~120k unique
> paths, the Roaring bitmap would have two or three chunks per bitmap (and
> those chunks could be empty). The overhead to store the chunk positions,
> types, and lengths does come at a cost, but it's more like 32 bytes _per
> commit_.

Hmph. It really sounds like we could do better with a custom RLE
solution. But that makes me feel like I'm missing something, because
surely I can't invent something better than the state of the art in a
simple thought experiment, right?

I know what I'm proposing would be quite bad for random access, but my
impression is that EWAH is the same. For the scale of bitmaps we're
talking about, I think linear/streaming access through the bitmap would
be OK.

> > So at any rate, I do think it would not be out of the question to store
> > bitmaps like this. I'm much more worried about the maintenance cost of
> > adding new entries incrementally. I think it's only feasible if we give
> > up sorting, and then I wonder what other problems that might cause.
> The patch below gives me a starting point to try the Bloom filter approach
> and see what the numbers are like. You did all the "git" stuff like
> computing the changed paths, so thanks!

Great, I hope it can be useful. I almost wrote it as perl consuming the
output of "log --format=%h --name-only", but realized I didn't have a
perl ewah implementation handy.

You'll probably want to tweak this part:

> > +	prepare_revision_walk(&revs);
> > +	while ((commit = get_revision(&revs))) {
> > +		data.commit = commit;
> > +		diff_tree_combined_merge(commit, 0, &revs);
> > +	}

...to handle merges in a particular way. This will actually ignore
merges totally. You could add "-m" to the revision arguments to get a
per-parent diff, but of course you'd see those in your callback
individually. If you want to do _just_ the first parent diff, I think
you'll have to pick it apart manually, like:

  while ((commit = get_revision(&revs))) {
	struct object_id *parent_oid;

	/* ignore non-first parents, but handle root commits like --root */
	if (commit->parents)
		parent = &commit->parents->item->object.oid;
	else
		parent = the_hash_algo->empty_tree;

	diff_tree_oid(parent, &commit->oid, ...);
  }

-Peff
