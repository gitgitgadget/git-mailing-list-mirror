From: Jeff King <peff@peff.net>
Subject: Re: glibc mutex deadlock in signal handler
Date: Fri, 4 Sep 2015 05:23:55 -0400
Message-ID: <20150904092355.GA524@sigill.intra.peff.net>
References: <s5hfv2vn4wq.wl-tiwai@suse.de>
 <xmqqvbbrjrs9.fsf@gitster.mtv.corp.google.com>
 <s5h7fo7wb3e.wl-tiwai@suse.de>
 <87y4gn5ijr.fsf@igel.home>
 <s5hy4gmvii2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 11:24:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXnED-0005t6-QM
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 11:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938AbbIDJX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 05:23:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:54864 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756936AbbIDJX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 05:23:58 -0400
Received: (qmail 28495 invoked by uid 102); 4 Sep 2015 09:23:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 04:23:58 -0500
Received: (qmail 18194 invoked by uid 107); 4 Sep 2015 09:24:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 05:24:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Sep 2015 05:23:55 -0400
Content-Disposition: inline
In-Reply-To: <s5hy4gmvii2.wl-tiwai@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277296>

On Fri, Sep 04, 2015 at 07:52:21AM +0200, Takashi Iwai wrote:

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] pager: don't use unsafe functions in signal handlers
> 
> Since the commit [a3da8821208d: pager: do wait_for_pager on signal
> death], we call wait_for_pager() in the pager's signal handler.  The
> recent bug report revealed that this causes a deadlock in glibc at
> aborting "git log" [*1].  When this happens, git process is left
> unterminated, and it can't be killed by SIGTERM but only by SIGKILL.
> 
> The problem is that wait_for_pager() function does more than waiting
> for pager process's termination, but it does cleanups and printing
> errors.  Unfortunately, the functions that may be used in a signal
> handler are very limited [*2].  Particularly, malloc(), free() and the
> variants can't be used in a signal handler because they take a mutex
> internally in glibc.  This was the cause of the deadlock above.  Other
> than the direct calls of malloc/free, many functions calling
> malloc/free can't be used.  strerror() is such one, either.

I think this approach is the only real solution here (and I agree it is
a real-world problem). Unfortunately, it is the tip of the iceberg.
Looking at other signal handlers, there are lots of other potential
problems. For example, here are the first few I found by grepping:

  - clone.c:remove_junk uses strbufs; these are doing useful work, and
    can't just be skipped if we are in a signal handler

  - fetch calls transport_unlock_pack, which has a free (which can be
    skipped)

  - repack uses remove_temporary_files, which uses a strbuf

and so on.

> Also the usage of fflush() and printf() in a signal handler is bad,
> although it seems working so far.  In a safer side, we should avoid
> them, too.

I'd be surprised if they are safe; stdio definitely involves locking.

Perhaps we should reconsider whether f4c3edc (vreportf: avoid
intermediate buffer, 2015-08-11) is a good idea.  Note that snprintf is
not on the list of safe functions, but I imagine that in practice it is
fine. Though just avoiding error()/warning() in signal handlers might be
a more practical solution anyway.

> diff --git a/pager.c b/pager.c
> index 27d4c8a17aa1..12d17af73745 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -26,7 +26,10 @@ static void wait_for_pager(void)
>  
>  static void wait_for_pager_signal(int signo)
>  {
> -	wait_for_pager();
> +	/* signal EOF to pager */
> +	close(1);
> +	close(2);
> +	finish_command_in_signal(&pager_process);
>  	sigchain_pop(signo);
>  	raise(signo);
>  }

Hmm, is there is any reason to just pass an "in_signal" flag to
wait_for_pager(), to avoid duplicating the logic?

The rest of the patch looks pretty straightforward.

-Peff
