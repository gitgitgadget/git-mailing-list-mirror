From: Jeff King <peff@peff.net>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Tue, 9 Apr 2013 13:12:47 -0400
Message-ID: <20130409171247.GD21972@sigill.intra.peff.net>
References: <20130409054553.GA1537@mteis.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Magnus Therning <magnus@therning.org>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:13:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPc6N-0000Bx-TB
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935480Ab3DIRMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:12:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36435 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935428Ab3DIRMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:12:52 -0400
Received: (qmail 23966 invoked by uid 107); 9 Apr 2013 17:14:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Apr 2013 13:14:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2013 13:12:47 -0400
Content-Disposition: inline
In-Reply-To: <20130409054553.GA1537@mteis.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220589>

On Tue, Apr 09, 2013 at 07:45:53AM +0200, Magnus Therning wrote:

> I've been trying to set up git-http-backend+lighttpd.  I've managed to
> set up anonymous read-only access, and I then successfully configured
> authentication for both read and write.  Then I get stuck.  The
> man-page for git-http-backend says that the following snippet can be
> used for Apache 2.x:
> 
>     <LocationMatch "^/git/.*/git-receive-pack$">
>         AuthType Basic
>         AuthName "Git Access"
>         Require group committers
>         ...
>     </LocationMatch>
> 
> However, when I put in this match on location in my lighty config and
> try to push I'm not asked for a password, instead I'm greeted with
> 
>     % git push 
>     error: The requested URL returned error: 403 Forbidden while accessing http://magnus@tracsrv.local/git/foo.git/info/refs?service=git-receive-pack

Something in your config is blocking access to info/refs there. It
should not be the block shown above, which handles only the actual POST
of the data. The sequence of http requests made is:

  1. GET $repo/info/refs?service=git-receive-pack

     This makes initial contact and gets the ref information which push
     uses to decide what it is going to push. So it is read-only, and in
     an anonymous-read setup, does not need to be protected.

  2. POST $repo/git-receive-pack

     This actually pushes up the objects and updates the refs, and
     must be protected.

The setup listed above does work with apache; it is tested as part of
our test suite (you can see the actual config in t/lib-httpd/apache.conf).
So what in lighttpd is giving us the 403? Can you share your whole
config?

> AFAICS this means the man-page is wrong, and that I instead ought to
> match on the "service=git-receive-pack" part.  Is that a correct
> conclusion?

No. It is not a bad idea to _also_ match on info/refs, but I think it's
a little trickier (you need to reliably match the query string to
differentiate it from a fetch, which IIRC is a little hard in apache, at
least).

But if you drop the protections on "/git-receive-pack$", then an
attacker can just POST whatever they want into your repository.

-Peff
