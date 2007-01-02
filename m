From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 2 Jan 2007 20:59:01 +0100
Message-ID: <20070102205901.3f4a9f1e.froese@gmx.de>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 20:59:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pn1-0000uK-Mn
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbXABT7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbXABT7J
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:59:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:35960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754911AbXABT7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:59:08 -0500
Received: (qmail invoked by alias); 02 Jan 2007 19:59:05 -0000
Received: from p50900A82.dip0.t-ipconnect.de (EHLO dialup) [80.144.10.130]
  by mail.gmx.net (mp001) with SMTP; 02 Jan 2007 20:59:05 +0100
X-Authenticated: #271361
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35808>

[Note: casual git-user speaking]

Junio C Hamano wrote:
>
> This allows "git checkout -d v1.4.3" to detach the HEAD from any
> branch but point directly at the named commit.  After this, "git
> branch" starts reporting that you are not on any branch.

Nice.  But why -d?  Create more confusion? [1]

> You can go back the normal state by switching to an existing
> branch, say, "git checkout master" for example.

This is fine.  Often you want to test a couple of tags, one
after another, so "git checkout v1", "git checkout v2", ...
should work.

> Another way to get out of this is "git checkout -b newbranch".

Wth should this do?  I already noticed this line in your posting
from 29.Dec: [slightly edited]

	$ git checkout v1.5.0
	Checking out a tag -- you are not on any branch now...
	$ <modify>
	$ git commit -m 'fix' -a
	You cannot commit without a current branch.
	$ git checkout -b maint-1.5.0
	$ git commit -m 'fix' -a

I assume it will create a new branch and modify HEAD so that
the current working dir/index gets committed into that branch.
(Basically "git branch main-1.5.0 &&
            echo 'ref: refs/head/main-1.5.0' >.git/HEAD")
If that's the case, I was looking for that incantation for
a long time and couldn't find it.  I'm using the git-branch
and echo as shown above to get that.  The man-page isn't
very helpful for that special case of git-checkout.

Anyway, if I want to commit and git tells me that I can't
because I'm not on a branch, the _most unintuitive_ thing
would be calling 'git-checkout'.  I want to checkin!  No
way that I call checkout and risk losing all my changes.

What's wrong with a -b option to commit, similar to -b on
checkout?

	$ git checkout v1.5.0
	Checking out a tag -- you are not on any branch now...
	$ <modify>
	$ git commit -m 'fix' -a
	You cannot commit without a current branch.
	Give '-b <newbranch>' to commit into a new branch. 
	$ git commit -b maint-1.5.0 -m 'fix' -a

Another variant (the one I prefer): commit just updates HEAD and
git-branch can be used to give it a name (and switch to it!).
So these workflows would be possible:

Name after commit:

	$ git checkout v1.5.0
	Checking out a tag -- you are not on any branch now...
	$ git branch
	  master
	* (unnamed) c8ff51290518949225c832bae1e22b1bba6ab2cd
	$ <modify>
	$ git commit -m 'fix' -a
	Warning: data committed into unnamed branch.
	Give it a name now with "git branch <newname>"
	$ git branch
	  master
	* (unnamed) 13482f25863e5380cdd41065338e1709d469a605
	$ git branch maint-1.5.0
	$ git branch
	  master
	* main-1.5.0

or name before commit:

	$ git checkout v1.5.0
	Checking out a tag -- you are not on any branch now...
	$ <modify>
	$ git branch
	  master
	* (unnamed) c8ff51290518949225c832bae1e22b1bba6ab2cd
	$ git branch maint-1.5.0
	$ git branch
	  master
	* maint-1.5.0
	$ git commit -m 'fix' -a

Yes, 'git branch <newname>' would get a new semantic:
if no start-point is given the newname will become the
new current branch.

[Btw, I would even do that when we are on some branch. How
often did I do a checkout of a regular branch and only later
noticed, that I want to commit changes into a temp-branch:

	$ git checkout master
	$ <play around, fix compile issues, add debug stuff>
	$ git branch debug
	$ git branch
	  master
	* debug
	$ git commit -a -m "Add foo debugging code"
]

But that special case is IMHO (M = my, a casual user's) much
better than some weird checkout-incantations.

Ciao, ET.


[1] My pet-peeve:

	$ git checkout foo
	fatal: Entry 'bar' not uptodate. Cannot merge.

    What the heck?  Nobody asked for a merge!?!?!  What
    is it trying to do?  Does it actually mean:

	fatal: Working dir is dirty.  Either give '-f'
	to force the checkout and lose your changes, or
	give '-m' to merge 'foo' and your changes.

   ?  But then, why does an 'rm bar' fixes that?  Now 'bar'
   definitely isn't "uptodate".
