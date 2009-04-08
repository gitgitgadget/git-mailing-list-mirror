From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [PATCH] graph API: Added logic for colored edges
Date: Wed, 8 Apr 2009 17:41:29 -0400
Message-ID: <20090408214129.GA20764@linux.vnet>
References: <20090331235922.GA7411@linux.vnet> <20090407185724.GA9996@linux.vnet> <7vd4bnpodt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 23:43:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrfYA-0002eo-5V
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 23:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911AbZDHVll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 17:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbZDHVlj
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 17:41:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:28481 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756339AbZDHVli (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 17:41:38 -0400
Received: by rv-out-0506.google.com with SMTP id f9so302948rvb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=eDsNq6pfahRAE3JQKzED32r650KQ9SMjcdX6pR7uepw=;
        b=qMH3JpgNpLFx1OinjmKHeVbeDmU0mGLsCCq7OZtxTiWpjfxPS7JJ05SikwtWFQybYO
         sotcRaISzPQbE9gKPd9GeEeoNerE/92rpdZrOyEejjsv64yj63/i348AHgE9QcshYThU
         AFeakK4SQoUCywv79x6tIxY9CkklC4IVFxm/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=DWOakvxzfbPVhhXnuXRbPAY+CYKSEAAxuhsNEFX0Y9A2QLNdBdhz2Xlm0BW/xy2mat
         2dSV6tR7PHqVd0Mv79om/AhK6pD6r99s3ZV62/WEPP+sW0k5O094UYPh2P0VwtxEfrk7
         ajhGexABcd+hAErEe9kA/Fdt+jVznhReppRPI=
Received: by 10.142.157.9 with SMTP id f9mr584862wfe.341.1239226897188;
        Wed, 08 Apr 2009 14:41:37 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 22sm10594146wfi.21.2009.04.08.14.41.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 14:41:35 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>
Content-Disposition: inline
In-Reply-To: <7vd4bnpodt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116126>

On Wed, 08 Apr 2009, Junio C Hamano wrote:
> Allan Caffee <allan.caffee@gmail.com> writes:
> 
> > @@ -72,11 +69,21 @@ struct column {
> >  	 */
> >  	struct commit *commit;
> >  	/*
> > -	 * XXX: Once we add support for colors, struct column could also
> > -	 * contain the color of its branch line.
> > +	 * The color to (optionally) print this column in.
> >  	 */
> > +	const char *color;
> 
> You already use short for git_graph.default_column_color and I suspect in
> the longer term you want to make this one an index into column_colors[]
> array the same way.  We may someday decide to support non-ANSI color
> scheme using ncurses or something, and at that point the "hardware color"
> constants like GIT_COLOR_RED and friends may change from strings to small
> integers we use to call our (yet to be written) curses interface layer
> with.

The problem with making it an index into the column_colors array is that
we don't have a convenient place to test whether the user actually wants
color.  We can't do it in strbuf_write_column because AFAIK there's no
way to get the rev-info to test the options.  I suppose we could define
GIT_NOT_A_COLOR to -1 and just set the color to that when we don't
intend to use color.  (Either way I should probably change that to an
unsigned short.)  What do you think?

> > @@ -312,6 +343,33 @@ static struct commit_list *first_interesting_parent(struct git_graph *graph)
> >  	return next_interesting_parent(graph, parents);
> >  }
> >  
> > +static const char* graph_get_current_column_color(const struct git_graph* graph)
> 
> Style.  Asterisk comes next to identifiers, not types (the parameter to
> graph_increment_column_color has the same issue).

Okay.

> 	static const char *graph_...color(const struct git_graph *graph)
> 
> > @@ -596,7 +661,7 @@ static void graph_output_padding_line(struct git_graph *graph,
> >  	 * Output a padding row, that leaves all branch lines unchanged
> >  	 */
> >  	for (i = 0; i < graph->num_new_columns; i++) {
> > -		strbuf_addstr(sb, "| ");
> > +		strbuf_write_column(sb, &graph->new_columns[i], "| ");
> 
> Hmmm, this forbids us to use reverse color in the color palette because
> that would highlight the trailing whitespace.  Is that something we care
> about, or a reversed "|", "/" and "\" are already too ugly that we won't
> want to support them?

Personally I don't think it's a good idea to limit the colors just
because they would "look funny".  It seems to me that if the user wanted
the background colored they would expect to see just the line segment
colored and not the whitespace.

The simplest way to fix this AFAIKS is to change strbuf_write_column to
take a single character and change the existing code to add spaces in
seperately.

/* For example */
strbuf_write_column(sb, &graph->new_columns[i], "| ");
/* Becomes */
strbuf_write_column(sb, &graph->new_columns[i], '|');
strbuf_addch(sb, ' ');

This would fix the problem at the minor expense of adding ~15 lines of
code.

> [...]
> 
> > @@ -744,14 +813,25 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
> >  			if (graph->num_parents < 3)
> >  				strbuf_addch(sb, ' ');
> >  			else {
> > +				/*
> > +				 * Here dashless_commits represents the
> > +				 * number of parents which don't need
> > +				 * to have dashes (because their edges
> > +				 * fit neatly under the commit).
> > +				 */
> > +				const int dashless_commits = 2;
> >  				int num_dashes =
> > -					((graph->num_parents - 2) * 2) - 1;
> > +					((graph->num_parents - dashless_commits) * 2) - 1;
> >  				for (j = 0; j < num_dashes; j++)
> > -					strbuf_addch(sb, '-');
> > -				strbuf_addstr(sb, ". ");
> > +					strbuf_write_column(sb,
> > +							    &graph->new_columns[(j / 2) + dashless_commits],
> > +							    "-");
> > +				strbuf_write_column(sb,
> > +						    &graph->new_columns[(j / 2) + dashless_commits],
> > +						    ". ");
> 
> The nesting seems to be becoming too deep and the body of the for loop is
> getting too long.  Time to make it a helper function that handles only one
> column, perhaps?

If I understand this correctly in order to write a per column function
would be like:

/*
 * Draw one peice of the commit line and return the new value of
 * seen_this.
 */
static int graph_commit_line_draw_column(struct git_graph *graph, 
                                         struct strbuf *sb,
                                         int i, int seen_this)

Which moves the entire body of the for loop into a function and only
reduces the indentation by one level.  Am I missing something?
