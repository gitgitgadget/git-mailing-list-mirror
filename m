From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Careful object writing..
Date: Tue, 3 May 2005 16:59:57 -0400
Message-ID: <20050503205957.GA25253@delft.aura.cs.cmu.edu>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org> <20050503200034.GA16104@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0505031306310.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 22:55:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT4PF-0002fL-Kt
	for gcvg-git@gmane.org; Tue, 03 May 2005 22:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVECVAM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVECVAM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:00:12 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:52867 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261690AbVECU77 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 16:59:59 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DT4Un-0006tQ-00; Tue, 03 May 2005 16:59:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505031306310.26698@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 03, 2005 at 01:11:47PM -0700, Linus Torvalds wrote:
> On Tue, 3 May 2005, Jan Harkes wrote:
> > I tried to pull in the latest version of your tree, but it doesn't look
> > like this commit has propagated to rsync.kernel.org yet. Hopefully you
> > will accept a small patch (should be < 5 lines) that makes git work
> > nicely when Coda complains about the cross-directory hardlink without
> > affecting the reliability of using link/unlink on normal filesystems.
> 
> What is it that coda wants to do, and is there some portable way to get 
> there? 

Short summary:

    rc = link(old, new);
    if (rc == -1 && errno == EXDEV)
	rc = rename(old, new);

On Coda, the cross-directory link fails, the following cross-directory
rename will work fine.  On a normal filesystem, if the link fails with
EXDEV, the rename will fail with the same.

Because our cache consistency model is fairly optimistic, we already
have to deal with potential problems with a rename removing an unwanted
target. So if we are logging write operations, and the link operation
did not return EEXISTS, then the rename will be marked as not having
removed any target file. If the target did happen to exist on the server
by the time we reintegrate the operations we end up with a reintegration
conflict.


Longer version:

When a server performs conflict resolution it happens on a per-directory
basis. So any cross-directory operation already a special case.

We cannot guarantee which directory will be resolved first, so if it is
the destination of a link or rename the object itself might not exist
yet. The advantage of a rename operation is that it contains a reference
to both the source and the destination directories. If we don't yet know
the renamed object we resolve the source first. That creates the object
and allows us to complete the rename operation.

However with a link we only have a reference to an object and the
directory where the link should be added. But again, the object might
not yet exist on all servers. At this point things get a bit more
complicated because we don't enforce access based on per object UNIX
mode bits, but rely on directory ACLs. So we can't just add a reference
to an unknown object in the destination directory because until we know
where else this object is located, we can't tell if the user actually is
allowed to access the object.

> Is it just that you want to stay within the directory? Or is it any link 
> action that is nasty?

We do allow links within the same directory, mostly because that often
happens in places like /usr/bin and we know that whenever we encounter
the link operation in the resolution log, that the object creation has
already been processed. We also know that the new link can't give a user
any rights he didn't already have.

> What makes resolving renames hard when the file contents are the same? 

Renames mostly work, there are only a few corner cases left. One is
where something is moved up in the directory tree and the source
directory is then removed. We end up screwing ourselves because we
append the childs logs on removal and the create operation ends up
behind the rename operation. But that is a dumb implementation problem.
Another issue is of course when someone (validly) hardlinks a file in
the same directory and then moves one of the links to another directory.

We definitely are not a typical filesystem with UNIX semantics, which is
why it is unusual to find an application that seems so well suited for
disconnected and weakly connected operation.

Jan

