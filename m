From: Jeff King <peff@peff.net>
Subject: Re: file mode
Date: Mon, 13 Jun 2011 01:38:14 -0400
Message-ID: <20110613053814.GA2680@sigill.intra.peff.net>
References: <alpine.DEB.1.10.1106122055210.6124@localhost>
 <BANLkTimh=-caLH5dVaUeXXmcF21+=-o0tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Kleiweg <pkleiweg@xs4all.nl>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 07:38:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVzr3-0007mw-6z
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 07:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab1FMFiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 01:38:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53365
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab1FMFiV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 01:38:21 -0400
Received: (qmail 10926 invoked by uid 107); 13 Jun 2011 05:38:29 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Jun 2011 01:38:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2011 01:38:14 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimh=-caLH5dVaUeXXmcF21+=-o0tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175685>

On Sun, Jun 12, 2011 at 07:12:42PM +0000, Michael Witten wrote:

> On Sun, Jun 12, 2011 at 18:57, Peter Kleiweg <pkleiweg@xs4all.nl> wrote:
> > I added a file that has file mode 600. When I do a check-out,
> > the file comes with mode 644. Is this supposed to happen? Then
> > how do I control what permissions files have?
> 
> Do some googling.

I really don't see the point of a response like this. It is one thing to
rudely point somebody to lmgtfy or an FAQ link. Then you're still being
rude, but at least you are pointing them in the right direction. But
this seems simply to make the list a less pleasant place _and_ to be
totally useless to the original poster. If you didn't want to give the
answer, wouldn't it have been better not to respond at all?

Peter:

This is by design. While the git data structure can technically store
unix mode bits in its trees, it was found early on in git's history that
respecting anything beyond a simple executable bit ended up being more
cumbersome for git's normal use cases (i.e., people storing code or
other shared files in a repository).

We could add in a config option to respect file modes, but it has
generally been seen as not worthwhile. It solves only a part of the
general metadata problem, as it omits owner and group names or ids, as
well as extended metadata like ACLs.

If modes are important to you, the suggested fixes are one of:

  1. Use a tool like "metastore" that can be called from git hooks, and
     will save and restore file permissions in a file that is tracked in
     the repository. Do note that when using such a tool there is a race
     condition in protecting files (i.e., git will create your file as
     644, and then metastore will correct it to 600; in the meantime,
     somebody could read your file).

  2. Depending on exactly what you're storing, it may make sense to keep
     your repository in another directory, protected by permissions, and
     then use a separate tool to deploy your files from the repository
     to their ultimate location (e.g., a Makefile or other install
     tool).

-Peff

PS I actually _did_ try googling for this, and didn't come up with an
answer that was as complete or clear (to me, anyway) as what I wrote
above.
