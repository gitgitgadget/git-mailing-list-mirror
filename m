From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-ancestor read-tree notes
Date: Tue, 06 Sep 2005 14:53:17 -0700
Message-ID: <7vslwhg8xe.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
	<7virxeycod.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509061228090.23242@iabervon.org>
	<7vbr36j75b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509061610080.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 23:54:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EClNc-0003VF-AH
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 23:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVIFVxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVIFVxV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 17:53:21 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36548 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750988AbVIFVxV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 17:53:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050906215318.KNLR3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Sep 2005 17:53:18 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509061610080.23242@iabervon.org> (Daniel
	Barkalow's message of "Tue, 6 Sep 2005 16:25:44 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8151>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Good. (Although that patch doesn't seem to be directly on top of my 
> version; I can tell what it's doing anyway)

That one was against the proposed updates head.  I've updated it
again to include the patch.

> I'm happy with the content in "pu"; the issue is just whether you want the 
> history cleaned up more. In the series I sent, I kept forgetting parts 
> that belonged in earlier patches.

Again, that is up to you.  I am not _that_ perfectionist but I
do not mind reapplying updated ones if you are ;-).

> Could you look over the documentation in
> Documentation/technical/trivial-merge.txt, and see if it's a
> suitable replacement for the table in
> t1000-read-tree-m-3way.sh?

I do not understand what you meant by '*' and 'index+' in
one-way merge table.  I take the first row ('*') to mean "If the
tree is missing a path, that path is removed from the index."

I like the second sentence in three-way merge description.  That
is a very easy-to-understand description of what the index
requirements are.

You have 2 2ALTs.  Also 14 and 14ALT look like they are the same
rule now.

What's "(empty)^" in "ancest"?  All of them must be empty for
this rule to apply?

I am not quite sure it is 'a suitable replacement' yet; the
existing table you can see it covers all the cases, but with
things like "'ancestor+' means one of them matches", I cannot
really tell the table covers all the cases or some cases fall of
the end of the chain.

Also when we have more than one ancestors or one remotes and we
say "no merge", it is still unspecified (and I have to admit I
cannot readily say what the result should be for all of them,
except that I agree #16 will be fine with an empty stage1) what
are left in which stages.

I personally think the exotic cases (i.e. no rule applies, or
"no merge" result with more than one ancestors/remotes) needs to
be handled outside read-tree anyway, by the script that drives
read-tree to attempt trivial merges.  That is the core of the
git-resolve-script would become:

    bases=`git-merge-base -a $ours $theirs` || exit
    git-read-tree -m -u $bases $ours $theirs
    case "$?" in
    0)
        # trivially resolved; nothing to do.
        ;;
    1)
        # no exotic cases -- just do it the old way.
    	git-merge-cache -o git-merge-one-file-script -a ;;
    2)
        # exotic cases like #16 and any other.
        # maybe try different heuristics, like best-base, from
        # scratch.
        git-read-tree --reset $ours
        ... attempt different merge policies ...
        ;;
    esac

So in that sense it probably does not matter what we leave in
stage1/2/3 in such cases as long as the command fails in such a
way that allows us to tell what happened.
