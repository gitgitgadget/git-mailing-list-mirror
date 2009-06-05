From: Alexander Gladysh <agladysh@gmail.com>
Subject: Troubles when directory is replaced by symlink
Date: Fri, 5 Jun 2009 09:43:08 +0400
Message-ID: <c6c947f60906042243v2e36251dn9a46343cf6b8a2f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 07:43:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCSDI-0008EY-6T
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 07:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbZFEFnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 01:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbZFEFnK
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 01:43:10 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:39757 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbZFEFnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 01:43:08 -0400
Received: by fxm9 with SMTP id 9so302015fxm.37
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 22:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=P1f+kINLYdJuovhRx24bE1s3dZNnyzt7JOpbYFDgzAE=;
        b=tR1UqGUFuwlXC9ko6yNJxJWz6YoVwkLCZuOoiJjXPV6XpIod0/1xLRw4DTEu5hwZiP
         bz5oDMP8ffkSmq+D9W3nB05NoQke2FNm4b/pVy3kS2ipQRPdyMB0jXcyNnScQqgfbRY2
         tP2+5dQtf/Set73iEjveKXXsvtP0X0m5Qvi44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=jIPZTsNh7x4qVmmgmkY5Nuy7DXYI1juEgzJTmWS3gI5DgBpl5+1g1Ve0W1BA6+bSLC
         UX1WjEq6fMfMxlsoopcmjt+omTrevSYL3hN9Lhn+PRx64gINHH8jPo52rA8oQNydIOQL
         XtkPPJ+jNhKNtlYB1OIVjKs3PYXtv5rL+VLY8=
Received: by 10.223.125.144 with SMTP id y16mr1674217far.93.1244180588462; 
	Thu, 04 Jun 2009 22:43:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120741>

Hi, list!

OS X 10.5.7

$ git --version
git version 1.6.3.2

In my master branch I've had this structure:

root /
    directory1 /
        some-files
    directory2 /
        copy-of-directory1 /
            some-files

In a separate branch I replaced copy-of-directory1 with a symlink to
../directory1. I did it in two commits: first remove
copy-of-directory1, in second commit -- create the symlink.

My master branch is then moved by couple commits ahead.

Now I have nasty problems when I try to merge that separate branch
back to master (see log below).

If I split the branch history in two, and first merge up to commit
with deletion, and then separately merge the rest of it with symlink
creation -- all goes well.

Below is the log on how to reproduce the problem:

Alexander.

$ mkdir test
$ cd test
$ git init
Initialized empty Git repository in /users/agladysh/tmp/test/.git/
$ mkdir alpha
$ echo "file1" > alpha/file1
$ git add .
$ git commit -m "first commit"
[master (root-commit) 1df90a8] first commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 alpha/file1

$ mkdir beta
$ cp -R alpha beta/
$ git add .
$ git commit -m "second commit"
[master 0eddb98] second commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 beta/alpha/file1

$ git checkout -b branch
Switched to a new branch 'branch'
$ rm -rf beta/alpha
$ git add -u
$ git commit -m "deleted"
[branch 34134ea] deleted
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 beta/alpha/file1

$ cd beta/
$ ln -s ../alpha
$ cd ..
$ git add .
$ git commit -m "symlink"
[branch b8dfba0] symlink
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 120000 beta/alpha

$ git checkout master
Switched to branch 'master'

### All works if we're just fast-forwarding ###

$ git branch backup
$ git merge branch
Updating 0eddb98..b8dfba0
Fast forward
 beta/alpha       |    1 +
 beta/alpha/file1 |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)
 create mode 120000 beta/alpha
 delete mode 100644 beta/alpha/file1

### Trying to restore to backup
$ git reset --hard backup
error: Invalid path ''
HEAD is now at 0eddb98 second commit
$ git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	deleted:    alpha/file1
#
no changes added to commit (use "git add" and/or "git commit -a")

### Needed second reset --hard.

$ git reset --hard
HEAD is now at 0eddb98 second commit

$ git status
# On branch master
nothing to commit (working directory clean)

### We're back to original master now

$ echo "change" >> alpha/file1
$ git commit -a -m "third commit"
[master 0f64b88] third commit
 1 files changed, 1 insertions(+), 0 deletions(-)

### Here it goes

$ git merge branch
CONFLICT (directory/file): There is a directory with name beta/alpha
in HEAD. Adding beta/alpha as beta/alpha~branch
Removing beta/alpha/file1
Automatic merge failed; fix conflicts and then commit the result.
[4168][agladysh.agmac: test]$ git status
beta/alpha: needs merge
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	deleted:    beta/alpha/file1
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	unmerged:   beta/alpha
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	beta/alpha~branch
$ git mergetool
Merging the files: beta/alpha

mv: rename beta/alpha to ./beta/alpha.BACKUP.55777: No such file or directory
cp: ./beta/alpha.BACKUP.55777: No such file or directory
Deleted merge conflict for 'beta/alpha':
  {local}: deleted
  {remote}: a symbolic link -> '../alpha'
Use (c)reated or (d)eleted file, or (a)bort? c
fatal: beta/alpha: unable to stat (No such file or directory)
mv: rename ./beta/alpha.BACKUP.55777 to beta/alpha.orig: No such file
or directory
