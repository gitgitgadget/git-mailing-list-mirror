From: Michael <git-scm@webhippo.net>
Subject: Bug Report: Creating a hardlink to any of the file in git repo
 cause the source file  to show up in git commit message editor under
 "Changes not staged for commit" section.
Date: Sun, 17 Jul 2011 20:42:52 -0700
Message-ID: <02a20a168c52beb42e57258bcc5c0551@mail.mxes.net>
Reply-To: git-scm@webhippo.net
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 18 05:42:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiejS-0002bw-6x
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 05:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab1GRDmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 23:42:53 -0400
Received: from mxout-08.mxes.net ([216.86.168.183]:57986 "EHLO
	mxout-08.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab1GRDmx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 23:42:53 -0400
Received: from wm2.irbs.net (wm2.irbs.net [216.86.168.169])
	by smtp.mxes.net (Postfix) with ESMTP id 9549450A5D
	for <git@vger.kernel.org>; Sun, 17 Jul 2011 23:42:52 -0400 (EDT)
Received: from wmbeta.mxes.net (wm2.irbs.net [216.86.168.169])
	by wm2.irbs.net (Postfix) with ESMTPA id 824B3853C6
	for <git@vger.kernel.org>; Sun, 17 Jul 2011 23:42:52 -0400 (EDT)
X-Sender: git-scm@webhippo.net
User-Agent: RoundCube Webmail/0.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177336>

 Creating a hardlink to any of the file in git repo cause the source 
 file
 to show up in git commit message editor under "Changes not staged for 
 commit"
 section.

 Reproduced on:
 Ubuntu 10.04, Gentoo, FreeBSD
 Git version: 1.7.6

 Bug has been observed by atleast 3 people.

 Follow these steps to reproduce:

 # create test repo
 cd /tmp
 mkdir -p test-repo/repo
 cd test-repo/repo
 git init
 git config user.name "Foo"
 git config user.email "foo@example.com"

 # put some files in the repo
 touch FILE1 FILE2 FILE3 FILE4 FILE5
 git add -A
 git commit -m "initial commit"

 # create git hook that hardlink FILE2 and FILE3 and remove the 
 hardlinks
 # right then and there
 echo "ln -vf FILE2 ../HARDLINK_TO_FILE2" >| .git/hooks/pre-commit
 echo "rm -vf ../HARDLINK_TO_FILE2" >> .git/hooks/pre-commit
 echo "ln -vf FILE3 ../HARDLINK_TO_FILE3" >> .git/hooks/pre-commit
 echo "rm -vf ../HARDLINK_TO_FILE3" >> .git/hooks/pre-commit

 # make pre-commit executable
 chmod u+x .git/hooks/pre-commit

 # modify FILE1
 echo "hello world" >> FILE1

 # run git status
 git status
 -------------------------------------------------------------------------------
 # On branch master
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working 
 directory)
 #
 #       modified:   FILE1
 #
 no changes added to commit (use "git add" and/or "git commit -a")
 -------------------------------------------------------------------------------

 # try commit using nano as commit editor and without usin -a flag
 VISUAL=nano git commit FILE1

 # Despite the fact that they are modified FILE2 and FILE3 will show in 
 the
 # commit message, under "Changes not staged for commit" section
 # like so:

 --------------------------------------------------------------------------------
 # Please enter the commit message for your changes. Lines starting
 # with '#' will be ignored, and an empty message aborts the commit.
 # Explicit paths specified without -i nor -o; assuming --only paths...
 # On branch master
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
 #
 #       modified:   FILE1
 #
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working 
 directory)
 #
 #       modified:   FILE2
 #       modified:   FILE3
 #
 --------------------------------------------------------------------------------


 In case anyone interested, tor me this happens when I do a python EGG 
 build
 which hardlinks files in order to build.


 -- Michael
