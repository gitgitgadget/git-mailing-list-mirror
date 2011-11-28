From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] echo usernames as they are typed
Date: Mon, 28 Nov 2011 06:31:27 -0500
Message-ID: <20111128113127.GA23408@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111127082744.GA32068@sigill.intra.peff.net>
 <CABPQNSb09kxjvdvz2P-WqU2VtMspaaA8ujTNLJ4+MuCrV=2zsw@mail.gmail.com>
 <20111128035321.GA15640@sigill.intra.peff.net>
 <CABPQNSbLvWh-ivaqBk-Du+kwZvV3t+ajEJhHATRzyGZbHYyM=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 12:31:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUzQt-0002YG-Ts
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 12:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab1K1Lbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 06:31:31 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54046
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852Ab1K1Lba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 06:31:30 -0500
Received: (qmail 24575 invoked by uid 107); 28 Nov 2011 11:38:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Nov 2011 06:38:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Nov 2011 06:31:27 -0500
Content-Disposition: inline
In-Reply-To: <CABPQNSbLvWh-ivaqBk-Du+kwZvV3t+ajEJhHATRzyGZbHYyM=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186012>

On Mon, Nov 28, 2011 at 10:36:21AM +0100, Erik Faye-Lund wrote:

> > You really want to open "/dev/tty" on most Unix systems (which is what
> > getpass() does).
> 
> Yes, you're right. Opening "/dev/tty" is much better. But what happens
> for processes started by GUI applications (with no easily observable
> tty, if any)? Does open simply fail? If so, is it desirable for us to
> fail in that case?

Yes, the open will fail (on Linux, I get ENXIO).

And yes, we should fail in that case. getpass() will generally return
NULL in that instance, and the current implementation of git_getpass()
will die(), explaining that we could not get the password.

> > I have no idea what would be appropriate on Windows.
> 
> It's pretty similar, but not exactly: CreateFile("CONIN$", ...) or
> CreateFile("CONOUT$", ...), depending on if you want the read-handle
> or the write-handle... I can probably cook up something a bit more
> concrete, though.

OK, that maps to the /dev/tty concept quite well. Though I suspect the
code for turning off character echo-ing is going to also be different.

> But _getch() that we already use always reads from the console
> (according to MSDN, I haven't actually tested this myself:
> http://msdn.microsoft.com/en-us/library/078sfkak%28v=VS.80%29.aspx).
> But I don't think this allows us to fail when no console is attached.
> Question is, should we fail in such cases? Windows does have an API to
> prompt for passwords in a GUI window... Perhaps fallbacking to those
> are the way to go? Something like:
> 
> if (GetConsoleWindow()) {
> 	/*  normal console-stuff */
> } else {
> 	/* call CredUIPromptForWindowsCredentials(...) instead */
> }

Certainly on non-Windows something like that would not be welcome. The
user can already have specified GIT_ASKPASS if they don't have a
terminal. And once the credential-helper code is in, they can use a
platform-specific helper that provides a nice dialog if they want it.

So I would say trying to do something graphical would be surprising and
unwelcome. But then, I am a very Unix-y kind of guy. Maybe on Windows
something like that would be more favorable. I'll leave that decision to
people who know more.

-Peff
