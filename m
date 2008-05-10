From: "v s" <git.viper@gmail.com>
Subject: filter-branch --subdirectory-filter fails on a branch
Date: Sat, 10 May 2008 22:22:32 +0300
Message-ID: <ed2394df0805101222l3da4c3cfn4a8ab8d782770703@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 21:23:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuufK-00080o-6S
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 21:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbYEJTWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 15:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754536AbYEJTWk
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 15:22:40 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:33491 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbYEJTWi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 15:22:38 -0400
Received: by yw-out-2324.google.com with SMTP id 9so983445ywe.1
        for <git@vger.kernel.org>; Sat, 10 May 2008 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=PPiJ2GEBASbrIzJsiXikoXUd9n+1k6fL3Bowa/pKpvM=;
        b=KxVG58RBZj5w4BLkI7m8d9WhhFNKrReEj5dYmVWzELAX1HvdpEXNLyxRSIiLlx1gZYLcD5Xlb7qqCiaqiuU2J0dT5Sg6OM5Co2wrc78SJILux5vZ52yKYwZofzQ2Rvbf7XUGReMNxJ+Ruu/E49OE6jNauU61ZPrpbfL/+NN3WCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RhVrMH4vGSKr9t9FKArYlQfN88wW9vbg0khjAf6HvoJ/UCmIUOXgbXTEeSUFgr50xuESASYBX17Yoa0pglIvS6TqJKA0Jh3f5S5Q1JjAt5Plw/Gkggn2OsyFq3W+n0Scl2WUX4OzlEo5GUfD5CqFlDPOno6RlGIZXRNH/dvpR4Q=
Received: by 10.150.50.3 with SMTP id x3mr6404760ybx.30.1210447353719;
        Sat, 10 May 2008 12:22:33 -0700 (PDT)
Received: by 10.151.144.13 with HTTP; Sat, 10 May 2008 12:22:32 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81692>

Hi there.

While splitting up a repository using git-filter-branch I stumbled upon
a tad weird case in which --subdirectory-filter refuses to filter out
a subdir on one of the branches, but succeeds on others. In addition,
in some cases git-filter-branch refuses to run unless git-status is
invoked first.

In a nutshell, I have 2 subdirs at top level which I want to turn into
separate repos, A and B. There are 2 topic branches in repo: Topic-A
modifying exclusively A subdir, Topic-B - modifying exclusively B
subdir, and master modifying both. Topic-B was branched off of Topic-A
which was branched off of master. Splitting out subdir A works without
a hitch, splitting out subdir B doesn't - Topic-A remains unchanged,
though master and Topic-B are transformed fine. Given full symmetry
of commits (at least in repro case), I find that strange.

Below please find the precise repro steps interleaved with git output,
with interesting points 1,2,3 and 4 commented. Sorry that it came out
quite longish and cluttered. "=====> " represents bash prompt (in vain
attempt to improve readability), grep-ping for it then sed-ding it out
ought to yield executable bash script, I think.

Am I somehow misusing git-filter-branch? Perusing its man page didn't
turn up anything immediately obvious that I might be overlooking. Any
ideas?

Thanks in advance.

V.Solo.


=====> git --version
git version 1.5.5.1
=====> mkdir zzz-both
=====> cd zzz-both
=====> pwd
/tmp/zzz-both
=====> git init
Initialized empty Git repository in .git/
=====> mkdir left
=====> mkdir right
=====> date > left/left.txt
=====> date > right/right.txt
=====> git add left right
=====> git commit -m "initial commit"
Created initial commit 525c08c: initial commit
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 left/left.txt
 create mode 100644 right/right.txt
=====> date > left/left.txt
=====> git commit -am "changed left"
Created commit 352e43c: changed left
 1 files changed, 1 insertions(+), 1 deletions(-)
=====> date > right/right.txt
=====> git commit -am "changed right"
Created commit 4c0decd: changed right
 1 files changed, 1 insertions(+), 1 deletions(-)
=====> date > left/left.txt
=====> date > right/right.txt
=====> git commit -am "changed both"
Created commit 4866710: changed both
 2 files changed, 2 insertions(+), 2 deletions(-)
=====> git checkout -b left-refact
Switched to a new branch "left-refact"
=====> date > left/left.txt
=====> git commit -am "left-refact: changed left"
Created commit 81fba4e: left-refact: changed left
 1 files changed, 1 insertions(+), 1 deletions(-)
=====> git show-branch
* [left-refact] left-refact: changed left
 ! [master] changed both
--
*  [left-refact] left-refact: changed left
*+ [master] changed both
=====> git checkout -b right-refact
Switched to a new branch "right-refact"
=====> date > right/right.txt
=====> git commit -am "right-refact: changed right"
Created commit 5cbddaa: right-refact: changed right
 1 files changed, 1 insertions(+), 1 deletions(-)
