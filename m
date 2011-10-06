From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remote-curl: Obey passed URL
Date: Thu, 6 Oct 2011 09:25:00 -0400
Message-ID: <20111006132500.GA1792@sigill.intra.peff.net>
References: <4E8D4BD5.2090202@drmicha.warpmail.net>
 <2f1eccfa3fa9e732e9bea344fd69dfd9b16697a9.1317906388.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 15:25:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBnwm-0001Hs-16
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 15:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860Ab1JFNZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 09:25:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54352
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935645Ab1JFNZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 09:25:04 -0400
Received: (qmail 7464 invoked by uid 107); 6 Oct 2011 13:25:03 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Oct 2011 09:25:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2011 09:25:00 -0400
Content-Disposition: inline
In-Reply-To: <2f1eccfa3fa9e732e9bea344fd69dfd9b16697a9.1317906388.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182946>

On Thu, Oct 06, 2011 at 03:15:59PM +0200, Michael J Gruber wrote:

> When the curl remote helper is called, e.g., as
> 
> git-remote-https foo https://john@doe.com
> 
> it looks up remote.foo.url rather than taking the provided url, at least
> as far as http_init() is concerned (authentication). (It does use the
> provided url at later stages.)
> [...]
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -846,6 +846,7 @@ int main(int argc, const char **argv)
>  
>  	if (argc > 2) {
>  		end_url_with_slash(&buf, argv[2]);
> +		remote->url[0] = xstrdup(argv[2]);
>  	} else {
>  		end_url_with_slash(&buf, remote->url[0]);
>  	}

Your analysis is correct, but tweaking the remote object seems kind
of ugly. I think a nicer solution would be to pass the URL in
separately to http_init. Of the three existing callers:

  1. http-fetch.c just passes a NULL remote. Which means we don't even
     look at the URL at all for grabbing the auth information. Passing
     the URL would be an improvement.

  2. http-push.c creates a fake remote just to stick the URL in. That
     ugly code could just go away.

  3. remote-curl.c needs to pass in the alternate URL anyway, as you
     described.

So it seems like all callsites would benefit.

That being said, I wonder if http_init is the right place to pull the
auth information out. It's where we've always done it, and it makes
sense if you are hitting one base URL. But what happens if we get a
redirect to some other site? Shouldn't we be deciding at the time of
making the request what the context of the http request is?

And then http_init can stop caring entirely what the URL is.

-Peff
