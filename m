From: Carl Baldwin <cnb@fc.hp.com>
Subject: [RFC] Using sticky directories to control access to branches.
Date: Thu, 17 Nov 2005 10:01:29 -0700
Organization: Hewlett Packard
Message-ID: <20051117170129.GA14013@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 17 18:02:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecn99-0007bC-QO
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 18:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVKQRBc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 12:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbVKQRBb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 12:01:31 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:1701 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932428AbVKQRBa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 12:01:30 -0500
Received: from smtp2.fc.hp.com (smtp2b.fc.hp.com [15.15.136.253])
	by atlrel9.hp.com (Postfix) with ESMTP id F101DC6CA
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 12:01:29 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP id B4F0541E42D
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 17:01:29 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id A3D0646E19; Thu, 17 Nov 2005 10:01:29 -0700 (MST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12133>

I had a thought this morning.  I wanted to use file permissions to
control access to push to a particular branch in a repository in order
to implement some sort of per-branch policy.  This assumes that there is
a repository setup into which multiple users can push.

My goals were to be able to...

a) allow only one user (or possibly one group) access to modify a
   branch.  Do this on per-branch basis.
b) Freeze tags so that they *cannot* be accidentally updated by a push.

My plan to accomplish this was to set the sticky bit (chmod +t) on the
refs/heads and refs/tags directories so that users couldn't bypass
file-permissions by replacing the file with their own.  Then grant write
permission to the owner (or possibly a group) to allow updates to that
branch.

I started testing this with git v0.99.9i and found that git push
actually creates a new file and replaces the old branch file with the
new one.  The consequence for me is that when I set the sticky bit on
the heads directory then all of the branches restrict access solely to
the owner of the file since only the owner will be able to replace it.
This precludes giving a group write access to the branch.  It also
precludes leaving most of the branches open to all users by default.

Now, git was probably designed to do this on purpose because it is the
safest way to update a branch in an automic way.  But, I wonder if there
is another way.  Maybe, git could make a temporary backup of the branch
doing something like this:

% cp refs/heads/master{,.$randomstring}
(on success, go ahead and edit refs/heads/master in place)
(on success, remove refs/heads/master.$randomstring

Something like this could still be pretty safe but would allow
per-branch access restrictions using unix file permissions.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
