From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pretty: Initialize notes if %N is used
Date: Mon, 12 Apr 2010 04:56:47 -0400
Message-ID: <20100412085647.GA26840@coredump.intra.peff.net>
References: <20100410220843.GA29987@coredump.intra.peff.net>
 <1270997662-25430-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Mon Apr 12 10:57:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1FSM-0001wT-Nj
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 10:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab0DLI5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 04:57:16 -0400
Received: from peff.net ([208.65.91.99]:42964 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab0DLI5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 04:57:15 -0400
Received: (qmail 17362 invoked by uid 107); 12 Apr 2010 08:57:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 12 Apr 2010 04:57:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Apr 2010 04:56:47 -0400
Content-Disposition: inline
In-Reply-To: <1270997662-25430-1-git-send-email-heipei@hackvalue.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144715>

On Sun, Apr 11, 2010 at 04:54:22PM +0200, Johannes Gilger wrote:

> something like this? I didn't see why userformat_fill_want had to have an extra
> argument for the format, since the user_format variable is static in pretty.c.

Yes, this is getting closer.

The reason to take the format argument is that there are places which
call format_commit_message() with an arbitrary string. We would want
them to be able to call userformat_fill_want(), too (right now, I don't
think any of them should need it, though).

Maybe it should take a format string, and use the user_format string if
you pass NULL?

> Sorry for the many very different patches to the bug, as you can see I'm not
> really familiar with best-practices in git.git.

Not at all. Sometimes seemingly simple bugs end up raising a whole host
of other issues. I am glad you are sticking around to help come up with
a good solution.

> diff --git a/builtin/log.c b/builtin/log.c
> index b706a5f..f8f5d22 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -58,7 +58,11 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
>  		usage(builtin_log_usage);
>  	argc = setup_revisions(argc, argv, rev, opt);
>  
> -	if (!rev->show_notes_given && !rev->pretty_given)
> +	struct userformat_want w;

Don't declare variables in the middle of a function. It's a C99-ism that
we avoid for older compilers.

> +	if (rev->commit_format == CMIT_FMT_USERFORMAT)
> +		userformat_fill_want(&w);
> +
> +	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
>  		rev->show_notes = 1;

Hmm. If we didn't get a userformat, what will be in w? It will be random
cruft from the stack, because we didn't call userformat_fill_want.

You can just call it unconditionally, and it should do the right thing
with a NULL user_format.

> +void userformat_fill_want(struct userformat_want *w)
> +{
> +	if (!user_format)
> +		return;
> +	struct strbuf dummy = STRBUF_INIT;
> +	memset(w, 0, sizeof(*w));
> +	strbuf_expand(&dummy, user_format, userformat_want_item, w);
> +	strbuf_release(&dummy);
> +}

This does nothing with a NULL user_format. It should probably still do
the memset() to indicate that nothing is wanted (otherwise the caller
has to be sure to initialize w themselves if they think user_format
might be NULL).

So combined with my above suggestion:

  void userformat_fill_want(const char *s, struct userformat_want *w)
  {
          struct strbuf dummy = STRBUF_INIT;
          memset(w, 0, sizeof(*w));
          if (!s) {
                  if (!user_format)
                          return;
                  s = user_format;
          }
          strbuf_expand(&dummy, user_format, userformat_want_item, w);
          strbuf_release(&dummy);
  }

and then you can just call

  userformat_fill_want(NULL, w);

safely from log.c (you don't even need to check rev->commit_format).

Also, even though I picked the name, userformat_fill_want is kind of a
lousy name. It was the best I could come up with, but maybe somebody has
a better suggestion.

-Peff
