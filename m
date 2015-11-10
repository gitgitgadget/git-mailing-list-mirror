From: Jeff King <peff@peff.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it
 to ignore instead?
Date: Tue, 10 Nov 2015 07:25:02 -0500
Message-ID: <20151110122501.GA14418@sigill.intra.peff.net>
References: <20151027184702.GB12717@sigill.intra.peff.net>
 <CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
 <20151030001000.GA2123@sigill.intra.peff.net>
 <CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
 <20151030005057.GA23251@sigill.intra.peff.net>
 <CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
 <20151030210849.GA7149@sigill.intra.peff.net>
 <CAM-tV-9CNO_hqnweFpLaRHx4xEA32CPRdq56y6vYMWqURV9kgg@mail.gmail.com>
 <20151109155342.GB27224@sigill.intra.peff.net>
 <CAM-tV--hBSdCJckCnMtKgkQB2f_3eN8sXHdFWwg2hzb6s7ufxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Noam Postavsky <npostavs@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 10 13:25:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw7z6-0005Vz-6X
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 13:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbbKJMZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 07:25:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:55495 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752650AbbKJMZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 07:25:05 -0500
Received: (qmail 24774 invoked by uid 102); 10 Nov 2015 12:25:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Nov 2015 06:25:05 -0600
Received: (qmail 26298 invoked by uid 107); 10 Nov 2015 12:25:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Nov 2015 07:25:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Nov 2015 07:25:02 -0500
Content-Disposition: inline
In-Reply-To: <CAM-tV--hBSdCJckCnMtKgkQB2f_3eN8sXHdFWwg2hzb6s7ufxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281117>

On Mon, Nov 09, 2015 at 08:05:25PM -0500, Noam Postavsky wrote:

> > Automated tests would be nice, but I suspect it may be too complicated
> > to be worth it.
> 
> I attempted
> 
> test_ignore_sighup ()
> {
>     mkdir "$HOME/.git-credential-cache" &&
>     chmod 0700 "$HOME/.git-credential-cache" &&
>     git -c credentialCache.ignoreSIGHUP=true credential-cache--daemon
> "$HOME/.git-credential-cache/socket" &
>     kill -SIGHUP $! &&
>     ps $!
> }
> 
> test_expect_success 'credentialCache.ignoreSIGHUP works' 'test_ignore_sighup'
> 
> but it does't pass (testing manually by running
> ./git-credential-cache--daemon $HOME/.git-credential-cache/test-socket
> & and then kill -HUP does work).

Your test looks racy. After the "&" in spawning the daemon, we don't
have any guarantee that the daemon actually reached the signal() call
before we issued our kill.

The daemon issues an "ok\n" to stdout to report that it's ready to serve
(this is how the auto-spawn avoids races). So you could use that with a
fifo to fix this. It's a little complicated; see lib-git-daemon.sh for
an example.

I'm also not sure the use of "ps" here is portable (i.e., does it always
report a useful error code on all systems?).

So I dunno. Given the complexity of the test, and that it is such a
simple feature that is unlikely to be broken, I'm not sure it is worth
it. A test failure seems like it would more likely be a problem in the
test, not the code.

> From 5fc95b6e2f956403da6845fc3ced83b21bee7bb0 Mon Sep 17 00:00:00 2001
> From: Noam Postavsky <npostavs@users.sourceforge.net>
> Date: Mon, 9 Nov 2015 19:26:29 -0500
> Subject: [PATCH] credential-cache: new option to ignore sighup
> 
> Introduce new option "credentialCache.ignoreSIGHUP" which stops
> git-credential-cache--daemon from quitting on SIGHUP.  This is useful
> when "git push" is started from Emacs, because all child
> processes (including the daemon) will receive a SIGHUP when "git push"
> exits.
> ---

Can you add a signed-off-by here (see the "sign-off" section in
Documentation/SubmittingPatches).

> diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
> index eef6fce..6cda9c0 100644
> --- a/credential-cache--daemon.c
> +++ b/credential-cache--daemon.c
> @@ -256,6 +256,9 @@ int main(int argc, const char **argv)
>  		OPT_END()
>  	};
>  
> +	int ignore_sighup = 0;
> +	git_config_get_bool("credentialcache.ignoresighup", &ignore_sighup);
> +

Style-wise, I think the declaration should go above the options-list.

> @@ -264,6 +267,10 @@ int main(int argc, const char **argv)
>  
>  	check_socket_directory(socket_path);
>  	register_tempfile(&socket_file, socket_path);
> +
> +	if (ignore_sighup)
> +		signal(SIGHUP, SIG_IGN);
> +

This part looks obviously correct. :)

I don't think there's any need to use sigchain_push here (we have no
intention of ever popping it).

-Peff
