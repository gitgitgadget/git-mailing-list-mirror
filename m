From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [PATCH v3] graph API: Added logic for colored edges
Date: Sun, 12 Apr 2009 13:43:19 -0400
Message-ID: <b2e43f8f0904121043o425ac311ib32c18625fac2c0e@mail.gmail.com>
References: <7vocv6is9g.fsf@gitster.siamese.dyndns.org>
	 <20090409222238.GA16573@linux.vnet>
	 <7vhc0u9s86.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 19:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt3jj-0003mD-5E
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 19:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbZDLRnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 13:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZDLRnW
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 13:43:22 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:34868 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbZDLRnV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 13:43:21 -0400
Received: by qyk16 with SMTP id 16so3459915qyk.33
        for <git@vger.kernel.org>; Sun, 12 Apr 2009 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nQh7M5MzJ6Py9QjaDeNaGXJxV1IP+ATjJRoEou0LimM=;
        b=qV5dUCy1qqpjwlthdcXg6Cr3F4/xeJ17W5E3zIjamqPSLpOO+shZKG8dF1q6MXfeUd
         Y+S3DFjQ8Rovm7lKCT0eB5lv5aVCfF6Ihfb0WpxdElmPJHZc6q+rwkUbnM6n/vS1nV7l
         cYgE+6Y85GTI1Fuam0+hr4n5aqqGVTqdOWf9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eF/3dUMlgZkc6esLgib4qED4NBLBaw8QsSTB+69wyv82+ZvF3Ctyn/rLuBSPqpb5WY
         pJrjB+ta/5P4aa+pad1HedQgUYpaFzWP7koH86ITRqkO3kAGuwtpmraMdEuWb6jSEPpP
         e7J2GMhzvNCR6TOZH7xyjtotndkNzyjfebyfE=
Received: by 10.220.73.6 with SMTP id o6mr5822007vcj.49.1239558199994; Sun, 12 
	Apr 2009 10:43:19 -0700 (PDT)
In-Reply-To: <7vhc0u9s86.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116384>

On Sun, 12 Apr 2009, Junio C Hamano wrote:

> Allan Caffee <allan.caffee@gmail.com> writes:
>
> > diff --git a/graph.c b/graph.c
> > index 162a516..beb622a 100644
> > --- a/graph.c
> > +++ b/graph.c
> > @@ -1,5 +1,6 @@
> >  #include "cache.h"
> >  #include "commit.h"
> > +#include "color.h"
> >  #include "graph.h"
> >  #include "diff.h"
> >  #include "revision.h"
> > @@ -72,11 +69,14 @@ struct column {
> >  	 */
> >  	struct commit *commit;
> >  	/*
> > -	 * XXX: Once we add support for colors, struct column could also
> > -	 * contain the color of its branch line.
> > +	 * The color to (optionally) print this column in.  This is an
> > +	 * index into column_colors.
> >  	 */
> > +	unsigned short color;
> >  };
> >
> > +const unsigned short GIT_NOT_A_COLOR = -1;
>
> That (-1) is an unusual value for an *unsigned* short variable.

Perhaps you would prefer USHRT_MAX?  I noticed that none of the existing
code #includes limits.h.  Is it safe to assume this header is present?

> > @@ -714,10 +790,30 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
> >  	strbuf_addch(sb, '*');
> >  }
> >
> > +inline void graph_draw_octopus_merge(const struct git_graph *graph,
> > +				     struct strbuf *sb)
> > +{
> > +	/*
> > +	 * Here dashless_commits represents the number of parents
> > +	 * which don't need to have dashes (because their edges fit
> > +	 * neatly under the commit).
> > +	 */
> > +	const int dashless_commits = 2;
> > +	int col_num, i;
> > +	int num_dashes =
> > +		((graph->num_parents - dashless_commits) * 2) - 1;
> > +	for (i = 0; i < num_dashes; i++) {
> > +		col_num = (i / 2) + dashless_commits;
> > +		strbuf_write_column(sb, &graph->new_columns[col_num], '-');
>
> graph.c: In function 'graph_draw_octopus_merge':
> graph.c:807: error: 'strbuf_write_column' is static but used in inline function 'graph_draw_octopus_merge' which is not static
> graph.c:810: error: 'strbuf_write_column' is static but used in inline function 'graph_draw_octopus_merge' which is not static
> make: *** [graph.o] Error 1
>
> In general, I'd prefer people not to say "inline" unless (1) they know
> what they are doing, and (2) the code is really performance critical.
>
> At least I do not think the colored commit graph is performance critical,
> especially a function that only deals with octopus merges.

Okay.  I'll remove the inline specifier from all the functions I added.
