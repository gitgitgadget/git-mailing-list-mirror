From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: possible bug when pushing with multiple remote repos.
Date: Fri, 22 Oct 2010 11:12:51 +0200
Message-ID: <1287738771.13348.34.camel@amolinux>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xexiFs/er1AeL4JB870c"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 11:13:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9DgM-0008AY-Lp
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 11:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab0JVJM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 05:12:56 -0400
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:39591 "HELO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751750Ab0JVJM4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 05:12:56 -0400
Received: from source ([74.125.82.49]) by eu1sys200aob116.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTMFVlqm3lGW6NshHWzNU7G8EYAm1oawQ@postini.com; Fri, 22 Oct 2010 09:12:55 UTC
Received: by wwb34 with SMTP id 34so605437wwb.6
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 02:12:54 -0700 (PDT)
Received: by 10.216.154.206 with SMTP id h56mr2181131wek.111.1287738773688;
        Fri, 22 Oct 2010 02:12:53 -0700 (PDT)
Received: from [192.200.1.198] (AAnnecy-551-1-57-136.w92-153.abo.wanadoo.fr [92.153.208.136])
        by mx.google.com with ESMTPS id b10sm1726216wer.17.2010.10.22.02.12.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 02:12:53 -0700 (PDT)
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159670>


--=-xexiFs/er1AeL4JB870c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, 

I found a behavior which is, at least, different from what "git help
push" seems to declare.
basically:
- if I have 2 remotes : 'origin' and 'remote_B'
- if I checkout with tracking a branch of 'remote_B'
- if I do "git push remote" or "git push" or "git push -repo=remote_B"
then git try to push all my branches of "origin" to remote_B.

I check with latest git 1.7.3.2, and the issue is still here.

strangely:
- git checkout master
- git push  =>  this is OK, and doesn't try to push any remote_B
references to origin.

I found this is particularity error prone as origin/master can be a fast
forward of remote_B/master, and in this case nobody will complains..
(that's what happened to me ;-) )

attached to this mail, a simple script that show the evidence.

regards,
arnaud



--=-xexiFs/er1AeL4JB870c
Content-Type: application/x-shellscript; name="test.sh"
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: 8bit

#!/bin/sh

# this test demonstrate that when working with multiple branches tracked from multiple remotes
# then 'git push' or 'git push [remote]' will try to push too many references to the remote repository

# git clone foo.git repo
# cd foo
# git remote add bar ../bar.git
# git fetch bar
# git checkout -b bar-master bar/master
# git push  =>> FAILED because trying to push origin/master to bar/master

# yet, the following is working fine
# git checkout master
# git push  => OK, doesn't try to push "bar" references to "origin"

set -x
set -e


rm -rf demo
mkdir demo
cd demo
ROOT_PATH=$(pwd)



# create our first bare repo
mkdir bare1.git
cd bare1.git
BARE1_PATH=$(pwd)
git init --bare


# create clone of bare1
cd $ROOT_PATH
git clone bare1.git work
cd work
WORK_PATH=$(pwd)

# push a first comit

echo "hello world" > foo.c
git add foo.c
git commit -m 'adding foo.c'
git push origin master


# create a bare clone of bare1
cd $ROOT_PATH
git clone --bare bare1.git bare2.git


# show that "git push" try to push "origin" references to all other remotes 
# if we try to branch/checkout a branch from other remote

# 1) add a new commit to bare2
git clone bare2.git bare2_work
cd bare2_work
echo "bye bye" > bar.c
git add bar.c
git commit -m 'adding bar.c'
git push

# 2) return to "work" and add bare2 as new remote
cd $WORK_PATH
git remote add bare2 ../bare2.git
git fetch bare2

# 3) create a tracking branch from bare2/master
git checkout -b bare2_master bare2/master

# 4) run "git push"
# "git help push" gives the example and says: 
#
#   git push
#       Works like git push <remote>, where <remote> is the current branch’s remote (or origin, if no remote is
#       configured for the current branch).
#
# so, we expect this command to do nothing as everything is up to date
# yet, it try to push 'master' reference to 'bare2/master'
# which obviously (and fortunatly) failed
# 'git push' failed but 'git push bare2' or 'git push --repo=bare2' are not better
# in any case the behavior is not good as trying to push bare1.git references to bare2.git


git push              
git push bare2        
git push --repo=bare2 

# if we are here, the bug is fixed
echo "fix done"
exit 0


--=-xexiFs/er1AeL4JB870c--
