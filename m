Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67074208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 21:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbeHFXhD (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 19:37:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:44768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732639AbeHFXhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 19:37:02 -0400
Received: (qmail 25938 invoked by uid 109); 6 Aug 2018 21:26:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 21:26:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4974 invoked by uid 111); 6 Aug 2018 21:26:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 17:26:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 17:26:03 -0400
Date:   Mon, 6 Aug 2018 17:26:03 -0400
From:   Jeff King <peff@peff.net>
To:     Noam Postavsky <npostavs@users.sourceforge.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Message-ID: <20180806212603.GA21026@sigill.intra.peff.net>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
 <573B6BF5.1090004@kdbg.org>
 <20160517194533.GA11289@sigill.intra.peff.net>
 <20160517195136.GB11289@sigill.intra.peff.net>
 <20160517195541.GC11289@sigill.intra.peff.net>
 <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
 <20180625162308.GA13719@sigill.intra.peff.net>
 <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 30, 2018 at 08:47:16AM -0400, Noam Postavsky wrote:

> I'm still having trouble getting a big picture understanding of how
> the graph struct relates the what gets drawn on screen, but through
> some poking around with the debugger + trial & error, I've arrived at
> a new patch which seems to work. It's also a lot simpler. I hope you
> can tell me if it makes sense.
> [...]
>  	int num_dashes =
>  		((graph->num_parents - dashless_commits) * 2) - 1;
>  	for (i = 0; i < num_dashes; i++) {
> -		col_num = (i / 2) + dashless_commits + graph->commit_index;
> +		col_num = (i / 2) + dashless_commits;
>  		strbuf_write_column(sb, &graph->new_columns[col_num], '-');
>  	}
> -	col_num = (i / 2) + dashless_commits + graph->commit_index;
> +	col_num = (i / 2) + dashless_commits;

Hmm. So this seems to work because in your example, we're showing the
merge in slot 1. So the index is 1, and we have an off-by-one problem,
and getting rid of that solves it.

But what if we had another line of development to the left of that?
I.e., if the "c" in your script was itself on the right-hand side of a
merge.

We can simulate that by adding this to your script, right before the
invocation of log:

  # We traverse in commit-date order, so make sure the new commit is
  # more recent than the others. This is also the cause of your "calling
  # it x doesn't work" comment, I think (all of these commits are
  # created in a single second, so the order we hit the refs in --all
  # matters).
  sleep 1

  git checkout -b a-prime master^
  git commit --allow-empty -m a-prime

That gives me a graph like this (for d-e-f):

  * d342ed8 (HEAD -> a-prime) a-prime
  | * 14aae3a (c) c
  | | *-------.   4bacae1 (m) merge a b d e f
  | | |\ \ \ \ \  
  | |/ / / / / /  
  | | | | | | * f19c3a9 (f) f
  | |_|_|_|_|/  
  |/| | | | |   
  | | | | | * 48fd961 (e) e
  | |_|_|_|/  
  |/| | | |   
  | | | | * 3f4914f (d) d
  | |_|_|/  
  |/| | |   
  | | | * 8bef98c (b) b
  | |_|/  
  |/| |   
  | | * 253e7ba (a) a
  | |/  
  |/|   
  | * 8a60f32 (master) 1
  |/  
  * b00ba42 0

and graph->commit_index is 2.

That doesn't trigger valgrind, but all the colors are off-by-one (which
makes sense; we're off-by-one towards the beginning of the array now).
Using "graph->commit_index - 1" seems to yield the right results, but it
feels like we're just hacking around it. And my understanding was that
the "straight edge" case actually works with the current code, and we'd
probably be breaking that.

I still think it makes more sense to iterate over the columns rather
than over the dashes, which removes a lot of these confusing cases. This
is what I came up with:

diff --git a/graph.c b/graph.c
index c782590202..d0a3e0858b 100644
--- a/graph.c
+++ b/graph.c
@@ -847,22 +847,24 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 static int graph_draw_octopus_merge(struct git_graph *graph,
 				    struct strbuf *sb)
 {
+	int col_num, first_col, last_col;
+
+	/* Skip the current commit, since we've already drawn its asterisk. */
+	first_col = graph->commit_index + 1;
 	/*
-	 * Here dashless_commits represents the number of parents
-	 * which don't need to have dashes (because their edges fit
-	 * neatly under the commit).
+	 * We subtract three, one each for:
+	 *  - the commit we're directly on top of
+	 *  - the commit to our left that we're merged into
+	 *  - we want to point to the final column, not one past
 	 */
-	const int dashless_commits = 2;
-	int col_num, i;
-	int num_dashes =
-		((graph->num_parents - dashless_commits) * 2) - 1;
-	for (i = 0; i < num_dashes; i++) {
-		col_num = (i / 2) + dashless_commits;
+	last_col = first_col + graph->num_parents - 3;
+
+	for (col_num = first_col; col_num <= last_col; col_num++) {
 		strbuf_write_column(sb, &graph->new_columns[col_num], '-');
+		strbuf_write_column(sb, &graph->new_columns[col_num],
+				    col_num == last_col ? '.' : '-');
 	}
-	col_num = (i / 2) + dashless_commits;
-	strbuf_write_column(sb, &graph->new_columns[col_num], '.');
-	return num_dashes + 1;
+	return 2 * (last_col - first_col + 1);
 }
 
 static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)

I suspect it still has a bug, which is that it is handling this
first-parent-goes-left case, but probably gets the straight-parent case
wrong. But at least in this form, I think it is obvious to see where
that bug is (the "three" in the comment is not accurate in that latter
case, and it should be two). Which I think is what your original fix was
getting at: we need to set first/last to start off with, and then
"shrink" them with a conditional depending on which form we're seeing.

-Peff
