From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] run-command: provide in_async query function
Date: Tue, 1 Sep 2015 16:26:10 -0400
Message-ID: <20150901202609.GA8063@sigill.intra.peff.net>
References: <20150901202215.GA17370@sigill.intra.peff.net>
 <20150901202243.GA6931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 22:26:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWs8W-0003Vf-5x
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 22:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbbIAU00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 16:26:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:53296 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751728AbbIAU0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 16:26:12 -0400
Received: (qmail 21704 invoked by uid 102); 1 Sep 2015 20:26:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 15:26:12 -0500
Received: (qmail 5478 invoked by uid 107); 1 Sep 2015 20:26:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 16:26:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 16:26:10 -0400
Content-Disposition: inline
In-Reply-To: <20150901202243.GA6931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277039>

On Tue, Sep 01, 2015 at 04:22:43PM -0400, Jeff King wrote:

> diff --git a/run-command.c b/run-command.c
> index 3277cf7..c8029f2 100644
> --- a/run-command.c
> +++ b/run-command.c

This diff is a little funny to read because the interesting context is
far away, and it is not immediately obvious why we are defining the
function twice. This:

> @@ -595,7 +595,7 @@ static NORETURN void die_async(const char *err, va_list params)
>  {
>  	vreportf("fatal: ", err, params);
>  
> -	if (!pthread_equal(main_thread, pthread_self())) {
> +	if (in_async()) {
>  		struct async *async = pthread_getspecific(async_key);
>  		if (async->proc_in >= 0)
>  			close(async->proc_in);
> @@ -614,6 +614,13 @@ static int async_die_is_recursing(void)
>  	return ret != NULL;
>  }
>  
> +int in_async(void)
> +{
> +	if (!main_thread_set)
> +		return 0; /* no asyncs started yet */
> +	return !pthread_equal(main_thread, pthread_self());
> +}
> +
>  #else

is all inside #ifndef NO_PTHREADS, and this:

> @@ -653,6 +660,12 @@ int git_atexit(void (*handler)(void))
>  }
>  #define atexit git_atexit
>  
> +static int process_is_async;
> +int in_async(void)
> +{
> +	return process_is_async;
> +}
> +
>  #endif

is the "#else" case where we fork.

-Peff
