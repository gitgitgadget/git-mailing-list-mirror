From: David Kastrup <dak@gnu.org>
Subject: The philosophy behind my directory proposal in a nutshell
Date: Sun, 22 Jul 2007 00:22:18 +0200
Message-ID: <85fy3hqtwl.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 00:22:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICNLQ-0004Gb-EY
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 00:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbXGUWW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 18:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754312AbXGUWW3
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 18:22:29 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:57538 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751946AbXGUWW1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 18:22:27 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id CA4A517FC40
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 00:22:25 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id BBBCB12D724
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 00:22:25 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-231.pools.arcor-ip.net [84.61.10.231])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 84A151CB721
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 00:22:25 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 820AC1D1E180; Sun, 22 Jul 2007 00:22:18 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3720/Sat Jul 21 23:34:48 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53191>


Ok, a big nut.

Many people have lost track since I developed the idea over dozens of
postings and so I have been explaining only details instead of the
actual picture.

Let us assume we habe the following files in the work tree (there is a
reason for starting off with / always in this discussion):

/i/never/saw/this
/i/never/should/have
/i/would/have

Now it is obvious that we _also_ have the directories (which I'll call
by their proposed git name):

/i/never/saw/.
/i/never/should/.
/i/never/.
/i/would/.
/i/.
/.

Git does right now not track any of them.  It _induces_ their
existence through trees in the repository.  Let us call the _trees_ in
the following way:

/i/never/saw/
/i/never/should/
/i/never/
/i/would/
/i/
/

[The last line here is the reason we prepended / everywhere: it makes
the root tree more apparent].

All those _trees_ are just string prefixes of file names, and those
prefixes are without a physical existence.  But if we check out the
files, we need to create directories to accommodate them.  And for
efficiency reasons, we call every prefix occuring in the flat file
list ending in / a "tree" and give it an SHA1 value.

Now when do we remove a directory that is in the work filesystem?
When the corresponding tree (=prefix) in the repository becomes empty,
namely the prefix becomes unused, the tree evaporates.  At that
moment, git has lost the necessity for keeping the directory around,
and attempts to remove it.  If the attempt does not succeed, something
outside of git is using the directory.  At this point removing the
directory becomes somebody else's problem: git will not try again.
The tree is gone from the repository, so there is nothing that makes
git even _think_ about that directory.

So far, so well.  Quite consistent, in some cases quite convenient,
but not in all.  There are situations where empty directories matter.

So we want git to be able to track them.  Let us take a simple example
first:

mkdir a
mkdir a/b
touch a/b/c
git add a/b/c
git commit
git rm a/b/c
git commit

The naive expectation would be that the directories made by the user
will not get touched by git.  Trying to implement anything like a "git
removes only directories it created itself" would be insane, and here
is why: the user actually has no _chance_ not to create those
directories before checking the files in.  And there is no way to
deduce whether he did it on behalf of git or because of some other
reason.  Also it is not important _how_ the directory got created: git
tracks states, not responsibilities.

So this case _must_ behave the same: after the first commit, we have
/a/b/c in the repository as the only file, and it induces the
existence of the trees

/a/b
/a
/

So when we remove /a/b first /a collapses and evaporates (if a tree
falls in the repository and there is nobody to hear it...), then /
collapses but is kept alive because we can't remove our current work
directory, not even if the repository is kept elsewhere (and actually,
/ _is_ special after all).

This behavior _must_ stay the same, regardless of what settings we
use.  Now let us assume that git can be told to track directories, and
that the user wants to keep a around even if empty, but not
necessarily b.  How can he achieve this?
mkdir a
git-add a
mkdir a/b
touch a/b/c
git-add a/b/c
git-commit
git-rm a/b/c
git-commit

Now directories come into play.  After the first git-add, the
repository contains the following non-volatile stuff:

/a/.

and in consequence it contains the trees

/a/
/

as well.  The second add adds /a/b/c but nothing else, so we have

/a/.
/a/b/c

and the trees

/a/b/
/a/
/

Ok, so now do the git-rm and following commit.  The tree then contains

/a/.

and /a/b/ collapses while /a/ and / are held up by /a/. perfectly
well.  The collapse of /a/b/ leads to the deletion of the
corresponding directory in the work tree (so the collapse of a tree in
the repository _does_ make a sound in the work directory as long as
somebody is there to hear it).

    [As a note aside: working directories get removed when their
    corresponding tree collapses and disappears from the
    repository.  I should think it only consistent if the same
    happened with git-rm: let the file by default disappear at
    the moment when it gets removed from the repository,
    implying --cached.  Namely, let

    git-rm some-file
    git-add some-file

    be a noop, regardless whether the file was registered
    previously.  This also implies that git-rm will always leave
    unregistered files alone.]

So when directory tracking is on, basically whenever adding
a directory explicitly by naming it or a parent directory in
the add or commit, the corresponding entry ending in "/."
gets added and keeps the tree alive even if no other file
does.  And while the tree is alive, git does not touch the
directory in the work tree.

So that are the basics for more or less manually adding and
removing directories when they are being tracked.  How do we
let git decide whether or not to track directories?  It
never tracks them if our git-add commands only mention
files: in that case, the behavior is indistinguishable from
previously.  But if we use git-add to add directories, then
not just files, but also directories make it to the index
and repository.

Of course, we can have a configuration variable to set
this.  But this is not enough.  Fortunately, all directories
carry a name ending with "/." in the repository, and thus we
can use the gitignore mechanism to make git ignore
directories.

Some commands accept "ignore this" or "don't ignore this" on
the command line, this takes highest priority.

Then .gitignore files come to play in the directory
hierarchy: those make it easy to exclude or include any
subtree in directory tracking by specifying the pattern "."
or "!.".  Then $GIT_DIR/info/exclude takes effect in a
similar way, another level lower core.excludesfile is
consulted, and at the very lowest level, if nobody else
cares (unlikely that a project would not set forth a policy
in $GIT_DIR/info/exclude), the users preference variable
core.trackdirs takes effect, defaulting to false for
compatibility until all projects wanting to keep directories
out of their repository have made their wish explicit in
their configuration.

I hope the concept now is somewhat clearer.

Now how does git _exactly_ deal with ignored files?  Ignored
files basically means that git skips them when they get
added (unless you use -f).  However, it _does_ notice when
they get deleted and updates the repository correspondingly.

What does this mean for interoperability of users with
different preferences of directory tracking?  First assume
that both have git versions capable of tracking directories.
One ignores ".", the other doesn't.  "." entries will in
this case be removed when the non-tracker commits a
directory with -a where the physical directory has
disappeared (and thus also all files beneath that).  That's
reasonably harmless.  "." entries will be added for a
directory and its subdirectories when the tracking person
commits a directory.

No problems here, little cause for violence.  Now what
happens with a "legacy" git?  The legacy git _never_ sees
anything corresponding to the weird directory entries in the
file system.  So with every commit of a tree with -a, the
tree gets "corrected" by removing the "strange" entries.
They will get added again when somebody else commits, but in
the mean time, empty directories might disappear.  If that
is a problem, you should not have given a person using an
old git commit access.  Could be worse.

So that basically wraps this up.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
