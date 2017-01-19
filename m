Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCAC20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 16:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753795AbdASQva (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 11:51:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:41571 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753374AbdASQv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 11:51:29 -0500
Received: (qmail 30443 invoked by uid 109); 19 Jan 2017 16:51:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 16:51:29 +0000
Received: (qmail 6631 invoked by uid 111); 19 Jan 2017 16:52:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 11:52:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 11:51:27 -0500
Date:   Thu, 19 Jan 2017 11:51:27 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] log --graph: customize the graph lines with
 config log.graphColors
Message-ID: <20170119165127.6cxw64fjz7aevkq2@sigill.intra.peff.net>
References: <20170109103258.25341-1-pclouds@gmail.com>
 <20170119114123.23784-1-pclouds@gmail.com>
 <20170119114123.23784-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170119114123.23784-4-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 06:41:23PM +0700, Nguyễn Thái Ngọc Duy wrote:

> +static void parse_graph_colors_config(struct argv_array *colors, const char *string)
> +{
> +	const char *end, *start;
> +
> +	start = string;
> +	end = string + strlen(string);
> +	while (start < end) {
> +		const char *comma = strchrnul(start, ',');
> +		char color[COLOR_MAXLEN];
> +
> +		if (!color_parse_mem(start, comma - start, color))
> +			argv_array_push(colors, color);
> +		else
> +			warning(_("ignore invalid color '%.*s' in log.graphColors"),
> +				(int)(comma - start), start);
> +		start = comma + 1;
> +	}
> +	argv_array_push(colors, GIT_COLOR_RESET);
> +}

This looks good.

> @@ -207,9 +228,24 @@ struct git_graph *graph_init(struct rev_info *opt)
>  {
>  	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
>  
> -	if (!column_colors)
> -		graph_set_column_colors(column_colors_ansi,
> -					column_colors_ansi_max);
> +	if (!column_colors) {
> +		struct argv_array ansi_colors = {
> +			column_colors_ansi,
> +			column_colors_ansi_max + 1
> +		};

Hrm. At first I thought this would cause memory corrution, because your
argv_array_clear() would try to free() the non-heap array you've stuffed
inside. But you only clear the custom_colors array which actually is
dynamically allocated. This outer one is just here to give uniform
access:

> +		struct argv_array *colors = &ansi_colors;
> +		char *string;
> +
> +		if (!git_config_get_string("log.graphcolors", &string)) {
> +			static struct argv_array custom_colors = ARGV_ARRAY_INIT;
> +			argv_array_clear(&custom_colors);
> +			parse_graph_colors_config(&custom_colors, string);
> +			free(string);
> +			colors = &custom_colors;
> +		}
> +		/* graph_set_column_colors takes a max-index, not a count */
> +		graph_set_column_colors(colors->argv, colors->argc - 1);
> +	}

Since there's only one line that cares about the result of "colors",
maybe it would be less confusing to do:

  if (!git_config_get-string("log.graphcolors", &string)) {
	... parse, etc ...
	graph_set_column_colors(colors.argv, colors.argc - 1);
  } else {
	graph_set_column_colors(column_colors_ansi,
	                        column_colors_ansi_max);
  }

-Peff
