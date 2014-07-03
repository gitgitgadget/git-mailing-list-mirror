From: Ted Felix <ted@tedfelix.com>
Subject: [BUG] rebase no longer omits local commits
Date: Thu, 03 Jul 2014 11:14:26 -0400
Message-ID: <53B57352.50202@tedfelix.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070106030909030700090702"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 17:20:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2ioR-0006P1-Cy
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 17:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758407AbaGCPUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 11:20:34 -0400
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:35256
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756065AbaGCPUd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2014 11:20:33 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jul 2014 11:20:33 EDT
Received: from omta23.westchester.pa.mail.comcast.net ([76.96.62.74])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id Mo8C1o0061c6gX85BrET26; Thu, 03 Jul 2014 15:14:27 +0000
Received: from [192.168.1.105] ([76.100.236.26])
	by omta23.westchester.pa.mail.comcast.net with comcast
	id MrES1o01G0arC9o3jrETUM; Thu, 03 Jul 2014 15:14:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1404400467;
	bh=8YcIvdzFl1g+NvrLJol3kUIAi9o5ZY+k06CKSuZfVWE=;
	h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
	 Content-Type;
	b=UbMcOkhXy4pmSZK3D2tGHB7wt62lTphfzsNEHPToX6Tt8E8lEh/khaUYoUYbeHsLV
	 iT9mpCXC5w+qyYqdDIsgnjxkXpI+sCjYGjFE4OTW9L+LuSiF/a2OxDkyj+ghVHBLrt
	 wEjNqxj3ZItINvLmxqQzWAQZl10FVOlMV84d/CbSP9V1fJLYjfwPndGBfBQaw3evU6
	 bQbZiurBAJeP7l4mgXPcvi82nd/9fAolFiGNhWnVEW4RuVJVkxKNyGVzQrx93gz0LP
	 9JCFBw9p0xIYAcAd7afBQKJnmGOuCoR19E6x4UV/csTLGjubh6Y8IAb+2iLcQo+ngh
	 bI95NVve+lmDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252866>

This is a multi-part message in MIME format.
--------------070106030909030700090702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Starting with git 1.9.0, rebase no longer omits local commits that 
appear in both the upstream and local branches.

I've bisected this down to commit bb3f458: "rebase: fix fork-point with 
zero arguments".  The attached script reproduces the problem.  Reverting 
the aforementioned commit fixes the problem.

A failed run of this script will result in conflicts.  A successful run 
against master with bb3f458 reverted ends as follows:

 From /tmp/rebase-issue/maint
    fe401cd..955af04  master     -> origin/master
fatal: Not a valid object name: ''
First, rewinding head to replay your work on top of it...
Applying: Third change

(I'm not sure if that "fatal: Not a valid object name: ''" is of any 
concern.  It started appearing for me at some point during the bisect.)

Let me know if there's more I can do to help.


--------------070106030909030700090702
Content-Type: text/x-shellscript;
 name="rebase-issue.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rebase-issue.sh"

#!/bin/bash

# git-rebase is supposed to drop commits that it finds in both the 
# local and upstream branches.  As of 1.9.0, this isn't happening.
# This script reproduces the problem.

# I've bisected the issue down to commit bb3f458.  Reverting that commit
# solves the problem.

# Run this in a directory where you have create privs.
# At the end, if there are conflicts, then the test has failed.

# Create a repo.
mkdir rebase-issue
cd rebase-issue
mkdir maint
cd maint
git init

# Create a README file and put some text in it
echo "Hi there!" >README
git add README
git commit -a -m "Initial commit"

# Clone the repo for "dev"
cd ..
git clone maint dev

# Dev makes *two* changes to the *same* area.
cd dev
# edit something, make some typos
echo "Freekwently Mispeled Werdz" >README
git commit -a -m "First change"
# edit same thing, fix those typos
echo "Frequently Misspelled Words" >README
git commit -a -m "Second change"

# Create patches to send to maintainer...
git format-patch -M origin/master
mv *.patch ../maint

# Add a third change that should make it through for completeness.
echo "Frequently Misspelled Words version 2" >README
git commit -a -m "Third change"

# We have to sleep (to make sure the times do not match?).
# If we don't, this script will succeed on fast machines.
# This can probably be reduced to 2 which should guarantee that
# the seconds will turn over on the clock.
echo
echo "Waiting 5 seconds to make sure apply time is different from patch time..."
sleep 5

echo
echo "Maint applies patches..."
cd ../maint
git am -3 *.patch

echo
echo "Dev does the fetch/rebase..."
cd ../dev
git fetch
git rebase

echo
git --version


--------------070106030909030700090702--
