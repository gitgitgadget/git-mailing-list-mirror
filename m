Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B1D31F404
	for <e@80x24.org>; Sat,  8 Sep 2018 16:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIHU7f (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 16:59:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:43714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726314AbeIHU7f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 16:59:35 -0400
Received: (qmail 10921 invoked by uid 109); 8 Sep 2018 16:13:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 08 Sep 2018 16:13:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28849 invoked by uid 111); 8 Sep 2018 16:13:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Sep 2018 12:13:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Sep 2018 12:13:16 -0400
Date:   Sat, 8 Sep 2018 12:13:16 -0400
From:   Jeff King <peff@peff.net>
To:     Noam Postavsky <npostavs@users.sourceforge.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Message-ID: <20180908161316.GA326@sigill.intra.peff.net>
References: <573B6BF5.1090004@kdbg.org>
 <20160517194533.GA11289@sigill.intra.peff.net>
 <20160517195136.GB11289@sigill.intra.peff.net>
 <20160517195541.GC11289@sigill.intra.peff.net>
 <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
 <20180625162308.GA13719@sigill.intra.peff.net>
 <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
 <20180806212603.GA21026@sigill.intra.peff.net>
 <CAM-tV-_=4WuMGemm6RTB902-m8JfMKGp_OkQFuJMagPE8bOOtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM-tV-_=4WuMGemm6RTB902-m8JfMKGp_OkQFuJMagPE8bOOtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 01, 2018 at 08:34:41PM -0400, Noam Postavsky wrote:

> On 6 August 2018 at 17:26, Jeff King <peff@peff.net> wrote:
> 
> > I suspect it still has a bug, which is that it is handling this
> > first-parent-goes-left case, but probably gets the straight-parent case
> > wrong. But at least in this form, I think it is obvious to see where
> > that bug is (the "three" in the comment is not accurate in that latter
> > case, and it should be two).
> 
> Yes, thanks, it makes a lot more sense this way. I believe the
> attached handles both parent types correctly.

Great (and sorry for the delayed response).

Let me see if I understand it...

> diff --git a/graph.c b/graph.c
> index e1f6d3bdd..478c86dfb 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -848,21 +848,45 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
>  				    struct strbuf *sb)
>  {
>  	/*
> -	 * Here dashless_commits represents the number of parents
> -	 * which don't need to have dashes (because their edges fit
> -	 * neatly under the commit).
> +	 * Here dashless_commits represents the number of parents which don't
> +	 * need to have dashes (because their edges fit neatly under the
> +	 * commit).  And dashful_commits are the remaining ones.
>  	 */
>  	const int dashless_commits = 2;

Why is dashless commits always going to be 2? I thought at first that it
was representing the merge commit itself, plus the line of development
to the left. But the latter could be arbitrarily sized.

But that's not what it is, because we handle that by using
graph->commit_index in the iteration below. So I get that the merge
commit itself does not need a dash. What's the other one?

> +	int dashful_commits = graph->num_parents - dashless_commits;

OK, this makes sense.

> +	/*
> +	 * Usually, each parent gets its own column, like this:
> +	 *
> +	 * | *-.
> +	 * | |\ \
> +	 * | | | *
> +	 *
> +	 * Sometimes the first parent goes into an existing column, like this:
> +	 *
> +	 * | *-.
> +	 * | |\ \
> +	 * |/ / /
> +	 *
> +	 */
> +	int parent_in_existing_cols = graph->num_parents -
> +		(graph->num_new_columns - graph->num_columns);

Ah, OK, this is the magic part: we compare num_new_columns versus
num_columns to see which case we have. Makes sense. And this comment is
very welcome to explain it visually.

> +	/*
> +	 * Draw the dashes.  We start in the column following the
> +	 * dashless_commits, but subtract out the parent which goes to an
> +	 * existing column: we've already counted that column in commit_index.
> +	 */
> +	int first_col = graph->commit_index + dashless_commits
> +		- parent_in_existing_cols;
> +	int i;

OK, so we start at the commit_index, which makes sense. We skip past the
dashless commits (which includes the merge itself, plus the other
mystery one). And then we go back by the parents in existing columns,
which I think is either 1 or 2.

And I think that may be the root of my confusion. The other "dashless"
commit is the parent we've already printed before hitting this function,
the left-hand line that goes all the way down below where we print the
other parents.

So I think this is doing the right thing. I'm not sure if there's a
better way to explain "dashless" or not.

> +	for (i = 0; i < dashful_commits; i++) {
> +		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
> +		strbuf_write_column(sb, &graph->new_columns[i+first_col],
> +				    i == dashful_commits-1 ? '.' : '-');
>  	}

And this loop is nice and simple now. Good.

So I think this patch looks right. This is all sufficiently complex that
we probably want to add something to the test suite. For reference,
here's how I hacked up your original script to put more commits on the
left:

--- test-multiway-merge.sh.orig	2018-09-08 12:04:23.007468601 -0400
+++ test-multiway-merge.sh	2018-09-08 12:11:02.267750789 -0400
@@ -25,6 +25,11 @@
 
 
 "$GIT" init
+for base in 1 2 3 4; do
+    echo base-$base >foo
+    git add foo
+    git commit -m base-$base
+done
 echo 0 > foo
 "$GIT" add foo
 "$GIT" commit -m 0
@@ -47,4 +52,10 @@
 "$GIT" checkout m
 "$GIT" merge -m "merge a b $*" a b "$@"
 
+sleep 1
+for i in 1 2 3 4; do
+    git checkout -b $i-prime master~$i
+    git commit --allow-empty -m side-$i
+done
+
 valgrind "$GIT" log --oneline --graph --all

Then running it as "test-multiway-merge d e f" gives a nice wide graph
that should show any off-by-one mistakes. We should be able to do away
with the "sleep" in a real test if we make use of test_commit(), which
advances GIT_COMMITTER_DATE by one second for each commit.

Do you feel comfortable trying to add something to the test suite for
this?

-Peff
