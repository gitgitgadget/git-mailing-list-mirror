From: Jeff King <peff@peff.net>
Subject: Re: git-svn won't remember pem password
Date: Sun, 19 Feb 2012 19:57:28 -0500
Message-ID: <20120220005727.GA4140@sigill.intra.peff.net>
References: <E56535F6-2C9B-4D14-A88F-2471E34D2769@gmail.com>
 <m3zkcgqt0g.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Igor <mrigor83@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 01:57:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzHZP-0001jM-Ti
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 01:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358Ab2BTA5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 19:57:31 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43224
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab2BTA5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 19:57:30 -0500
Received: (qmail 28794 invoked by uid 107); 20 Feb 2012 00:57:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 19 Feb 2012 19:57:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Feb 2012 19:57:28 -0500
Content-Disposition: inline
In-Reply-To: <m3zkcgqt0g.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191034>

On Sat, Feb 18, 2012 at 03:30:00AM -0800, Jakub Narebski wrote:

> Igor <mrigor83@gmail.com> writes:
> 
> > I'm running into an issue where I have to enter my pem certificate
> > password every time I git-svn fetch or git-svn dcommit. Vanilla svn
> > uses OS X KeyChain and remembers my password just fine. Is there a
> > known solution for this? Other users have ran into same issue as
> > described here:
> >
> >   http://stackoverflow.com/questions/605519/does-git-svn-store-svn-passwords
> 
> > However, that solution of removing .subversion folder did not work
> > for me.
> 
> I don't know if it is svn that has to remember password, or git that
> has to remember password.  Git 1.7.9 learned "credentials API" that
> allows integration with platform native keychain mechanisms, and I
> think OS X Keychain is one of examples / supported platforms (but it
> might not made it into core git)... though I am not sure if it affects
> git-svn, or only HTTP(S) transport.

It does not affect git-svn currently.

I have some thoughts on providing access to the credentials API for
scripts like git-svn (right now, it is accessible only by C git
programs). However, there is an important question: should password
prompting in git-svn behave like git, or behave like svn?

So far, it has been the latter, and I think that is reasonable. The
resource that requires the credentials is an svn repo, not a git repo,
so you are more likely to want to share credentials for it with real
svn, and not other git commands.

As to the lack of keychain support, it looks like libsvn should be
handling this for us. We simply give it a callback function that gets
called if the user needs prompted, but I would think things like the
keychain handling would happen before it gets to our prompt (and if I
understand it, for _some_ credential storage formats, it does). So
either there is a bug in libsvn, or we are somehow invoking it
incorrectly.

-Peff
