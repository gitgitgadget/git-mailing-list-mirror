From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [RFC] Colorization of log --graph
Date: Thu, 19 Mar 2009 12:59:23 -0400
Message-ID: <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com>
References: <20090318100512.GA7932@linux.vnet>
	 <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 18:03:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkLcr-0008Mv-M0
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 18:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbZCSQ71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 12:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbZCSQ70
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 12:59:26 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:15734 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbZCSQ7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 12:59:25 -0400
Received: by qw-out-2122.google.com with SMTP id 8so526939qwh.37
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sSOZOMVm0BfoxtEXMMb9J24Ct7krTkKzvfdzpt+7W0g=;
        b=V6RExDwDoqtc9HcFgiSiKyI4JPHv0bgJywUX0t3dK1DTpFwfCTP6HnxjmHgQsyEkaA
         jzH6VJChpkPLEODcuR2PlKicVmWAWPrpbCdHBVXDHGVHlgGWx8vQA4EVRl3tRxDMm9N+
         FoOIl8Wah9JCrkkdRv6gDXFZlI3ipPnfnS5UA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T/xlsrfGdZwqaMt5/mI0CmeM4rrNH421Am5Fbj2C9Vqkc15UXMKw0/KAvl8OAoIaDp
         vXTWhDHNaYexqcus2N7H/vjeoD/87nq8QBuBEo6FnEfOuKYTDUelFHJgwaP0WfWGJSVM
         oJ8crVyO4Y5kSjgzxeWm1MDIYpk73disXszUY=
Received: by 10.220.73.134 with SMTP id q6mr1458599vcj.51.1237481963541; Thu, 
	19 Mar 2009 09:59:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113793>

Hello and thanks for the speedy reply!

On Wed, Mar 18, 2009 at 7:44 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 18 Mar 2009, Allan Caffee wrote:
>
> > I know that _some_ people arn't particularly fond of colors, but I was
> > wondering how difficult it would be to colorize the edges on the --graph
> > drawn by the log command?  It can be a little tricky trying to follow
> > them with a relatively complex history.  I was thinking something like
> > gitk already does.
>
> That's a good idea!  (And it is mentioned as a TODO in graph.c...)

That's me, always thinking outside the box.  ;-)

> > Is anybody else interested in seeing this?
>
> Count me in.  Are you interested in implementing this?

I'll give it a go.  Been a while since I've done anything of substance
in pure C so it should be a nice refresher.  :)

> If so:
>
> - you need to #include "color.h" in graph.c
>
> - you need to insert a color identifier into struct column (there is an
>  XXX comment at the correct location)

By color identifier I assume you mean the ANSI escape sequence, right?
I didn't see a type for representing colors in color.{c,h} other than
the int it seems to use internally.

> - you need to find a way to determine colors for the branches

Okay, so if we were to make this similiar to how gitk works it would involve:
If the previous commit was a merge:
	for (i = 0; i < graph->num_columns; i++)
		graph->columns[i]->color = get_next_column_color();
else
	get_current_column_color();

I was thinking of storing the current color by adding a
default_column_color attribute to git_graph that serves as an index into
column_colors.  column_colors being the array of available colors.

> - you need to put the handling into the function
>  graph_output_pre_commit_line() in graph.c (and probably
>  graph_output_commit_char(), graph_output_post_merge_line(),
>  graph_output_collapsing_line(), graph_padding_line(), and
>  graph_output_padding_line(), too)
>
> - it would make sense IMHO to introduce a new function that takes a
>  pointer to an strbuf, a pointer to a struct column and a char (or maybe
>  a string) that adds the appropriately colorized char (or string) to the
>  strbuf

That makes sense.  Then we can just update the functions you mentioned
above to use this.

> - use the global variable diff_use_color to determine if the output should
>  be colorized at all

The function for adding a column to an strbuf would offer a convenient
place to put the condition.

> - probably you need to make an array of available colors or some such
>  (which might be good to put into color.[ch])

This would be the color_codes array I mentioned but it seems like it
might belong in graph.c.  There's something similiar in diff.c and it
seems like this is more related to graphing then to colors in general.
Although I do think it makes sense to #define some of the more common
ANSI codes there so that they don't have to be duplicated.  grep shows 6
occurrences of '\033[31m', the code for red foreground.

I'll begin working on a patch.  Comments/questions?

~Allan
