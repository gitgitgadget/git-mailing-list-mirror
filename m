From: Jeff King <peff@peff.net>
Subject: Re: Fix potential hang in https handshake (v3)
Date: Fri, 19 Oct 2012 17:08:51 -0400
Message-ID: <20121019210851.GD24184@sigill.intra.peff.net>
References: <5081c054.eD2hEWR8K8zW5vdM%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, sop@google.com,
	daniel@haxx.se
To: szager@google.com
X-From: git-owner@vger.kernel.org Fri Oct 19 23:09:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPJoY-0004qh-PM
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 23:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab2JSVIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 17:08:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39962 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754833Ab2JSVIy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 17:08:54 -0400
Received: (qmail 19247 invoked by uid 107); 19 Oct 2012 21:09:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Oct 2012 17:09:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2012 17:08:51 -0400
Content-Disposition: inline
In-Reply-To: <5081c054.eD2hEWR8K8zW5vdM%szager@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208067>

On Fri, Oct 19, 2012 at 02:04:20PM -0700, szager@google.com wrote:

> From 32e06128dbc97ceb0d060c88ec8db204fa51be5c Mon Sep 17 00:00:00 2001
> From: Stefan Zager <szager@google.com>
> Date: Thu, 18 Oct 2012 16:23:53 -0700

Drop these lines.

> Subject: [PATCH] Fix potential hang in https handshake.

And make this one your actual email subject.

> It has been observed that curl_multi_timeout may return a very long
> timeout value (e.g., 294 seconds and some usec) just before
> curl_multi_fdset returns no file descriptors for reading.  The
> upshot is that select() will hang for a long time -- long enough for
> an https handshake to be dropped.  The observed behavior is that
> the git command will hang at the terminal and never transfer any
> data.
> 
> This patch is a workaround for a probable bug in libcurl.  The bug
> only seems to manifest around a very specific set of circumstances:
> 
> - curl version (from curl/curlver.h):
> 
>  #define LIBCURL_VERSION_NUM 0x071307
> 
> - git-remote-https running on an ubuntu-lucid VM.
> - Connecting through squid proxy running on another VM.
> 
> Interestingly, the problem doesn't manifest if a host connects
> through squid proxy running on localhost; only if the proxy is on
> a separate VM (not sure if the squid host needs to be on a separate
> physical machine).  That would seem to suggest that this issue
> is timing-sensitive.

Thanks, that explanation makes much more sense.

> diff --git a/http.c b/http.c
> index df9bb71..51eef02 100644
> --- a/http.c
> +++ b/http.c
> @@ -631,6 +631,17 @@ void run_active_slot(struct active_request_slot *slot)
>  			FD_ZERO(&excfds);
>  			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
>  
> +			/* It can happen that curl_multi_timeout returns a pathologically
> +			 * long timeout when curl_multi_fdset returns no file descriptors
> +			 * to read.  See commit message for more details.
> +			 */

Minor nit, but our multi-line comment style is:

  /*
   * blah blah blah
   */

> +			if (max_fd < 0 &&
> +			    select_timeout.tv_sec > 0 ||
> +			    select_timeout.tv_usec > 50000) {
> +				select_timeout.tv_sec  = 0;
> +				select_timeout.tv_usec = 50000;
> +			}

Should there be parentheses separating the || bit from the &&?

-Peff
