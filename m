Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5203A75A8
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433093; cv=none; b=D6JBQInduGlRo4p2I4wRo8PbMeDRU/jstf3mVsSaopNqri2eaCieAMCKT0DevCcvdxAQxyfMcyXlTQj0vyQXSCjPnC98w4e9m489O8hMwZvPwACCx9i3f7QTDMIAtqRMIe4EzLsgVhY/zK9gXqdhel8LR88Psv54FtFO8mhC5Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433093; c=relaxed/simple;
	bh=HDFMXt3Y5zsMaoibK9xdl88skB3NP8T26uSdVikfmMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDwpMEnJZ1fkgJQTsRksIv96WfN/UP/06l+U26wL87jKRDfCgAGaM1Oz6ueWGmGGGWLRVVTg58P/h8rN6g2mFurFxXwwRmo95sAciCYxvGqF7n4PSpSopoFNVEsLGw+BD4UAjF7qD21hmWWPSVKESZvIfFEL1VBs7rdAyhveYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4fgjFD71YFzRpLH;
	Wed, 25 Mar 2026 11:04:48 +0100 (CET)
Message-ID: <19cef686-6287-4916-8fec-a9ffe33f7889@kdbg.org>
Date: Wed, 25 Mar 2026 11:04:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v4 2/3] graph: truncate graph visual output
Content-Language: en-US
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com,
 ayu.chandekar@gmail.com, siddharthasthana31@gmail.com,
 chandrapratap3519@gmail.com, gitster@pobox.com, git@vger.kernel.org
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-3-pabloosabaterr@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260323215935.74486-3-pabloosabaterr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 23.03.26 um 22:59 schrieb Pablo Sabater:
> +	/*
> +	 * If graph_max_lanes is set, cap the padding from the branches
> +	 */
> +	if (graph->revs->graph_max_lanes > 0) {
> +		/*
> +		 * Get the maximum width by multiplying the maximum number of
> +		 * lanes by the size of the lane "| " and adds the truncation
> +		 * mark ". "
> +		 */
> +		int max_columns_width = graph->revs->graph_max_lanes * 2 + 2;

Please be to the point in the code comments. That there is a
multiplication and an addition, we can see in the code. Perhaps:

		/* width of "| " per lane plus truncation mark ". " */

> +		if (graph->width > max_columns_width)
> +			graph->width = max_columns_width;
> +	}
> +
>  	/*
>  	 * Shrink mapping_size to be the minimum necessary
>  	 */

> @@ -1022,6 +1043,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
>  	 * children that we have already processed.)
>  	 */
>  	seen_this = 0;
> +
>  	for (i = 0; i <= graph->num_columns; i++) {
>  		struct column *col = &graph->columns[i];
>  		struct commit *col_commit;

Is this empty line really needed?

> +				if (j >= 2)
> +					truncation_max -= 1;

I think it is more idiomatic way to write this as truncation_max--.

> @@ -1288,12 +1365,20 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
>  	 */
>  	for (i = 0; i < graph->mapping_size; i++) {
>  		int target = graph->mapping[i];
> -		if (target < 0)
> -			graph_line_addch(line, ' ');
> -		else if (target * 2 == i)
> -			graph_line_write_column(line, &graph->new_columns[target], '|');
> -		else if (target == horizontal_edge_target &&
> -			 i != horizontal_edge - 1) {
> +
> +		if (!truncated && graph_needs_truncation(graph, i / 2)) {
> +			graph_line_addstr(line, ". ");
> +			truncated = 1;
> +		}
> +
> +		if (target < 0) {
> +			if (!truncated)
> +				graph_line_addch(line, ' ');
> +		} else if (target * 2 == i) {
> +			if (!truncated)
> +				graph_line_write_column(line, &graph->new_columns[target], '|');
> +		} else if (target == horizontal_edge_target &&
> +			   i != horizontal_edge - 1) {
>  				/*
>  				 * Set the mappings for all but the
>  				 * first segment to -1 so that they
> @@ -1301,13 +1386,14 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
>  				 */
>  				if (i != (target * 2)+3)
>  					graph->mapping[i] = -1;
> -				used_horizontal = 1;
> -			graph_line_write_column(line, &graph->new_columns[target], '_');
> +			used_horizontal = 1;
> +			if (!truncated)
> +				graph_line_write_column(line, &graph->new_columns[target], '_');

Huh? The indentation of "used_horizontal..." changed. The reason is that
this whole if-branch is indented too far by one tab. Perhaps an initial
clean-up commit that only fixes this indentation?

>  		} else {
>  			if (used_horizontal && i < horizontal_edge)
>  				graph->mapping[i] = -1;
> -			graph_line_write_column(line, &graph->new_columns[target], '/');
> -
> +			if (!truncated)
> +				graph_line_write_column(line, &graph->new_columns[target], '/');
>  		}
>  	}
>  
> @@ -1356,7 +1442,6 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
>  		graph_output_collapsing_line(graph, &line);
>  		break;
>  	}
> -
>  	graph_pad_horizontally(graph, &line);
>  	return shown_commit_line;
>  }

This removal of an empty line isn't warranted, I think.

-- Hannes

