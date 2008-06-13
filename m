From: Len Brown <lenb@kernel.org>
Subject: merge weirdness
Date: Fri, 13 Jun 2008 00:42:25 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806130028080.8340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 06:44:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K718g-0000Dt-3a
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 06:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760657AbYFMEml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 00:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbYFMEml
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 00:42:41 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:55241 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760499AbYFMEmk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 00:42:40 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2D00CDAX2RTYF4@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 12 Jun 2008 23:42:28 -0500 (CDT)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id m5D4gQ7q015339; Fri,
 13 Jun 2008 00:42:27 -0400
Received: from localhost (lenb@localhost)
	by localhost.localdomain (8.14.2/8.14.2/Submit) with ESMTP id m5D4gQr0015334;
 Fri, 13 Jun 2008 00:42:26 -0400
X-X-Sender: lenb@localhost.localdomain
X-Authentication-warning: localhost.localdomain: lenb owned process doing -bs
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I merged about a dozen small branches earlier this week and sent the batch 
to Linus, who pulled them upstream with 
da50ccc6a0f32ad29c1168837330a78e6e2e2923

I pulled Linus' tree and then went to compare which of my branches had 
made it upstream, and my topic branches "git.status" script (pasted 
below) said that none of them had!

Looking at Linus' history, it seems that my merge is gone.  Instead there 
is a series of patches that look like they've been cherry-picked -- same 
commit but different commit id.

I run the top-of-tree version of git.
Did something strange happen with git a few days ago in this department?

I still had my merge in command history so I checked out an old branch and 
did the same merge using today's git (git version 1.5.6.rc2.26.g8c37)
and gitk shows it as an octopus, as expected.

clues?

thanks,
-Len

---
#!/bin/bash
# report on status of my ia64 GIT tree
cd ~/src/acpi

gb=$(tput setab 2)
rb=$(tput setab 1)
restore=$(tput setab 9)

#if [ `git-rev-list release ^test | wc -c` -gt 0 ]
if [ `git rev-list test..release | wc -c` -gt 0 ]
then
	echo $rb Warning: commits in release that are not in test $restore
	git-whatchanged release ^test
fi

#for branch in `ls .git/refs/heads`
for branch in `git show-ref --heads | sed 's|^.*/||'`
do
	if [ $branch = linus -o $branch = test -o $branch = release ]
	then
		continue
	fi

	echo -n $gb ======= $branch ====== $restore " "
	status=
	for ref in test release linus
	do
		if [ `git-rev-list $branch ^$ref | wc -c` -gt 0 ]
		then
			status=$status${ref:0:1}
		fi
	done
	case $status in
	trl)
		echo $rb Need to pull into test $restore
		;;
	rl)
		echo "In test"
		;;
	l)
		echo "Waiting for linus"
		;;
	"")
		echo $rb All done $restore
		;;
	*)
		echo $rb "<$status>" $restore
		;;
	esac
#	git-whatchanged $branch ^linus | git-shortlog | cat
	git log linus..$branch | git shortlog | cat
done
