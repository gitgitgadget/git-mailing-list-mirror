From: Andreas Ericsson <ae@op5.se>
Subject: Re: Why can't git-rebase back up?
Date: Fri, 17 Feb 2006 17:30:08 +0100
Message-ID: <43F5FA10.5020605@op5.se>
References: <20060217153434.26359.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 17:30:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA8Up-0005Gt-Hg
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 17:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030644AbWBQQaL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 11:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWBQQaL
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 11:30:11 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:61610 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030644AbWBQQaK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 11:30:10 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 2D0EB6BD06; Fri, 17 Feb 2006 17:30:09 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: linux@horizon.com
In-Reply-To: <20060217153434.26359.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16358>

linux@horizon.com wrote:
>>>[[ This is because core git won't allow the checked-out HEAD to point
>>>to anything but a branch,
> 
> 
>>Yes it will. That's how "git reset" works (i.e. pointing HEAD to some 
>>random object). Think of branches and tags as short and humanly 
>>understandable names for certain points in the history. You can visit 
>>any point in history without having a special short name for it.
> 
> 
> Er... say again?  git reset doesn't touch the .git/HEAD symlink;
> it overwrites the file that .git/HEAD points to.
> 

My bad. You're right.

> If you know a way to make the core git tools produce a .git/HEAD that
> is either not a symlink or does NOT begin with "refs/heads/", I'm quite
> curious.
> 

The order of precedence works as such:
.git/<anchor-name>
.git/refs/<anchor-name>
.git/refs/tags/<tag-name>
.git/refs/heads/<branch-name>
sha1, with git magic to allow abbreviations

This is why you can't sanely have a branch named HEAD.

> 
>>>and checking out something without having
>>>HEAD point to it is fragile and delicate.  Cogito lets you do this with
>>>cg-seek. ]]
> 
> 
>>It's more than delicate. It's impossible (even for Cogito). You can take 
>>snapshots of how the tree looked at a certain state and export that 
>>using git-tar-tree if you wish, but other than that it's impossible to 
>>visit a certain point in history without pointing HEAD to it (that's how 
>>visiting that point is done, actually).
> 
> 
> Actually, you're right... Cogito uses refs/heads/cg-seek-point.
> But you can do it by hand with git-read-tree and git-checkout-index.
> (Very little in git is impossible; some things are just a Really Bad
> Idea.)
> 
> 
>>Now, if I want to migrate to a newer base version, I can always use
>>git-reset --hard v2.6.16-rc3, but that's a bit dangerous.
>>Preferable is to use git-rebase v2.6.16-rc3, which will preserve
>>any local edits.
>>
>>(I could also do it as a merge, but that seems like unnecessary history
>>clutter.  It's not like local edits are common, anyway.)
>>
>>But suppose discover a nasty bug in -rc3 and want to move my build branch
>>back to -rc2.  "git-rebase v2.6.16-rc2" does nothing.  After a bit
>>of thought, I realize why, but sometime I do want to back up.
>>
> 
> 
>>I'd suggest doing something like this when changing base version (of any 
>>project, really).
> 
> 
> [Use separate branch names for the two build versions.]
> 
> That's certainly a possibility, but kind of annoying to remember what
> the "current" version is.  Typically, there are no local changes,
> and I'm just using "build" as a conventional name to let me check
> out the version.  Just like cg-seek-point.
> 

Then make the current production be 'build', the "soon-to-become 
production" to be 'devel' and tag the ones you're finished with so you 
can revert to them easily if it becomes necessary. That's more or less 
how all projects work, AFAIK.

> 
>>However, branches and tags are cheap to create, efficient to use, easy 
>>to remove once you're done with them. They make life easier. Use them. 
>>You'll be glad you did.
> 
> 
> I don't really *want* a branch at all.  I just want to export the
> right source tree and compile it.


$ git tar-tree v2.6.16-rc3 linux-2.6.16-rc3

OTOH, you could just download the released sources and patches from ftp.

>  Local changes are more likely a
> mistake than anything else, but core git doesn't have Cogito's "blocked"
> flag.  I'm just trying to avoid getting
> into the habit of typing "git reset --hard" a lot because that's
> dangerous.
> 

I don't see why you should have to, even if you don't use a topic-branch 
for fiddling with things. You can still do

	$ git tar-tree <tag> linux-<tag>

to get the snapshot no matter how much you reset and muck about with the 
working tree copy of the current HEAD.

If you're unsure about this, try

$ git checkout -b foo 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
$ gitk; # behold the dawn of time
$ git tar-tree v2.6.16-rc3 foo | gzip -9 > foo.tar.gz

Note that the first operation takes quite a while, as it has to update 
all the files in the working tree.

> It's sort of along the lines of "any workflow that makes you type
> 'rm -rf *' on a regular basis is a recipe for disaster".
> 
> The usual solution, of course, is to write a shell script wrapper with
> some safety checking.  For example, I could see if git-name-rev --tags
> can come up with a name for the branch head before unleashing git-reset
> on it.
> 
> But I thought I'd check if the tool already existed.
> 

It does, and it doesn't. git checkout -b <name> <commit-ish> does what 
you want, although it creates a branch. "git seek" isn't needed, since 
creating branches is so cheap and far better than having to protect 
certain branch- and tag-names for the sake of creating tools that offer 
less power and flexibility than those already there.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
