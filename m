From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] Adjust stat width calculations to take --graph
 output into account
Date: Fri, 23 Mar 2012 11:13:25 -0700
Message-ID: <7vy5qrtcca.fsf@alter.siamese.dyndns.org>
References: <1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
 <1332482108-2659-1-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 19:13:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB8zW-0008FD-S1
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 19:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776Ab2CWSN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 14:13:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756558Ab2CWSN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 14:13:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F1617330;
	Fri, 23 Mar 2012 14:13:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MkKrmcI4oQN+C3ZnsM/5l022SGo=; b=q/LsyD
	I1XtRbFH5wOnFnDXArbyVHvbnbgZ/xqDhTWgxzxm0oVwIfsT+6deeovHS/oyRCFK
	7q9z5A99+y/+ztATqTwlAEvX9mYHzMs6d5/X1j3Uwo1hD6DXNHVeIVtpFIYLxkf0
	yn18vBkHdfCyzpG+8s/Dl8vvNzJ7OD+GD86Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lr0PGiRGy3ykhqOqSwtfDYF+cl9IyT6w
	jLMXd4p3wAln2PTB1hU2O0/8ktgR/IxoIHOXDYET3LImPGy0KUnqPyKl/iNc1HI3
	nZ2x07D8Q64K4VdzecSXblvKqMNRynJFaVUCPmYz2atkQJdow+ggQOBoTglt2Yuv
	BttKxp7wd78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45B9F732F;
	Fri, 23 Mar 2012 14:13:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9391E732B; Fri, 23 Mar 2012
 14:13:26 -0400 (EDT)
