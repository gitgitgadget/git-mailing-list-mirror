From: Jeff King <peff@peff.net>
Subject: Re: Bug? git submodule add SSL certificate problem: unable to get
 local issuer certificate
Date: Mon, 9 Mar 2015 03:43:39 -0400
Message-ID: <20150309074339.GA31866@peff.net>
References: <F24DBF8D-40EE-4C8D-AE9C-463E59C4AAD7@aschemann.net>
 <27F61CEE-F1D3-4B7F-B394-8D06A4AD8976@aschemann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Aschemann Gerd <gerd@aschemann.net>
X-From: git-owner@vger.kernel.org Mon Mar 09 08:43:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUsLw-00026q-V2
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 08:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbbCIHnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 03:43:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:59045 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753129AbbCIHnn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 03:43:43 -0400
Received: (qmail 9050 invoked by uid 102); 9 Mar 2015 07:43:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 02:43:42 -0500
Received: (qmail 4603 invoked by uid 107); 9 Mar 2015 07:43:49 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 03:43:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Mar 2015 03:43:39 -0400
Content-Disposition: inline
In-Reply-To: <27F61CEE-F1D3-4B7F-B394-8D06A4AD8976@aschemann.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265133>

On Thu, Mar 05, 2015 at 04:20:10PM +0100, Aschemann Gerd wrote:

> seems to be a bug: If adding a submodule from an https URL with a certificate issued by StartSSL (or even a private/self-signed one?) leads to the following error:
> 
>   $ git -c http.sslverify=false submodule add https://example.com/git/xxx.git
>   Cloning into 'xxx'...
>   fatal: unable to access 'https://example.com/git/xxx.git/': server certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none
>   Clone of 'https://example.com/git/xxx.git' into submodule path 'xxx' failed
> 
> Performing a simple clone works well:
> 
>   $ git -c http.sslverify=false clone https://example.com/git/xxx.git
>   Cloning into 'xxx'...
>   Password for 'https://example.com':

I think the problem is that the submodule code wipes all "local"
environment variables before executing the submodule clone, and that
includes the variable containing command-line config.

Config like this is in a funny boat. We do not want it to cross
transport boundaries, so that if we run:

  git -c foo=bar clone /some/local/path

the process serving /some/local/path should not see the "foo" option[1].
But for submodules in the same repository, keeping the shared config is
probably more reasonable (I can imagine a config variable that you might
want to behave differently between the submodule and the main project,
but I could not think of any off-hand, and I expect it would be a rare
exception).

Submodule folks (cc'd) may have opinions.

-Peff

[1] This behavior comes from 655e8d9 (do not pass "git -c foo=bar"
    params to transport helpers, 2010-08-24), and the original
    discussion is here:

      http://thread.gmane.org/gmane.comp.version-control.git/154241/focus=154255

    I am tempted to simply drop the transport-layer blocking of config
    options. It is not buying us anything security-wise, and it could
    actually be convenient to pass options to the "other side". But it's
    probably a bad idea, if only because it would not be consistently
    applied to repos on the other side of git://, http://, or ssh
    sessions.

    So the sanest fix, if we want submodules to inherit the command-line
    config, would be to drop GIT_CONFIG_PARAMETERS from local_repo_env,
    and have the transport code suppress it manually.
