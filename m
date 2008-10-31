From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 20:31:54 -0400
Message-ID: <20081031003154.GA5745@sigill.intra.peff.net>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Sam Vilain <samv@vilain.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 01:33:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvhwz-0007sR-6O
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 01:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbYJaAcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 20:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbYJaAcA
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 20:32:00 -0400
Received: from peff.net ([208.65.91.99]:2013 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbYJaAb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 20:31:59 -0400
Received: (qmail 21134 invoked by uid 111); 31 Oct 2008 00:31:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.233.202.2)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 30 Oct 2008 20:31:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Oct 2008 20:31:54 -0400
Content-Disposition: inline
In-Reply-To: <20081030002239.D453B21D14E@mail.utsl.gen.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99541>

On Wed, Oct 29, 2008 at 05:22:00PM -0700, Sam Vilain wrote:

>  Some suggestions, which have been briefly scanned over by some of the
>  (remaining) GitTogether attendees.  Please keep it constructive!  :)

Thanks for putting this together.

> +  * 'git stage' would do what 'git add' does now.
> +
> +  * 'git unstage' would do what 'git reset --' does now

These seem reasonable.

> +  * 'git status' would encourage the user to use
> +    'git diff --staged' to see staged changes as a patch

I notice the commit template message getting longer and longer. Maybe it
is time for status.verbosetemplate (which could default to true, I just
want to be able to turn it off).

> +  * 'git commit' with no changes should give useful information about
> +    using 'git stage', 'git commit -a' or 'git commit filename ...'

There is already infrastructure that figures out exactly what the
situation is (no changes versus changes in untracked files versus
changes in unstaged files), so it should just be a matter of tweaking
the messages.

> +  * 'git add' and 'git rm': no change
> +
> +  * 'git update-index' considered plumbing, not changed

Definitely.

> +  * 'git revert' deprecated in favour of 'git cherry-pick --revert'

I think I would make it "-R, --reverse", since it really is analagous to
"git diff -R".

> +  * 'git undo' would do what 'git checkout HEAD --' does now

This is an awful name, IMHO. It doesn't point out _what_ you're undoing,
so it leaves me with the feeling that you can undo arbitrary things.
I think the name needs to be considered along with related operations.

So think of us as having three "spots": the HEAD (H), the "stage"[1] (S),
and the working tree (W). And we want commands for moving content
between them. Now we have:

  W->S: add
  H->S: reset --
  S->W: checkout --
  S->H: commit (no paths)

And if you want to include things that jump the staging area:

  W->H: commit (paths or -a)
  H->W: checkout HEAD --

So I think with your stage/unstage, we have:

  W->S: stage
  H->S: unstage
  S->W: ?
  S->H: commit (no paths)
  W->H: commit (paths or -a)
  H->W: ?

So I think we can note something: movement commands are related based on
their _destination_. So since both of the missing ones impact the
working tree, they should have a related name.

But do note the difference between "stage vs unstage" as opposed to
"commit versus commit -a". I think this is because the stage sits in the
middle. So it is mentally "which direction are changes coming from" and
not "how _far_ are changes coming from".

So by that rationale, we should have a single command which says "put
stuff in the working tree", with a flag for "from HEAD" versus "from the
staging area." And that's what we have right now with "git checkout".
The real problem with it is that it is an overload of checkout's other
behavior of switching branches.

So what I am saying is "git undo" _must_ support both "put index content
into working tree" as well as "put HEAD content into working tree", or
it will be a step backwards in consistency.

So I guess that doesn't really suggest a name. But "undo" is awful. ;P

Side note: there are actually _other_ places you might want to move
content. Like a stash. So now you can think of it as:

                 stash
                  ^  ^
                 /    \
                /      \
               v        v
  HEAD <--> stage <--> working tree

So maybe we just need a "git content" command. And then you can "git
content --from=HEAD --to=tree <paths>" or "git content --from=tree
--to=stash", with all equally supporting "--interactive".  And of course
I am kidding, because typing that would be awful. But I think
conceptually, it makes sense. To me, anyway.

> +  * 'git branch --switch' : alternative to checkout

Blech. I think switching branches is the one thing that checkout does
unconfusedly. And this is much more typing. Not to mention that So I
would rather see "git switch" if checkout is somehow unpalatable.

But I don't know that it is. This seems like an attempt to say "branch
operations should all be part of 'git branch'". But checkout isn't
necessarily a branch operation. Consider detaching HEAD to a tag. Should
it be "git tag --switch"?

> +  * 'git push --matching' does what 'git push' does today (without
> +    explicit configuration)

I think this is reasonable even without other changes, just to override
any configuration.

> +  * 'git push' with no ref args and no 'push =' configuration does
> +    what:
> +    'git push origin $(git symbolic-ref HEAD | sed "s!refs/heads/!!")'
> +    does today.  ie, it only pushes the current branch.
> +    If a branch was defined in branch.<name>.push, push to that ref
> +    instead of the matching one.  If there is no matching ref, and
> +    there is a branch.<name>.merge, push back there.

There was a thread between me and Junio some months ago that touched on
this. I don't remember all of the arguments, but it was resolved to keep
the current behavior. Any proposal along these lines should at least
revisit and respond to those arguments.

> +  * 'git push' to checked out branch of non-bare repository not
> +    allowed without special configuration.  Configuration available

I have this patch done and sitting in my repo, but I need to add the
"without special configuration" bit and add tests and docs.

> +Informational
> +-------------
> +
> +  * 'git branch' should default to '--color=auto -v'

This should at least be configurable (even if it defaults to "on"). "-v"
is more expensive, and not always wanted.

I, for one, just use "git branch" to get the current branch. I don't
know of a more obvious way to ask for it (and please don't mention an
ever-changing bash prompt).

> +  * 'git tag -l' should show more information

I remember somebody talking about this, but not the details. Which
information?

> +  * 'git am -3' the default; with global option to make it not the
> +    default for those that prefer the speed of -2

I would prefer that personally. I think Linus has been very reasonable
in the past about recognizing that his workflow and speed requirements
aren't always typical, and being willing to accept setting a
configuration flag in those cases. So I think if he ack'd such a patch,
nobody else would complain.

> +  * 'git export' command that does what
> +    'git archive --format=tar --prefix=dir | tar x' does now

I agree, if you mean "does what ... does now" means "looks to the user
like ... is happening". This is much more sanely done using
git-checkout-index (though somebody suggested "remote export", which
would need to use tar itself).

> +  * 'git init --server' (or similar) should do everything required for
> +    exporting::
> +----
> +chmod -R a+rX
> +touch git-daemon-export-ok
> +git gc
> +git update-server-info
> +chmod u+x .git/hooks/post-update
> +git config core.sharedrepository=1
> +----

But not all of those things are necessarily related, and some of them
have security implications. I would hate to get a bug report like "I
used --server because I wanted to share my content via dumb http, but my
repo was p0wned because of too-loose group permissions."

-Peff
