From: Nicolas Pitre <nico@cam.org>
Subject: Re: Dangers of working on a tracking branch
Date: Fri, 16 Feb 2007 11:34:01 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702161044100.18370@xanadu.home>
References: <17876.51013.561979.431717@lisa.zopyra.com>
 <Pine.LNX.4.64.0702151557410.1757@xanadu.home>
 <17876.52962.662946.582507@lisa.zopyra.com>
 <17876.53654.426022.454712@lisa.zopyra.com> <er333i$787$1@sea.gmane.org>
 <17877.51730.418633.750922@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 17:34:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI62D-0006e4-6T
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 17:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbXBPQeG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 11:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945990AbXBPQeF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 11:34:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20143 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945972AbXBPQeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 11:34:03 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDK005OPE0PHLI0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Feb 2007 11:34:02 -0500 (EST)
In-reply-to: <17877.51730.418633.750922@lisa.zopyra.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39926>

On Fri, 16 Feb 2007, Bill Lear wrote:

> Ok, I'm trying to come up with an experiment that verifies this, so
> I can give a concrete example to our developers.
> 
> I don't seem to be able to get it to fail, but I sure remember having
> severe problems with this in practice.

Try this:

	# create first repository
	mkdir foo
	cd foo
	git init-db
	echo FOO > biz
	git add biz
	git commit -a -m "commit 1 in foo"

	# clone this repository elsewhere
	cd ..
	git clone foo bar
	cd bar

	# modify the tracking branch (origin in this case)
	git checkout origin
	echo BAR > biz
	git commit -a -m "modify tracking branch in bar"

	# go back to original repo and modify it
	cd ../foo
	echo BAZ > biz
	git commit -a -m "modify master branch in foo"

	# now back to the cloned repo
	cd ../bar
	git fetch	# it fails
	git push	# itfails
	git pull	# it almost performs the merge but...

Because you now have a conflict to resolve, you might wish to inspect 
what the remote state actually is.  But because you modified your origin 
branch you don't have any pristine version of what the remote has, 
except maybe the MERGE_HEAD.  But if you work in a complex project, 
MERGE_HEAD will not stay there for long if you move around.

Imagine that you want to move to another branch, say master, because 
right now you don't feel like resolving this ultra complex merge:

	git checkout master	# it fails (unresolved merge)
	git checkout -f		# succeeds, discarding the merge

But at this point you still don't have any way to look at the remote's 
content.  If instead the origin branch was untouched and the work had 
occurred in the master branch, then you could git-log the origin branch, 
you could git-diff your master branch with the origin branch, you could 
even checkout the origin content to test it, etc.  But since you added 
commits on top of the origin branch then you cannot do any of that 
because it is impossible to update the origin branch with the remote 
stuff.  Well you can force it of course:

	git fetch -f

But by doing so you lose all the work you committed on top of origin.

BTW I checked out v1.4.4.1 to verify the above operations..... and this 
GIT version really feels odd compared to v1.5.0


Nicolas
