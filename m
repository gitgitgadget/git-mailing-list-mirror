From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: git merge, .gitignore, and silently overwriting untracked files
Date: Mon, 16 Aug 2010 23:21:31 -0600
Message-ID: <4C6A1C5B.4030304@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 17 07:21:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlEcB-0003bF-7x
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 07:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab0HQFVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 01:21:30 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:37922 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab0HQFV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 01:21:29 -0400
Received: (qmail 12125 invoked by uid 399); 16 Aug 2010 23:21:29 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 16 Aug 2010 23:21:29 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153700>

  Git silently overwrote an important untracked file for me today.  I 
have come up with the following transcript to reproduce the issue.

In a nutshell, if an untracked file is in .gitignore, a merge from a 
branch where the file was added will OVERWRITE the untracked file 
without warning.

This doesn't seem right.

What do others think?

Josh

-------------------------------

/s/testgitoverwrite
$ mkdir aaa

/s/testgitoverwrite
$ cd aaa

/s/testgitoverwrite/aaa
$ echo abc > abc.txt

/s/testgitoverwrite/aaa
$ ls -l
total 1
-rw-r--r--    1 Joshua   Administ        4 Aug 16 23:10 abc.txt

/s/testgitoverwrite/aaa
$ git init
Initialized empty Git repository in s:/testgitoverwrite/aaa/.git/

/s/testgitoverwrite/aaa (master)
$ git add abc.txt

/s/testgitoverwrite/aaa (master)
$ git commit -m "Added abc.txt"
[master (root-commit) 0e8bffb] Added abc.txt
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 abc.txt

/s/testgitoverwrite/aaa (master)
$ cd ..

/s/testgitoverwrite
$ git clone aaa bbb
Cloning into bbb...
done.

/s/testgitoverwrite
$ cd bbb

/s/testgitoverwrite/bbb (master)
$ ls -l
total 1
-rw-r--r--    1 Joshua   Administ        4 Aug 16 23:10 abc.txt

/s/testgitoverwrite/bbb (master)
$ echo "Important stuff" > important.txt

/s/testgitoverwrite/bbb (master)
$ git add important.txt

/s/testgitoverwrite/bbb (master)
$ git commit -m "This file is SO important"
[master 2fe9ab6] This file is SO important
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 important.txt

/s/testgitoverwrite/bbb (master)
$ cd ..

/s/testgitoverwrite
$ cd aaa

/s/testgitoverwrite/aaa (master)
$ echo "Local testing copy of important.txt" > important.txt

/s/testgitoverwrite/aaa (master)
$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       important.txt
nothing added to commit but untracked files present (use "git add" to track)

/s/testgitoverwrite/aaa (master)
$ git pull ../bbb
remote: Counting objects: 4, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
 From ../bbb
  * branch            HEAD       -> FETCH_HEAD
Updating 0e8bffb..2fe9ab6
error: Untracked working tree file 'important.txt' would be overwritten 
by merge.  Aborting

/s/testgitoverwrite/aaa (master)
$ git pull --rebase ../bbb
 From ../bbb
  * branch            HEAD       -> FETCH_HEAD
First, rewinding head to replay your work on top of it...
error: Untracked working tree file 'important.txt' would be overwritten 
by merge.
could not detach HEAD

/s/testgitoverwrite/aaa (master)
$ echo important.txt > .gitignore

/s/testgitoverwrite/aaa (master)
$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
nothing added to commit but untracked files present (use "git add" to track)

/s/testgitoverwrite/aaa (master)
$ cat important.txt
Local testing copy of important.txt

/s/testgitoverwrite/aaa (master)
$ git pull ../bbb
 From ../bbb
  * branch            HEAD       -> FETCH_HEAD
Updating 0e8bffb..2fe9ab6
Fast-forward
  important.txt |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 important.txt

/s/testgitoverwrite/aaa (master)
$ cat important.txt
Important stuff