In-Reply-To: <1332482108-2659-1-git-send-email-lucian.poston@gmail.com>
 (Lucian Poston's message of "Thu, 22 Mar 2012 22:54:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2B4BBF0-7513-11E1-B727-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193783>

Lucian Poston <lucian.poston@gmail.com> writes:

> The recent change to compute the width of diff --stat did not take into
> consideration the output from --graph. The consequence is that when both
> options are used, e.g. in 'log --stat --graph', the lines are too long.
>
> Adjust stat width calculations to take --graph output into account.
>
> Prevent graph width of diff-stat from falling below minimum.
>
> Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
> ---
>  diff.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 52 insertions(+), 20 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 377ec1e..31ba10c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1383,6 +1383,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	int width, name_width, graph_width, number_width = 4, count;
>  	const char *reset, *add_c, *del_c;
>  	const char *line_prefix = "";
> +	int line_prefix_length = 0;
> +	int reserved_character_count;
>  	int extra_shown = 0;
>  	struct strbuf *msg = NULL;
>  
> @@ -1392,6 +1394,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	if (options->output_prefix) {
>  		msg = options->output_prefix(options, options->output_prefix_data);
>  		line_prefix = msg->buf;
> +		line_prefix_length = options->output_prefix_length;
>  	}
>  
>  	count = options->stat_count ? options->stat_count : data->nr;
> @@ -1427,37 +1430,46 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	 * We have width = stat_width or term_columns() columns total.
>  	 * We want a maximum of min(max_len, stat_name_width) for the name part.
>  	 * We want a maximum of min(max_change, stat_graph_width) for the +- part.
> -	 * We also need 1 for " " and 4 + decimal_width(max_change)
> -	 * for " | NNNN " and one the empty column at the end, altogether
> +	 * Each line needs space for the following characters:
> +	 *   - 1 for the initial " "
> +	 *   - 4 + decimal_width(max_change) for " | NNNN "
> +	 *   - 1 for the empty column at the end,
> +	 * Altogether, the reserved_character_count totals
>  	 * 6 + decimal_width(max_change).
>  	 *
> -	 * If there's not enough space, we will use the smaller of
> -	 * stat_name_width (if set) and 5/8*width for the filename,
> -	 * and the rest for constant elements + graph part, but no more
> -	 * than stat_graph_width for the graph part.
> -	 * (5/8 gives 50 for filename and 30 for the constant parts + graph
> -	 * for the standard terminal size).
> +	 * Additionally, there may be a line_prefix, which reduces the available
> +	 * width by line_prefix_length.
> +	 *
> +	 * If there's not enough space, we will use the smaller of stat_name_width
> +	 * (if set) and 5/8*width for the filename, and the rest for the graph
> +	 * part, but no more than stat_graph_width for the graph part.
> +	 * Assuming the line prefix is empty, on a standard 80 column terminal
> +	 * this ratio results in 50 characters for the filename and 20 characters
> +	 * for the graph (plus the 10 reserved characters).

Please do not do reflowing of the text in the same patch as modifying the
logic.  It is unreadable for the purpose of finding out what you really
changed.

>  	 *
>  	 * In other words: stat_width limits the maximum width, and
>  	 * stat_name_width fixes the maximum width of the filename,
>  	 * and is also used to divide available columns if there
>  	 * aren't enough.
>  	 */
> +	reserved_character_count = 6 + number_width;

As far as I can tell, this introduces a variable that is set (and is meant
to be set) only at a single place, namely, here, and used throughout the
rest of the function. But it invites later patches to mistakenly update
the variable.  I do not see the merit of it.

If you wanted to have a symbolic name for (6+number_width), #define would
have served better.

Also as we see in the later part of the review, this name is probably way
too long to be useful.  We need a shorter and sweeter name to call it.

>  	if (options->stat_width == -1)
>  		width = term_columns();
>  	else
>  		width = options->stat_width ? options->stat_width : 80;
>  
> +	width -= line_prefix_length;
> +

Isn't this wrong?  This is not a rhetoric question, iow, I am not
declaring that this is wrong --- I just cannot see why the above is a good
change, as I do not see a sound reasoning behind it.

When the user said "--stat-width=80", she means that the diffstat part
(name and bargraph) is to extend 80 places, and she does not expect it to
be reduced by the width of the ancestry graph.  If the user wanted to clip
the entire width, she would have used COLUMNS=80 instead.

Am I missing something?

> @@ -1472,16 +1484,36 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	/*
>  	 * Adjust adjustable widths not to exceed maximum width
>  	 */
> -	if (name_width + number_width + 6 + graph_width > width) {
> -		if (graph_width > width * 3/8 - number_width - 6)
> -			graph_width = width * 3/8 - number_width - 6;
> +	if (reserved_character_count + name_width + graph_width > width) {
> +		/*
> +		 * Reduce graph_width to be at most 3/8 of the unreserved space and no
> +		 * less than 6, which leaves at least 5/8 for the filename.
> +		 */
> +		if (graph_width > width * 3/8 - reserved_character_count) {
> +			graph_width = width * 3/8 - reserved_character_count;
> +			if (graph_width < 6) {
> +				graph_width = 6;
> +			}
> +		}

What is this about?  reserved_character_count already knows about the
magic number 6 and here you have another magic number 6.  How are they
related with each other?

In other words, shouldn't the added code be more like this?

	if (graph_width < reserved_character_count - number_width)
		graph_width = reserved_character_count - number_width;

> +		/*
> +		 * If the remaining unreserved space will not accomodate the
> +		 * filenames, adjust name_width to use all available remaining space.
> +		 * Otherwise, assign any extra space to graph_width.
> +		 */
> +		if (name_width > width - reserved_character_count - graph_width) {
> +			name_width = width - reserved_character_count - graph_width;
> +		} else {
> +			graph_width = width - reserved_character_count - name_width;
> +		}
> +		/*
> +		 * If stat-graph-width was specified, limit graph_width to its value.
> +		 */
>  		if (options->stat_graph_width &&
> -		    graph_width > options->stat_graph_width)
> +				graph_width > options->stat_graph_width) {
>  			graph_width = options->stat_graph_width;
> -		if (name_width > width - number_width - 6 - graph_width)
> -			name_width = width - number_width - 6 - graph_width;
> -		else
> -			graph_width = width - number_width - 6 - name_width;
> +		}
>  	}

Yikes. It took me three minutes to realize that the only thing you did in
this hunk was to move the "if stat-graph-width is set" logic down.  Not
your fault, but this is one of the times I wish our diff generation logic
matched "corresponding" block of lines better.
