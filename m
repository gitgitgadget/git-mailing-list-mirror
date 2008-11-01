From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git/Mercurial interoperability (and what about bzr?)
Date: Sat, 1 Nov 2008 09:39:31 -0400
Message-ID: <20081101133931.GC8134@mit.edu>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org> <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se> <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl> <20081028191234.GS24201@genesis.frugalware.org> <20081028213144.GC10862@mit.edu> <87ljw3zx8i.fsf@mid.deneb.enyo.de> <m3prlffzk2.fsf@localhost.localdomain> <87abcjpvy2.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sat Nov 01 14:41:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwGjZ-0005Hi-D1
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 14:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbYKANji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 09:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYKANji
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 09:39:38 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:39028 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751410AbYKANjh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 09:39:37 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KwGhQ-0001QE-PV; Sat, 01 Nov 2008 09:39:32 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KwGhP-0001v6-U3; Sat, 01 Nov 2008 09:39:31 -0400
Content-Disposition: inline
In-Reply-To: <87abcjpvy2.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99742>

On Sat, Nov 01, 2008 at 11:44:21AM +0100, Florian Weimer wrote:
> > Now Mercurial has chosen to use in-tree '.hgtags' file to have global
> > tags transferable.  Never mind the fact that it had to treat this file
> > in special way to have it non-versioned
> 
> Oops, thought this file was versioned.  Things like
> 
>   <http://tycoon.hpl.hp.com/changeset/932:931d181e9f58/.hgtags>

.hgtags is stored as a versioned file in Mercurial.  That's one of the
problems, and it leads to no shortage of headaches.

Some of the problems are discussed here:

   http://www.selenic.com/mercurial/wiki/index.cgi/Tag

Specifically, to quote the Mercurial Wiki:

    The fact that tags identify changesets and are also parts of
    changesets has some potentially confusing implications:

    * The changeset that a tag refers to is always older than the
      changeset that commits the tag itself.

    * Updating a working dir to a particular tag will take that
      directory back to a point before the tag itself existed.

    * Cloning a repo to a particular tag will give you a new repo that
      does not have that tag.

In addition, Mercurial has to play interesting special case games in a
repository which has multiple heads (in git terms, "branches").  When
looking up a tag, it has to take the union of all of the .hgtags files
at the tips of each of the branches.  So if you have a large number of
heads in your Mercurial repository, tags access doesn't scale well at
all.  Mercurial is very much optimized for having a single or at best
a few heads/branches in a repository.

As I mentioned earlier this makes it much more difficult to do a
bidrectional hg/git gateway, since the two DAG's are not toplogically
equivalent, and in fact, *when* you add a tag to a particular
commit/revision can make a distinct difference to the shape of the
DAG.  If you tag right after creating the revision in question, then
there is a tag commit right after the revision.  If you commit a few
dozen changes into the repository, and *then* tag a point many commits
earlier, then the tag commit will be tacked onto the head of whatever
branch you happened to be on.

In fact, in the worst case, if you accidentally tag a revision on the
"maint" branch while you happened to be on the "devel" branch, the tag
for the commit in the "maint" branch will be attached to the "devel"
branch, and while it will work just fine for *you*, someone who only
fetches the "maint" branch might never see the tag that you placed on
the maint branch --- unless they happen to also pull the devel branch.

What fun, eh?

					- Ted