=====> git checkout master
Switched to branch "master"
=====> git show-branch --more=10
! [left-refact] left-refact: changed left
 * [master] changed both
  ! [right-refact] right-refact: changed right
---
  + [right-refact] right-refact: changed right
+ + [left-refact] left-refact: changed left
+*+ [master] changed both
+*+ [master^] changed right
+*+ [master~2] changed left
+*+ [master~3] initial commit
=====> ls *
left:
left.txt

right:
right.txt
=====> cp -r . ../zzz-left
=====> pwd
/tmp/zzz-both
=====> cd ../zzz-left/
=====> pwd
/tmp/zzz-left
=====> git branch
  left-refact
* master
  right-refact
=====> # (1) weirdness #1 : why do I have to "git status" first?
=====> git filter-branch --subdirectory-filter left HEAD left-refact
right-refact
Cannot rewrite branch(es) with a dirty working directory.
=====> git status
# On branch master
nothing to commit (working directory clean)
=====> git filter-branch --subdirectory-filter left HEAD left-refact
right-refact
Rewrite 81fba4e28d8b18bfcc4b139479ce547017a25dce (4/4)
Ref 'refs/heads/master' was rewritten
Ref 'refs/heads/left-refact' was rewritten
Ref 'refs/heads/right-refact' was rewritten
=====> git reset --hard
HEAD is now at 91fdc32 changed both
=====> ls
left.txt
=====> git show-branch --more=10
! [left-refact] left-refact: changed left
 * [master] changed both
  ! [right-refact] left-refact: changed left
---
+ + [left-refact] left-refact: changed left
+*+ [master] changed both
+*+ [master^] changed left
+*+ [master~2] initial commit
=====> git log --pretty=oneline --name-status left-refact
ea1d9b2391a94952658c0a1ccc7fd6f1b7fb9348 left-refact: changed left
M   left.txt
91fdc32587a7e688970fe8b77aac51820a53aed0 changed both
M   left.txt
c62bf71dc9f6684598212beb056a8ad2e17fea91 changed left
M   left.txt
360b8064403f7e86075eb6722919776e2d6981c5 initial commit
A   left.txt
=====> cp ../zzz-both/ ../zzz-right
cp: omitting directory `../zzz-both/'
=====> cp -r ../zzz-both/ ../zzz-right
=====> pwd
/tmp/zzz-left
=====> cd ../zzz-right/
=====> pwd
/tmp/zzz-right
=====> git branch
  left-refact
* master
  right-refact
=====> # (2) weirdness #1 : why do I have to "git status" first?
=====> git filter-branch --subdirectory-filter right HEAD left-refact
right-refact
Cannot rewrite branch(es) with a dirty working directory.
=====> git status
# On branch master
nothing to commit (working directory clean)
=====> # (3) weirdness #2 : filter-branch fails
=====> git filter-branch --subdirectory-filter right HEAD left-refact
right-refact
Rewrite 5cbddaa45ae4fa53170dbbd1adcf86d841709c36 (4/4)
Ref 'refs/heads/master' was rewritten
WARNING: Ref 'refs/heads/left-refact' is unchanged
Ref 'refs/heads/right-refact' was rewritten
=====> git reset --hard
HEAD is now at 9a16605 changed both
=====> ls
right.txt
=====> # (4) weirdness #2 : indeed, left-refact is intact
=====> git show-branch --more=10
! [left-refact] left-refact: changed left
 * [master] changed both
  ! [right-refact] right-refact: changed right
---
  + [right-refact] right-refact: changed right
 *+ [master] changed both
 *+ [master^] changed right
 *+ [master~2] initial commit
+   [left-refact] left-refact: changed left
+   [left-refact^] changed both
+   [left-refact~2] changed right
+   [left-refact~3] changed left
+   [left-refact~4] initial commit
=====> git log --pretty=oneline --name-status left-refact
81fba4e28d8b18bfcc4b139479ce547017a25dce left-refact: changed left
M   left/left.txt
4866710cda33fcf563486f94883550e6e41eedc1 changed both
M   left/left.txt
M   right/right.txt
4c0decd9458301b474fa16be8344a436aaf4e97f changed right
M   right/right.txt
352e43c705fcdac0abeaae78a814820146130cb3 changed left
M   left/left.txt
525c08c8fdc51ef81aae40f26423259b1f394e61 initial commit
A   left/left.txt
A   right/right.txt
=====> git log --pretty=oneline --name-status right-refact
55f1c2a693e7447ae8f5cb3b9b4994c815a5c2b7 right-refact: changed right
M   right.txt
9a16605e9650d82abdf64edd102c9824d4468c71 changed both
M   right.txt
b5ebdf2d5027ca9372a0811636604a9670b762dd changed right
M   right.txt
56f5e5c2ad98cc1597bbb5b97e291452fd3b9fd9 initial commit
A   right.txt
=====> git checkout left-refact
Switched to branch "left-refact"
=====> ls *
left:
left.txt

right:
right.txt
=====>
