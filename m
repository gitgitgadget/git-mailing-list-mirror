From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-clone: add --track <headname> support
Date: Thu, 12 Apr 2007 20:50:35 -0700
Message-ID: <7vps69gcfo.fsf@assigned-by-dhcp.cox.net>
References: <1176372539871-git-send-email-martin@catalyst.net.nz>
	<87veg1tuuv.wl%cworth@cworth.org> <461EA8C5.1070503@catalyst.net.nz>
	<87slb5tbvu.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org,
	junkio@cox.net
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 05:50:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcCoJ-0007lM-Lq
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 05:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbXDMDuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 23:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbXDMDuh
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 23:50:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:65144 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbXDMDug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 23:50:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413035037.RIWO1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Apr 2007 23:50:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id mTqb1W00U1kojtg0000000; Thu, 12 Apr 2007 23:50:36 -0400
In-Reply-To: <87slb5tbvu.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	12 Apr 2007 16:24:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44378>

Carl Worth <cworth@cworth.org> writes:

> I'd love to get that down to:
>
> 	git clone <something with <repo> and <branch>>
> 	cd <project>
> 	git pull # as needed
>
> and then adding a subsequent branch to track would be:
>
> 	git track <something with <repo> and <branch>>
> 	git checkout <branch>
> 	git pull # as needed

I have a different suggestion.  Why not forget about 'git clone'?

After working in a clone of git.git, if you want to use the
project history from another related repository, say Shawn's
fastimport, what would you do?

Yes.  You add it with "git remote add".

	git remote add [options] gfi git://repo.or.cz/git/fastimport.git/

If you are _not_ working off of anybody else's work, how would
you start a repository?

Yes, you just do "git init" in an empty repository.

	git init

And after that, in such a repository, certainly "git remote add"
to add the FIRST remote would work, wouldn't it?

So, how about this two-command sequence instead?

 (0) Have this in $HOME/.gitconfig:

	$ cat >>$HOME/.gitconfig <<\EOF
	[branch]
        	autosetupmerge
	EOF

 (1) Prepare your working area and add the remote you want to
     track, with initial fetch:

        $ git remote add -f origin git://repo.or.cz/alt-git.git/

 (2) If you want to fork off of next, you can:

	$ git checkout -b next origin/next

The result of (2) reads like this:

	$ cat .git/config
        [remote "origin"]
                url = /opt/packrat/playpen/public/in-place/git/git.junio/
                fetch = +refs/heads/*:refs/remotes/origin/*
        [branch "next"]
                remote = origin
                merge = refs/heads/next

The [remote "origin"] section was added with (1), and [branch
"next"] was done with (2).  It means "When I am on 'next', if I
did not give any parameter to 'git pull', I want a fetch from
'origin', and then get their 'next' branch merged.".

So after setting up your 'next' branch with a single command (2),
when you are finished working in your 'next' and are ready to
merge the corresponding 'next' branch of 'origin', you can just
say 'git pull'.  Isn't this what you want?

And I do not think trying to mix up (1) and (2) is a great idea.
Whenever you are interested in yet another person's work, you do
(1).  And whenever you want to fork off of some remote tracking
branch you have already done (1) for, you do (2).  IOW, you can
do more than one (2) for a single remote repository.
