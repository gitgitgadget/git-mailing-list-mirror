From: "Lauri Alanko" <la@iki.fi>
Subject: Re: A design for subrepositories
Date: Sun, 14 Oct 2012 18:27:46 +0300
Message-ID: <20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
	<7vd30m2sbr.fsf@alter.siamese.dyndns.org>
	<20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi>
	<7vzk3p1xh3.fsf@alter.siamese.dyndns.org>
	<20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi>
	<507ABDF3.4040106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; DelSp="Yes"; format="flowed"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 17:28:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNQ6q-00067o-4m
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 17:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab2JNP15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 11:27:57 -0400
Received: from smtp-rs1-vallila2.fe.helsinki.fi ([128.214.173.75]:54702 "EHLO
	smtp-rs1-vallila2.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751471Ab2JNP14 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 11:27:56 -0400
Received: from webmail.helsinki.fi (webmail1-vallila2.fe.helsinki.fi [128.214.173.135])
	by smtp-rs1.it.helsinki.fi (8.14.4/8.14.4) with ESMTP id q9EFRkif011410;
	Sun, 14 Oct 2012 18:27:47 +0300
Received: from scan-proxy1-1.it.helsinki.fi (scan-proxy1-1.it.helsinki.fi
	[128.214.2.137]) by webmail.helsinki.fi (Horde Framework) with HTTP; Sun,
	14 Oct 2012 18:27:46 +0300
In-Reply-To: <507ABDF3.4040106@web.de>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207667>

Quoting "Jens Lehmann" <Jens.Lehmann@web.de>:

>>>> If the
>>>> submodules ever get reorganized and foo is moved to ./bar, then it is
>>>> impossible to check out older versions or alternate branches, since
>>>> the submodule is no longer where it is expected to be at the origin.

> Your initial statement is not correct.

Please elaborate. My initial statement was about "git submodule add  
./foo", and this is what I get:

la@bq:~/tmp$ git --version
git version 1.8.0.rc2.2.gfc364c7
la@bq:~/tmp$ git init super
Initialized empty Git repository in /home/la/tmp/super/.git/
la@bq:~/tmp$ cd super
la@bq:~/tmp/super$ echo foo > foo
la@bq:~/tmp/super$ git add foo
la@bq:~/tmp/super$ git ci -m foo
[master (root-commit) a0dd543] foo
  1 file changed, 1 insertion(+)
  create mode 100644 foo
la@bq:~/tmp/super$ git init sub
Initialized empty Git repository in /home/la/tmp/super/sub/.git/
la@bq:~/tmp/super$ cd sub
la@bq:~/tmp/super/sub$ echo bar > bar
la@bq:~/tmp/super/sub$ git add bar
la@bq:~/tmp/super/sub$ git ci -m bar
[master (root-commit) a6ee6d6] bar
  1 file changed, 1 insertion(+)
  create mode 100644 bar
la@bq:~/tmp/super/sub$ cd ..
la@bq:~/tmp/super$ git submodule add ./sub
Adding existing repo at 'sub' to the index
la@bq:~/tmp/super$ git ci -m sub
[master cb289e8] sub
  2 files changed, 4 insertions(+)
  create mode 100644 .gitmodules
  create mode 160000 sub
la@bq:~/tmp/super$ git branch old
la@bq:~/tmp/super$ git mv sub movedsub
fatal: source directory is empty, source=sub, destination=movedsub
la@bq:~/tmp/super$ mv sub movedsub
la@bq:~/tmp/super$ git rm sub
rm 'sub'
la@bq:~/tmp/super$ git add movedsub
la@bq:~/tmp/super$ git config -f .gitmodules submodule.sub.path movedsub
la@bq:~/tmp/super$ git config -f .gitmodules submodule.sub.url ./movedsub
la@bq:~/tmp/super$ git ci -am movedsub
[master 5598bc0] movedsub
  2 files changed, 2 insertions(+), 2 deletions(-)
  rename sub => movedsub (100%)
la@bq:~/tmp/super$ cd ..
la@bq:~/tmp$ git clone super superc
Cloning into 'superc'...
done.
la@bq:~/tmp$ cd superc
la@bq:~/tmp/superc$ git co old
Branch old set up to track remote branch old from origin.
Switched to a new branch 'old'
la@bq:~/tmp/superc$ git submodule update --init
Submodule 'sub' (/home/la/tmp/super/sub) registered for path 'sub'
fatal: repository '/home/la/tmp/super/sub' does not exist
Clone of '/home/la/tmp/super/sub' into submodule path 'sub' failed

So a normal relative path in .gitmodules to inside the tree is  
fragile, since the location of the submodule can change.

> Did you notice that "git fetch" fetches all those submodules too which
> have been updated in the commits fetched for the superproject, no matter
> on what branch they are on?

No. This would be great, but this is what I get:

la@bq:~/tmp$ git init super
Initialized empty Git repository in /home/la/tmp/super/.git/
la@bq:~/tmp$ cd super
la@bq:~/tmp/super$ echo foo > foo
la@bq:~/tmp/super$ git add foo
la@bq:~/tmp/super$ git ci -m foo
[master (root-commit) 0f207c9] foo
  1 file changed, 1 insertion(+)
  create mode 100644 foo
la@bq:~/tmp/super$ git branch nosubs
la@bq:~/tmp/super$ git init sub
Initialized empty Git repository in /home/la/tmp/super/sub/.git/
la@bq:~/tmp/super$ cd sub
la@bq:~/tmp/super/sub$ echo bar > bar
la@bq:~/tmp/super/sub$ git add bar
la@bq:~/tmp/super/sub$ git ci -m bar
[master (root-commit) 180c6c9] bar
  1 file changed, 1 insertion(+)
  create mode 100644 bar
la@bq:~/tmp/super/sub$ cd ..
la@bq:~/tmp/super$ git submodule add ./sub
Adding existing repo at 'sub' to the index
la@bq:~/tmp/super$ git ci -m sub
[master 16cff18] sub
  2 files changed, 4 insertions(+)
  create mode 100644 .gitmodules
  create mode 160000 sub
la@bq:~/tmp/super$ cd ..
la@bq:~/tmp$ git clone super superc
Cloning into 'superc'...
done.
la@bq:~/tmp$ cd superc
la@bq:~/tmp/superc$ git submodule update --init
Submodule 'sub' (/home/la/tmp/super/sub) registered for path 'sub'
Cloning into 'sub'...
done.
Submodule path 'sub': checked out '180c6c979289f4e25525003673e51d0e39dab8f6'
la@bq:~/tmp/superc$ cd ../super/sub
la@bq:~/tmp/super/sub$ echo baz >> bar
la@bq:~/tmp/super/sub$ git ci -am baz
[master 652c8b3] baz
  1 file changed, 1 insertion(+)
la@bq:~/tmp/super/sub$ cd ..
la@bq:~/tmp/super$ git ci -am subbaz
[master c7c3bfc] subbaz
  1 file changed, 1 insertion(+), 1 deletion(-)
la@bq:~/tmp/super$ cd ../superc
la@bq:~/tmp/superc$ git co nosubs
warning: unable to rmdir sub: Directory not empty
Branch nosubs set up to track remote branch nosubs from origin.
Switched to a new branch 'nosubs'
la@bq:~/tmp/superc$ git fetch --recurse-submodules=yes
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 2 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (2/2), done.
 From /home/la/tmp/super
    16cff18..c7c3bfc  master     -> origin/master
la@bq:~/tmp/superc$ git co master
Switched to branch 'master'
Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded.
la@bq:~/tmp/superc$ git fetch --recurse-submodules=yes
Fetching submodule sub
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
 From /home/la/tmp/super/sub
    180c6c9..652c8b3  master     -> origin/master

So I had to checkout master in order to fetch the updates to the  
submodule used by master.

> What's wrong with making git clone all submodules together with the
> superproject (when the user said he wants to update all submodules on
> clone too by setting a - still to be added - config option)?

Depends on how it's done. In a previous mail I just considered various  
ways to do it. If I see correctly, your choice is to read .gitmodules  
from every branch and every tag to find the total set of submodules  
used by the repository. As I said already, that is certainly possible,  
but it's just not very scalable, if fetch operations slow down  
linearly in the number of tags.

But no matter the technical issues, it seems that you at least have  
the _intention_ to eventually support self-contained, HEAD-independent  
repository collections. That already is valuable information, thanks.


Lauri
