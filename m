From: Jeff King <peff@peff.net>
Subject: Re: who's on first? - following first parent and merge-management
Date: Thu, 8 Mar 2012 02:14:03 -0500
Message-ID: <20120308071403.GE7643@sigill.intra.peff.net>
References: <jj6s47$m98$1@dough.gmane.org>
 <7vwr6woo8p.fsf@alter.siamese.dyndns.org>
 <7vty1zfwmd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 08:14:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5XYD-0006vt-Q4
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 08:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab2CHHOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 02:14:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44356
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086Ab2CHHOG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 02:14:06 -0500
Received: (qmail 878 invoked by uid 107); 8 Mar 2012 07:14:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Mar 2012 02:14:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Mar 2012 02:14:03 -0500
Content-Disposition: inline
In-Reply-To: <7vty1zfwmd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192530>

On Wed, Mar 07, 2012 at 10:13:46PM -0800, Junio C Hamano wrote:

> If you are a purist, you could instead do this when "git push" is
> rejected in the original sequence:
> 
>     $ git reset --hard HEAD^ ;# cancel the merge of mywork
>     $ git pull --ff-only ;# get the updated tip of shared history
>     $ git merge mywork
>     $ test
>     $ git push

This gave me an idea that I think is probably crazy, but that I hadn't
seen mentioned before.

What if the user could specify a partial ordering of refs, and we used
that order when listing merge parents in the resulting commit. So for
example, if you said that:

  refs/remotes/origin/master > refs/heads/master

then doing:

  $ git checkout master
  $ git pull origin master

would result in a "flipped" merge commit, with origin/master as the
first parent, and master as the second. That makes the CVS-style
central workflow (i.e. "oops, somebody else pushed, I'll just pull &&
push") follow the first-parent flow that people expect.

You could extend it to topic branches, too ("refs/heads/master >
refs/heads/jk/*"). Of course, depending on your workflow, you might
_want_ to have them flipped. I.e., when it is not just laziness or lack
of understanding, and you really are making a merge commit to say "topic
XYZ depends on something that is now in master, so let's merge that in
before continuing topic development".

So I think the primary audience would be people doing clueless
centralized-repo development. Of course you'd perhaps want to flip the
merge message, too. And I do think people are overly-interested in
--first-parent in the first place, so the effort of specifying the
parent ordering like this is probably not worth it.

I think when people ask about --first-parent, what they really want to
say is "what happened on branch X, and what happened on this other
branch". I wonder if we would do better to annotate the ref name of each
side of the merge, and then people could follow a particular ref through
history if they felt like it. That feels very un-git, as the DAG
fundamentally does not care about the ref names. On the other hand,
people do care, and we actually do have that information already in our
stock merge commit messages

What if we had something like "git log --follow-branch=master", and it
was implemented something like:

  if commit has no parents
    add nothing to traversal
  else if commit has one parent
    consider parent for traversal (subject to usual UNINTERESTING, etc)
  else
    match commit message against /Merge branch '(.*)'( into (.*))?/
    if $2 is empty, then set $2 to 'master'
    if $1 is 'master', add parent 2 to traversal
    if $2 is 'master', add parent 1 to traversal

IOW, mine the commit messages to make a guess about the original state.
I wonder how well it would work in practice. Git lets you do funny
things like merge on a detached HEAD and assign the result to a ref.
That may give you an odd merge message, but that's OK, because nothing
is parsing it. But it would break a traversal like this.

Like I said, I think these probably crazy ideas, but they were
interesting enough to me to think through. Maybe they will inspire
something not-crazy from somebody else. :)

-Peff
