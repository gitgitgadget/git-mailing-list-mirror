Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B78205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 05:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755214AbdAIFav (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 00:30:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:36789 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754795AbdAIFau (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 00:30:50 -0500
Received: (qmail 16619 invoked by uid 109); 9 Jan 2017 05:30:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 05:30:50 +0000
Received: (qmail 1028 invoked by uid 111); 9 Jan 2017 05:31:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 00:31:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2017 00:30:47 -0500
Date:   Mon, 9 Jan 2017 00:30:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] log --graph: customize the graph lines with config
 log.graphColors
Message-ID: <20170109053047.sn75d6ynipgf4nur@sigill.intra.peff.net>
References: <xmqqzijjd34j.fsf@gitster.mtv.corp.google.com>
 <20170108101333.26221-1-pclouds@gmail.com>
 <xmqq37gtyluf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37gtyluf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 08, 2017 at 07:05:12PM -0800, Junio C Hamano wrote:

> > +{
> > +	static char **colors;
> > +	static int colors_max, colors_alloc;
> > +	char *string = NULL;
> > +	const char *end, *start;
> > +	int i;
> > +
> > +	for (i = 0; i < colors_max; i++)
> > +		free(colors[i]);
> > +	if (colors)
> > +		free(colors[colors_max]);
> > +	colors_max = 0;
> 
> The correctness of the first loop relies on the fact that colors is
> non-null when colors_max is not zero, and then the freeing of the
> colors relies on something else.  It is not wrong per-se, but it
> will reduce the "Huh?" factor if you wrote it like so:
> 
> 	if (colors) {
>         	/* 
>                  * Reinitialize, but keep the colors[] array.
> 		 * Note that the last entry is allocated for
> 		 * reset but colors_max does not count it, hence
> 		 * "i <= colors_max", not "i < colors_max".
> 		 */
> 		int i;
> 		for (i = 0; i <= colors_max; i++)
> 			free(colors[i]);
> 		colors_max = 0;
> 	}

Yeah, I agree that what you've written here is less confusing. Less
confusing still would be to keep colors_nr, and deal separately with the
"max" interface to graph_set_column_colors().

I also wonder if it is worth just using argv_array. We do not care about
NULL-terminating the list here, but it actually works pretty well as a
generic string-array class (and keeping a NULL at the end of any
array-of-pointers is a reasonable defensive measure). Then the function
becomes:

  argv_array_clear(&colors);
  ...
  if (!color_parse_mem(..., color))
          argv_array_push(&colors, color);
  ...
  argv_array_push(&colors, GIT_COLOR_RESET);
  /* graph_set_column_colors takes a max-index, not a count */
  graph_set_column_colors(colors.argv, colors.argc - 1);

It is not much shorter than ALLOC_GROW(), but IMHO it is easier to read.

-Peff
