From: dieter@schoen.or.at
Subject: how to remove unreachable objects?
Date: Mon, 19 Sep 2011 11:08:31 +0200
Message-ID: <20110919110831.ewq03vnqos4w8cs8@webmail.edis.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 11:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5aCT-0007J2-2B
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 11:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590Ab1ISJbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 05:31:34 -0400
Received: from manage.edis.at ([62.99.242.136]:50532 "EHLO manage.edis.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574Ab1ISJbc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2011 05:31:32 -0400
X-Greylist: delayed 1379 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Sep 2011 05:31:31 EDT
Received: by manage.edis.at (Postfix, from userid 17890)
	id 9CEA8801984F; Mon, 19 Sep 2011 11:08:31 +0200 (CEST)
Received: from atvies9915zsrv.siemens.at (atvies9915zsrv.siemens.at
	[194.138.12.171]) by webmail.edis.at (Horde MIME library) with HTTP; Mon,
	19 Sep 2011 11:08:31 +0200
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181673>

hi,

i am relatively new to git, and am currently trying to get used to it.

at the moment i am exploring how to remove unneeded objects, this
should be possible with prune, gc and/or fsck.
maybe i have not found the right combination or something in my
understand is not correct.

this is my use case:
i create a repository and produce several commits on master.
then i go back to a certain tag and create a new branch, where i also
commit.
then i switch back to master and delete (-D) the other branch.
it should now be unreachable from within git (to prove its existence,
i remember a commit SHA1 on the dead branch).
then i try to get rid of the unreachable objects with a series of
prune, fsck and gc.

-------------
schoen.d@ax:~/projects/gitFeatures$ cat mk_dead_end.sh
#!/bin/sh

DEAD=dead_end

rm -rf $DEAD
mkdir $DEAD
cd $DEAD
git init
echo "first commit" > A
git add A
git commit -m "first commit"
git tag first_commit
echo "second commit" >> A
git add A
git commit -m "second commit"
git checkout first_commit
echo "commit in dead end" >> A
git add A
git commit -m "changed A in dead end"
git checkout -b $DEAD
dead_commit=`git log -1 --format="%H"`
git checkout master
git branch -D $DEAD
git show $dead_commit
git fsck --unreachable --full --verbose
git fsck --unreachable HEAD \
                    $(git for-each-ref --format="%(objectname)" refs/heads)
git fsck --lost-found
git prune -v $dead_commit
git prune $(git rev-parse --all)
git repack
git prune-packed
git gc --prune=now
git gc --aggressive
git show $dead_commit


------
if you look at the output of this script then you see that git knows  
that there
are unreachable/dangling objects, but they remain.

thankful for any pointer,
dieter
