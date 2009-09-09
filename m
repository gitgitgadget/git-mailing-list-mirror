From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] push: make non-fast-forward help message
 configurable
Date: Wed, 9 Sep 2009 16:39:39 -0400
Message-ID: <20090909203939.GA10438@sigill.intra.peff.net>
References: <20090909112623.GA30765@coredump.intra.peff.net>
 <20090909113858.GA31051@coredump.intra.peff.net>
 <7vr5ugszte.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 22:39:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlTxF-00008U-6s
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 22:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbZIIUjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 16:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbZIIUji
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 16:39:38 -0400
Received: from peff.net ([208.65.91.99]:54199 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924AbZIIUji (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 16:39:38 -0400
Received: (qmail 30188 invoked by uid 107); 9 Sep 2009 20:39:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 09 Sep 2009 16:39:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2009 16:39:39 -0400
Content-Disposition: inline
In-Reply-To: <7vr5ugszte.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128080>

On Wed, Sep 09, 2009 at 12:06:21PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/advice.c b/advice.c
> > new file mode 100644
> > index 0000000..b5216a2
> > --- /dev/null
> > +++ b/advice.c
> > @@ -0,0 +1,25 @@
> > +#include "cache.h"
> > +
> > +int advice_push_nonfastforward = 1;
> > +
> > +static struct {
> > +	const char *name;
> > +	int *preference;
> > +} advice_config[] = {
> > +	{ "pushnonfastforward", &advice_push_nonfastforward },
> > +};
> 
> Can we have the value inside this struct, instead of having a pointer
> to another variable, and get rid of that variable altogether?

We could, but then callers need some way of indexing into the array.
Which means either:

  - a constant offset (like "#define ADVICE_PUSH_NONFASTFORWARD 0"). The
    problem with that is you get no compile-time support for making sure
    that your index matches the variable you want. I.e., you have:

      { "pushnonfastforward", 1 } /* ADVICE_PUSH_NONFASTFORWARD */

    with the position in the array implicitly matching the manually
    assigned numbers.  We do have precedent in things like diff_colors.
    I don't remember if we have ever screwed it up.

  - a dynamic offset, like (as you noted):

> If we did so, this part needs to become
> 
> 	if (nonfastforward && check_advice("pushnonfastforward")) {
> 
> which would be less efficient, but by definition advices are on the slow
> path, right?

which, as you note, is less efficient. It also turns typo-checking into
a run-time error rather than a compile-time error, which is IMHO a bad
idea. And if you care about such things, it is worse for using something
like ctags to find variable uses.

I went the way I did because it provides compile-time checking, and
because the variable is referred to by name in the table, the matching
is explicit and thus harder to screw up.

One final option would be to get rid of the table altogether. Its
function is to allow you to iterate over all of the variables. Now that
the "advice.all" option has been dropped, the only use is during config
parsing. We could simply unroll that loop to:

  if (!strcmp(k, "pushnonfastforward")) {
          advice_push_nonfastforward = git_config_bool(var, value);
          return 0;
  }
  if (!strcmp(k, "statushints")) {
          advice_status_hints = git_config_bool(var, value);
          return 0;
  }

as we do in other config parsing.

-Peff
