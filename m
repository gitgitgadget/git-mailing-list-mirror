From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Wed, 30 Jan 2008 02:47:58 -0500
Message-ID: <20080130074758.GT24004@spearce.org>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <47A01963.1030703@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 08:48:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK7gf-0002sg-3X
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 08:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbYA3HsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 02:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbYA3HsH
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 02:48:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35192 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYA3HsF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 02:48:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JK7fr-00037v-Id; Wed, 30 Jan 2008 02:47:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EA82E20FBAE; Wed, 30 Jan 2008 02:47:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47A01963.1030703@vilain.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72046>

Sam Vilain <sam@vilain.net> wrote:
> Shawn O. Pearce wrote:
> > * New protocol extension to send-pack/receive-pack pair:
> > 
> >   If server wants to require (or optionally) accept a signed push
> >   event it sends a new capability string when it advertises its
> >   current known heads:
> 
> Ok - but I think if the client is pushing a signed tag to the tagname
> listed in the signed body of the tag, that no extra signature should be
> necessary.  It's only commits that need the extra information.

Doh.  Of course the standard signed tag case is easily verified,
without the new authentication extension.  But adding it around
a signed tag push doesn't really hurt anything, except maybe the
user who entered her passphrase yet again.

Signing a tag push is actually relevant in some cases.  For example
when I mirror Junio's git.git tree into my local server at day-job.
Junio signed the v1.5.4-rc5 tag.  I pushed it to the same location,
and although we can validate Junio's signature, it may matter (to
people who have too much free time on their hands but I digress)
who at our organization put that v1.5.4-rc5 tag from Junio onto
that particular system, and when they did that.  Was it me?
Or another co-worker?

> And remember, for global replication of the data between untrusted nodes
> to be possible, the signatures must be saved somewhere.  I have sketched
> a simple design below.

Crap.  You mentioned this in your initial email, and I forgot
about it when I posted the message you are responding to now.
Its actually an interesting concept.  We can validate the entire
chain of commits that led up to a signed tag, and we can validate
that signature on that tag.  So why shouldn't we also be able to
validate the changes to refs in a distributed fashion?

This does complicate things considerably, as now we're talking
about the ref namespace no longer being this simple set of DAG
pointers, but itself becoming a DAG.  Someone please stop the
madness!  :-)

> > * PGP public key storage:
> > * ref/access-keys security:
> 
> Ok perhaps it is best to wrap all this up in a single state branch, that
> has in it:
> 
>    access-keys/
>      - tree with one key per e-mail address
>    access
>      - maps reference globs to e-mail addresses permitted to change
>        them - with a "+" if the address may rewind the ref
>    owners
>      - maps reference globs to e-mail addresses permitted to add entries
>        to the "access" map above

This part I get.  Using only globs is a tad limited in my mind.
I actually abuse regexes on refs at day-job in a few places to get
the access list to work with just a handful of rules.

>    signatures/
>      - stores any detached signatures.  only the signatures verifying
>        updates since the last commit to the access meta-branch need to
>        be stored
>    packed-refs
>      - the new list of references (the refs/access commitid is naturally
>        absent or the same as the parent), or just the changed
>        references.

This I'm not so sure.  Are you suggesting that we save the detached
signature I described earlier that signed the push command set and
store it here, in this access state branch?  And that we also store
a copy of all refs (save this one) as a flat file?

I guess the hidden part here is one can recover the command set used
between any two pushes by diffing the packed-refs file and parsing
that diff to regenerate the command set.  Then you have to find some
detached signature that is associated with this set of commands and
verify it.  Matching the signature back to its public key is easy.
What isn't described here is the complexity of matching the detached
signature to a command set that was extracted from the diff of the
packed-refs file.

Urgh.

I think this needs to be rethunk.  Its really freaking early morning
here, and I probably should be in bed, not solving security problems,
but this is starting to feel like we are trying to use the Titantic
as a hammer to tighten a motherboard mounting screw.  Its a bit
heavy, somewhat difficult to yield with one hand, and probably
not the best tool for the job.  But it moved that D@*! screw.
And your desk, your floor, your office building, and the rest of
the city block while it was at it.
 
> You don't necessarily need a new commit on this for every single push,
> just once "every so often", and perhaps for safety once for every change
> to the access file.

Actually I think you would need a new commit for each detached
signature you received.  Otherwise you may wind up with a set of
refs that you cannot explain how they happened, and the signatures
you do have don't sign those changes.

Now maybe you have a "mob" branch that anyone can push to, without
authorization, in which case OK, I can see the not every push does
an update to the access state branch case.  But I think that if we
get a signature for a ref command set we'd need to save that, if
we are saving them at all.

> This branch should then be auditable; replicating tools can go and
> verify that there have been no unauthorized changes.
> 
> Forks don't necessarily need special treatment; they can exist under
> refs/forks/foobar/ - similar to the refs/remotes/ namespace, and have
> their own independent ACL branches within.
> 
> Allowing "grant" permissions to refspaces would need to be handled
> specially; you can't simply grant access to change refs/access; the
> actual push to refs/access would need inspecting to see if the changed
> "access" file comes within the rights of the user that signed the update.

Right.  Which gets interesting.  The paranoid update hook also does
file level ACLs by checking the output of `git diff-tree $old $new`,
but it really gets tripped up during merges.  It cannot tell that
you are just merging some other branch and haven't yourself made
modifications to the files.

> I think this seems about right for a first cut.  Possibly bigger
> projects like Debian would like to say that for certain ref spaces,
> multiple signatures are required, so that no one PGP key retains
> complete control.  But I think these things are easily added as features
> on top of this basic infrastructure.

Where do we enqueue the partial pushes until final approval?

I actually like this idea, of allowing voting for a refspace change,
and having the refspace update only when sufficient authorization
has been received.  Possibly based upon pure number of users who
authorized the change, or based upon their PGP trust values in the
server's PGP trust database, or a combination of the two.

At day-job we use a code review system based upon Git where code
reviewers push commit SHA-1s into special hidden namespaces:

	refs/approved/$ri/$branch
	refs/rejected/$ri/$branch

The $ri is the reviewer's private namespace (e.g. mine is sp,
yours might have been sv) and $branch is the name of the branch
head, minus refs/heads.  A little Perl script reads the output of
`git ls-remote` to count the number of approved and rejected refs
for a given branch, where the SHA-1 values are all identical.  If a
developer amends or pushes new commits onto an already approved
branch the approval is no longer counted, as the SHA-1s now differ.

A simple GC script cleans up any stale approved and rejected refs,
and gets run once a week alongside repack.

Really simple Apache style change voting, in git.

I bring this up now because our code review approvals are sort
of along the lines you were just suggesting "bigger projects like
Debain" might need to allow changes to say their stable security
fix branch.  We're a lot smaller than Debian, but it would be nice
if there is some sort of middle ground that would get both groups
some support within the core.

Enterprises that have "two person change" rules may also like this
sort of feature, as then the system automatically enforces the
rule that at least two individuals must approve a change in status
for software.  Oh, my day-job is such a group, but since our tools
don't really verify squat we ignore that two man change thing.

But yes, this is really heavy-weight process wise, and we can't
please everyone and still have a really simple system that mere
mortals can understand, so I'm probably off in la-la land at this
point in the discussion.
 
> Sound like something worth working towards?

We're getting there.

-- 
Shawn.
