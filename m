From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] graph API: Added logic for colored edges
Date: Sun, 12 Apr 2009 01:44:09 -0700
Message-ID: <7vhc0u9s86.fsf@gitster.siamese.dyndns.org>
References: <7vocv6is9g.fsf@gitster.siamese.dyndns.org>
 <20090409222238.GA16573@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 10:46:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsvKg-0007ZY-S2
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 10:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230AbZDLIoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 04:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757208AbZDLIoV
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 04:44:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856AbZDLIoU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 04:44:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B165E0A7;
	Sun, 12 Apr 2009 04:44:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 340DEE0A6; Sun,
 12 Apr 2009 04:44:11 -0400 (EDT)
In-Reply-To: <20090409222238.GA16573@linux.vnet> (Allan Caffee's message of
 "Thu, 9 Apr 2009 18:22:38 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1CD6A900-273E-11DE-BDA4-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116374>

Allan Caffee <allan.caffee@gmail.com> writes:

> diff --git a/graph.c b/graph.c
> index 162a516..beb622a 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "commit.h"
> +#include "color.h"
>  #include "graph.h"
>  #include "diff.h"
>  #include "revision.h"
> @@ -72,11 +69,14 @@ struct column {
>  	 */
>  	struct commit *commit;
>  	/*
> -	 * XXX: Once we add support for colors, struct column could also
> -	 * contain the color of its branch line.
> +	 * The color to (optionally) print this column in.  This is an
> +	 * index into column_colors.
>  	 */
> +	unsigned short color;
>  };
>  
> +const unsigned short GIT_NOT_A_COLOR = -1;

That (-1) is an unusual value for an *unsigned* short variable.

> @@ -714,10 +790,30 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
>  	strbuf_addch(sb, '*');
>  }
>  
> +inline void graph_draw_octopus_merge(const struct git_graph *graph,
> +				     struct strbuf *sb)
> +{
> +	/*
> +	 * Here dashless_commits represents the number of parents
> +	 * which don't need to have dashes (because their edges fit
> +	 * neatly under the commit).
> +	 */
> +	const int dashless_commits = 2;
> +	int col_num, i;
> +	int num_dashes =
> +		((graph->num_parents - dashless_commits) * 2) - 1;
> +	for (i = 0; i < num_dashes; i++) {
> +		col_num = (i / 2) + dashless_commits;
> +		strbuf_write_column(sb, &graph->new_columns[col_num], '-');

graph.c: In function 'graph_draw_octopus_merge':
graph.c:807: error: 'strbuf_write_column' is static but used in inline function 'graph_draw_octopus_merge' which is not static
graph.c:810: error: 'strbuf_write_column' is static but used in inline function 'graph_draw_octopus_merge' which is not static
make: *** [graph.o] Error 1

In general, I'd prefer people not to say "inline" unless (1) they know
what they are doing, and (2) the code is really performance critical.

At least I do not think the colored commit graph is performance critical,
especially a function that only deals with octopus merges.
