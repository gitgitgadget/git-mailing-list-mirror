From: Matthew Gwynne <mathew.gwynne@gmail.com>
Subject: Issues with envelopesender and empty log messages using
	contrib/hooks/post-receive-email
Date: Mon, 20 Aug 2007 23:53:23 +0100
Message-ID: <20070820225323.GA25430@ares>
References: <20070819081847.GA6166@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 00:59:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INGDP-0004Y9-7J
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 00:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbXHTW7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 18:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbXHTW7N
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 18:59:13 -0400
Received: from queueout03-winn.ispmail.ntl.com ([81.103.221.33]:39440 "EHLO
	queueout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751785AbXHTW7M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2007 18:59:12 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20070820225344.KPFD4.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Mon, 20 Aug 2007 23:53:44 +0100
Received: from aeternus.no-ip.org ([82.16.168.8])
          by aamtaout04-winn.ispmail.ntl.com with ESMTP
          id <20070820225344.TYCR29112.aamtaout04-winn.ispmail.ntl.com@aeternus.no-ip.org>
          for <git@vger.kernel.org>; Mon, 20 Aug 2007 23:53:44 +0100
Received: by aeternus.no-ip.org (Postfix, from userid 1000)
	id 04F9784834D; Mon, 20 Aug 2007 23:53:24 +0100 (BST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070819081847.GA6166@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56266>

I've recently encountered 2 problems with use of the example
post-receive-mail script in contrib/hooks/post-receive-email.

Firstly I found that having set hooks.envelopesender, the script ended
up sending mail with the envelope sender set to the email address
given literally surrounded by single quotes which caused the mail
server to complain about invalid address syntax.

The offending lines appears to be - 

if [ -n "$envelopesender" ]; then
   envelopesender="-f '$envelopesender'"
fi

which when replaced with 

if [ -n "$envelopesender" ]; then
   envelopesender="-f \"$envelopesender\""
fi

have the desired effect of the script using the unaltered envelope
sender when sending mail as set in hooks.envelopesender. I have
attached a diff to this effect.

The second problem is that when using a branch that is derived from
master, has some differences, but regularly has master merged into it
to keep it up to date. If one makes some changes to master, merges
these into the other branch, then pushes these to the repository with
the mail hook, the email regarding the changes to master has an empty
log message.

The relevant lines seem to be in generate_update_branch_email(), line
380 - 

git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
git rev-list --pretty --stdin $oldrev..$newrev

I understand git-rev-parse will return the negation of the heads of
boths branches (master and the other branch) and then the master
branch negation is grep outed. However that leaves essentially the
command - 

git rev-list --pretty --stdin $oldrev..$newrev ^$otherbranchhead

which when $oldrev and $newrev are in the other branch as well seems
to result in an empty list / no result as nothing before
$otherbranchhead should be shown, and $oldrev and $newrev are both
before $otherbranchhead in the stated case but have never been shown
in any mails.

Steps to reproduce :

1) Create a repository (repo1) with just the master branch and make
some commits.  
2) Copy contrib/hooks/post-receive-email to [.git/]hooks/post-receive
and chmod +x it.  
3) Create a branch (testbranch) in repo1 
4) Clone repo1 creating repo2 
5) Checkout repo1/testbranch in repo2 
6) Make some commits to testbranch in repo2 
7) Push from repo2 to repo1 
8) Make some commits in repo2/master 
9) Merge repo2/master into repo2/testbranch 
10) Push repo2 to repo1 
11) Notice an empty log message for the mail detailing changes to
master.

If I have misunderstood some key concepts rather than there being bugs
here, I apologise in advance, and would just like to know what stupid
thing I've done :) 

Matthew Gwynne

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index c589a39..a733d0c 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -608,7 +608,7 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 	PAGER= generate_email $2 $3 $1
 else
 	if [ -n "$envelopesender" ]; then
-		envelopesender="-f '$envelopesender'"
+		envelopesender="-f \"$envelopesender\""
 	fi
 
 	while read oldrev newrev refname
