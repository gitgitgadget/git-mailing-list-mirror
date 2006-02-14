From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 09:05:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
References: <43F20532.5000609@iaglans.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 18:08:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F93cD-0007IW-Pj
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 18:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422678AbWBNRFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 12:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWBNRFX
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 12:05:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422678AbWBNRFW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 12:05:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1EH5HDZ018593
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 09:05:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1EH5Gt9016899;
	Tue, 14 Feb 2006 09:05:16 -0800
To: "Nicolas Vilz 'niv'" <niv@iaglans.de>
In-Reply-To: <43F20532.5000609@iaglans.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16141>



On Tue, 14 Feb 2006, Nicolas Vilz 'niv' wrote:
> 
> i wonder, how i revoke a straight forward merge of two trees... I
> actually wanted to be look like somewhere in the git-repository, where
> some branches are merged back with the master tree, but i think, that
> wasn't "cg-merge -c <tree to merge with the actual one>"...
> 
> my result was that my master tree has now the same sha1-sum as my
> development-tree and gitk visualisation differs from that what i saw in
> the git-repository. (Several Arrows headed into back into one line...)
> 
> maybe that was because i didn't do anything in my master tree in the
> meantime.
> 
> And another thing, is there no posibility to get back to some commits or
> tags? I realized you can rebranch tags... what, if i want to switch back
> to git version 1.1.6 in the git repository? Or a certain commit?

Both of these can be solved with "git reset".

Before going into any more detail on that, let's go over the other related 
"basic operations" too:

 - "git branch". This creates a new branch of development at an arbitrary 
   point (that defaults to "current state").

   Example:

	git branch development-trial v1.1.6

   This will create a new branch called "development-trial", which starts 
   at the v1.1.6 state. NOTE! It will _not_ check it out - your old active 
   state is left totally alone, and you still stay on whatever branch you 
   used to be on.

 - "git checkout". This switches to another branch. As a shorthand, you 
   can also choose to create the branch at the same time, but normally 
   you'd just do like this example:

	git checkout development-trial

   which will switch to the branch you just created and check that out.

 - "git reset". This will reset the current branch state to something 
   else. This is what you would use if you want to undo a commit, 
   for example: you can "reset" the current branch to before the commit 
   happened.

   NOTE! When you do this, you also have to choose what you want to do 
   about your checked-out working tree. For example, when undoing the last 
   commit, you normally want to totally undo all the working tree changes 
   too, but you might also want to just undo the commit, and leave the 
   actual changes you committed alone, so that you can re-commit them with 
   a fixed commit message, for example.

   Example:

	git reset --hard HEAD^

   this will undo the last commit (more exactly: it will select the first 
   parent of HEAD to be the new top-of-development, so if the last thing 
   you did was a merge, it will reset to the previous state). The "--hard" 
   means that you want to reset the working tree too.

   Other example:

	git reset --hard v1.1.6

   This will just reset the current branch to a particular known state (ie 
   1.1.6 in this case).

   Without the "--hard", it will _not_ change the working tree, but just 
   update the index (and branch pointer, of course) to the new state, and 
   tell you which files are "dirty" in that new state. This is great for 
   undoing just a "git commit", but leaving the tree in the state is was 
   before you committed. It's not so great if you expected to revert 
   everything, and are now confused because "git diff" shows lots of 
   changes ;)

Finally, let's go over the difference between "git fetch" and "git pull":

 - "git fetch" is what you want to do if you want to _update_ another 
   branch. For example, if you want to track what Junio is doing in his 
   git repository (assuming that was what you cloned for), doing

	git fetch origin

   will update the "origin" branch, but will _not_ touch the current 
   branch itself. This is very useful for seeing what Junio has been 
   doing, without actually affecting your own work in any way.

 - "git pull" is really just "git fetch" + "git merge". It will fetch the 
   state you asked for, and then merge that into your current branch. So 
   it's important to rmember that this actually _changes_ what you have 
   checked out and have worked on. 

   One very special case of "git pull" is when you only use the repository 
   to track another branch, and you never do any changes at all, and you 
   never switch branches around, and you always pull from the same source. 
   In that case, "git pull" will basically boil down to just a read-only 
   tracking mechanism (ie you could think of this particular usage as 
   being the git equivalent of "anoncvs" access)

The reason people may get confused is that they start out using "git pull" 
as a read-only tracking mechanism, and it's not necessarily obvious that 
"git pull" really fundamentally is a very powerful operations - much MUCH 
more complex and powerful than just "track that other branch". Which is 
why I try to make the distinction between "git fetch" and "git pull" 
clear.

			Linus
