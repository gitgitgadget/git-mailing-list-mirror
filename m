From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph API: Added logic for colored edges
Date: Wed, 08 Apr 2009 00:59:10 -0700
Message-ID: <7vd4bnpodt.fsf@gitster.siamese.dyndns.org>
References: <20090331235922.GA7411@linux.vnet>
 <20090407185724.GA9996@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 10:01:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrSiO-0005Ym-OI
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 10:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbZDHH7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 03:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbZDHH7T
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 03:59:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbZDHH7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 03:59:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 30081D333;
	Wed,  8 Apr 2009 03:59:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2F432D332; Wed, 
 8 Apr 2009 03:59:12 -0400 (EDT)
In-Reply-To: <20090407185724.GA9996@linux.vnet> (Allan Caffee's message of
 "Tue, 7 Apr 2009 14:57:24 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 289A4702-2413-11DE-ACE4-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116058>

Allan Caffee <allan.caffee@gmail.com> writes:

> @@ -72,11 +69,21 @@ struct column {
>  	 */
>  	struct commit *commit;
>  	/*
> -	 * XXX: Once we add support for colors, struct column could also
> -	 * contain the color of its branch line.
> +	 * The color to (optionally) print this column in.
>  	 */
> +	const char *color;

You already use short for git_graph.default_column_color and I suspect in
the longer term you want to make this one an index into column_colors[]
array the same way.  We may someday decide to support non-ANSI color
scheme using ncurses or something, and at that point the "hardware color"
constants like GIT_COLOR_RED and friends may change from strings to small
integers we use to call our (yet to be written) curses interface layer
with.

> @@ -312,6 +343,33 @@ static struct commit_list *first_interesting_parent(struct git_graph *graph)
>  	return next_interesting_parent(graph, parents);
>  }
>  
> +static const char* graph_get_current_column_color(const struct git_graph* graph)

Style.  Asterisk comes next to identifiers, not types (the parameter to
graph_increment_column_color has the same issue).

	static const char *graph_...color(const struct git_graph *graph)

> @@ -596,7 +661,7 @@ static void graph_output_padding_line(struct git_graph *graph,
>  	 * Output a padding row, that leaves all branch lines unchanged
>  	 */
>  	for (i = 0; i < graph->num_new_columns; i++) {
> -		strbuf_addstr(sb, "| ");
> +		strbuf_write_column(sb, &graph->new_columns[i], "| ");

Hmmm, this forbids us to use reverse color in the color palette because
that would highlight the trailing whitespace.  Is that something we care
about, or a reversed "|", "/" and "\" are already too ugly that we won't
want to support them?

> @@ -648,8 +713,11 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>  	for (i = 0; i < graph->num_columns; i++) {
>  		struct column *col = &graph->columns[i];
>  		if (col->commit == graph->commit) {
> +			struct strbuf tmp = STRBUF_INIT;
>  			seen_this = 1;
> -			strbuf_addf(sb, "| %*s", graph->expansion_row, "");
> +			strbuf_addf(&tmp, "| %*s", graph->expansion_row, "");
> +			strbuf_write_column(sb, col, tmp.buf);
> +			strbuf_release(&tmp);

Same here.

> @@ -662,13 +730,13 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>  			 */
>  			if (graph->prev_state == GRAPH_POST_MERGE &&
>  			    graph->prev_commit_index < i)
> -				strbuf_addstr(sb, "\\ ");
> +				strbuf_write_column(sb, col, "\\ ");
>  			else
> -				strbuf_addstr(sb, "| ");
> +				strbuf_write_column(sb, col, "| ");
>  		} else if (seen_this && (graph->expansion_row > 0)) {
> -			strbuf_addstr(sb, "\\ ");
> +			strbuf_write_column(sb, col, "\\ ");
>  		} else {
> -			strbuf_addstr(sb, "| ");
> +			strbuf_write_column(sb, col, "| ");
>  		}
>  	}

Likewise.

> @@ -744,14 +813,25 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
>  			if (graph->num_parents < 3)
>  				strbuf_addch(sb, ' ');
>  			else {
> +				/*
> +				 * Here dashless_commits represents the
> +				 * number of parents which don't need
> +				 * to have dashes (because their edges
> +				 * fit neatly under the commit).
> +				 */
> +				const int dashless_commits = 2;
>  				int num_dashes =
> -					((graph->num_parents - 2) * 2) - 1;
> +					((graph->num_parents - dashless_commits) * 2) - 1;
>  				for (j = 0; j < num_dashes; j++)
> -					strbuf_addch(sb, '-');
> -				strbuf_addstr(sb, ". ");
> +					strbuf_write_column(sb,
> +							    &graph->new_columns[(j / 2) + dashless_commits],
> +							    "-");
> +				strbuf_write_column(sb,
> +						    &graph->new_columns[(j / 2) + dashless_commits],
> +						    ". ");

The nesting seems to be becoming too deep and the body of the for loop is
getting too long.  Time to make it a helper function that handles only one
column, perhaps?
