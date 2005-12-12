From: Junio C Hamano <junkio@cox.net>
Subject: Re: branching and supporting a tagged kernel version
Date: Mon, 12 Dec 2005 14:37:22 -0800
Message-ID: <7virtueycd.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512121331x13bfb691t62224d02ced04a27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 23:40:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElwIS-0001uo-DI
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 23:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVLLWhZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 17:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVLLWhY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 17:37:24 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:63730 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932201AbVLLWhY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 17:37:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051212223601.NJPY17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 17:36:01 -0500
To: Don Zickus <dzickus@gmail.com>
In-Reply-To: <68948ca0512121331x13bfb691t62224d02ced04a27@mail.gmail.com> (Don
	Zickus's message of "Mon, 12 Dec 2005 16:31:08 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13545>

Don Zickus <dzickus@gmail.com> writes:

> So my questions (for now) are:
>
> 1) what is the easiest way to branch off on a tagged version (in this
> case 2.6.14)?  I didn't quite understand what <starting point>
> referred to in the git-branch docs.

Starting point is badly worded, but essentially it means
"anything that names a particular commit".  That's the commit
you want to base your branch off of.

In your case, you would run:

------------
$ git clone git://git.kernel.org/pub/.../torvalds/linux-2.6/ my2.6
$ cd my2.6
$ git checkout -b private v2.6.14
------------

to create and checkout a branch called "private" to house your
personal changes, based on v2.6.14.  Your working tree is based
on v2.6.14 and you are on the "private" branch immediately after
this operation, and you should see no diff from either of these
commands:

------------
$ git diff v2.6.14 <1>
$ git diff private v2.6.14 <2>

<1> compare your work tree with v2.6.14 tagged by Linus
<2> compare "private" branch head with v2.6.14 tagged by Linus
------------

Then work as usual, the cycle is:

------------
$ edit
$ git diff ;# to see how well you are doing
$ compile
$ test
$ git diff HEAD ;# final review before committing
$ git commit -a ;# commit all changes as you tested
------------

> 2) is there a way to get a list of commits from upstream that are not
> in my branch and then selectively apply them?  Yes, I understand the
> potential merge mess...

I'll refrain from saying that it is not the usual way to work
with git, since you seem to know what you are doing.  So let's
assume that you somehow do not ever want to merge from Linus
head into the "private" branch.

After you have worked there:

------------
$ git fetch origin
$ git cherry origin private
------------

would show the list of commits since you forked from origin, 
which is Linus head --- when you run "git clone" to set up
"my2.6" repository, it would have made .git/remotes/origin
shorthand that has this line in it:

------------
URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
Pull: master:origin
------------

pick the ones you want, and apply them with:

------------
$ git cherry-pick 12233445....
------------
