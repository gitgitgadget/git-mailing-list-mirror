From: Jeff King <peff@peff.net>
Subject: Re: [RFC] rename detection: allow more renames
Date: Tue, 24 Nov 2015 18:33:28 -0500
Message-ID: <20151124233328.GA13872@sigill.intra.peff.net>
References: <20151113163506.GD16219@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 00:33:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1N5Z-00010w-Ja
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 00:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbbKXXdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 18:33:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:33558 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753501AbbKXXdb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 18:33:31 -0500
Received: (qmail 30432 invoked by uid 102); 24 Nov 2015 23:33:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 17:33:30 -0600
Received: (qmail 20005 invoked by uid 107); 24 Nov 2015 23:33:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 18:33:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 18:33:28 -0500
Content-Disposition: inline
In-Reply-To: <20151113163506.GD16219@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281650>

On Fri, Nov 13, 2015 at 05:35:06PM +0100, Andreas Krey wrote:

> The code talks about limiting the size
> of the rename matrix, but as far as I
> can see, the matrix itself never exists
> as such, and the only thing that could
> actually overflow is the computation
> for the progress indication. This
> can be fixed by reporting just the
> destinations checked instead of the
> combinations, since we only update
> the progress once per destination
> anyway.

I didn't dig in the archive, but I think we discussed the "just show
progress for destinations" before. The problem you run into is that the
items aren't a good indication of the amount of work. You really are
doing n*m work, so if you just count "m", it can be very misleading if
"n" is high (and vice versa).

Might it make more sense just to move to a larger integer size? Or
perhaps to allow a higher limit for each side as long as the product of
the sides does not overflow?

> And we would also like to see progress when doing
> a cherry pick - in our case this takes a few minutes:
> 
>  
> diff --git a/sequencer.c b/sequencer.c
> index 3c060e0..8fce028 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -282,6 +282,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  
>  	for (xopt = opts->xopts; xopt != opts->xopts + opts->xopts_nr; xopt++)
>  		parse_merge_opt(&o, *xopt);
> +	o.show_rename_progress = isatty(2);
>  
>  	clean = merge_trees(&o,
>  			    head_tree,

I think that's sensible, for the same reasons that "merge" shows
progress. I suspect the patch you show above catches "git revert", too,
but if not, it should probably get the same treatment.

-Peff
