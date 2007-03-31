From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Keep rename/rename conflicts of intermediate merges while doing recursive merge
Date: Sat, 31 Mar 2007 13:03:43 -0700
Message-ID: <7vwt0xuqn4.fsf@assigned-by-dhcp.cox.net>
References: <20070329141230.GB16739@hermes>
	<81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
	<81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
	<20070329183237.GB2809@steel.home>
	<Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703301754590.6730@woody.linux-foundation.org>
	<20070331104947.GA4377@steel.home> <20070331114938.GB4377@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Tom Prince <tom.prince@ualberta.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 22:03:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXjnh-00030p-JY
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 22:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbXCaUDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 16:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbXCaUDq
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 16:03:46 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:54159 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbXCaUDp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 16:03:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070331200344.MWSS24385.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 31 Mar 2007 16:03:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hY3j1W0061kojtg0000000; Sat, 31 Mar 2007 16:03:44 -0400
In-Reply-To: <20070331114938.GB4377@steel.home> (Alex Riesen's message of
	"Sat, 31 Mar 2007 13:49:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43568>

Alex Riesen <raa.lkml@gmail.com> writes:

> This patch leaves the base name in the resulting intermediate tree, to
> propagate the conflict from intermediate merges up to the top-level merge.
> ---

I've eyeballed not your patch but the entire merge-recursive
again, to make sure that the codepath you are touching is the
only one that can potentially leave higher stages in the index
for intermediate merge.  Anything that calls update_file() for
intermediate merge ends up doing add_cacheinfo() hence drops
higher stages for that path, and it seems that the function you
are changing, conflict_rename_rename, is the only one that
leaves unmerged entries in the tree, so I think thi is good.
The assertion you added to git_write_tree() is good way to catch
if the above assumption was wrong and we missed other codepaths.

> The result seem to be at least predictable. Still, doesn't it mean
> that once a rename/rename conflict is in it has to be resolved
> manually forever?

That's certainly better than segfaulting, and in my opinion, it
is much better than silently giving a wrong merge result
assuming one conflict resolution.

We've been resolving other cases that we should not usually
resolve for intermediate merges, leaning on the safer side.  For
example, look at what delete/modify does for an intermediate
merge.  It leaves the modified contents in the index.

The reason an intermediate merge conflicts is because the two
branches resolved the same (not necessarily "exactly the same")
merges differently earlier.  That means the two people who made
those ancestor merges could not agree on something.  Because
they could not agree on, you end up being responsible for
reconciling their differences in opinion.  I do not think it is
a bad thing -- in fact, I even think it is a good thing.  Forks
do not have to converge and you have an opportunity to decide
which side you are on for yourself.

An illustration.

Suppose there is a project that has incorrect documentation, and
Alice and Bob worked on it separately.  Alice finds the
documentation's language horrible and makes typofixes, while in
Bob's opinion its contents, even if its language were to be
improved, keeping the incorrect documentation spreads
misinformation and it is worthless.  Bob deletes the incorrect
documentation and keeps working on other things.

         .------------A1--A2------------A
        /   modify doc \ / take "modify"
       /                X  and later improve          
      /                / \           
  ---o---------------B1---B2------------B
           delete doc     take "delete"

In short, Alice modified and Bob deleted, and reached point A1
and B1, respectively.

Now Alice pulls from Bob, hand-resolves the delete/modify and
improves the contents to make it not just language clean (which
she did in the previous steps leading to A1) but technically
accurate.  She now is at point A2, but haven't pushed her
changes out yet.  She continues to work and reaches A

In the meantime Bob is making further changes to the parts of
the system the documentation used to describe.  Bob commits his
changes, pulls from Alice's last published one A1, and gets
delete/modify conflict in the doc, and he takes the deletion and
merge result is B2.  He continues to work and reaches B.

Later Charlie clones from Bob's B, and tries to merge from
Alice's A.  There are two merge bases (A1 and B1), so an attempt
to merge the merge bases is made by recursive.  This gives
delete/modify conflict.  We leave the modified contents in this
intermediate "virtual ancestor" tree, but the end result is that
Charlie has a chance to resolve this delete/modify conflict
Alice and Bob could not agree on for himself.

If Charlie thinks the same way as Alice and it is a good idea to
keep the documentation up to date, he might do something like
Alice did at A2.  If on the other hand Charlie agrees with Bob
at B2, he might take delete.  I think leaving that decision up
to Charlie is not necessarily a bad thing.
