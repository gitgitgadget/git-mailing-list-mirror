From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Sun, 22 Jul 2007 23:56:44 -0400
Message-ID: <20070723035644.GC32566@spearce.org>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site> <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222223460.14781@racer.site> <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222255010.14781@racer.site> <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707230000020.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:57:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICp2c-0007u8-Nw
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 05:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbXGWD4v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 23:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754612AbXGWD4v
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 23:56:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41085 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbXGWD4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 23:56:50 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICp2A-00074t-Kt; Sun, 22 Jul 2007 23:56:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6861220FBAE; Sun, 22 Jul 2007 23:56:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707230000020.14781@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53384>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 22 Jul 2007, Julian Phillips wrote:
> 
> > On Sun, 22 Jul 2007, Johannes Schindelin wrote:
> > 
> > > Well, I am really not interested in shooting myself in the foot, and 
> > > having that option in checkout would make that much more likely.  So I 
> > > really, really want to have this in git-branch.
> > 
> > Fair enough.  Your patch - so you get to choose.  I don't have any 
> > strong objections (and no power to express any if I did :P) - just 
> > airing my POV ;)
> 
> In related news, you got me convinced that my "solution" is not 
> sufficient.  So I guess this patch has to wait until after 1.5.3 _and_ 
> after we convinced Junio to put his BASE index extension in again.

The last time we had that thing in Git it really screwed with git-gui.
I'm not looking forward to it coming back.


But anyway, I think there's something else that needs to be fixed
before this symlink workdir thing is fully in core git.  Right now we
delete the .git/config and .git/packed-refs files when we edit them.
This means it is *very* unsafe to run `git-config` or `git-tag -d`
in a symlinked workdir, as the workdir will get its own config or
packed-refs file and the real repository directory won't be affected.

Now .git/config switching from symlink to real file is maybe almost
a feature.

But .git/packed-refs switching from symlink to real file is *not*
a feature.  Its a massive bug.

I live by new-workdir.  I do everything with it.  And today I just
spent over an hour sorting out cases where my many, many workdirs
have different refs than their base repositories, because their
packed-refs files are different.  Grrrrrrrrrrrrrrrrrr.


So we really need to make anyone that edits packed-refs (and
maybe also config) resolve the symlink and do the edit in the
target directory.  Then we can consider adding this workdir thing
to core git.

Yes, I know, stop whining and submit a patch.  I'll get around to
it soon if nobody else beats me.  I just want to voice yet another
reason why this shouldn't be in 1.5.3.

-- 
Shawn.
