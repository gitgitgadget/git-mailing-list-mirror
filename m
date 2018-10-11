Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C400D1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 03:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJKKiP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 06:38:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:36646 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726047AbeJKKiP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 06:38:15 -0400
Received: (qmail 24175 invoked by uid 109); 11 Oct 2018 03:13:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 03:13:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25585 invoked by uid 111); 11 Oct 2018 03:12:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 23:12:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 23:13:03 -0400
Date:   Wed, 10 Oct 2018 23:13:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PoC -- do not apply 2/3] test-tree-bitmap: add "dump" mode
Message-ID: <20181011031303.GB25067@sigill.intra.peff.net>
References: <20181009231250.GA19342@sigill.intra.peff.net>
 <20181009231405.GB23730@sigill.intra.peff.net>
 <xmqqy3b6occq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3b6occq.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 09:48:53AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The one difference is the sort order: git's diff output is
> > in tree-sort order, so a subtree "foo" sorts like "foo/",
> > which is after "foo.bar". Whereas the bitmap path list has a
> > true byte sort, which puts "foo.bar" after "foo".
> 
> If we truly cared, it is easy enough to fix by having a custom
> comparison function in 1/3 used in collect_paths() phase.

Yep. I thought about doing it just so I could drop this "one difference"
note, but I got lazy.

Running this on linux.git, I do see a few other differences. It looks
like my code does actually compute lists of touched paths for some
merges (presumably using "-c"). That wasn't intended, and it would
actually make my timings less good, but my goal was just to get a rough
idea on size here (but see below).

> > +	/* dump it while we have the sorted order in memory */
> > +	for (i = 0; i < n; i++) {
> > +		printf("%s", sorted[i]->path);
> > +		putchar('\0');
> > +	}
> 
> With printf("%s%c", sorted[i]->path, '\0'); you can lose the braces.

Heh, I didn't really expect review at that level. I'm not even sure this
is a good direction to go versus something like the bloom filters (or
even a more full --raw cache). But if it is, this code is mostly
throw-away anyway, as we'd want to integrate it with the actual diff
code.

My original goal had mostly been to get an idea of the size, and the
"dump" half was there to verify that the results were roughly sane. But
it actually works for rough timing, too. I can generate roughly the same
results as "rev-list --all | diff-tree --stdin -t --name-only" in about
300ms, as opposed to 33s. So that's good.

But it's also a slight cheat, since I'm not actually traversing the
commits, but rather just opening up the bitmaps in the order we wrote
them. ;)

Actually walking the commits (and not looking at the trees) takes ~7s,
so it would at least be more like 33s versus 7.3s. With core.commitgraph,
it's more like 1.1s, so imagine 27s versus 1.4s, I guess.

That's also neglecting any load/lookup time for actual random-access to
the bitmaps. I doubt that's more than a few hundred ms, but that's just
a made-up number.

So I think the rough timings are favorable, but the real proof would
actually be using it from a revision walk, which I haven't written.

> > +	putchar('\0');
> > +
> >  	free(sorted);
> >  }
> >  
> > @@ -142,6 +150,8 @@ static void generate_bitmap(struct diff_queue_struct *q,
> >  
> >  	ewah = bitmap_to_ewah(bitmap);
> >  	ewah_serialize_strbuf(ewah, &out);
> > +
> > +	fwrite(data->commit->object.oid.hash, 1, GIT_SHA1_RAWSZ, stdout);
> >  	fwrite(out.buf, 1, out.len, stdout);
> 
> OK, so per commit, we have ewah bitmap that records the "changed
> paths" after the commit object name.  Makes sense.

Yeah. This format, btw, is garbage. It was just the smallest and
simplest thing I could think of that would work for my case. We'd want
random-access to the bitmaps for each commit, probably via an index
block in the commit-graph file.

> And the list of paths are based on the "one" side of the filepair.
> When we do an equivalent of "git show X", we see "diff-tree X~1 X"
> and by collecting the "one" side (i.e. subset of paths in the tree
> of X~1 that were modified when going to X) we say "commit X changed
> these paths".  Makes sense, too.

I didn't think too hard on whether we'd need to look at the "two" side
ever. I turned off renames, so we'd see deletions via the "one". I feel
like we'd miss additions in that case, though, but from my results, we
do not seem to.

-Peff
