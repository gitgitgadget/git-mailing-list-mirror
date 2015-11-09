From: Jeff King <peff@peff.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it
 to ignore instead?
Date: Mon, 9 Nov 2015 10:53:43 -0500
Message-ID: <20151109155342.GB27224@sigill.intra.peff.net>
References: <20151026215016.GA17419@sigill.intra.peff.net>
 <xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
 <20151027184702.GB12717@sigill.intra.peff.net>
 <CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
 <20151030001000.GA2123@sigill.intra.peff.net>
 <CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
 <20151030005057.GA23251@sigill.intra.peff.net>
 <CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
 <20151030210849.GA7149@sigill.intra.peff.net>
 <CAM-tV-9CNO_hqnweFpLaRHx4xEA32CPRdq56y6vYMWqURV9kgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Noam Postavsky <npostavs@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Nov 09 16:53:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvolS-00010n-D6
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 16:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbbKIPxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 10:53:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:54952 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751520AbbKIPxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 10:53:45 -0500
Received: (qmail 2706 invoked by uid 102); 9 Nov 2015 15:53:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 09:53:45 -0600
Received: (qmail 16335 invoked by uid 107); 9 Nov 2015 15:54:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 10:54:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Nov 2015 10:53:43 -0500
Content-Disposition: inline
In-Reply-To: <CAM-tV-9CNO_hqnweFpLaRHx4xEA32CPRdq56y6vYMWqURV9kgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281053>

On Sun, Nov 08, 2015 at 09:58:06PM -0500, Noam Postavsky wrote:

> > I am leaning more towards ignoring SIGHUP (configurably) being the only
> > really sane path forward. Do you want to try your hand at a patch?
> 
> Something like this?

Yes, but with a proper commit message, and an update to
Documentation/config.txt. :)

Automated tests would be nice, but I suspect it may be too complicated
to be worth it.

> diff --git i/credential-cache--daemon.c w/credential-cache--daemon.c
> index eef6fce..e3f2612 100644
> --- i/credential-cache--daemon.c
> +++ w/credential-cache--daemon.c
> @@ -256,6 +256,9 @@ int main(int argc, const char **argv)
>          OPT_END()
>      };
> 
> +    int ignore_sighup = 0;
> +    git_config_get_bool("credential.cache.ignoreSighup", &ignore_sighup);

I don't think we should use the credential.X.* namespace here. That is
already reserved for credential setup for URLs matching "X".

Probably "credentialCache.ignoreSIGHUP" would be better. Or maybe
"credential-cache". We usually avoid dashes in our config names, but
in this case it matches the program name.

Also, we usually spell config names as all-lowercase in the code. The
older callback-interface config code needed this (since we just strcmp'd
the keys against a normalized case). I think git_config_get_bool() will
normalize the key we feed it, but I'd rather stay consistent.

> @@ -264,6 +267,12 @@ int main(int argc, const char **argv)
> 
>      check_socket_directory(socket_path);
>      register_tempfile(&socket_file, socket_path);
> +
> +    if (ignore_sighup) {
> +        sigchain_pop(SIGHUP);
> +        signal(SIGHUP, SIG_IGN);
> +    }
> +

I don't think you need to pop the tempfile handler here. You can simply
sigchain_push() the SIG_IGN, and since we won't ever pop and propagate
that, it doesn't matter what is under it.

-Peff
