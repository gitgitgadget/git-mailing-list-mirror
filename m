From: Petr Baudis <pasky@suse.cz>
Subject: Re: History rewriting swiss army knife
Date: Sun, 26 Mar 2006 15:17:43 +0200
Message-ID: <20060326131743.GK18185@pasky.or.cz>
References: <20060324140831.GY18185@pasky.or.cz> <7vek0rzchc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 15:17:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNV7h-0003zt-03
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 15:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWCZNRd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 08:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWCZNRd
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 08:17:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:51344 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750802AbWCZNRd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 08:17:33 -0500
Received: (qmail 8299 invoked by uid 2001); 26 Mar 2006 15:17:43 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek0rzchc.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18039>

Dear diary, on Fri, Mar 24, 2006 at 11:47:43PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> >   It's never been so easy before - I've written cg-admin-rewritehist,
> > which will execute your filters for each commit (which can rewrite the
> > tree contents, just the tree itself through the index, committer/author
> > information and commit message) while the script will obviously preserve
> > all the other information like merges, author/committer information etc.
> 
> Hmph.  The above description sounds like you are not allowing
> the user's custom script to drop existing parent (or graft a new
> one) while rewriting.  I have not looked at how you are
> interfacing with user's custom script, but I sort-of expected
> you to throw a commit at it from older to newer (i.e. topo-order
> in reverse), along with the names of already re-written commit
> objects that are parents of taht commit, and have it build a
> rewritten commit and report its object name back to you.

There are rather several "filters" (user scripts) which are called at
various stages of the commit rewrite. In sum they are doing the same
thing as the single user script would, but cg-admin-rewritehist will
prepare some things to you so that everyone does not have to write the
common stuff again and again.

The net flexibility loss was zero, except two things:

* The parents list construction was hardcoded. Now I added a parent
  filter which gets the parent string on stdin (including the -p bits,
  but life's tough) and let it rewrite it (e.g. add stuff at the end).
  So to "etch a graft":

	cg-admin-rewritehist --parent-filter sed\ 's/^$/-p graftcommitid/' newbranch

  assuming single-root history; but you have current commit id in
  $GIT_COMMIT so you can go wild:

	cg-admin-rewritehist --parent-filter 'cat; [ "$GIT_COMMIT" = "COMMIT" ] && echo "-p GRAFTCOMMIT"' newbranch

* A new commit would be always created. Sometimes you might want to
  omit some commits. Now I added a commit filter which would be
  called instead of the git-commit-tree command.

  To remove commits authored by "Darl McBribe" from the history:

	cg-admin-rewritehist --commit-filter '
		if [ "$GIT_AUTHOR_NAME" = "Darl McBribe" ]; then
			shift
			while [ -n "$1" ]; do
				shift; echo "$1"; shift
			done
		else
			git-commit-tree "$@"
		fi' newbranch

  (note that this will handle even Darl's merges).

Thanks for the inspiration,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
