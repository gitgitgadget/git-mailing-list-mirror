From: Junio C Hamano <junkio@cox.net>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Fri, 23 Sep 2005 23:19:01 -0700
Message-ID: <7virwr2dka.fsf@assigned-by-dhcp.cox.net>
References: <E1EIVsD-0001Hu-9m@jdl.com> <20050922191058.GM21019@pasky.or.cz>
	<34462.10.10.10.28.1127417134.squirrel@linux1>
	<20050923091012.GA10255@pasky.or.cz>
	<7vslvwcelj.fsf@assigned-by-dhcp.cox.net>
	<20050923095742.GC10255@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 08:19:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJ3NZ-00070p-VX
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 08:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVIXGTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 02:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVIXGTG
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 02:19:06 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:30911 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751441AbVIXGTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 02:19:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050924061904.LOJS13739.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Sep 2005 02:19:04 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050923095742.GC10255@pasky.or.cz> (Petr Baudis's message of
	"Fri, 23 Sep 2005 11:57:42 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9229>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Fri, Sep 23, 2005 at 11:34:16AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> told me that...
>> Petr Baudis <pasky@suse.cz> writes:
>> 
>> > 	* cg-fetch can do with symlinked object database
>> 
>> Do you mean ".git/object" in the repository you are fetching
>> into is a symlink to somewhere, or something else?
>
> Yes, exactly that. You get it by doing cg-clone -l
> /local/path.

git-clone -l -s does optimization similar to that in spirit, but
it does not create a repository with symlinked .git/object
pointing at /some/where/original/repo/.git/object.  Instead it
uses alternates to borrow from the other; newly created objects
are always stored locally.

But I thought you were talking about fetch.  git-fetch should be
able to pull into a repository whose .git/object happens to be a
symlink pointing at somewhere else just fine.

> Just that if the reference pointer did not change, you don't try to pull
> any objects.

Both git-aware protocol and commit walker peek at the remote ref
and stop without downloading objects if it is known to us, so I
think we are OK.

>>     $ git-init-db && git fetch http://kernel.org/pub/scm/git/git.git
>> 
>> should work.
>
> Good.

Of course, the above 'git fetch' only fetches remote HEAD and
stores it in .git/FETCH_HEAD; if you truly want to 'clone', you
could first run git-ls-remote to peek the remote refs and then
give them as storing refspecs to git fetch, doing something like
this (modulo renaming 'master' over there to 'origin' here):

	mkdir foo && cd foo && git-init-db
	refspec=$(git-ls-remote $repo | \
	        sed -n -e 's/^[0-9a-f]*	//' -e 's|refs/.*|&:&|p')
	git fetch $repo $refspec
