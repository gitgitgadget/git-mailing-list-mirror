From: Jeff King <peff@peff.net>
Subject: Re: Using socks proxy with git for http(s) transport
Date: Wed, 6 Mar 2013 04:45:53 -0500
Message-ID: <20130306094552.GA11531@sigill.intra.peff.net>
References: <CABmRxH1g2BR+-MvGZ4J-2vC8NDq3x8pG148hXfuYTpUkX0L=0A@mail.gmail.com>
 <20130306082110.GA31638@sigill.intra.peff.net>
 <CABmRxH2CGTxFaGufSMgUqhrSTZPvFBHoEnP8-p5HhkU4kszJPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yves Blusseau <yves.blusseau@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 10:46:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDAvb-0007Hg-VS
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 10:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab3CFJqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 04:46:01 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37941 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812Ab3CFJp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 04:45:59 -0500
Received: (qmail 24459 invoked by uid 107); 6 Mar 2013 09:47:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 04:47:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 04:45:53 -0500
Content-Disposition: inline
In-Reply-To: <CABmRxH2CGTxFaGufSMgUqhrSTZPvFBHoEnP8-p5HhkU4kszJPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217511>

On Wed, Mar 06, 2013 at 10:21:42AM +0100, Yves Blusseau wrote:

> > Try:
> >
> >   git config --global http.proxy 'socks://yourhost:port'
> >
> > That will enable it for all git repositories on your machine. Git should
> > also respect any environment variables that curl handles (because we use
> > libcurl under the hood), if you prefer to set it up that way. See "man
> > curl" for details.
> 
> Thanks Jeff but it's not working.

Hmm. I just double-checked, and it works for me.

> I use git 1.8.15

I assume you mean 1.8.1.5 here.

> My socks proxy listen on my localhost at port 1080 so I do:
> git config --global http.proxy  'socks://127.0.0.1:1080'

That looks right to me.

> But when i try to talk with a git server with http protocol i have:
> [...]
> * About to connect() to proxy 127.0.0.1 port 1080
> *   Trying 127.0.0.1... * connected
> * Connected to 127.0.0.1 (127.0.0.1) port 1080
> > GET http://git.kernel.org/pub/scm/git/git.git/info/refs?service=git-upload-pack HTTP/1.1
> [...]
> * Empty reply from server

If I set up a simple socks proxy with ssh, like:

  ssh -v -D 1080 my-ssh-host

and run the same command, I get:

  * About to connect() to proxy localhost port 1080 (#0)
  *   Trying 127.0.0.1...
  * SOCKS4 request granted.
  * Connected to localhost (127.0.0.1) port 1080 (#0)
  > GET /pub/scm/git/git.git/info/refs?service=git-upload-pack HTTP/1.1
  [...]
  < HTTP/1.1 200 OK

and it works. It does look like curl is treating localhost:1080 as a
regular http proxy. What version of libcurl do you have? Is there
anything in your environment that might be causing it to override the
configured proxy setting (e.g., an http_proxy or https_proxy environment
variable)?

> As you can see git connect to my socks proxy (Connected to 127.0.0.1
> (127.0.0.1) port 1080) but seems to send the http request directly
> instead of a socks command. So it does'nt work :(

Yeah, that definitely looks like the problem.

-Peff
