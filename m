From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-tree
Date: Mon, 7 Nov 2005 18:33:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511071819510.3247@g5.osdl.org>
References: <20051108021232.GB10835@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 03:35:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZJJQ-0003KJ-Az
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 03:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965683AbVKHCeG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 21:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965678AbVKHCeB
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 21:34:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965674AbVKHCd5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 21:33:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA82XcnO006518
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 7 Nov 2005 18:33:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA82XUhZ013068;
	Mon, 7 Nov 2005 18:33:35 -0800
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20051108021232.GB10835@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11303>



On Mon, 7 Nov 2005, Dave Jones wrote:
>
> Can someone remind me what the deprecated git-rev-tree command did,
> or how this should be fixed up to use newer git commands?

It was basically the same as "git-rev-list", except:

 - it output the date (as a raw number) in front, so pretty much everybody 
   ended up using "cut" to remove it, sometimes after sorting the output 
   numerically.

   Sorting numerically is unnecessary with git-rev-list, since the output 
   is already sorted (not necessarily exactly by date, but by "recency" 
   and/or by other even stricter sorting rules)

 - it was limited to a certain number of heads maximum (I forget, but I 
   think it was 16).

 - it parsed the whole tree before outputting anything.

> I'm trying to get git-changes-script working, but all the
> variants I've found on the web use this deprecated tool.

The git-changes-script was pretty broken.

You're _much_ better off doing it by:

 - fetch the "remote" branch into the local repository. The 
   "git-changes-script" thing required that you fetch the remote branch 
   into _another_ repository, but still local. These days, just use a 
   local branch in the same repo.

   So, for example, tracking my tree

	export KERNEL=master.kernel.org:/pub/scm/linux/kernel/git/
	git fetch $KERNEL/torvalds/linux-2.6 master:linus

   which will just fetch my "master" branch into the local "linus" branch.

 - then just do

	git log linus..HEAD

   and you'll see exactly what you wanted: what exists in your HEAD but 
   not in mine.

No complex script required.

Now, I've told some people that the diffstat is just the same (ie using a 
simple "git diff linus..HEAD | git-apply --stat") but that was because 
I've been muching some really awesomely bad 'shrooms. Clearly that doesn't 
work well at all, since it will show all the stuff I have in my branch 
reversed (since your head doesn't have it). 

The way to get a diff is really to do a merge, and throw the merge away 
after creating the diff. Ie something like this should work:

	git checkout -b merge-branch
	git merge "dummy merge" master linus &&
		git-diff linus.. | git-apply --stat
	git checkout -f master
	git branch -D merge-branch

which will also tell you if the merge failed (in which case you might not 
want to send me a "please pull", but instead try the merge locally and fix 
it up, and then try again)

All of the above is obviously totally untested.

		Linus
