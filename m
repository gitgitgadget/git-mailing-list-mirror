From: Csaba Henk <csaba@lowlife.hu>
Subject: git symbolic-ref vs. reflog (vs. rebase)
Date: Fri, 29 Apr 2011 15:03:52 +0000 (UTC)
Message-ID: <ipek0o$l0v$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 17:10:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFpKl-0003ls-JY
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 17:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429Ab1D2PKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 11:10:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:54975 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab1D2PKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 11:10:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QFpKZ-0003eY-Kc
	for git@vger.kernel.org; Fri, 29 Apr 2011 17:10:07 +0200
Received: from gluelinux.org ([195.56.45.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 17:10:07 +0200
Received: from csaba by gluelinux.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 17:10:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: gluelinux.org
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172456>

"git symbolic-ref" is a dangerous command in the sense that it can
change your HEAD position without updating the reflog. Is it
intended behaviour?

I found now a case where this feature causes strange behavior.
It seems to me that either behaviour of git symbolic-ref, or the way
it is used should be changed, but I'm not sure which of these
would be the right solution.

If I'm at a detached HEAD and I do a rebase onto it, from which then
I step back with "git rebase --abort", then I seem to lose references
to the HEAD before rebase, as git reflog won't show it anymore.

This is because of two factors:

- unlike a rebase onto a branch-referred head, we don't get an
  additional reflog entry for moving to the starting position
  of the rebase (ie. we don't actually changes HEAD, nevertheless
  in the branchy case a dummy reflog entry is made for HEAD);

- upon aborting the rebase, a call is done to "git symbolic-ref"
  in the aforementioned unsafe way, ie. it changes HEAD but
  does not update reflog.

The phenomenon is illustrated by the script below. Usage:

- fist arg is the dir where the script will run (should
  not exist at invocation, script creates it).

- optional second arg is a branchname, if you give it, you'll
  see the branchy case, else you get the rebase-onto-detached
  case

Observe the following: 

- in both of branchy and detached cases, one reflog entry for
  the starting HEAD disappears from reflog output, but in the
  branchy case there are two of them before "rebase --abort"
  so you don't lose the reference;

- "rebase --abort" does not change the reflog file, but
  the reflog command's output changes, as it shows the actual HEAD
  as HEAD{0}, regardless of the last log entry.

Csaba

 * * *

bash> cat gtr.sh
#!/bin/bash -e

GIT=${GIT:-git}

if !([ $# -eq 1 ] || [ $# -eq 2 ]) || [ "$1" = -h ]; then
    echo usage: `basename $0` scratchdir [branchname]
fi

if ! [ -z $2 ]; then
    branch=$2
    bropt=-b
fi

mkdir "$1"
cd "$1"

{
$GIT init

echo master > file
$GIT add file
$GIT commit -m Master.

$GIT checkout -b topic
echo topic > file
$GIT commit -am Topic.

$GIT checkout $bropt $branch master~0
echo detached > file
$GIT commit -am 'Rebase base'.
} &>/dev/null

echo
$GIT log --all --graph --decorate --pretty=oneline
echo

set -x

$GIT hash-object .git/logs/HEAD
$GIT rebase HEAD topic || :
$GIT hash-object .git/logs/HEAD
$GIT reflog
# ruby is used to compactify the logfile,
# if you don't have ruby, comment out
# the filtering part.
cat .git/logs/HEAD | ruby -ane 'puts $F.map{|x| x[0..(x =~ /:$/ ? -1 : 7)] }.join(" ")'
$GIT rebase --abort
$GIT hash-object .git/logs/HEAD
$GIT reflog

bash> ./gtr.sh testdir

* 27a1300e35857be6357adaf6759eb8ce0818d37b (topic) Topic.
| * 5d4be82c08bf6effc906a37419220ca428834844 (HEAD) Rebase base.
|/
* 6fa006d134be4d986e1a680cac4eddd61494164a (master) Master.

+ git hash-object .git/logs/HEAD
cd15f363cf16ea3e03f5177b502de8ce3543ff21
+ git rebase HEAD topic
First, rewinding head to replay your work on top of it...
Applying: Topic.
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging file
CONFLICT (content): Merge conflict in file
Failed to merge in the changes.
Patch failed at 0001 Topic.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

+ :
+ git hash-object .git/logs/HEAD
cd15f363cf16ea3e03f5177b502de8ce3543ff21
+ git reflog
5d4be82 HEAD@{0}: commit: Rebase base.
6fa006d HEAD@{1}: checkout: moving from topic to master~0
27a1300 HEAD@{2}: commit: Topic.
6fa006d HEAD@{3}: checkout: moving from master to topic
6fa006d HEAD@{4}: commit (initial): Master.
+ cat .git/logs/HEAD
+ ruby -ane 'puts $F.map{|x| x[0..(x =~ /:$/ ? -1 : 7)] }.join(" ")'
00000000 6fa006d1 Csaba Henk <csaba@l 13040883 +0530 commit (initial): Master.
6fa006d1 6fa006d1 Csaba Henk <csaba@l 13040883 +0530 checkout: moving from master to topic
6fa006d1 27a1300e Csaba Henk <csaba@l 13040883 +0530 commit: Topic.
27a1300e 6fa006d1 Csaba Henk <csaba@l 13040883 +0530 checkout: moving from topic to master~0
6fa006d1 5d4be82c Csaba Henk <csaba@l 13040883 +0530 commit: Rebase base.
+ git rebase --abort
HEAD is now at 27a1300 Topic.
+ git hash-object .git/logs/HEAD
cd15f363cf16ea3e03f5177b502de8ce3543ff21
+ git reflog
27a1300 HEAD@{0}: commit: Rebase base.
6fa006d HEAD@{1}: checkout: moving from topic to master~0
27a1300 HEAD@{2}: commit: Topic.
6fa006d HEAD@{3}: checkout: moving from master to topic
6fa006d HEAD@{4}: commit (initial): Master.
bash> rm -rf testdir
bash> ./gtr.sh testdir foobr

* fa0c2b339d1f048281ed7098d8d7d55a12b35154 (HEAD, foobr) Rebase base.
| * a87b990fcd5c7a109611694dcc9523d4f00ae8fe (topic) Topic.
|/
* 1e2d1c12f46105c9329479535780ec230afe7fa0 (master) Master.

+ git hash-object .git/logs/HEAD
734ae3b60eee21ee2b8b51450040389004d56e5d
+ git rebase HEAD topic
First, rewinding head to replay your work on top of it...
Applying: Topic.
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging file
CONFLICT (content): Merge conflict in file
Failed to merge in the changes.
Patch failed at 0001 Topic.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

+ :
+ git hash-object .git/logs/HEAD
5acf3d5f543333f549b3f9d295ed2ba91074b43d
+ git reflog
fa0c2b3 HEAD@{0}: checkout: moving from foobr to fa0c2b339d1f048281ed7098d8d7d55a12b35154^0
fa0c2b3 HEAD@{1}: commit: Rebase base.
1e2d1c1 HEAD@{2}: checkout: moving from topic to foobr
a87b990 HEAD@{3}: commit: Topic.
1e2d1c1 HEAD@{4}: checkout: moving from master to topic
1e2d1c1 HEAD@{5}: commit (initial): Master.
+ cat .git/logs/HEAD
+ ruby -ane 'puts $F.map{|x| x[0..(x =~ /:$/ ? -1 : 7)] }.join(" ")'
00000000 1e2d1c12 Csaba Henk <csaba@l 13040887 +0530 commit (initial): Master.
1e2d1c12 1e2d1c12 Csaba Henk <csaba@l 13040887 +0530 checkout: moving from master to topic
1e2d1c12 a87b990f Csaba Henk <csaba@l 13040887 +0530 commit: Topic.
a87b990f 1e2d1c12 Csaba Henk <csaba@l 13040887 +0530 checkout: moving from topic to foobr
1e2d1c12 fa0c2b33 Csaba Henk <csaba@l 13040887 +0530 commit: Rebase base.
fa0c2b33 fa0c2b33 Csaba Henk <csaba@l 13040887 +0530 checkout: moving from foobr to fa0c2b33
+ git rebase --abort
HEAD is now at a87b990 Topic.
+ git hash-object .git/logs/HEAD
5acf3d5f543333f549b3f9d295ed2ba91074b43d
+ git reflog
a87b990 HEAD@{0}: checkout: moving from foobr to fa0c2b339d1f048281ed7098d8d7d55a12b35154^0
fa0c2b3 HEAD@{1}: commit: Rebase base.
1e2d1c1 HEAD@{2}: checkout: moving from topic to foobr
a87b990 HEAD@{3}: commit: Topic.
1e2d1c1 HEAD@{4}: checkout: moving from master to topic
1e2d1c1 HEAD@{5}: commit (initial): Master.
