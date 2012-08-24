From: Jeff King <peff@peff.net>
Subject: Re: git no longer prompting for password
Date: Fri, 24 Aug 2012 17:25:01 -0400
Message-ID: <20120824212501.GA16285@sigill.intra.peff.net>
References: <5037E1D0.6030900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 23:25:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T51NS-000627-9C
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 23:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876Ab2HXVZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 17:25:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47675 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997Ab2HXVZG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 17:25:06 -0400
Received: (qmail 4901 invoked by uid 107); 24 Aug 2012 21:25:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Aug 2012 17:25:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2012 17:25:01 -0400
Content-Disposition: inline
In-Reply-To: <5037E1D0.6030900@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204233>

On Fri, Aug 24, 2012 at 09:19:28PM +0100, Iain Paton wrote:

> A recent update to git 1.7.12 from 1.7.3.5 seems to have changed
> something - trying to push to a smart http backend no longer prompts
> for a password and hence fails the server auth.
> [...]
> Backtracking through the versions I've skipped and this doesn't seem
> to be a new problem, client side up to 1.7.7.7 works, 1.7.8 onwards
> don't. Server side version doesn't seem to make a difference.

There was some work in v1.7.8 to avoid prompting for a password when it
is not necessary; I suspect this is a fallout of that.

You could try bisecting the bug. My guess is that you will end up at
commit 986bbc0 (http: don't always prompt for password, 2011-11-04).

> user@fubar01:~/test# git --version
> git version 1.7.7.7
> user@fubar01:~/test# git push http://ipaton@10.0.0.1/git/test.git master
> Password: 

As per the discussion in 986bbc0, this is actually prompting you before
git makes any request. Whereas here:

> user@fubar01:~/test# git --version
> git version 1.7.8
> user@fubar01:~/test# git push http://ipaton@10.0.0.1/git/test.git master --verbose

We should get an HTTP 401 from the server, then prompt, then retry.
What's weird is that it sort of works:

> Pushing to http://ipaton@10.0.0.1/git/test.git
> Counting objects: 6, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (5/5), 491 bytes, done.
> Total 5 (delta 0), reused 0 (delta 0)
> error: RPC failed; result=22, HTTP code = 401
> fatal: The remote end hung up unexpectedly
> fatal: The remote end hung up unexpectedly

It's like the initial http requests do not get a 401, and the push
proceeds, and then some later request causes a 401 when we do not expect
it. Which is doubly odd, since we should also be able to handle that
case (the first 401 we get should cause us to ask for a password).

Can you show us the result of running with GIT_CURL_VERBOSE=1? I'd
really like to see which requests are being made with and without
authentication.

> Looking at changelogs for 1.7.8 and I'm not really seeing anything
> that says I need to do something different.

No, you shouldn't need to do anything different. I'd suspect the
weirdness you are seeing is from a credential helper trying to supply a
blank password, except that you would have to have configured one
manually for it to run (I assume you are not on a shared machine where
somebody might have tweaked /etc/gitconfig or anything like that).

-Peff
