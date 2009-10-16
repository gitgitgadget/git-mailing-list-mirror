From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Pretty formats for reflog data
Date: Fri, 16 Oct 2009 01:20:03 -0400
Message-ID: <20091016052003.GA10629@coredump.intra.peff.net>
References: <20091014050645.GD31810@coredump.intra.peff.net>
 <cover.1255645570.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 16 07:23:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyfI3-0001ST-1D
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 07:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbZJPFUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 01:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbZJPFUn
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 01:20:43 -0400
Received: from peff.net ([208.65.91.99]:44214 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbZJPFUm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 01:20:42 -0400
Received: (qmail 13159 invoked by uid 107); 16 Oct 2009 05:23:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 16 Oct 2009 01:23:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Oct 2009 01:20:03 -0400
Content-Disposition: inline
In-Reply-To: <cover.1255645570.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130455>

On Fri, Oct 16, 2009 at 12:41:43AM +0200, Thomas Rast wrote:

> Jeff King wrote:
> > Maybe a better solution would be a "short name" variant for pretty
> > format specifiers. We already have %(refname) and %(refname:short) [...]
> > The tricky part would be deciding on a syntax. This seems to come up a
> > fair bit.
> 
> Ok, I settled for %g[dDs] for now to save on letters.  I'm saving the
> syntax question for a later series while we discuss this one ;-)

:) That is probably sensible. Your %g[dD] doesn't support selecting
between the numbered version and the "date" version, which is something
we might want, but certainly it is no worse than the status quo (and
doing something like that probably _would_ want an extended syntax, as
you now have two orthogonal arguments: shorten and date/numbered).

> I think going for %(...) wouldn't be too bad since we already have
> that in for-each-ref, and it can be backwards compatible.  So we would
> have different sets of short and long specifiers, e.g.
> 
>   %ae = %(authoremail)
>   %aE = %(authoremail:mailmap)
> 
> We can then pass arguments via some yet-to-be decided syntax, say,
> %(body:indent(10)).

That seems reasonable to me, though if we can limit ourselves to one
argument per specifier (I suspect most specifiers would simply be
boolean, but a few may take numbers or strings), then something like
%(body:indent=10) might be a little more readable.

It would also be nice to have some sort of conditional inclusion, which
could deal with your extra ": " in patch 3. Either something like:

  %(reflog:short)%(reflog:+: )

or even

  %(reflog:short:prefix=\: )

and note that allowing arbitrary arguments means we get to deal with
quoting.

But that is all for another potential series.

> Other changes in this version include:
> 
> * I followed your struct suggestion, which is the new 1/5.

Thanks. It looks like it didn't turn out to be too invasive, and I think
some of the callsites are a bit more readable.

> * I fixed the warning that Junio found (and finally found the right
>   combination of -W flags, though I cannot compile with -Werror myself
>   because of *other* warnings...)

I always compile with -Wall -Werror (including testing your series);
what warnings are you getting?

> Thomas Rast (5):
>   Refactor pretty_print_commit arguments into a struct
>   reflog-walk: refactor the branch@{num} formatting
>   Introduce new pretty formats %g[sdD] for reflog information
>   stash list: use new %g formats instead of sed
>   stash list: drop the default limit of 10 stashes

Thanks, this series looks really good to me. I have a few comments on
patch 3 which I'll send separately.

-Peff
