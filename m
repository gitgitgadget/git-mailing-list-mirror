From: Rajkumar S <rajkumars@asianetindia.com>
Subject: cvsimport woes
Date: Sat, 04 Mar 2006 13:17:36 +0530
Message-ID: <44094618.6070404@asianetindia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Mar 04 08:47:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFRUT-0000M4-VP
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 08:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWCDHrl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 02:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWCDHrl
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 02:47:41 -0500
Received: from vhs2.linuxense.com ([64.34.173.90]:34474 "EHLO
	vhs1.asianetindia.com") by vger.kernel.org with ESMTP
	id S1750918AbWCDHrk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 02:47:40 -0500
Received: (qmail 26614 invoked by uid 1014); 4 Mar 2006 07:47:41 -0000
Received: from rajkumars@asianetindia.com by vhs2.linuxense.com by uid 1003 with qmail-scanner-1.22 
 (clamdscan: 0.74. spamassassin: 2.63.  Clear:RC:0(202.88.239.86):SA:0(0.0/6.5):. 
 Processed in 0.645287 secs); 04 Mar 2006 07:47:41 -0000
X-Spam-Status: No, hits=0.0 required=6.5
Received: from tarpit.linuxense.com (HELO [192.168.3.49]) (raj@linuxense.com@[202.88.239.86])
          (envelope-sender <rajkumars@asianetindia.com>)
          by vhs1.asianetindia.com (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 4 Mar 2006 07:47:40 -0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17179>

Hi,

I am trying to track a cvs project using git. The idea is to use cvsimport to update my 
local git copy and make my changes in a separate branch. But for some reason after 
cvsimport the last update of cvs repository is not reflected in git. I have made a small 
script to test this behavior and am able to reproduce is consistently. I am working on 
FreeBSD 6.0-RELEASE, git version 1.2.4 and cvsps version 2.1

The first script is to init a cvs repository, add 3 files and cvsimport it into git 
repository, before which I remove the all directories and .cvsps

raj@beastie:~$ cat git_init.sh
export CVSROOT=/home/raj/cvsroot
rm -rf cvsroot/ git/ src/ /home/raj/.cvsps
mkdir cvsroot  git src
cvs init
cd src/
echo "Line one" > file.txt
echo "Line one" > file1.txt
echo "Line one" > file2.txt
cvs import -m "Imported sources" src start realstart
cd ..
rm -rf src/
cvs co src
git cvsimport -v -d /home/raj/cvsroot -C git/  src


on executing:

N src/file.txt
N src/file1.txt
N src/file2.txt

No conflicts created by this import

cvs checkout: Updating src
U src/file.txt
U src/file1.txt
U src/file2.txt
cvs_direct initialized to CVSROOT /home/raj/cvsroot
cvs rlog: Logging src
Fetching file.txt   v 1.1
New file.txt: 9 bytes
Fetching file1.txt   v 1.1
New file1.txt: 9 bytes
Fetching file2.txt   v 1.1
New file2.txt: 9 bytes
Tree ID b75643d0deaa77018b4dbaa2ff81756c4c1bebc1
Committed patch 1 (origin 2006-03-04 07:37:59)
Committing initial tree b75643d0deaa77018b4dbaa2ff81756c4c1bebc1
Commit ID e800fd633e319b9a0b4c351f2964a03abf96b6e2
Fetching file.txt   v 1.1.1.1
Update file.txt: 9 bytes
Fetching file1.txt   v 1.1.1.1
Update file1.txt: 9 bytes
Fetching file2.txt   v 1.1.1.1
Update file2.txt: 9 bytes
Tree ID b75643d0deaa77018b4dbaa2ff81756c4c1bebc1
Parent ID e800fd633e319b9a0b4c351f2964a03abf96b6e2
Committed patch 2 (start 2006-03-04 07:37:59)
Commit ID 21bd067b19310d11790e99ad421de6611b942fbd
Created tag 'realstart' on 'start'
DONE; creating master branch

Now edit two files, commit cvs and cvsupdate again.

raj@beastie:~$ cat git_test.sh
export CVSROOT=/home/raj/cvsroot
cd src/
echo "Line two" >> file.txt
echo "Line two" >> file1.txt
cvs commit -m "v2.0"
cd ..
git cvsimport -v -d /home/raj/cvsroot -C git/  src
cd git
git status
cd ..
echo cat git/file.txt
cat git/file.txt
echo cat src/file.txt
cat src/file.txt

on executing:

cvs commit: Examining .
Checking in file.txt;
/home/raj/cvsroot/src/file.txt,v  <--  file.txt
new revision: 1.2; previous revision: 1.1
done
Checking in file1.txt;
/home/raj/cvsroot/src/file1.txt,v  <--  file1.txt
new revision: 1.2; previous revision: 1.1
done
cvs_direct initialized to CVSROOT /home/raj/cvsroot
cvs rlog: Logging src
skip patchset 1: 1141457879 before 1141457879
skip patchset 2: 1141457879 before 1141457879
Switching from master to origin
Fetching file.txt   v 1.2
Update file.txt: 18 bytes
Fetching file1.txt   v 1.2
Update file1.txt: 18 bytes
Tree ID 18d855d5b825ef1c0ecb9d26591e654cbe5c21df
Parent ID e800fd633e319b9a0b4c351f2964a03abf96b6e2
Committed patch 3 (origin 2006-03-04 07:39:35)
Commit ID 6e7129d186834d5b2941e78c1c67c5255f868e12
DONE
#
# Updated but not checked in:
#   (will commit)
#
#       modified: file.txt
#       modified: file1.txt
#
cat git/file.txt
Line one
cat src/file.txt
Line one
Line two


As you can see the git/file.txt and src/file.txt are different. I have tried my best to 
read all documentation and follow them faithfully and I hope I am not making any obviously 
  stupid mistake.

raj
