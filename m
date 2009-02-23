From: "christopherlmarshall@yahoo.com" <christopherlmarshall@yahoo.com>
Subject: example of git-p4 usage: checking out remote branches?
Date: Mon, 23 Feb 2009 08:30:52 -0800 (PST)
Message-ID: <4431fe90-a540-4b19-954f-78465ef91eb2@e18g2000yqo.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 17:32:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbdjF-0003UC-Nz
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 17:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612AbZBWQa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 11:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755511AbZBWQa4
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 11:30:56 -0500
Received: from yw-out-2122.google.com ([74.125.46.27]:56277 "EHLO
	yw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262AbZBWQay (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 11:30:54 -0500
Received: by yw-out-2122.google.com with SMTP id 1so1591926ywp.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 08:30:52 -0800 (PST)
Received: by 10.150.122.18 with SMTP id u18mr970475ybc.16.1235406652084; Mon, 
	23 Feb 2009 08:30:52 -0800 (PST)
X-IP: 206.253.190.42
User-Agent: G2/1.0
X-HTTP-Via: 1.0 SDALISA2
X-HTTP-UserAgent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; 
	InfoPath.1),gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111151>

I am trying to learn how to use git-p4 to clone a perforce depot with
multiple branches to a git repo, push git changes back to p4, and pull
p4 changes into a git repo.

I have written a bash script that executes a scenario like this end-to-
end.

I am wondering if the commands I am using make sense or if they are
missing the point of git-p4; is my approach absurdly cumbersome?

In particular, should I really be checking out a remote branch, then
creating a local branch from it to work with?

I'm attached my bash script below.

Chris Marshall

#!/bin/bash
# file_summary: git-p4 clone, illustrates importing p4 repo, git -> p4
changes, and p4 -> git changes

rm -rf server workspace
mkdir -p server workspace git-proj
CWD=$(pwd)

# start server
cd server
p4d -f -p 1666 &
p4pid=$!
disown $p4pid

#
cd ../workspace
export P4PORT=1666
export P4CLIENT=testws
export P4EDITOR=true

# create client
while ! p4 client -o > tmp.txt ; do
sleep 1
done
p4 client -i < tmp.txt

# create some files in the mainline of a project
mkdir -p proj1/main
cd proj1/main
echo "1" > f1
echo "2" >> f1
echo "3" >> f1
echo "4" >> f1
echo "5" >> f1
p4 add f1
p4 submit -d "initial checkin"
sleep 2

# create a branch
(
   echo "Branch: main2br1"
   echo "View:"
   echo "   //depot/proj1/main/... //depot/proj1/br1/..."
) | p4 branch -i

p4 integrate -b main2br1
p4 submit -d "created br1 branch"
sleep 2

# change main line
p4 edit f1
echo "1" > f1
echo "2" >> f1
echo "3" >> f1
echo "4" >> f1
echo "4.1" >> f1
echo "5" >> f1
p4 submit -d "4.1 -> f1 on main line" f1
sleep 2

# change branch
cd ../br1
p4 edit f1
echo "1" > f1
echo "2" >> f1
echo "2.1" >> f1
echo "3" >> f1
echo "4" >> f1
echo "5" >> f1
p4 submit -d "2.1 -> f1 on br1" f1
sleep 2

cd $CWD
cd git-proj
git-p4 clone //depot/proj1@all proj1 --detect-branches

cd proj1

# checkout the head of the remote branch
git checkout p4/proj1/br1

# create a local branch to work with
git branch br1
git checkout br1

# make changes
echo "1" > f1
echo "2" >> f1
echo "2.1" >> f1
echo "2.2" >> f1
echo "3" >> f1
echo "4" >> f1
echo "5" >> f1
# commit
git commit -a -m "2.2 -> f1 on br1"

# br1: submit back to perforce
(
   echo "y"
) | git-p4 submit

# p4 2.3 -> f1 on br1
cd ${CWD}/workspace/proj1/br1
p4 edit f1
echo "1" > f1
echo "2" >> f1
echo "2.1" >> f1
echo "2.2" >> f1
echo "2.3" >> f1
echo "3" >> f1
echo "4" >> f1
echo "5" >> f1
p4 submit -d "2.3 -> f1 on br1"

# pull them into git repo
cd ${CWD}/git-proj/proj1
git-p4 sync //depot/proj1@all --detect-branches
git merge p4/proj1/br1

# kill server
kill $p4pid
cd  $CWD
rm -rf workspace server git-proj
