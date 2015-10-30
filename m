From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: add --progress option
Date: Fri, 30 Oct 2015 15:31:51 -0400
Message-ID: <20151030193151.GB5336@sigill.intra.peff.net>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
 <CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
 <xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:31:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsFP3-0001Gt-N5
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758754AbbJ3Tby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:31:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:50591 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751309AbbJ3Tbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:31:53 -0400
Received: (qmail 7643 invoked by uid 102); 30 Oct 2015 19:31:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 14:31:53 -0500
Received: (qmail 25786 invoked by uid 107); 30 Oct 2015 19:32:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 15:32:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2015 15:31:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280531>

On Fri, Oct 30, 2015 at 11:48:36AM -0700, Junio C Hamano wrote:

> > Does this logic also need to be applied to the other instance where
> > isatty() is consulted in merge_working_tree()?
> 
> This makes me wonder if option_progress and o->quiet change once
> parse_options() finished doing its job.  If we know that these two
> will never change once parse_options() is done, then we can
> introduce a variable "show_progress", assign the value of that
> variable to opts.verbose_update in these places and then arrange
> that variable is set to the combination of quiet, option_progress
> and isatty(2) just once after parse_options().
> 
> That is, something like this on top of Edmundo's patch.

Yeah, I like splitting it out like this.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e28c36b..53d7c49 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -27,7 +27,7 @@ static const char * const checkout_usage[] = {
>  	NULL,
>  };
>  
> -static int option_progress = -1;
> +static int show_progress = 1;

You don't need this initialization, right? Looks like we assign
unconditionally to it in cmd_checkout.

> @@ -1143,6 +1142,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	struct branch_info new;
>  	char *conflict_style = NULL;
>  	int dwim_new_local_branch = 1;
> +	int option_progress = -1;
>  	struct option options[] = {
>  		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
>  		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
> @@ -1187,6 +1187,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, options, checkout_usage,
>  			     PARSE_OPT_KEEP_DASHDASH);
>  
> +	show_progress = (!opts.quiet &&
> +			 (0 < option_progress || (option_progress < 0 && isatty(2))));
> +

I sometimes find it confusing when there are two variables with very
similar meanings (option_progress and show_progress here). I wonder if
we could use one variable, like:

  static int show_progress = -1;
  ...
  OPT_BOOL(0, "progress", &show_progress, ...);
  ...
  parse_options(...);
  if (show_progress < 0) {
	if (opts.quiet)
		show_progress = 0;
	else
		show_progress = isatty(2);
  }

That somehow is much clearer to me, especially around the behavior of
"-q --progress". Mine does the opposite of what you wrote above, but I
think it makes more sense.

I can live with it either way, though. :)

-Peff
