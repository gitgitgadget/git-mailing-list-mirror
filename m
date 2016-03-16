From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of
 XDG_RUNTIME_DIR
Date: Wed, 16 Mar 2016 13:15:36 -0400
Message-ID: <20160316171535.GC4039@sigill.intra.peff.net>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
 <1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, pickfire@riseup.net
To: Hui Yiqun <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:15:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agF2t-0000k9-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbcCPRPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 13:15:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:60691 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751498AbcCPRPi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 13:15:38 -0400
Received: (qmail 7870 invoked by uid 102); 16 Mar 2016 17:15:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 13:15:38 -0400
Received: (qmail 15739 invoked by uid 107); 16 Mar 2016 17:15:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 13:15:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 13:15:36 -0400
Content-Disposition: inline
In-Reply-To: <1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288998>

On Wed, Mar 16, 2016 at 06:07:45PM +0800, Hui Yiqun wrote:

> diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
> index 82c8411..0718bb0 100755
> --- a/t/t0301-credential-cache.sh
> +++ b/t/t0301-credential-cache.sh
> @@ -12,7 +12,32 @@ test -z "$NO_UNIX_SOCKETS" || {
>  # don't leave a stale daemon running
>  trap 'code=$?; git credential-cache exit; (exit $code); die' EXIT
>  
> +test_expect_success 'set $XDG_RUNTIME_DIR' '
> +	XDG_RUNTIME_DIR=$HOME/xdg_runtime/
> +'

Doesn't this need to export the variable so that credential-cache can
see it?

> +
> +helper_test cache
> +

This runs the full suite of tests twice (once here, and once for the
original helper_test invocation you left below). Shouldn't we just do it
once (making sure that $XDG_RUNTIME_DIR is respected)?

> +test_expect_success 'force git-credential-cache to exit so that socket disappear' '
> +	git credential-cache exit &&
> +	test_path_is_missing "$XDG_RUNTIME_DIR/git/credential-cache.sock" &&
> +	unset XDG_RUNTIME_DIR
> +'

I wondered if this might be racy. credential-cache tells the daemon
"exit", then waits for a response or EOF. The daemon sees "exit" and
calls exit(0) immediately. We clean up the socket in an atexit()
handler. So I think we are OK (the pipe will get closed when the process
exits, and the atexit handler must have run by then).

But that definitely was not designed, and is just how it happens to
work. I'm not sure if it's worth commenting on that (here, or perhaps in
the daemon code).

-Peff
