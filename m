From: Mark Levedahl <mlevedahl@verizon.net>
Subject: directory / submodule merge conflcts
Date: Sat, 12 Jul 2008 12:01:37 -0400
Message-ID: <4878D561.8090009@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 12 18:03:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHhZi-0002ao-QE
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 18:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbYGLQBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 12:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbYGLQBq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 12:01:46 -0400
Received: from vms173005pub.verizon.net ([206.46.173.5]:33381 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbYGLQBp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 12:01:45 -0400
Received: from [192.168.1.117] ([71.246.235.165]) by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3W0003JHUQB1L4@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 12 Jul 2008 11:01:39 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88253>

Over time, I have converted a number of subdirectories in a main project 
into submodules, while maintaining the complete pathnames intact. Thus, 
only git knows that an object at code/dir1 is a submodule or a 
subdirectory of the superproject.

git has trouble merging branches across the above boundaries, the script 
below demonstrates the issue. I cannot merge the main branch and a 
branch that occurred before conversion to a submodule.

Paraphrasing the script, the formula is
    - create a superproject with a subdirectory (sub1)
    - on master, convert sub1 to a submodule (no other changes)
    - on branch base (before sub1 conversion to a submodule), change a 
file not in sub1 (no other changes)
    - merge master into base - failure

The actual reported error message is:
fatal: cannot read object b500f4d0c6aaf40a0251da35b82c0fa5c57b6503 
'sub1~master': It is a submodule!
Merge with strategy recursive failed.

Any ideas or hints on how to improve this would be greatly appreciated.

Thanks,
Mark

#!/bin/sh
#
# demonstrate issue with directory / submodule (D/S) conflict problem

mkdir dsprob || exit
cd dsprob
git init
mkdir sub1
echo hi > foo
echo hi1 > sub1/foo
git add .
git commit -m "Create base"
git checkout -b base
echo bye >> foo
git add .
git commit -m "Modify base"
git checkout master

# make sub1 a submodule
git rm -r -f sub1
git commit -m "removed sub1 directory"
git checkout base sub1
git reset
cd sub1
git init
git add .
git commit -m "Start sub1 as its own project"
cd ..
mv sub1 sub1_repo
git submodule add "$(pwd)/sub1_repo" sub1
git commit -m "Added sub1 as a submodule"

# now, go back to base and try to merge
rm -rf sub1
git checkout -f base
git merge master
