From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 16:35:44 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910171528390.32515@iabervon.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <m49nq6-uk5.ln1@burns.bruehl.pontohonk.de> <7vr5t2h3do.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christoph Bartoschek <bartoschek@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 22:36:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzG0K-0003RM-Ok
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 22:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbZJQUfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 16:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbZJQUfq
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 16:35:46 -0400
Received: from iabervon.org ([66.92.72.58]:58146 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515AbZJQUfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 16:35:45 -0400
Received: (qmail 1657 invoked by uid 1000); 17 Oct 2009 20:35:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Oct 2009 20:35:44 -0000
In-Reply-To: <7vr5t2h3do.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130576>

On Sat, 17 Oct 2009, Junio C Hamano wrote:

> Christoph Bartoschek <bartoschek@gmx.de> writes:
> 
> [jc: added Daniel back to cc list; please do not cull the cc list without
> good reason]
> 
> > Daniel Barkalow wrote:
> >
> >> The upshot of the messages should be:
> >> 
> >>  $ git checkout origin/master
> >>  Since you can't actually change "origin/master" yourself, you'll just
> >>  be sightseeing unless you create a local branch to hold new local work.
> >> 
> >>  $ git branch
> >>  * (not a local branch, but "origin/master")
> >> 
> >>  $ git commit
> >>  You've been sightseeing "origin/master". The commit can't change that
> >>  value, so your commit isn't held in any branch. If you want to create
> >>  a branch to hold it, here's how.
> > ...
> > But then I was not able to verify that the checkout indeed matched the 
> > 1.3.0-beta.  "git status" and "git branch" did not help here. 
> 
> This is not going to help you, but "git reflog" would have helped here.
> 
> The reason my suggesting "git reflog" now won't help you is because the
> word "reflog" does not connect the question "how did I get here" unless
> and until you know git already; in other words, it is not your fault that
> you got lost, but it is showing a wart in the UI.
> 
> If the question you were asking was "does the files I have in my work tree
> after issuing that scary checkout actually match origin/1.3.0-beta?", you
> could have asked that question in a more direct way, and the command to do
> so is "git diff origin/1.3.0-beta".  I do not think this would be asking
> the user to be doing something unreasonably unintuitive.
> 
> If the question you were asking was (and it was not, from the description
> of your experience, but you could be in that situation when you "return
> some weeks later") "how does the checked out history relate to 1.3.0-beta?",
> then there is a way to ask the question in a very direct way, and the
> command to do so is "git show-branch HEAD origin/1.3.0-beta" (or give the
> same argument to "gitk").
> 
> Although it is not _so_ unreasonable to expect "git status" to show the
> information, I suspect it would not be practical.  After all, whenever
> somebody is lost, everything is "status".  For a person who is lost and
> does not know where in the history he is, it might be reasonable to expect
> "status" to give the relationship between your HEAD and some branch/tag,
> while for another person who was hit by "git gui" complaining that he has
> too many loose objects, it might be reasonable for him to expect "status"
> to give the number of loose objects in the repository.  IOW, "status" is
> too broad a word and following the path to cram everything into "status"
> so that any new person who gets lost can get necessary infor from the
> command will unfortunately lead to insanity.
> 
> The second item in the Daniel's transcript above may be an improvement but
> I think it is a wrong economy to record and show 'but "origin/master"'
> (which cannot be correct forever and has to be invalidated once the user
> starts committing or resetting) in the message.

It's easy to invalidate it for reasons of the user going elsewhere: you 
invalidate it when you invalidate MERGE_HEAD (which, incidentally, 
locates a bug in my original patch: there's a third 
"unlink(git_path("MERGE_HEAD"));" I didn't think of, in builtin-merge.c).

I think the case of it going stale, mainly due to updating a ref it uses, 
is a matter of having whatever wants to describe HEAD check if the 
extended sha1 still expands to the same sha1.

I also think that it fits with the git world model to distinguish 
"lvalues" from "non-lvalues". An "lvalue" is something where you can make 
a commit and change the value while the expression stays the same; you can 
assign to it. If your current position is not an "lvalue" and you commit, 
your current position must become a new temporary "lvalue", diverging from 
the thing you can't change. But if you don't assign to it, there's no 
problem with having a non-lvalue be your current position.

> I am wondering if a similar effect to help new users can be had by 
> rewording the message to:
> 
>     $ git branch
>     * (not a local branch; see "git reflog" to learn how you got here)
> 
> The user can see how he got there even after doing something else after
> the checkout (see Nico's write-up in $gmane/130527).  The difference is
> between giving fish and teaching how to catch one himself.

The reflog hint is a good one in general; on the other hand, I think it 
would be generally helpful to have the information in a more 
machine-readable fashion, for a "git checkout (whatever I gave to reset or 
checkout before)".

Perhaps the right implementation is actually to have machine-readable 
descriptions in the HEAD reflog? That would actually lead to the 
interesting:

$ git checkout topic
$ git checkout origin/master
$ git checkout HEAD@{1}
$ git branch
* topic

Actually, we turn out to have a flaw in our reflog explanation: when 
rebase finishes, it doesn't log that it's back to a particular branch.

	-Daniel
*This .sig left intentionally blank*
