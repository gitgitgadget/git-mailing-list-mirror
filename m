From: Claudia.Ignat@loria.fr
Subject: Octopus merge
Date: Thu, 26 Nov 2009 16:56:02 +0100
Message-ID: <4B0EA512.1050001@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 17:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDgr2-0001Xc-ES
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 17:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760279AbZKZQFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 11:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760162AbZKZQFt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 11:05:49 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:56095
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756443AbZKZQFs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 11:05:48 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Nov 2009 11:05:48 EST
X-IronPort-AV: E=Sophos;i="4.47,294,1257116400"; 
   d="scan'208";a="38811633"
Received: from coockie.loria.fr (HELO [152.81.12.125]) ([152.81.12.125])
  by mail3-relais-sop.national.inria.fr with ESMTP; 26 Nov 2009 16:56:03 +0100
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133806>

Hello,

I have problems on understanding the results of octopus merge in the 
following scenario.

Workspaces ws2, ws3, ws4 and ws5 are clones of the workspace ws1. 
Suppose the current workspace is ws3 and some changes are done in 
parallel in all these 4 workspaces. Further suppose that changes of ws2 
and ws3 are conflicting, while the changes in ws4 and ws5 are neither 
conflicting between them nor with ws2 and ws3.

While I am in the current workspace ws3 I perform the merge

git merge ws4 ws2 ws5

Obviously I obtain conflicts between changes in ws3 and ws2 which I fix 
manually and afterwards I commit the new version of ws3. It seems 
strange that the commit object has only one parent, while including the 
changes of ws4.

If instead I perform

git merge ws4 ws5 ws2

and fix manually the conflicts and performing the commit, the commit 
object has 4 parents (ws3,ws4,ws5 and ws2).

I provide below the script illustrating the first scenario:

# !/bin/bash
TEST_NAME="TP1" # name of the working directory
rm -rf ${TEST_NAME} # cleaning working directory
mkdir -p ${TEST_NAME}
cd ${TEST_NAME}

# initialising initial git workspace
mkdir ws1
cd ws1
git init

# adding a file to ws1
# commit changes
echo -e -n "1\n2\n3\n4\n5\n" > file.txt
git add file.txt
git commit -m "ws1 | add 12345"
cd ..

# cloning three times ws1 (as ws2, ws3 and ws4)
git clone ws1 ws2
git clone ws1 ws3
git clone ws1 ws4
git clone ws1 ws5

# updating file.txt in ws2 (insert X at line 3, then write and quit 'ed')
# commit changes
cd ws2
echo -e "3i\nX\n.\nw\nq\n" | ed file.txt
git add file.txt
git commit -m "ws2 | insert 12X345"
cd ..


# updating file.txt in ws3 (insert Y at line 3, then write and quit 'ed')
# commit changes
cd ws3
echo -e "3i\nY\n.\nw\nq\n" | ed file.txt
git add file.txt
git commit -m "ws3 | insert 12Y345"
cd ..

cd ws4
echo -e -n "U1\n2\n3\n4\n5\n" >  u.txt
git add u.txt
git commit -m "ws4 | add u.txt"
cd ..

cd ws5
echo -e -n "W1\n2\n3\n4\n5\n" > w.txt
git add w.txt
git commit -m "ws5 | add w.txt"
cd ..

# ws3 pull from ws2 ws4 ws5
cd ws3
git remote add bws2 ../ws2
git remote add bws4 ../ws4
git remote add bws5 ../ws5
git fetch bws2
git fetch bws4
git fetch bws5
git merge bws4/master bws2/master bws5/master
cd ..

# resolve conflict in ws3
cd ws3
echo -e '7d\n5d\n3d\n.\nw\nq\n' | ed file.txt
git add file.txt
git commit -m "ws3| in file.txt solve conflict (kept XY) "
cd ..

Could somebody please explain me these results? I suspect a bug in 
octopus merge. I am using version 1.6.3.3 of git.
Thank you in advance.

Best regards,
Claudia Ignat
