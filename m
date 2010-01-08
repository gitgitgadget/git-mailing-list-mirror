From: Jeff King <peff@peff.net>
Subject: Re: Possible bug in git-completion.sh
Date: Fri, 8 Jan 2010 11:24:04 -0500
Message-ID: <20100108162404.GA5799@coredump.intra.peff.net>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:24:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTHdM-0003sS-8v
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 17:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab0AHQYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 11:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615Ab0AHQYP
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 11:24:15 -0500
Received: from peff.net ([208.65.91.99]:53666 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467Ab0AHQYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 11:24:15 -0500
Received: (qmail 17437 invoked by uid 107); 8 Jan 2010 16:29:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 08 Jan 2010 11:29:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jan 2010 11:24:04 -0500
Content-Disposition: inline
In-Reply-To: <4B4751EA.8060707@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136453>

On Fri, Jan 08, 2010 at 04:40:26PM +0100, Michael J Gruber wrote:

> Jon Schewe venit, vidit, dixit 08.01.2010 16:17:
> > If I create a directory "build" at the top of my git repository and then
> > add it to .gitignore, git behaves as expected and ignores the build
> > directory when checking status. Now git-completion.sh has some issues. I
> > have GIT_PS1_SHOWUNTRACKEDFILES to "1", so that I will be notified when
> > there are untracked files in my working directory. When I'm in the
> > top-level directory my prompt looks like expected, no '%'. However if I
> > change to the build directory I get a '%', even though git status shows
> > no untracked files. I see that git-completion.sh is using git ls-files
> > to check this and that function does indeed show output when in my build
> > directory. So the question here: Is git-completion.sh using ls-files
> > improperly or is ls-files behaving improperly?
> > 
> 
> Neither, but: output between status and ls-files is inconsistent. More
> specifically, different commands behave differently with respect to the
> treatment of subdirs. ls-files assumes "." implicitly, status does not.
> "git status ." should give you the same behavior is "git ls-files" in
> this regard.

It doesn't, and I think there is a bug in ls-files.

Try this:

  git init
  touch base-cruft
  mkdir subdir
  touch subdir/cruft
  echo subdir >.gitignore
  git status ;# shows gitignore and base-cruft
  git ls-files -o --exclude-standard ;# ditto
  cd subdir
  git status . ;# shows nothing, since everything in subdir is ignored
  git ls-files -o --exclude-standard ;# BUG: shows cruft

Yes, ls-files operates in the subdirectory, which means it should not
show cruft from the root (and it does not). But it should respect
.gitignore directives going all the way back to the root, and it
doesn't.

-Peff
