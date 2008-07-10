From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revisions: refactor handle_revision_opt into
	parse_revision_opt.
Date: Thu, 10 Jul 2008 03:14:18 -0400
Message-ID: <20080710071418.GD3195@sigill.intra.peff.net>
References: <1215639514-1612-1-git-send-email-madcoder@debian.org> <1215639514-1612-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 09:15:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGqNF-0004Jz-B4
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 09:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbYGJHOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 03:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbYGJHOb
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 03:14:31 -0400
Received: from peff.net ([208.65.91.99]:4434 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbYGJHOa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 03:14:30 -0400
Received: (qmail 18124 invoked by uid 111); 10 Jul 2008 07:14:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 10 Jul 2008 03:14:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2008 03:14:18 -0400
Content-Disposition: inline
In-Reply-To: <1215639514-1612-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87948>

On Wed, Jul 09, 2008 at 11:38:34PM +0200, Pierre Habouzit wrote:

> It seems we're using handle_revision_opt the same way each time, have a
> wrapper around it that does the 9-liner we copy each time instead.
> 
> handle_revision_opt can be static in the module for now, it's always
> possible to make it public again if needed.

I have been on the road, and I finally got the chance to read through
your whole parseopt/blame refactoring. I think it looks good overall, as
do these patches.

I have one comment, though I am not sure it is worth implementing.

I was happy to see this refactoring, which I think improves readability:

> -		n = handle_revision_opt(&revs, ctx.argc, ctx.argv,
> -					&ctx.cpidx, ctx.out);
> -		if (n <= 0) {
> -			error("unknown option `%s'", ctx.argv[0]);
> -			usage_with_options(blame_opt_usage, options);
> -		}
> -		ctx.argv += n;
> -		ctx.argc -= n;
> +		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);

but it also seems like the top bit of that for loop is boilerplate, too:

>  	for (;;) {
>  		switch (parse_options_step(&ctx, options, shortlog_usage)) {
>  		case PARSE_OPT_HELP:
>  			exit(129);
>  		case PARSE_OPT_DONE:
>  			goto parse_done;
>  		}

AFAICT, the main reason for not folding this into your refactored
function is that after the parse_options_step, but before we handle the
revision arg to parse_revision_opt, there needs to be an opportunity for
the caller to intercept and do something based on revision opts (like
blame does with --reverse):

	if (!strcmp(ctx.argv[0], "--reverse")) {
		ctx.argv[0] = "--children";
		reverse = 1;
	}

But I wonder if it would be a suitable alternative to just add
"--reverse" in this case to the blame options, but with an option flag
for "parse me, but also pass me along to the next parser" (which would
be added). Then we could do our thing in a callback.

Of course, in this case, we do something a bit tricky by actually
_rewriting_ the argument to "--children". So we would have to have
support for callbacks rewriting arguments, or it would have to manually
do what "--children" should do. So perhaps it isn't worth the trouble.
This particular boilerplate is at least not very error-prone.

So food for thought, mainly, I suppose. Apologies if you already thought
of this and I missed the discussion. I think I am up to date on my
back-reading of the git list, but it is easy to lose some threads. :)

-Peff
