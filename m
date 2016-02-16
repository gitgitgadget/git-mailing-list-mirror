From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] pager: factor out a helper to prepare a child
 process to run the pager
Date: Tue, 16 Feb 2016 18:26:58 -0500
Message-ID: <20160216232657.GB18634@sigill.intra.peff.net>
References: <1455664017-27588-1-git-send-email-gitster@pobox.com>
 <1455664017-27588-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:27:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVp1N-0004Ny-Ma
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933257AbcBPX1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 18:27:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:43689 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756250AbcBPX1A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:27:00 -0500
Received: (qmail 8834 invoked by uid 102); 16 Feb 2016 23:27:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 18:27:00 -0500
Received: (qmail 32306 invoked by uid 107); 16 Feb 2016 23:27:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 18:27:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 18:26:58 -0500
Content-Disposition: inline
In-Reply-To: <1455664017-27588-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286455>

On Tue, Feb 16, 2016 at 03:06:56PM -0800, Junio C Hamano wrote:

> diff --git a/pager.c b/pager.c
> index 5dbcc5a..1406370 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -53,6 +53,23 @@ const char *git_pager(int stdout_is_tty)
>  	return pager;
>  }
>  
> +void prepare_pager_args(struct child_process *pager_process, ...)
> +{
> +	va_list ap;
> +	const char *arg;
> +
> +	va_start(ap, pager_process);
> +	while ((arg = va_arg(ap, const char *)))
> +		argv_array_push(&pager_process->args, arg);
> +	va_end(ap);
> +
> +	pager_process->use_shell = 1;
> +	if (!getenv("LESS"))
> +		argv_array_push(&pager_process->env_array, "LESS=FRX");
> +	if (!getenv("LV"))
> +		argv_array_push(&pager_process->env_array, "LV=-c");
> +}

When reading this, I had to wonder what the "..." args were supposed to
be. I figured it out when I read the caller, but I wonder if a comment
would help. Also, we are expecting the pager here as the first argument,
so maybe:

  void prepare_pager_args(struct child_process *pager_process,
                          const char *pager, ...);

would be a better signature. That also made me wonder if we could simply
get away with:

  void prepare_pager_args(struct child_process *pager_process,
                          const char *pager);

and have callers argv_array_push() themselves afterwards.

And if you put the git_pager() call inside prepare_pager_args (which I
agree would be cleaner), we just have:

  void prepare_pager_args(struct child_process *pager_process);

which is pretty self-explanatory (though it might need a new name; I'd
be tempted to call it init_pager_process() or something, and actually
have it do the child_process_init() to make sure it is working with a
sane clean slate).

-Peff
