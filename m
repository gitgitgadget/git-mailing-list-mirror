From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] graph API: Added logic for colored edges
Date: Sun, 12 Apr 2009 14:59:48 -0700
Message-ID: <7veivx354b.fsf@gitster.siamese.dyndns.org>
References: <7vk55p7lu3.fsf@gitster.siamese.dyndns.org>
 <20090412202709.GA20549@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 00:02:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt7kX-0004WA-2W
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 00:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbZDLWAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 18:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbZDLWAB
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 18:00:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbZDLWAA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 18:00:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A955CAAEE7;
	Sun, 12 Apr 2009 17:59:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 705A2AAEE5; Sun,
 12 Apr 2009 17:59:50 -0400 (EDT)
In-Reply-To: <20090412202709.GA20549@linux.vnet> (Allan Caffee's message of
 "Sun, 12 Apr 2009 16:27:09 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 43B69D2C-27AD-11DE-8285-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116394>

Allan Caffee <allan.caffee@gmail.com> writes:

> I assumed that the +1 in your example was a typo since AFAIKS ARRAY_SIZE
> should give us one past the last index.

You are correct.

> Also if git is to be expanded allow the use of non-ANSI color codes (or
> already does so) the strbuf_escape_sequence_length needs to be updated
> to accept the relevant escape codes.

Actually, I am starting to hate this.

Just step back a bit and imagine how you would do this, if you _were_
writing an application to do this kind of thing, generating output
directly to the terminal.  You obviously would not seek back and count the
width of what you sent out.  Instead,...?

That's right.  You just keep a running total of how much you sent, iow,
what column you expect the current cursor should be.  Can't we do the same
thing here?

> @@ -312,6 +351,33 @@ static struct commit_list *first_interesting_parent(struct git_graph *graph)
>  	return next_interesting_parent(graph, parents);
>  }
>  
> +unsigned short graph_get_current_column_color(const struct git_graph *graph)

static?

> +static void graph_increment_column_color(struct git_graph *graph)
> +{
> +	graph->default_column_color = (graph->default_column_color + 1) %
> +		ARRAY_SIZE(column_colors);

COLUMN_COLORS_MAX?

> +unsigned short graph_find_commit_color(const struct git_graph *graph,
> +				       const struct commit *commit)
> +{

static?

> @@ -714,10 +790,30 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
>  	strbuf_addch(sb, '*');
>  }
>  
> +void graph_draw_octopus_merge(const struct git_graph *graph,
> +			      struct strbuf *sb)

static?

> @@ -789,6 +880,17 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
>  		graph_update_state(graph, GRAPH_COLLAPSING);
>  }
>  
> +struct column *find_new_column_by_commit(struct git_graph *graph,
> +					 struct commit *commit)
> +{

static?

> diff --git a/strbuf.c b/strbuf.c
> index a884960..666460d 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1,3 +1,4 @@
> +#include <ctype.h>
>  #include "cache.h"
>  #include "refs.h"

BAD.  Do not directly include system headers.  If you need isgraph(),
please support it as part of sane_ctype.  But if you count what you
emitted so far, you would not have to do this at all.

> +/*
> + * Return the length of the escape sequence in a string buffer
> + * starting at index i.  If there is no escape sequence starting at
> + * return 0.
> + */
> +size_t strbuf_esc_sequence_length(const struct strbuf *sb, size_t i)
> +{
> +	size_t start = i;
> +	if (sb->buf[i] != '\033')
> +		return 0;
> +	++i;
> +
> +	if (i >= sb->len || sb->buf[i] != '[')
> +		return 0;
> +	++i;
> +	while (i < sb->len && isdigit(sb->buf[i]))
> +		++i;
> +	if (i >= sb->len || sb->buf[i] != 'm')
> +		return 0;

These preincrements are extremely unreadable at least for me.

	if (sb->buf[i++] != '\033')
        	return 0;
	if (sb->len <= i || sb->buf[i++] != '[')
        	return 0;
	...

But again the point is hopefully moot.
