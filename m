From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Fri, 20 Jul 2007 22:17:17 -0400
Message-ID: <20070721021717.GS32566@spearce.org>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <20070720050455.GN32566@spearce.org> <20070720105602.7dcm241ts0k0ww88@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 04:17:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC4XN-0001cV-Fy
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 04:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757629AbXGUCR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 22:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756816AbXGUCR1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 22:17:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58519 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756534AbXGUCR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 22:17:26 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IC4Ws-00086U-7H; Fri, 20 Jul 2007 22:17:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B68BB20FBAE; Fri, 20 Jul 2007 22:17:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070720105602.7dcm241ts0k0ww88@webmail.tu-harburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53131>

Christian Stimming <stimming@tuhh.de> wrote:
> I used (and prefer) "_" because that's the standard function name for  
> i18n'd strings when using gettext (talking about a "standard" way).

I thought about this today.  I almost want to use _, e.g:

  proc _ {args} {
    return [eval mc $args]
  }

For the translation, but I don't think its worth the CPU cycles in
Tcl to eval mc via _ every time we need a string when it only is
saving us one keystroke on a function name, *and* we are breaking
tradition with Tcl.

So when in Rome, wear a toga.  Or in this case, use [mc ...].

> Being a newcomer on this list, could you please explain to me how to  
> proceed with the i18n patches so far?

Sure.

> Do you want to have patches  
> submitted after some further changes (which ones?)

Yes.  Here's a few to get started with and that are really obvious.
Some I'm just asking for more information on.

 - Import msgcat::mc and use [mc] instead of [_].

 - Please combine the second and third patches into a single change.
 There is no reason to switch to [mc {}] only to switch to [mc ""].

 - Please use mc's formatting support, rather than [format].
 Its shorter code.

 - Don't bother trying to translate the strings "Tools" (for the
 Tools menu) or "Migrate" (for its only menu option).  This block
 of code doesn't even belong in git-gui.  Its for my day-job and
 is a custom hack that I need to strip out and carry as a local
 patch there, rather than in the public distribution.

 - In our Makefile we do the looping in GNU make using its
 $(foreach) operator, rather than using the shell's for builtin.
 In other words, can we have the catalog target look more like the
 install target?

 - Can ALL_LINGUAS be automatically built from the directory
 contents of the po/ directory?

 - Can we define a dist rule for the maintainer to build the catalog
 files, so the maintainer can convert the .po -> .msg for Tcl and
 the user doesn't need the GNU tools installed to build git-gui?


> and/or in different  
> formats?

Please send one patch per email message, inline and not attached.
This way they are easy to review, respond to and comment on.

> Do you prefer to have all changes in a smaller number of  
> commit rather than split the way I did before?

No, this series looks reasonably fine to me structurally.

Did you base the patches on git.git's git-gui/ subdirectory, or
did you base them on the git-gui.git repository?  Technically all
patches for git-gui should be against the git-gui repository on
repo.or.cz, as git-gui is its own project.  Periodic stable snapshots
are imported into git.git under the git-gui/ subdirectory, for the
ease of distribution with core git.

Dscho recently created a fork of git-gui.git here:

  http://repo.or.cz/w/git-gui/git-gui-i18n.git

and added your patch series into it.  But I'd like to see some
cleanups before it merges in, and I want to hold off on actually
applying it into git-gui 0.8.0 is released, which should be Real
Soon Now as I'm trying to make it into git 1.5.3, which is coming
Even Sooner Than I'd Hoped.  ;-)

> Should I wait for some  
> more days/weeks/whatever until you or particular other developers have  
> reviewed the patches? Thanks.

I think we're settled on using [mc].  I'm fine with the *.po ->
*.msg thing, especially if the maintainer can produce them and
package the *.msg files in the release tarball, so that the enduser
doesn't need to worry about msgfmt working.

-- 
Shawn.
