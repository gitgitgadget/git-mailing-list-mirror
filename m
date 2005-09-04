From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Moved files and merges
Date: Sun, 4 Sep 2005 14:28:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509041329340.23242@iabervon.org>
References: <4318E754.9000703@zytor.com> <7vek87djat.fsf@assigned-by-dhcp.cox.net>
 <7vek867e29.fsf@assigned-by-dhcp.cox.net> <7vy86erntu.fsf@assigned-by-dhcp.cox.net>
 <20050903190500.GB8379@mars.ravnborg.org> <7voe7arlqk.fsf@assigned-by-dhcp.cox.net>
 <20050903220355.GA1895@mars.ravnborg.org> <7v64thl248.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 20:25:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBzAX-0002Ig-FL
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 20:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVIDSYg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 14:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVIDSYg
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 14:24:36 -0400
Received: from iabervon.org ([66.92.72.58]:34313 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932077AbVIDSYf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2005 14:24:35 -0400
Received: (qmail 12625 invoked by uid 1000); 4 Sep 2005 14:28:27 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2005 14:28:27 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64thl248.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8065>

On Sun, 4 Sep 2005, Junio C Hamano wrote:

> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> > If the problem is not fully understood it can be difficult to come up
> > with the proper solution. And with the example above the problem should
> > be really easy to understand.
> > Then we have the tree as used by hpa with a few more mergers in it. But
> > the above is what was initial tried to do with the added complexity of a
> > few more renames etc.
> 
> All true.  Let's redraw that simplified scenario, and see if
> what I said still holds.  It may be interesting to store my
> previous message and this one and run diff between them.  I
> suspect that the main difference to come out would be the the
> problem description part and the merge machinery part would not
> be all that different.

I'm not quite so convinced, because I think that the actual situation is a 
bit more natural, and therefore our expectations at the end should be 
closer to right with less attention to detail. But I think the actual 
situation is more interesting, anyway, because it's more likely to happen 
and we're more likely to be able to help.

> ------------
> This is a simplified scenario of klibc vs klibc-kbuild HPA had
> trouble with, to help us think of a way to solve this
> interesting merge problem.
> 
> 	 #1 - #3 - #5 - #7
>        /    /         /
>     #0 - #2 - #4 - #6
> 
> There are two lines of developments.  #0->#1 renames F to G and
> introduces K.  #0->#2 keeps F as F and does not introduce K.
> 
> At commit #3, #2 is merged into #1.  The changes made to the
> file contents of F between #0 and #2 are appreciated, but we
> would also want to keep our decision to rename F to G and our
> new file K.  So commit #3 has the resulting merge contents in G
> and has K, inherited from #1.  This _might_ be different from
> what we traditionally consider a 'merge', but from the use case
> point of view it is a valid thing one would want to do.

I think this is actually quite a regular merge, and I think we should be 
able to offer some assistance. The situation with K is normal: case #3ALT. 
If someone introduces a file and there's no file or directory with that 
name in other trees, we assume that the merge should include it.

F/G is trickier, and I don't think we can actually do much about it with 
the current structure of read-tree/merge-cache/etc, but, theoretically, we 
should recognize that #0->#1 is a rename plus content changes, and #0->#2 
is content changes, so the total should be the rename plus contents 
changes; I think we want to additionally signal a conflict, because 
there's a reasonable chance that the rename will interfere with the #0->#2 
changes, and need intervention. Most likely, this just means that we 
should not commit automatically, but have the user test the result first.

For now, of course, we don't get renames at any point in the merging 
procedure, so our code can't tell, and sees it as a big conflict that the 
user has to deal with. But we can agree on what the result is if the user 
"includes all the changes from the other branch" (and see the situation 
you reported first as "cherry-picking" the content and leaving the 
structural changes).

> Commit #4 is a continued development from #2; changes are made
> to F, and there is no K.  Commit #5 similarly is a continued
> development from #3; its changes are made to G and K also has
> further changes.
> 
> We are about to merge #6 into #5 to create #7.  We should be
> able to take advantage of what the user did when the merge #3
> was made; namely, we should be able to infer that the line of
> development that flows #0 .. #3 .. #7 prefers to rename F to G,
> and also wants the newly introduced K.  We should be able to
> tell it by looking at what the merge #3 did.

Again, K should be unexceptional, because we're keeping a file that was 
added to one side but not the other. (In the other situation, it still 
works; relative to the common ancestor, we're in #8ALT, since #5 doesn't 
have K, which was in #2 and #6; we see the rejection in a merge as a 
removal, which is effectively the same.)

> Now, how can we use git to figure that out?

First off, it should handle K automatically, because we're still including 
a file added by one side without interference from the other side.

> First, given our current head (#5) and the other head we are
> about to merge (#6), we need a way to tell if we merged from
> them before (i.e. the existence of #3) and if so the latest of
> such merge (i.e. #3).
> 
> The merge base between #5 and #6 is #2.  We can look at commits
> between us (#5) and the merge base (#2), find a merge (#3),
> which has two parents.  One of the parents is #2 which is
> reachable from #6, and the other is #1 which is not reachable
> from #6 but is reachable from #5.  Can we say that this reliably
> tells us that #2 is on their side and #1 is on our side?  Does
> the fact that #3 is the commit topologically closest to #5 tell
> us that #3 is the one we want to look deeper?
> 
> This is still handwaving, but assuming the answers to these
> questions are yes, we have found that the 'previous' merge is
> #3, that #1 is its parent on our side, and that #2 is its parent
> on their side.
> 
> Then we can ask 'diff-tree -M #2 #3' to see what `tree
> structure` non-changes we do _not_ want from their line of
> development, while slurping the contents changes from them.
> When making the tree to put at #7, just like I outlined to my
> previous message to HPA, we can first create a tree that is a
> derivative of #6 with only the structural changes detected
> between #2 and #3 (which are 'rename from F to G' and 'addition
> of K') applied.  Here, applying 'addition of K' is only
> conceptual, unlike the original message you (Sam) had trouble
> with due to my misunderstanding of which line of development
> renames/adds.  It is conceptual in the sense that we do not have
> to do anything special.  #6-adjusted is different from #6 in
> that it has F's contents from #6 at G.

That's true, but we don't need to find and use #3; we can just use #5. The 
only difference is structural changes introduced between #3 and #5, and we 
presume we want those changes as well, unless they conflict with 
something. And if we don't look for #3, we can recognize the merge of #0, 
#1, and #2 as the same situation, with the same solution.

> Similarly, we make another derivative, this time of #2, with
> only the structural changes to adjust it to 'our' tree (again,
> 'rename from F to G' and 'addition of K' which is only
> conceptual --- that is, #2-adjusted has contents of F from #2 at
> G).  Then we can run 3-way git-read-tree like this:
> 
>     git-read-tree -m -u '#2-adjusted' '#5' '#6-adjusted'
> 
> The last part, using the structurally adjusted tree as the
> merge-base tree, is what I forgot to do in the previous message
> to HPA.
> 
> In all these three trees fed to read-tree, the original F
> (modified in two lines since #0 which had it at F) appears at F,
> so the normal 3-way merge machinery would work just fine.  #2
> does not have G (neither #2-adjusted), #5 does, and #6 does not
> (neither #6-adjusted), so again the ordinary 3-way merge
> machinery would pick up G from #5 and drop it in #7.  That's why
> 'adjusting to our tree' for addition is only conceptual, unlike
> the removal and rename in the previous message.
> 
> So as I said, the principle is not that different.

We already do the addition and non-addition (like removal) in read-tree. 
We could also handle renames there as well, although I can't quite picture 
an efficient code organization for it. Of course, read-tree is in flux at 
the moment, so making more structural changes to it at the same time is 
awkward.

In any case, I think that your algorithm is correct, except that you can 
use the sides of the present merge and the common ancestor, rather than 
looking for past merges, which aren't really relevant. (For that matter, 
there's no reason to believe that #1 and #5 are "part of the same line"; 
you'd get the same graph if #3 were merging some third party's 
restructuring, and 4 and 6 were a fork that started before the change and 
is being merged after it:

  1
 / \
0-2-3-5-7
   \   /
    4-6

It shouldn't matter to the merge at 7 if the 2-3 reorganization was done 
locally, by applying a patch, or by merging.

	-Daniel
*This .sig left intentionally blank*
