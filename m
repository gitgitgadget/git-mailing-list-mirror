From: Per Cederqvist <cederp@opera.com>
Subject: git clone fails intermittently if source repo is updated
Date: Tue, 17 Apr 2012 14:54:40 +0200
Message-ID: <87vckyldrj.fsf@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ceder@lysator.liu.se
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 14:54:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK7vp-0006gN-PR
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 14:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193Ab2DQMyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 08:54:46 -0400
Received: from smtp.opera.com ([213.236.208.81]:43531 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755778Ab2DQMyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 08:54:45 -0400
Received: from centurion.linkoping.osa (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q3HCsgoc006134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 17 Apr 2012 12:54:42 GMT
Received: by centurion.linkoping.osa (Postfix, from userid 1000)
	id E062CB9A702; Tue, 17 Apr 2012 14:54:40 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195756>

Running "git clone master.git copy" sometimes fails if changes are being
pushed to master.git.  Likewise, running "git clone mirror.git copy"
sometimes fails if the mirror is currently fetching changes from
master.git.

In git 1.7.9 I sometimes get one of two fatal error messages.  In one of
the cases, git still exits with exit code 0, but the working directory
of "copy" is not updated with the proper files.  (See below for the
exact error messages.)

In git 1.7.10 the mirror sometimes ends up in "detached HEAD" state.
Sometimes it prints a warning message.  (See below for the messages.)

The following shell scripts can reproduce the problem.  I've been using
a 4-core CPU on Ubuntu 11.04.  I've compiled Git from source.

The first script, test-git-setup.sh, creates the directory "test-git"
and three git repositories in it: master.git, mirror.git, and committer:

------ cut here for test-git-setup.sh ------
#!/bin/sh
mkdir test-git || exit 1
cd test-git
mkdir master.git
(cd master.git && git init --bare)
git clone master.git committer
(cd committer &&
    touch foo &&
    git add foo &&
    git commit -m"Initial commit" &&
    git push origin master)
git clone --mirror master.git mirror.git
------ cut here ------

The second script continuously modifies the file "foo" in the committer
repository, commits it, and pushes it to master.git:

------ cut here for test-git-commit.sh ------
#!/bin/sh
set -e
cd test-git/committer
i=0
while :
do
    echo $i > foo
    git add foo
    git commit -m"Updated foo"
    git push
    i=`expr $i + 1`
done
------ cut here ------

The third script repeatedly clones a repository, and ensures that the
"git clone" command does exit 0, prints no unexpected output, and
creates a sane clone (the file "foo" must exist).  You must give it the
argument "master" or "mirror" to tell it which repository to clone.

------ cut here for test-git-reclone.sh ------
#!/bin/sh

what=$1

case "$what" in
    master);;
    mirror);;
    *) echo need to specify master or mirror >&2
       exit 1;;
esac

good=0
cd test-git || exit 1
rm -rf $what-clone
while :
do
    git clone $what.git $what-clone >$what.out 2>$what.err || exit 1
    if [ -s $what.err ]
    then
	echo unexpected stderr from git clone:
	cat $what.err
	exit 1
    fi
    if [ "`cat $what.out`" != "Cloning into '$what-clone'...
done." ]
    then
	echo unexpected stdout from git clone:
	cat $what.out
	exit 1
    fi
    if ! [ -f $what-clone/foo ]
    then
	echo failed to create $what-clone/foo
	exit 1
    fi
    rm -rf $what-clone
    good=`expr $good + 1`
    echo "$good good clones"
done
------ cut here ------

The final script repeatedly runs "git fetch" in mirror.git, to update it
from master.git.

------ cut here for test-git-mirror.sh ------
#!/bin/sh
cd test-git/mirror.git
while :
do
    echo running fetch...
    git fetch || exit 1
    echo done.
done
------ cut here ------

To reproduce, run this command:

    ./test-git-setup.sh

When it has completed, run the following commands at once (preferably
in four separate windows so you can see what is going on).  Start them
in the indicated order.

    ./test-git-reclone.sh master
    ./test-git-reclone.sh mirror
    ./test-git-mirror.sh
    ./test-git-commit.sh

The reclone commands will print lines such as these:

    1 good clones
    2 good clones
    3 good clones
    4 good clones

Let them run to at least 200 good clones before you decide that you
cannot reproduce the problem.

Using Git 1.7.10 I get the following error after a while:

> unexpected stderr from git clone:
> Note: checking out 'c210776284dc8bc1c3f6eecc316b539c9aea85c9'.
>
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in this
> state without impacting any branches by performing another checkout.
>
> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -b with the checkout command again. Example:
>
>   git checkout -b new_branch_name
>

When this happens, I can recover by running "git checkout master" in the
clone, but before I do so "git status" reports:

> # Not currently on any branch.
> nothing to commit (working directory clean)

and "git branch -a" reports:

> * (no branch)
>   remotes/origin/master

Sometimes I get a different error:

> unexpected stderr from git clone:
> warning: failed to stat /home/cederp/test-git/mirror.git/objects/f6/tmp_obj_TZjRRd
>

or

> unexpected stderr from git clone:
> warning: failed to stat /home/cederp/test-git/master.git/objects/59/tmp_obj_SZtkWc
>

Using Git 1.7.9 I sometimes get this error when running
"./test-git-reclone.sh mirror":

> Cloning into 'mirror-clone'...
> done.
> error: refs/remotes/origin/master does not point to a valid object!
> error: Trying to write ref refs/heads/master with nonexistent object 5d049be4cd93c230a88503d8f9b4057587c76b2d
> fatal: Cannot update the ref 'HEAD'.

Sometimes I get this message:

> Cloning into 'mirror-clone'...
> done.
> error: unable to find 1338993ab85d24f451be1cd6565c4685c24fcc15
> error: unable to read sha1 file of foo (1338993ab85d24f451be1cd6565c4685c24fcc15)

In this case, "git clone" does exit(0), but the file "foo" does not
exist in the created mirror.

    /ceder
