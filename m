From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Sun, 31 Dec 2006 16:35:41 -0800
Message-ID: <7vd55zd1nm.fsf@assigned-by-dhcp.cox.net>
References: <11676088584199-git-send-email-bfields@fieldses.org>
	<1167608858759-git-send-email-bfields@fieldses.org>
	<11676088582634-git-send-email-bfields@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 01:35:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1B9i-0002Gg-Ke
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 01:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbXAAAfq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 19:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755138AbXAAAfq
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 19:35:46 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:36461 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbXAAAfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 19:35:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070101003542.LZCN18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 19:35:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5cav1W00S1kojtg0000000; Sun, 31 Dec 2006 19:34:56 -0500
To: bfields@fieldses.org
In-Reply-To: <11676088582634-git-send-email-bfields@fieldses.org>
	(bfields@fieldses.org's message of "Sun, 31 Dec 2006 18:47:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35716>

bfields@fieldses.org writes:

>  git pull, git pull origin::
> -	Fetch the default head from the repository you cloned
> -	from and merge it into your current branch.
> +	Update the remote tracking brances for the repository
> +	you cloned from, then merge one of them into your
> +	current branch.  Normally the branch merged in is
> +	the HEAD of the remote repository, when your master
> +	branch is checked out.  When on another branch,
> +	the (alphabetically) first branch from the remote
> +	repository is merged in.  These defaults can be modified
> +	using the branch and remote sections of the repository
> +	configuration; see gitlink:git-repo-config[1] for details.

I think documenting this is wrong.  At least we should say "do
not be lazy and say 'git pull' or 'git pull origin' without
configuring what branch you are interested in when on a branch
you created yourself".  Later, people can supply patches to make
that configuration easier.

When the user says "pull origin" while on another branch that
does not have branch.$that_branch.merge properly configured, it
happens to find the first remote branch -- which unfortunately
comes from the wildcard remote.origin.fetch created by clone to
say "track all remote branches".

What we wanted to do ideally was to forbid "git pull" that does
not have explicit refspec from the command line, without
configuring branch.*.merge.  However this broke established
workflow of people who has remote.$origin.fetch configured to
list the remote branch to fetch explicitly; the merged branch
selection has always been "the first set of branches listed in
the configuration" and these peoples had their configuration
right without needing to have branch.*.merge at all.

Unfortunately git is too flexible around this area.  

We probably could somehow arrante the remote branches that came
from wildcarding not subject to the merge branch selection
logic, but honestly I am tired of looking at that code for now.

An acceptable short-term workaround might be to revert the
effect of commit 3dd3d5b0.
