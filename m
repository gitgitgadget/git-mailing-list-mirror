From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How can I easily verify my diffs are in parent branch?
Date: Wed, 11 Apr 2007 09:00:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704110822530.6730@woody.linux-foundation.org>
References: <1175686583.19898.68.camel@okra.transitives.com> 
 <Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
 <1176291474.11130.12.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:00:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbfFA-0002Vx-2s
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 18:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbXDKQAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 12:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbXDKQAT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 12:00:19 -0400
Received: from smtp.osdl.org ([65.172.181.24]:50043 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205AbXDKQAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 12:00:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3BG0BVZ012524
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 09:00:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3BG0AYZ007683;
	Wed, 11 Apr 2007 09:00:11 -0700
In-Reply-To: <1176291474.11130.12.camel@okra.transitives.com>
X-Spam-Status: No, hits=-0.456 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44243>



On Wed, 11 Apr 2007, Alex Bennee wrote:

> On Wed, 2007-04-04 at 08:12 -0700, Linus Torvalds wrote:
> > 
> > Yeah, sad.
> > <snip>
> > So all your small diffs get smushed in as part of one *big* change? Or do 
> > they still exist in the baseline CVS tree as individual commits?
> 
> Unfortunately they are all smushed together :-(

Ok, that just sucks.

> > For example, one thing you can do, if the number of commits you have is 
> > fairly small, is to just be on your "my-branch" and then do
> > 
> > 	git rebase [--merge] cvs-upstream
> 
> Yeah I've tried using the rebase approach (which I in fact use a lot
> when re-baseing my work anyway without losing my micro commit history).
> The one fly in the ointment is the branch result at the end contains no
> changes so I have no historical record of what I did while creating the
> change.

Ok, that's what "rebase" is *meant* to do. If the upstream already 
contains the patch (which especially with "--merge" means that it just 
cleanly did a 3-way merge - whether upstream was one big smushed- 
together thing or actually contained that patch explicitly doesn't 
matter), then "rebase" just skips that patch, since it's not "necessary" 
any more.

If you actually want to keep your own cleaner history, you should really 
do a "git merge", not a rebase. That's kind of the fundamental difference 
between rebasing and merging: rebasing throws away the old history (and 
creates totally new commits to keep the stuff that wasn't there), while 
"merge" creates a *superset* of the two histories.

> I assume the commit objects are still in git somewhere but I'm not sure
> how to get at it. What I would like to ask git is "what did my git-log
> look like when 'mybranch' was based off master at A instead of B after O
> rebased?"

What you *can* do, is to do "rebase *and* merge" kind of operation, if 
you really want to.

Your history will look a bit odd, and you'll have unmerged commits always 
show up twice (or as many times as you do this operation, in fact - if you 
keep on doing it, and they don't get merged up-stream, they'll always be 
re-done over and over again). But you'll have *both* the rebase result 
*and* the merge result.

The way to do that would be to basically be something like this by having 
*three* branches rather than two: your CVS import branch (call it "cvs"), 
your "merged work" branch (call it "cvs-merged") and the branch you 
actually do development on (call it "master")

 - update the "CVS tracking branch"

	# something like this.. 
	git cvsimport -i -m -o cvs

 - switch to the "cvs-merged" branch, and merge your old changes *and* the 
   new CVS state into it, but merge it as the CVS state *only*:

	# reset the "cvs-merge" branch to the new "cvs" state
	git branch -f cvs-merge cvs

	# switch to it
	git checkout cvs

	# and merge your old "master" into it but only merge the history, 
	# not the actual contents (ie using the "ours" strategy)
	git merge -s ours master

 - now, go back to your development branch, and rebase the work you have 
   there into the cvs-merge branch that works as the "history branch"

	# switch back to the development branch (which doesn't have the merge)
	git checkout master

	# Now, rebase the stuff that was *not* int he original "cvs" 
	# branch, but is in your development branch, and put it on top of 
	# the merge you just did.
	git rebase --merge --onto cvs-merge cvs

which *should* mean that in the end you have your "master" branch that 
contains your old history *and* the CVS history merged, *and* on top of 
that merge it also has the patches that you had in your old history that 
weren't in the CVS tree.

(The above is just a rough idea - I'm not actually guaranteeing that it 
works, I didn't test it, I just wrote it up as an example. That last 
"rebase" in particular might need some work to make sure that it only 
rebases your new stuff since the last cvs-merge: I think it will do that 
as-is, but I've always found the "git rebase" command to have very 
non-intuitive semantics because it doesn't use the normal "range" 
operations to describe what to actually rebase).

You get the idea. Once you get that working, you can just script it. The 
whole point is that you can use a merge *and* a rebase to both save away 
your old history, *and* to then re-do the commits that weren't merged on 
top of it.

So you *can* keep both the history *and* rewrite it, but it will require 
you to do more work, and you'd have to experiment a bit (as mentioned, I 
really don't think that "git rebase" example I gave above necessaly works 
as-is - you might have to tweak it a bit to make sure that it rebases 
exactly the commits that have been done since the last cvs merge: it might 
involve using "git-merge-base" to figure out what the last merge was 
before you do the "git merge -s ours" thing etc etc)

		Linus
