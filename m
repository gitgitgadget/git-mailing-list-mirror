From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix signal handler
Date: Wed, 10 Feb 2010 12:33:48 -0500
Message-ID: <20100210173348.GA5091@coredump.intra.peff.net>
References: <4B684F5F.7020409@web.de>
 <20100202205849.GA14385@sigill.intra.peff.net>
 <4B71A2EE.8070708@web.de>
 <4B72E81B.3020900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:34:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfGS4-00060p-4i
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 18:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210Ab0BJRdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 12:33:49 -0500
Received: from peff.net ([208.65.91.99]:46987 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755849Ab0BJRdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 12:33:47 -0500
Received: (qmail 6265 invoked by uid 107); 10 Feb 2010 17:33:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 10 Feb 2010 12:33:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2010 12:33:48 -0500
Content-Disposition: inline
In-Reply-To: <4B72E81B.3020900@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139525>

On Wed, Feb 10, 2010 at 06:08:43PM +0100, Markus Elfring wrote:

> A global flag can only be set by a signal handler in a portable way if
> it has got the data type "sig_atomic_t". The previously used
> assignment of a function pointer in the function "early_output" was
> moved to another variable in the function "setup_early_output".
>
> The involved software design details were also mentioned on the
> mailing list.

Keep in mind commit messages will be read much later through "git log"
and the like.  Mentioning the mailing list is usually not very helpful
there. It is usually a good idea instead to summarize what was said on
the list for later readers of the commit (though in this case, I think
your first paragraph really says everything that needs to be said).

> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -123,7 +123,7 @@ static void show_early_header(struct rev_info *rev, const char *stage, int nr)
>  
>  static struct itimerval early_output_timer;
>  
> -static void log_show_early(struct rev_info *revs, struct commit_list *list)
> +extern void log_show_early(struct rev_info *revs, struct commit_list *list)

Why does this need to become extern? It looks like we are still just
assigning the function pointer from within this file.

> -volatile show_early_output_fn_t show_early_output;
> +sig_atomic_t show_early_output = 0;
> +show_early_output_fn_t early_output_function = NULL;

Good. I was worried from the above s/static/extern/ that you were going
to make log_show_early the only possible early output function, but the
way you did it is definitely the right way.

Overall, this change looks sane to me. You still haven't provided any
evidence that this is a problem in practice, but these changes are not
particularly cumbersome, so it is probably better to be on the safe
side.

-Peff
