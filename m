From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git/Mercurial interoperability (and what about bzr?) (was: Re:
	[VOTE] git versus mercurial)
Date: Tue, 28 Oct 2008 17:31:44 -0400
Message-ID: <20081028213144.GC10862@mit.edu>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org> <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se> <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl> <20081028191234.GS24201@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 22:33:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuwBZ-00049E-Ut
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 22:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbYJ1Vb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 17:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYJ1Vb4
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 17:31:56 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:42474 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751688AbYJ1Vb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 17:31:56 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KuwAD-0006VH-2x; Tue, 28 Oct 2008 17:31:45 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KuwAC-00029V-Cu; Tue, 28 Oct 2008 17:31:44 -0400
Content-Disposition: inline
In-Reply-To: <20081028191234.GS24201@genesis.frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99326>

On Tue, Oct 28, 2008 at 08:12:34PM +0100, Miklos Vajna wrote:
> On Tue, Oct 28, 2008 at 04:33:54PM +0100, Pieter de Bie <pdebie@ai.rug.nl> wrote:
> > fast-import yet. If I understand dscho correctly, that exists now, so it 
> > should be easy enough to integrate that as well.
> 
> That's new to me. Theodore Ts'o once mentioned on this list that there
> is a "hg fast-export" but actually he just referred to "there is a
> git2hg conversion tool in hg's contrib dir" and it has nothing with
> fast-import.

The code I was referring to was called hg-fast-export, which is part
of the "fast export" tools that front-end into git fast-import.  The
git repository can be found here:

	http://repo.or.cz/w/fast-export.git
	git://repo.or.cz/fast-export.git

I ended up using a very customized version of that script to convert
the hg e2fsprogs repository to git.

In the past I've looked at the possibility of creating a
bi-directional, incremental gateway between hg and git repositories.
The main thing which makes this difficult is that hg stores tags
in-band inside the change-controlled .hgtags file.  This means that if
you cut a release, tag it, and then create a commit to further modify
the repository, the new commit is descended from the tag commit,
whereas in git, the tag is a "bookmark" --- perhaps signed via GPG,
but not part of the revision history.

I think the git method is much more sane, but what it means is that
topologically, the commit tree for git and hg can never be identical.
It also means that if you add a tag to a git tree after making several
commits on that branch, how you reflect that in the hg repository is
highly problematic.  Do you rewrite the branch?  Do you add the tag
later on, disturbing the parent-child relationship of later commits?
How do you keep track of when a tag hg repository topology if you are
trying to maintain a bidirectional mapping between commits?

It's not impossible, but it makes it much more difficult, since in the
hg world, tag commits can be inserted between arbitrary commits.  This
also means that if you want to create a bidrectional gateway between
hg and git, it has to be a single gateway so it can keep track of this
state information.  If you try to have multiple gateways they would
need to synchronize on when a tag entered the hg universe, and with
what commit ID (and what timestamp).

						- Ted
