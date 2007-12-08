From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Submodules and merging
Date: Sat, 8 Dec 2007 19:40:31 +0100
Message-ID: <20071208184030.GA21613@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 19:40:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J14bf-0008An-UV
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 19:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbXLHSke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 13:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbXLHSkd
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 13:40:33 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:48019 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbXLHSkd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 13:40:33 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1J14bH-0007jz-Un
	for git@vger.kernel.org; Sat, 08 Dec 2007 19:40:32 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67563>

>From an earlier discussion here on the mailing list I had the
impression that there was some support for merging submodules from the
supermodule. This does not seem to be the case, but I think it would
be very good if this WAS possible?

Here is the shortest example that still mimics "real" work that shows
the problem. Assume change1 and change2 are done by two different
people in two different repositories and push this into separate
branches in a central repo somewhere. A maintainer at the central
repo wants to merge in one or both changes:


# Create directory and some repos with a simple README
rm -rf submodule-test
mkdir submodule-test
cd submodule-test
( mkdir super-module; cd super-module; git init )
( mkdir sub-module; cd sub-module; git init )

cd super-module
echo 'this is the super module' > README
git add README
git commit -m 'added a readme'

cd ../sub-module
echo 'this is the sub module' > README
git add README
git commit -m 'added a readme'
cd ..

# Make a testdir, clone the master repo, and add
# the sub-module
mkdir testdir
cd testdir
git clone `pwd`/../super-module
cd super-module
git submodule add `pwd`/../../sub-module
git commit -m 'added the submodule'

# make change1 on a branch in both super and sub module
git checkout -b change1 
cd sub-module/
git checkout -b sub-change1
echo 'This is change1' > change1
git add change1
git commit -m 'added change1 file'
cd ..
git add sub-module
git commit -m 'did change1 in change1 branch'

# Make change2 on a branch in both super and sub module
git checkout -b change2 master
git submodule update
cd sub-module/
git checkout -b sub-change2
echo 'this is change2' > change2
git add change2
git commit -m 'added change2 file'
cd ..
git add sub-module
git commit -m 'did the change2 change'

# Try to merge change1 and change2
git checkout -b mergetest master
git submodule update
git merge change1
git merge change2 



This fails with the somewhat obscure error message:
fatal: cannot merge modes?
Merge with strategy recursive failed.

- Finn Arne
