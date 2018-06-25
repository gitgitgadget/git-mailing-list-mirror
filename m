Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38901F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeFYQXM (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:23:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:53868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752327AbeFYQXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:23:11 -0400
Received: (qmail 14981 invoked by uid 109); 25 Jun 2018 16:23:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Jun 2018 16:23:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18762 invoked by uid 111); 25 Jun 2018 16:23:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Jun 2018 12:23:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jun 2018 12:23:09 -0400
Date:   Mon, 25 Jun 2018 12:23:09 -0400
From:   Jeff King <peff@peff.net>
To:     Noam Postavsky <npostavs@users.sourceforge.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Message-ID: <20180625162308.GA13719@sigill.intra.peff.net>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
 <573B6BF5.1090004@kdbg.org>
 <20160517194533.GA11289@sigill.intra.peff.net>
 <20160517195136.GB11289@sigill.intra.peff.net>
 <20160517195541.GC11289@sigill.intra.peff.net>
 <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 23, 2018 at 05:45:19PM -0400, Noam Postavsky wrote:

> On 20 May 2016 at 18:12, Noam Postavsky <npostavs@users.sourceforge.net> wrote:

My, this is a blast from the past. :)

> Subject: [PATCH v1] log: Fix coloring of certain octupus merge shapes
> 
> For octopus merges where the first parent edge immediately merges into
> the next column to the left:
> 
> | | *-.
> | | |\ \
> | |/ / /
> 
> then the number of columns should be one less than the usual case:
> 
> | *-.
> | |\ \
> | | | *

These diagrams confused me for a minute, because I see two differences:

  1. The first one has an extra apparently unrelated parallel branch on
     the far left.

  2. The first has the first-parent of the "*" merge commit immediately
     join the branch.

But if I understand correctly, we only care about the second property.
So would it be accurate to show them as:

  | *-.
  | |\ \
  |/ / /

  | *-.
  | |\ \
  | | | *

?

I think that makes it easier to compare them.

I don't remember much about our prior discussion, so let me try to talk
myself through the patch itself:

> diff --git a/graph.c b/graph.c
> index e1f6d3bdd..c919c86e8 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -856,12 +856,16 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
>  	int col_num, i;
>  	int num_dashes =
>  		((graph->num_parents - dashless_commits) * 2) - 1;
> -	for (i = 0; i < num_dashes; i++) {
> -		col_num = (i / 2) + dashless_commits + graph->commit_index;

OK, so the old code emitted num_dashes, and every pair was done with the
same column. Our highest iteration of this loop would use the column at
(num_dashes-1) / 2. We know that num_dashes is always odd, so:

 num_dashes = 1 puts our last column at 0
 num_dashes = 3 puts our last column at 1

And so on. So far so good.

> +	int first_col = dashless_commits + graph->commit_index;

This corresponds to the i=0 case, makes sense.

> +	int last_col = first_col + (num_dashes / 2);

But here our last_col misses the "-1". I don't think it matters because
we know num_dashes is always odd, and therefore due to integer
truncation (num_dashes-1)/2 == (num_dashes/2).

> +	if (last_col >= graph->num_new_columns) {
> +		first_col--;
> +		last_col--;
> +	}

The shifting of last_col I expect as part of the fix. I was surprised by
shifting first_col, though. Wouldn't it always start at 0 (offset by the
previous commits)? It definitely seems to be necessary, but I'm not sure
I understand why.

> +	for (i = 0, col_num = first_col; i < num_dashes; i++, col_num++) {
>  		strbuf_write_column(sb, &graph->new_columns[col_num], '-');
>  	}
> -	col_num = (i / 2) + dashless_commits + graph->commit_index;
> -	strbuf_write_column(sb, &graph->new_columns[col_num], '.');
> +	strbuf_write_column(sb, &graph->new_columns[last_col], '.');

In this new loop we count up our dashes and our columns. But now we have
1-to-1 correspondence as we increment! I don't think that can be right.
And indeed, if I take your original problem report and add an extra "d"
branch and make the octopus "a b d", then the problem comes back. You
don't notice with a 3-parent merge because 

We need to increment col_num only half as much as num_dashes. Should we
be doing:

  for (col_num = first_col; col_num < last_col; col_num++) {
	  strbuf_write_column(sb, &graph->new_columns[col_num], '-');
	  strbuf_write_column(sb, &graph->new_columns[col_num], '-');
  }
  strbuf_write_column(sb, &graph->new_columns[last_col], '-');
  strbuf_write_column(sb, &graph->new_columns[last_col], '.');

I.e., write "--" for each interior column, and then "-." for the last
one?

-Peff
