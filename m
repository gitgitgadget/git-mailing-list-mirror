From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] graph API: Added logic for colored edges.
Date: Mon, 30 Mar 2009 18:04:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903301749590.7534@intel-tinevez-2-302>
References: <20090318100512.GA7932@linux.vnet> <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de> <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com> <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302> <20090320064813.6117@nanako3.lavabit.com>
 <b2e43f8f0903201213o396de6c0sb52149ed1d889d1@mail.gmail.com> <20090320195806.GC26934@coredump.intra.peff.net> <20090321175726.GA6677@linux.vnet> <20090330141322.GA6221@linux.vnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 18:08:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoJzv-0007g1-Uj
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 18:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbZC3QEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 12:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbZC3QEc
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 12:04:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:60006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753029AbZC3QEb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 12:04:31 -0400
Received: (qmail invoked by alias); 30 Mar 2009 16:04:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp066) with SMTP; 30 Mar 2009 18:04:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+KL9BJ2+uKQ5dvEXJhzC6qZWSnpMur33b9cdQSs/
	2KrVC0o8LKS6H2
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090330141322.GA6221@linux.vnet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115171>

Hi,

On Mon, 30 Mar 2009, Allan Caffee wrote:

> Modified the graph drawing logic to colorize edges based on parent-child 
> relationships similiarly to gitk.
> 
> Signed-off-by: Allan Caffee <allan.caffee@gmail.com>

Nice!

> I havn't gotten the chance to do any of the color clean up that's been 
> discussed on this thread.  I'll try to throw something together in a 
> seperate patch series.
> 
> Also this patch isn't respecting the --no-color option which I imagine 
> means that diff_use_color_default isn't the right variable to be 
> checking.  Johannes mentioned using diff_use_color but the only instance 
> I see is a parameter to diff_get_color.  What am I missing?

The patch I sent you should work...

> diff --git a/graph.c b/graph.c
> index 162a516..2929c8b 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -72,11 +74,22 @@ struct column {
>  	 */
>  	struct commit *commit;
>  	/*
> -	 * XXX: Once we add support for colors, struct column could also
> -	 * contain the color of its branch line.
> +	 * The color to (optionally) print this column in.
>  	 */
> +	char *color;
>  };
>  
> +static void strbuf_write_column(struct strbuf *sb, const struct column *c,
> +		const char *s);
> +
> +static char* get_current_column_color (const struct git_graph* graph);
> +
> +/*
> + * Update the default column color and return the new value.
> + */
> +static char* get_next_column_color(struct git_graph* graph);
> +
> +

Please just insert the definitions here, instead of using a forward 
declaration.

> @@ -86,6 +99,24 @@ enum graph_state {
>  	GRAPH_COLLAPSING
>  };
>  
> +/*
> + * The list of available column colors.
> + */
> +static char column_colors[][COLOR_MAXLEN] = {
> +	GIT_COLOR_RED,
> +	GIT_COLOR_GREEN,
> +	GIT_COLOR_YELLOW,
> +	GIT_COLOR_BLUE,
> +	GIT_COLOR_MAGENTA,
> +	GIT_COLOR_CYAN,
> +	GIT_COLOR_BOLD GIT_COLOR_RED,
> +	GIT_COLOR_BOLD GIT_COLOR_GREEN,
> +	GIT_COLOR_BOLD GIT_COLOR_YELLOW,
> +	GIT_COLOR_BOLD GIT_COLOR_BLUE,
> +	GIT_COLOR_BOLD GIT_COLOR_MAGENTA,
> +	GIT_COLOR_BOLD GIT_COLOR_CYAN,
> +};
> +
>  struct git_graph {
>  	/*
>  	 * The commit currently being processed

I imagine that this is a good start.  Whether to make a patch that moves 
this into color.[ch] before or after this patch is up to Junio, I guess 
(even if I would prefer it to be done before, so that it gets done).

> @@ -317,6 +354,14 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
>  					  int *mapping_index)
>  {
>  	int i;
> +	char *color = get_current_column_color(graph);
> +
> +	for (i = 0; i < graph->num_columns; i++) {
> +		if (graph->columns[i].commit == commit) {
> +			color = graph->columns[i].color;
> +			break;
> +		}
> +	}

I imagine that this would be better done using a struct decorate mapping 
commits to the color strings.

Also, I'd only call get_current_column_color() if there was no color 
assigned to the commit (instead of calling it all the time).

It might not be a performance bottleneck here, but I guess it is better 
not to get used to that pattern anyway.

> @@ -334,6 +379,8 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
>  	 * This commit isn't already in new_columns.  Add it.
>  	 */
>  	graph->new_columns[graph->num_new_columns].commit = commit;
> +/*         fprintf(stderr,"adding the %scommit%s\n", color, GIT_COLOR_RESET); */

Please remove this line.

> @@ -649,7 +702,10 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>  		struct column *col = &graph->columns[i];
>  		if (col->commit == graph->commit) {
>  			seen_this = 1;
> -			strbuf_addf(sb, "| %*s", graph->expansion_row, "");
> +			struct strbuf tmp = STRBUF_INIT;
> +			strbuf_addf(&tmp, "| %*s", graph->expansion_row, "");
> +			strbuf_write_column(sb, col, tmp.buf);
> +			strbuf_release(&tmp);

Maybe it would be better to add functions

const char *column_color(struct column *c)
{
	return c->color ? c->color : "";
}

const char *column_color_reset(struct column *c)
{
	return c->color ? GIT_COLOR_RESET : "";
}

?

Sorry, I have to stop the review here, ran out of time...

If nobody beats me to it, I will continue here later.

Thanks!
Dscho
