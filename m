From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git reset --hard isn't resetting
Date: Sat, 9 Aug 2008 01:08:25 -0700
Message-ID: <20080809080825.GA30694@hand.yhbt.net>
References: <1c5969370808060941q59cb8f7fhabee3ef3c5107715@mail.gmail.com> <32541b130808061102q752076a8ydc02fef4e799491f@mail.gmail.com> <1c5969370808071806g1f989260n55a4b8bebfedb6e@mail.gmail.com> <32541b130808080740q249cb0f6t4395cc2623e67c5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Graham <mdg149@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 10:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRjW1-0004HS-RP
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 10:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbYHIIIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 04:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753688AbYHIIIa
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 04:08:30 -0400
Received: from hand.yhbt.net ([66.150.188.102]:57949 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbYHIII0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 04:08:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 398362DC01B;
	Sat,  9 Aug 2008 01:08:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b130808080740q249cb0f6t4395cc2623e67c5a@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91751>

Avery Pennarun <apenwarr@gmail.com> wrote:
> On Thu, Aug 7, 2008 at 9:06 PM, Matt Graham <mdg149@gmail.com> wrote:
> > On Wed, Aug 6, 2008 at 2:02 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> > Indeed that was the problem.  In fact, l now noticed that my linux
> > machine has both versions as well.  Being case sensitive, it didn't
> > mind and the problem wasn't obvious.
> 
> Did your Linux machine import the data using git-svn, or did it clone
> a repo from Windows that imported using git-svn?
> 
> I can imagine a situation where git-svn on Windows could get confused
> and add the wrong filenames (although it would be kind of unlikely if
> they really were removed in one revision, then readded in another; why
> would git-svn even think about the old names in that case?).  However,
> there's no explanation for a Linux system introducing such a mistake,
> since the two files are just unrelated as far as Linux is concerned.

git-svn *never* touches the working tree on the filesystem directly.
It only does so via git-rebase or git-reset when dcommiting.

That said, I have no idea (nor interest in knowing the gory details) as
to how/if git works on case-insensitive filesystems.  git-svn certainly
has never done any special with them; git-svn itself will always take
path names that SVN provides as-is.

> > This worked fine exactly as you said.  I'm curious what will happen when I do
> >   git svn dcommit
> > These aren't my files and I'm sort of using git svn on the sly.  I'd
> > prefer to not have something weird happen to the svn repository due to
> > this.  Due to the schedule, our tolerance for screwing things up b/c I
> > want to use git will be low.  And my argument that we should have used
> > git from the outset probably won't help any.

Matt: try using --dry-run with dcommit to figure out what it's doing.

Whenever git-svn dcommits to SVN, it reads all of its pathnames from
already-committed history in git, so it's unlikely to be affected
by issues on the local filesystem.  However the rebase/reset after
dcommit could be problematic.  --no-rebase can probably be used with
dcommit here to avoid issues with rebase.

That said, I take no responsibility for any screwups that may happen.
(especially since Windows is involved).

> If your git-svn repo doesn't reflect *exactly* the set of files in
> your real svn repo, then you've hit a pretty bad bug and you're almost
> certainly going to have problems with dcommit.  On the other hand,
> you're unlikely to manage to screw up your svn repo, assuming the
> files you deleted were the ones that weren't supposed to be there;
> "extra deleting" them from svn wouldn't be dangerous.  I'd expect git
> svn dcommit to just fail with a weird error.

git-svn should always die/croak immediately if it notices anything
wrong.  Again, there is no guarantee nor warranty :)

> >> I'm not really sure what git should do better in this case, although
> >> the current behaviour is obviously a bit confusing.
> >
> > Yes, if SVN is going to have both versions, it's understandable that
> > git wouldn't know what to do.  Unfortunately, it looks like SVN only
> > had one version at a time.  So it seems git somehow revived the
> > uppercase version when the lowercase one was readded through git svn.
> 
> Since this seems virtually impossible, it would be nice if you could
> double check your SVN repo to make sure the problem really doesn't
> exist there in *any* version.  It just doesn't seem likely that git
> would have had this problem if the files were cleanly removed in one
> revision, then added in a later one.  I could imagine it if they were
> renamed all in one revision, though, or if there was *ever* an svn
> revision where both files existed at once.  In all those cases we
> effectively have a bug in git-svn, but at least in the latter cases
> it's an explainable one :)

One possibility is that the SVN libraries themselves fail to report
case-changing renames on Windows when git-svn is fetching.  And then
(hypothetically) git on cygwin tries to do something smart somewhere
with case-insensitive paths.

The above is purely a hunch, anybody else want to investigate that
possibility?

-- 
Eric Wong
