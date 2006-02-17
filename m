From: linux@horizon.com
Subject: Re: Why can't git-rebase back up?
Date: 17 Feb 2006 10:34:34 -0500
Message-ID: <20060217153434.26359.qmail@science.horizon.com>
References: <43F5DF8B.6050307@op5.se>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 16:34:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA7dF-0000G8-AO
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 16:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWBQPeg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 10:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWBQPef
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 10:34:35 -0500
Received: from science.horizon.com ([192.35.100.1]:36649 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751485AbWBQPef
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 10:34:35 -0500
Received: (qmail 26360 invoked by uid 1000); 17 Feb 2006 10:34:34 -0500
To: ae@op5.se, linux@horizon.com
In-Reply-To: <43F5DF8B.6050307@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16355>

>> [[ This is because core git won't allow the checked-out HEAD to point
>> to anything but a branch,

> Yes it will. That's how "git reset" works (i.e. pointing HEAD to some 
> random object). Think of branches and tags as short and humanly 
> understandable names for certain points in the history. You can visit 
> any point in history without having a special short name for it.

Er... say again?  git reset doesn't touch the .git/HEAD symlink;
it overwrites the file that .git/HEAD points to.

If you know a way to make the core git tools produce a .git/HEAD that
is either not a symlink or does NOT begin with "refs/heads/", I'm quite
curious.

>> and checking out something without having
>> HEAD point to it is fragile and delicate.  Cogito lets you do this with
>> cg-seek. ]]

> It's more than delicate. It's impossible (even for Cogito). You can take 
> snapshots of how the tree looked at a certain state and export that 
> using git-tar-tree if you wish, but other than that it's impossible to 
> visit a certain point in history without pointing HEAD to it (that's how 
> visiting that point is done, actually).

Actually, you're right... Cogito uses refs/heads/cg-seek-point.
But you can do it by hand with git-read-tree and git-checkout-index.
(Very little in git is impossible; some things are just a Really Bad
Idea.)

> Now, if I want to migrate to a newer base version, I can always use
> git-reset --hard v2.6.16-rc3, but that's a bit dangerous.
> Preferable is to use git-rebase v2.6.16-rc3, which will preserve
> any local edits.
> 
> (I could also do it as a merge, but that seems like unnecessary history
> clutter.  It's not like local edits are common, anyway.)
> 
> But suppose discover a nasty bug in -rc3 and want to move my build branch
> back to -rc2.  "git-rebase v2.6.16-rc2" does nothing.  After a bit
> of thought, I realize why, but sometime I do want to back up.
> 

> I'd suggest doing something like this when changing base version (of any 
> project, really).

[Use separate branch names for the two build versions.]

That's certainly a possibility, but kind of annoying to remember what
the "current" version is.  Typically, there are no local changes,
and I'm just using "build" as a conventional name to let me check
out the version.  Just like cg-seek-point.

> However, branches and tags are cheap to create, efficient to use, easy 
> to remove once you're done with them. They make life easier. Use them. 
> You'll be glad you did.

I don't really *want* a branch at all.  I just want to export the
right source tree and compile it.  Local changes are more likely a
mistake than anything else, but core git doesn't have Cogito's "blocked"
flag.  I'm just trying to avoid getting
into the habit of typing "git reset --hard" a lot because that's
dangerous.

It's sort of along the lines of "any workflow that makes you type
'rm -rf *' on a regular basis is a recipe for disaster".

The usual solution, of course, is to write a shell script wrapper with
some safety checking.  For example, I could see if git-name-rev --tags
can come up with a name for the branch head before unleashing git-reset
on it.

But I thought I'd check if the tool already existed.
