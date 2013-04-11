From: Mike Galbraith <bitbucket@online.de>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 09:59:19 +0200
Message-ID: <1365667159.19620.116.camel@marge.simpson.net>
References: <1365572015.4658.51.camel@marge.simpson.net>
	 <20130410135605.GB4694@odin.tremily.us>
	 <1365651583.19620.8.camel@marge.simpson.net>
	 <20130411054207.GE27795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "W. Trevor King" <wking@tremily.us>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 09:59:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQCPz-0004tF-EW
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 09:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab3DKH7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 03:59:35 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:63445 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab3DKH7e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 03:59:34 -0400
Received: from [192.168.178.27] (p4FE190B6.dip0.t-ipconnect.de [79.225.144.182])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LbQ1i-1UsLR428ZW-00kqrz; Thu, 11 Apr 2013 09:59:21 +0200
In-Reply-To: <20130411054207.GE27795@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.3 
X-Provags-ID: V02:K0:AxI/spoCVQfrPKLCKcET3/qRM9/AdMl80nD3iupp1Qu
 eZb0sKwSyWgv/9uWfkn/cb2HK00rYhUFFT19bvugNj9T2iUXXK
 pXsgNHQHfgsAmbh96rumE/pVnl4oTPy8BXZv0qtE5RPwYnxsgu
 xg/uL7910z2b2GDPLiV+l3PLoM0JgZcU+1foxsiqZPopzE6WAg
 g/bPiGiSzTVryYuhCyA3J4DZ4rvsMFcU0Vos8p3M/XOVhjQUaY
 ohdp5sEFgrwvpwXSE8fKcZ4Da2YOBFdR5n5RqrR8ykZ7mWrh4U
 RqLgJ4//ZYyrB7Ku4YmVK1mGR/m7f5osMWnQOOfQYRHmSTqJsz
 frak3eEiLX3XIG5lYpyVuUyiag1Xj00nZq9285GBNhtp9urOAj
 pV8bQe4Jg3mIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220833>

On Thu, 2013-04-11 at 01:42 -0400, Jeff King wrote: 
> On Thu, Apr 11, 2013 at 05:39:43AM +0200, Mike Galbraith wrote:
> 
> > >   ALLOWED_ENV="PATH HOME"
> > >   HOME=/
> > 
> > I can work around it by changing the init script to use su - git -c "bla
> > bla" to launch the thing, instead of using --user=git --group=daemon,
> > but that's just a bandaid for the busted environment setup those
> > switches were supposed to make happen, no?
> 
> Yeah, I think the bug here is that git-daemon should be setting $HOME
> when it switches privileges with --user. Does this patch fix it for you?
> 
> diff --git a/daemon.c b/daemon.c
> index 6aeddcb..a4451fd 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1091,6 +1091,7 @@ static void drop_privileges(struct credentials *cred)
>  	if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||
>  	    setgid (cred->gid) || setuid(cred->pass->pw_uid)))
>  		die("cannot drop privileges");
> +	setenv("HOME", cred->pass->pw_dir, 1);
>  }
>  
>  static struct credentials *prepare_credentials(const char *user_name,
> 
> I guess that would technically break anybody who was trying to do
> something clever with HOME (i.e., point it somewhere besides --user's
> HOME where they had put some config files). But the obvious clever
> thing would be to also set the user's passwd homedir to the same place.

I did exactly that yesterday, and it didn't work, which rather surprised
me.  Let me double check that I didn't screw trivial all up...

Heh, if ya don't plunk new binary into the old oddly placed bucket :)
Yeah, that works just fine.

-Mike 
