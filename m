From: Marcel Cary <marcel@care2team.com>
Subject: "recursive" merge strategy fails when renaming a file into a 
	subdirectory: fatal: git write-tree failed to write a tree
Date: Fri, 2 Jul 2010 14:03:05 -0700
Message-ID: <AANLkTilrcoBcTgDeooTEmlnZ7lmg4vL4_8U_k_QSCH8E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 23:03:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUnOG-00089M-SP
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 23:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520Ab0GBVDJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 17:03:09 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61343 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab0GBVDG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 17:03:06 -0400
Received: by pvc7 with SMTP id 7so1431417pvc.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 14:03:05 -0700 (PDT)
Received: by 10.142.139.5 with SMTP id m5mr1908437wfd.141.1278104585356; Fri, 
	02 Jul 2010 14:03:05 -0700 (PDT)
Received: by 10.142.192.7 with HTTP; Fri, 2 Jul 2010 14:03:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150166>

When I merge with a branch that renames hi to hi/there, the
"recursive" strategy fails with this error:

    hi/there: unmerged (45b983be36b73c0788dc9cbcb76cbb80fc7bb057)
    fatal: git write-tree failed to write a tree

The "resolve" strategy works; that is my work-around for now:

    git merge -s resolve master


Here's a transcript of a simple example anyone can use to replicate
the problem, with some commentary interspersed. =A0I see this behavior
on=A01.6.3.3 on Linux and=A01.7.1 on Mac.

    ~/tmp$ mkdir test-repo
    ~/tmp$ cd test-repo/
    ~/tmp/test-repo$ git init
    Initialized empty Git repository in /Users/marcel/tmp/test-repo/.gi=
t/
    ~/tmp/test-repo|master$ echo hi > hi
    ~/tmp/test-repo|master$ git add hi
    ~/tmp/test-repo|master$ git commit -m hi
    [master (root-commit) 635cab8] hi
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 hi
    ~/tmp/test-repo|master$ git branch other-feature
    ~/tmp/test-repo|master$ git rm hi
    rm 'hi'
    ~/tmp/test-repo|master$ mkdir hi
    ~/tmp/test-repo|master$ echo hi > hi/there
    ~/tmp/test-repo|master$ git add hi/there
    ~/tmp/test-repo|master$ git commit -m 'hi there'
    [master eee387a] hi there
     1 files changed, 0 insertions(+), 0 deletions(-)
     rename hi =3D> hi/there (100%)
    ~/tmp/test-repo|master$ git checkout other-feature
    Switched to branch 'other-feature'
    ~/tmp/test-repo|other-feature$ echo foo > foo
    ~/tmp/test-repo|other-feature$ git add foo
    gmarcel@marcel-carys-macbook:~/tmp/test-repo|other-feature$ git
commit -m 'foo'
    [other-feature 5d7bd95] foo
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 foo
    ~/tmp/test-repo|other-feature$ git merge master
    hi/there: unmerged (45b983be36b73c0788dc9cbcb76cbb80fc7bb057)
    fatal: git write-tree failed to write a tree

That was the error.  Now, I've seen long-past posts about this error
message that suggested using the standard conflict resolution
procedure, so here goes... (but it will produce a commit which is not
in fact a merge commit).

    ~/tmp/test-repo|other-feature$ git status
    # On branch other-feature
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #	deleted:    hi
    #
    # Unmerged paths:
    #   (use "git reset HEAD <file>..." to unstage)
    #   (use "git add/rm <file>..." as appropriate to mark resolution)
    #
    #	added by them:      hi/there
    #
    ~/tmp/test-repo|other-feature$ ls -l hi
    ls: hi: No such file or directory
    ~/tmp/test-repo|other-feature$ git checkout master -- hi/there
    ~/tmp/test-repo|other-feature$ git status
    # On branch other-feature
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #	renamed:    hi -> hi/there
    #
    ~/tmp/test-repo|other-feature$ git commit
    [other-feature ef1d221] merged
     1 files changed, 0 insertions(+), 0 deletions(-)
     rename hi =3D> hi/there (100%)
    ~/tmp/test-repo|other-feature$ git log -n 1
    commit ef1d221d87f09b08fd705f55ede4870dd3df338b
    Author: Marcel Cary <marcel@earth.care2.com>
    Date:   Fri Jul 2 13:21:29 2010 -0700

        merged

Ok, there was the commit I got from the standard resolution procedure.
 Note how there's no line "Merge: 5d7bd95 eee387a" ?  Normally such a
commit header would be shown if the commit really had two parents.  So
the standard resolution procedure failed.  If I were to try merging
again, instead of "Already up-to-date" it would fail again with a
similar message.

So I'll try again with the work-around...

    ~/tmp/test-repo|other-feature$ git reset --hard HEAD@{1}
    HEAD is now at 5d7bd95 foo
    ~/tmp/test-repo|other-feature$ git merge -s resolve master
    Trying really trivial in-index merge...
    error: Merge requires file-level merging
    Nope.
    Trying simple merge.
    Simple merge failed, trying Automatic merge.
    Adding hi/there
    Merge made by resolve.
     hi =3D> hi/there |    0
     1 files changed, 0 insertions(+), 0 deletions(-)
     rename hi =3D> hi/there (100%)
    ~/tmp/test-repo|other-feature$ git --version
    git version 1.7.1
    ~/tmp/test-repo|other-feature$

The "resolve" strategy works great.  It would be nice if the
"recursive" merge strategy could also handle such a case, so users
don't have to know to choose a special one for this case.  Git
generally seems to handle this sort of repurposing of path names
pretty well, so perhaps this is an oversight.

Note that simply changing a file to a directory is not enough; one of
the new files in the directory has to appear as an exact or fuzzy
rename of the original file.

I'm not volunteering to fix it;  when I first searched Google for the
error message there was no conclusion (that applied to me at least)
about (a) what class of conditions leads to the error, nor (b) how to
resolve or work around the problem, I thought I'd share this remedy,
for what it's worth.

Here are the two threads I found:

http://osdir.com/ml/git/2009-03/msg00247.html
http://git.661346.n2.nabble.com/fatal-error-when-merging-a-rename-td266=
4375.html

And there was even an attempt to fix it, but no mention of the "-s
resolve" work around:

http://thread.gmane.org/gmane.comp.version-control.git/100859/

Marcel
