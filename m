From: Graham Perks <gperks@ausperks.net>
Subject: Am able to delete a file with no trace in the log
Date: Tue, 2 Jun 2009 14:33:14 -0500
Message-ID: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 21:56:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBa65-0001HM-BS
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 21:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbZFBT4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 15:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbZFBT4Y
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 15:56:24 -0400
Received: from web.server.MX.relay.75.127.110.30-static.reverse.yourdnshost.com ([75.127.110.30]:50165 "EHLO www30.yourdnshost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750871AbZFBT4Y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 15:56:24 -0400
X-Greylist: delayed 1390 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2009 15:56:24 EDT
Received: from cpe-66-25-148-19.austin.res.rr.com ([66.25.148.19]:48255 helo=[192.168.0.10])
	by www30.yourdnshost.com with esmtp (Exim 4.67)
	(envelope-from <gperks@ausperks.net>)
	id 1MBZjX-0003NY-Qp
	for git@vger.kernel.org; Tue, 02 Jun 2009 15:33:16 -0400
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120538>

We just had this come up. A file was accidentally removed during a  
merge operation, and we could find no clue in the gitk and git log  
output as to which change the deletion occurred in. We found the  
original file addition in a change; but no other mention of this file.

This seems like a bug. The log should show the file being deleted.

This is pretty easy to reproduce. Just run the script below. Here,  
pretend "c" is the central repo to which two users are pushing/ 
pulling. The users are using repositories r1 and r2.

# create and init repos
md r1
md r2
md c
cd c
git init --bare
cd ..
cd r1 && git init && cd ..
cd r2 && git init && cd ..

# create a file to conflict later
cd r1
echo hello > a.txt
git add .
git commit -m "add file"
git push ../c master

# sync other repo
cd ../r2
git pull ../c

# make conflicting change
echo helloworld > a.txt
git commit -a -m "change file in r2"

# and add a file
echo bye > b.txt
git add .
git commit -m "add file b"
git push ../c

# Meanwhile, r1 has been working
cd ../r1
echo hellogit > a.txt
git commit -a -m "change file in r1"
git pull ../c

# edit a.txt to resolve merge
vi a.txt

# User in r1 erroneously thinks "ooh, I didn't edit b.txt, I don't  
want that in my commit!"
# This is especially easy to do in git gui. That's what our user did.
# Or, the user could legitimately remove the file as part of the  
merge. Probably
# they should git rm, but our user didn't.
git reset HEAD b.txt

# But he thinks, "I did merge a.txt"
git add a.txt
git commit -m "Merged"
git push ../c


# Now user in r2 wants to pull r1's changes
cd ../r2
git pull ../c

# File b.txt deleted! Woah! How did that happen?
# gitk and git log show nothing about the deletion.
# There seems to be no evidence about who, how, why, or when the file  
got deleted.
# So it's hard to track down which user mis-used the system and  
educate them.

Cheers,
Graham Perks.
