From: David Kastrup <dak@gnu.org>
Subject: Re: A simpler approach to tracking directories
Date: Sun, 22 Jul 2007 20:45:37 +0200
Message-ID: <85myxoi8fi.fsf@lola.goethe.zz>
References: <85fy3hqtwl.fsf@lola.goethe.zz> <85abtola79.fsf@lola.goethe.zz>
	<20070722175731.GA16658@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 22 20:45:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgR7-0003li-D4
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 20:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758375AbXGVSpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 14:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757922AbXGVSpl
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 14:45:41 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:40883 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757482AbXGVSpl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 14:45:41 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 0CE3617F483;
	Sun, 22 Jul 2007 20:45:39 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id EDED22DAB40;
	Sun, 22 Jul 2007 20:45:38 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-022-107.pools.arcor-ip.net [84.61.22.107])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id A8D2E1D316D;
	Sun, 22 Jul 2007 20:45:38 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id DABCB1D1E182; Sun, 22 Jul 2007 20:45:37 +0200 (CEST)
In-Reply-To: <20070722175731.GA16658@thunk.org> (Theodore Tso's message of "Sun\, 22 Jul 2007 13\:57\:31 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3729/Sun Jul 22 18:10:33 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53288>

Theodore Tso <tytso@mit.edu> writes:

> On Sun, Jul 22, 2007 at 05:39:06PM +0200, David Kastrup wrote:
>> Now my proposal basically boils down to using the u+x bit on
>> directory/tree entries for tracking "keep around when empty".
>> 
>> I think we are on the safe side to assume a directory with access
>> permissions zero (a-rwx) is something we never want to be able to
>> track with git.
>
> Ok, so I think you are still missing the fundamental issue about why
> Linus is upset with your proposals.

Or I am not careful in communicating what I consider obvious in
addressing it.

> One of the fundamental things which falls out of the "Git Tracks
> Contents" mantra is that information which you expect to be pushed
> forward future revisions (as opposed to metadata which is specific
> to a commit, such as the Author and Committer of a patch, the Commit
> log, etc.) *MUST* be information which is realized in the working
> tree.

For every _file_ in the working tree, there is _one_ bit of
information in the repository that is not in the working tree: namely
whether git is tracking this file at all.

> That way, if you diff between working trees, one of which has either
> your "." entry or your "u+x" bit, and of which doesn't, they need to
> be *different* when run "git diff" on the two working trees.

If I have two identical working trees, and in one working tree a file
A has been added into git, and in the other it hasn't, then git diff
will report a difference.

> Another way of putting is this single bit of information meaning
> "keep this directory around when empty" is something that ***must***
> be representable in three different places: in a git tree object, in
> the index, *AND* in the working tree.  The problem with "." is that
> since all directories contain the "." entry, you can't represent the
> bit of information you want to record in the working tree in that
> way.

But if I have two identical working trees, where in one of them A has
been added into git and in the other it hasn't, there _is_ a bit of
difference in the repository.

I think the remaining problem boils down to the following: a file that
is not tracked by git has nothing in the repository which one would
associate with it.  That is easy to understand.  But trees in the
repository are right now a consequence of tracking files: a file needs
a tree, and git creates one.  So we have an object in the repository
which we naturally correlate with the directory in the working tree
that is required for holding the files in the working tree.  So the
relationship becomes somewhat less intuitive:

git tracks file -> file is in the repository
git does not track file -> file is not in the repository

That's easy.

git tracks directory -> tree permissions are not zero in the repository
git does not track directory -> no tree with non-zero permissions

So the problem in understanding is that in spite of git not tracking
the directory, there can be _still_ an _incidental_ tree whose
existence is solely to support the blobs in it.  This problem is
acerbated by git having to actually manipulate working file
directories even if it has no information about them.  So that git
_works_ with directories does not help to clarify that it does not
_track_ them.  At least one pointer that it does not track them,
however, is that they are not even entered into the index.  So since
no information flow into the repository happens, at the current point
of time, all directories can be considered untracked.  git _is_
accessing and manipulating them, but without any help from the
repository that would be specific to the directory.

> There is a same problem with using the u+x permission, for the same
> reason.  Unless you want to make directories you want to keep around
> with access permissions of zero in the working tree, you're *still*
> not able to record presence or absence of the "keep around when
> empty bit" in the working tree.

Like it is not encoded in the working tree whether or not git is
tracking a particular file.

> That's why the ".gitignore" entry is acceptable, where as your
> proposals are not.

But whether or not a file is tracked is not decided by a .gitignore
entry: gitignore comes into play only when one is adding entire
directories, and thus _implicitly_ adding files.

The explicit act or non-act of "git-add file" records a difference in
the repository that is nowhere reflected in the work directory.

> But the problem is that Linus very much wants the "do not erase" bit
> to be visible in the working directory, since to do otherwise would
> violate fundamental design assumptions all over the git source
> files.

Whether or not a file is tracked is _not_ encoded in the work
directory.  While the gitignore entries provide useful defaults, as
long as every git-add and git-rm is only naming single files, tracking
and not tracking remains a possibility for every single file, a
possibility nowhere reflected in the work directory.

> So your new proposal suffers from the same fundamental flaw as your
> previous one.

It pretty much behaves the same, yes.  After all, it has to represent
the difference between

mkdir a
touch a/b
git-add a/b
git-commit -m x
git-rm a/b
git-commit -m x

(where a should be removed) and

mkdir a
touch a/b
git-add a
git-commit -m x
git-rm a/b
git-commit -m x

(where a should be retained).  Feel free to address this.

> Maybe you disagree with Linus's design constraint, but you've never
> addressed his specific concern on-point, which is that since Git
> Tracks Content, if you want something to be tracked across
> revisions, it must be visible in the working tree.

Oh, I address it pretty much in every posting: whether or not a _file_
is being tracked is _not_ visible in the working directory, and nobody
sees a problem with that.  So this "design constraint" is very much
violated all the time, anyway.

> The problem with such a proposal is that it now requires that the
> filesystem used to store the working directory MUST support extended
> attributes, and some filesystems, such as FAT filesystems, do not.
> And Git already has been accused of not being Windows friendly
> enough, and this would make things worse.

Where is the relation to my proposal?  Am I asking for anything that
any file system could not represent?

> It's also a lot of hair for two very marginal features, namely being
> able to support arbitrary SVN property values, and the "do not erase
> when empty" directory bit.

Maybe we should call the bit by its meaning, not its effect.  Call it
the "git has been told to track this directory" bit.

Perhaps then it gets less offensive.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
