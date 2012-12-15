From: Ben Aveling <ben.aveling@optusnet.com.au>
Subject: Unexpected behaviour when trying to merge two new repositories.
Date: Sat, 15 Dec 2012 16:18:25 +1100
Message-ID: <50CC0821.7000103@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 06:28:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjkIX-0006Ip-Vc
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 06:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825Ab2LOF1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 00:27:19 -0500
Received: from fallbackmx07.syd.optusnet.com.au ([211.29.132.9]:54728 "EHLO
	fallbackmx07.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750783Ab2LOF1T (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Dec 2012 00:27:19 -0500
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Dec 2012 00:27:18 EST
Received: from mail02.syd.optusnet.com.au (mail02.syd.optusnet.com.au [211.29.132.183])
	by fallbackmx07.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id qBF5JhPw018146
	for <git@vger.kernel.org>; Sat, 15 Dec 2012 16:19:43 +1100
Received: from [192.168.1.8] (d110-33-202-185.mas801.nsw.optusnet.com.au [110.33.202.185])
	(authenticated sender ben.aveling)
	by mail02.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id qBF5IPM6006272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 15 Dec 2012 16:18:27 +1100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.0 cv=L9pF2Jv8 c=1 sm=1 a=0wiOde9d68gA:10
	a=M3tzrNKUSDoA:10 a=8nJEP1OIZ-IA:10 a=PO7r1zJSAAAA:8 a=hbhFNEOghCQA:10
	a=k0RX194OXZ2P6kRFG80A:9 a=wPNLvfGTeEIA:10 a=4NP5J10xAyPq4kFdsjtLAw==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211519>


Hi,

I have a directory of files that have been copied between different 
machines, and then drifted apart.

I was trying to merge the different versions into a single unified 
repository.

I succeeded, but I had to navigate though, and recover from, what seems 
to me to be counter-intuitive behaviour.

Let me walk through a mock up of what I did.

Scenario 1. Merging two repositories.

Mock up first directory, and commit it.

   > mkdir a
   > git init a
   Initialized empty Git repository in /tmp/a/.git/
   > cd a
   > echo 1 > 1
   > echo 2 > 2
   > git add .
   > git commit -m "add 1 and 2"
   [master (root-commit) 9a649ab] add 1 and 2
    2 files changed, 2 insertions(+), 0 deletions(-)
    create mode 100644 1
    create mode 100644 2

Mock up second directory. Add files, but don't commit.

   > mkdir b
   > cd ../b
   > git init
   Initialized empty Git repository in /tmp/b/.git/
   > echo 1 > 1
   > echo 3 > 3
   > git pull ../a
   remote: Counting objects: 4, done.
   remote: Compressing objects: 100% (2/2), done.
   remote: Total 4 (delta 0), reused 0 (delta 0)
   Unpacking objects: 100% (4/4), done.
   From ../a
    * branch            HEAD       -> FETCH_HEAD
   error: Untracked working tree file '1' would be overwritten by merge.
   > git add 1 3

Now merge in the first directory.

   > git pull ../a master
   From ../a
    * branch            master     -> FETCH_HEAD
   Already up-to-date.
   > git status
   # On branch master
   # Changes to be committed:
   #   (use "git reset HEAD <file>..." to unstage)
   #
   #    deleted:    2
   #    new file:   3
   #

This surprised me. I wasn't expecting 2 to be deleted. And I wasn't 
expecting to be told that it was "Already up to date".

Scenario 2. Merging two repositories with everything committed.

Mock up a third directory. Add files and this time, commit. Then merge 
from a.

   > mkdir ../c
   > cd ../c
   > git init
   Initialized empty Git repository in /tmp/c/.git/
   > echo 1 > 1
   > echo 4 > 4
   > git add 1 4
   > git commit -m "add 1 and 4"
   [master (root-commit) b6081d9] add 1 and 4
    2 files changed, 2 insertions(+), 0 deletions(-)
    create mode 100644 1
    create mode 100644 4
   > git pull ../a master
   warning: no common commits
   remote: Counting objects: 4, done.
   remote: Compressing objects: 100% (2/2), done.
   remote: Total 4 (delta 0), reused 0 (delta 0)
   Unpacking objects: 100% (4/4), done.
   From ../a
    * branch            master     -> FETCH_HEAD
   Merge made by recursive.
    2 |    1 +
    1 files changed, 1 insertions(+), 0 deletions(-)
    create mode 100644 2
   > ll *
   -rw-rw-r-- 1 ben ben 2 2012-12-15 15:02 1
   -rw-rw-r-- 1 ben ben 2 2012-12-15 15:10 2
   -rw-rw-r-- 1 ben ben 2 2012-12-15 15:03 4

This is what I was expecting the first time.

It seems that if there are no commits in the new repository, git doesn't 
detect that there are no common commits.

Scenario 3. Merge with uncommitted changes.

Create another mock directory. Create some of the same files, but with 
different contents. Again, add them but don't commit.

   > mkdir ../d
   > cd ../d
   > git init
   Initialized empty Git repository in /tmp/d/.git/
   > echo 1a > 1
   > echo 5 > 5
   > git add 1 5
   > git commit -m "add 1 and 5"
   [master (root-commit) b6081d9] add 1 and 5
    2 files changed, 2 insertions(+), 0 deletions(-)
    create mode 100644 1
    create mode 100644 5
   > git pull ../a master
   remote: Counting objects: 4, done.
   remote: Compressing objects: 100% (2/2), done.
   remote: Total 4 (delta 0), reused 0 (delta 0)
   Unpacking objects: 100% (4/4), done.
   From ../a
    * branch            master     -> FETCH_HEAD
   > git status
   # On branch master
   nothing to commit (working directory clean)
   > ls -l
   total 8
   -rw-rw-r-- 1 ben ben 2 2012-12-15 15:31 1
   -rw-rw-r-- 1 ben ben 2 2012-12-15 15:31 2

This too, surprised me.  This time, the incoming file was added where 
before it was deleted. And file 5 has vanished.

   > git fsck
   dangling blob a8994dc188ebbbc9e8a885470651a7fbb9127528
   dangling blob 7ed6ff82de6bcc2a78243fc9c54d3ef5ac14da69
   > cat 1
   1
   > git cat-file -p a8994dc188ebbbc9e8a885470651a7fbb9127528
   1a
   > git cat-file -p 7ed6ff82de6bcc2a78243fc9c54d3ef5ac14da69
   5

In fact, both file 1 and file 5 have been 'lost'.  It's not obvious to 
me why this happens, except that it seems to be a feature of the need to 
merge.

This seems inconsistent. In one case, we have merged all 3 files. In one 
case, we have deleted incoming files. And in one case, we have 'lost' 
files that were already in the repository.

In one way, this is a slightly obscure edge case - merging into a new 
repository and then adding but not committing the files.  But the people 
most likely to do this are new git users - the ones who have to work 
hardest to recover the deleted/lost files.

     Regards, Ben
