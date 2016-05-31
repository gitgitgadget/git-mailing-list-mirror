From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/lib-git-daemon: ksh portability workaround
Date: Tue, 31 May 2016 19:05:47 -0400
Message-ID: <20160531230547.GC4585@sigill.intra.peff.net>
References: <xmqqinxt3kwq.fsf@gitster.mtv.corp.google.com>
 <xmqq60tt3k4f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 01:05:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7sjT-0007JF-Gl
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 01:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbcEaXFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 19:05:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:46826 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750730AbcEaXFv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 19:05:51 -0400
Received: (qmail 3088 invoked by uid 102); 31 May 2016 23:05:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 19:05:50 -0400
Received: (qmail 28220 invoked by uid 107); 31 May 2016 23:05:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 19:05:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2016 19:05:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqq60tt3k4f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296032>

On Tue, May 31, 2016 at 04:04:00PM -0700, Junio C Hamano wrote:

> The "git daemon" test checks with what status the daemon exits when
> we terminate it, and we expect that we can observe death by SIGTERM.
> 
> We forgot that ksh adds 256, unlike 128 that are used by other POSIX
> shells, to the signal number that caused the process to die when
> coming up with the exit status.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> index 340534c..623b3ae 100644
> --- a/t/lib-git-daemon.sh
> +++ b/t/lib-git-daemon.sh
> @@ -83,7 +83,8 @@ stop_git_daemon() {
>  	wait "$GIT_DAEMON_PID" >&3 2>&4
>  	ret=$?
>  	# expect exit with status 143 = 128+15 for signal TERM=15
> -	if test $ret -ne 143
> +	# or 271 = 256+15 on ksh
> +	if test $ret -ne 143 && test $ret -ne 271

The presence of this patch (on top of the other one) makes me think we
should go with something like:

  test_exit_code_is

or something, and make it available via test-lib-functions.sh.

-Peff
