From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Colorization of log --graph
Date: Thu, 19 Mar 2009 18:41:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302>
References: <20090318100512.GA7932@linux.vnet>  <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de> <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 18:43:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkMGh-0002DR-BQ
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 18:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbZCSRla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 13:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbZCSRl3
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 13:41:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:33971 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751751AbZCSRl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 13:41:29 -0400
Received: (qmail invoked by alias); 19 Mar 2009 17:41:25 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 19 Mar 2009 18:41:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ASWI1KP6AfTUdiQfLDv3/CNPoIf64yyHS2wAXdZ
	i0q1BAJ0hQV6V9
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113799>

Hi,

On Thu, 19 Mar 2009, Allan Caffee wrote:

> Hello and thanks for the speedy reply!

Heh, Git is known for raw speed ;-)

> On Wed, Mar 18, 2009 at 7:44 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Wed, 18 Mar 2009, Allan Caffee wrote:
> >
> > > Is anybody else interested in seeing this?
> >
> > Count me in.  Are you interested in implementing this?
> 
> I'll give it a go.  Been a while since I've done anything of substance 
> in pure C so it should be a nice refresher.  :)

Great!

> > If so:
> >
> > - you need to #include "color.h" in graph.c
> >
> > - you need to insert a color identifier into struct column (there is an
> >  XXX comment at the correct location)
> 
> By color identifier I assume you mean the ANSI escape sequence, right? I 
> didn't see a type for representing colors in color.{c,h} other than the 
> int it seems to use internally.

I'd actually add an enum color_names, or something like that.

> > - you need to find a way to determine colors for the branches
> 
> Okay, so if we were to make this similiar to how gitk works it would 
> involve: If the previous commit was a merge:
> 	for (i = 0; i < graph->num_columns; i++)
> 		graph->columns[i]->color = get_next_column_color();
> else
> 	get_current_column_color();
> 
> I was thinking of storing the current color by adding a 
> default_column_color attribute to git_graph that serves as an index into 
> column_colors.  column_colors being the array of available colors.

Yep, I agree.  That index could be of type "enum color_names" if you 
introduce the latter...

> > - you need to put the handling into the function 
> >   graph_output_pre_commit_line() in graph.c (and probably 
> >   graph_output_commit_char(), graph_output_post_merge_line(), 
> >   graph_output_collapsing_line(), graph_padding_line(), and 
> >   graph_output_padding_line(), too)
> >
> > - it would make sense IMHO to introduce a new function that takes a 
> >   pointer to an strbuf, a pointer to a struct column and a char (or 
> >   maybe a string) that adds the appropriately colorized char (or 
> >   string) to the strbuf
> 
> That makes sense.  Then we can just update the functions you mentioned
> above to use this.

Right.

> > - use the global variable diff_use_color to determine if the output 
> >   should be colorized at all
> 
> The function for adding a column to an strbuf would offer a convenient 
> place to put the condition.

Yes!

> > - probably you need to make an array of available colors or some such 
> >   (which might be good to put into color.[ch])
> 
> This would be the color_codes array I mentioned but it seems like it
> might belong in graph.c.  There's something similiar in diff.c and it
> seems like this is more related to graphing then to colors in general.
> Although I do think it makes sense to #define some of the more common
> ANSI codes there so that they don't have to be duplicated.  grep shows 6
> occurrences of '\033[31m', the code for red foreground.

I'd actually like to see it in color.[ch], so that other code paths can 
use it, too.

I'd start like this:

	enum color_name {
		COLOR_RESET,
		COLOR_RED,
		COLOR_GREEN,
		COLOR_YELLOW,
		COLOR_BLUE,
		COLOR_MAGENTA,
		COLOR_CYAN,
		COLOR_WHITE
	};

Maybe the best thing would then be to add a function

	void strbuf_add_color(struct strbuf *buf, enum color_name name) {
		if (name == COLOR_RESET)
			strbuf_addf(buf, "\033[m");
		else
			strbuf_addf(buf, "\033[%dm", 31 + name - COLOR_RED);
	}

Ciao,
Dscho
