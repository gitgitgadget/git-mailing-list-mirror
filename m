From: Jeff King <peff@peff.net>
Subject: Re: [sort-of-BUG] merge-resolve cannot resolve "content/mode"
 conflict
Date: Wed, 18 May 2016 21:03:18 -0400
Message-ID: <20160519010318.GA23155@sigill.intra.peff.net>
References: <20160403052627.GA10487@sigill.intra.peff.net>
 <xmqqh9fh5lcl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 03:03:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3CN4-0001VH-F3
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 03:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbcESBDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 21:03:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:41605 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752242AbcESBDV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 21:03:21 -0400
Received: (qmail 8371 invoked by uid 102); 19 May 2016 01:03:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 21:03:21 -0400
Received: (qmail 28243 invoked by uid 107); 19 May 2016 01:03:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 21:03:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 21:03:18 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9fh5lcl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295031>

On Mon, Apr 04, 2016 at 10:34:34AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Imagine a merge where one side changes the content of a path and the
> > other changes the mode. Here's a minimal reproduction:
> >
> >   git init repo && cd repo &&
> >
> >   echo base >file &&
> >   git add file &&
> >   git commit -m base &&
> >
> >   echo changed >file &&
> >   git commit -am content &&
> >
> >   git checkout -b side HEAD^
> >   chmod +x file &&
> >   git commit -am mode
> > ...
> > This is a leftover from my experiments with merge-resolve versus
> > merge-recursive last fall, which resulted in a few actual bug-fixes. I
> > looked into fixing this case, too, at that time. It seemed possible, but
> > a little more involved than you might think (because the logic is driven
> > by a bunch of case statements, and this adds a multiplicative layer to
> > the cases; we might need to resolve the permissions, and _then_ see if
> > the content can be resolved).
> 
> Perhaps I am missing some other codepath in the "multiplicative"
> layer, but is this not sufficient?

Sorry for the super-slow reply; just cleaning out my "to respond to"
pile, which has gotten pretty deep.

Looking at it again, I think you are right. I seemed to recall that
there were multiple case arms where we dealt with the permissions, but I
cannot find such a spot now. So I think the solution you outlined looks
good.

> -	if test "$6" != "$7"
> +	# Three-way merge of the permissions
> +	perm= ;# assume the result is the same from stage #2, i.e. $6
> +	if test "$6" = "$7" || test "$5" = "$7"
> +	then
> +		: nothing
> +	elif test "$5" = "$6"
>  	then
> +		case "$7" in
> +		100644)	perm=-x ;;
> +		100755) perm=+x ;;
> +		*) echo "ERROR: $7: funny filemode not handled." >&2 ;;
> +		esac

We reject symlinks and submodules earlier, so I think this "funny
filemode" error really should only be truly-funny entries. Good.

-Peff
