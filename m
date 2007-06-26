From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT RFC] Changing patch@branch syntax
Date: Wed, 27 Jun 2007 00:31:43 +0200
Message-ID: <20070626223143.GG7730@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0705220527x5d4c3d0fw2d0d66b37aab3f97@mail.gmail.com> <20070522210020.GV19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070621230207.GD7730@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0706220859n2c2962ffy21464526a5ebd6cd@mail.gmail.com> <20070622200037.GE7730@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0706221529w63a41e82r557179a45b461f61@mail.gmail.com> <20070624212603.GA6361@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0706251522s6baf7997r48beae7f57681d77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:32:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3JZn-0000rX-Dv
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 00:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235AbXFZWb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 18:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757604AbXFZWb6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 18:31:58 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:43466 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757235AbXFZWb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 18:31:57 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6F0BC5A09D;
	Wed, 27 Jun 2007 00:31:55 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id F1D5D1F151; Wed, 27 Jun 2007 00:31:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0706251522s6baf7997r48beae7f57681d77@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50982>

On Mon, Jun 25, 2007 at 11:22:15PM +0100, Catalin Marinas wrote:
> >I have often wondered if it would be useful to have a given
> >patch@stack as a base for another stack, or maybe as one of the
> >"heads" of an hydra.  Still not sure it would make any sense, however
> >- especially, proper use of hydras would possibly suppress the need
> >for the former.
> 
> There are situations when I want a separate branch but it relies on
> patches in other branches. I currently duplicate the patches and use
> the 'sync' command to keep them up to date (though this command would
> be more useful with support for git-rerere to avoid fixing the same
> conflict several times).
> 
> Can a patch series be part of multiple pools? This would be useful to
> my workflow.

In the current prototype, yes, since the current "hydra" object only
binds existing stacks.  In the design we've discussed, not directly -
let's find a solution.

My idea of what we've discussed most recently is that stackables will
be *contained* in patchsets.  Ie. a pool will be able to contain both
patches-as-we-know-them, and stacks, but those stacks won't be git
heads, only refs in a namespace still to be decided upon - something
similar to how we currently store patch refs.

To allow sharing a stack between several pools, I can see 2 options.
The easiest to implement (but not necessarily the easiest to live
with) is to clone and sync the stack.

Another one is to add another Stackable subclass (eg. StackableLink),
that would figure some sort of symbolic link to the reference
Stackable.  It would provide in the current patchset a local name for
the linked Stackable, but may need to be more than a simple alias: a
pool is, at least for now, an octopus, and thus only supports
conflict-less members; thus, if the linked Stackable changes to be
incompatible with the link siblings, the patchset containing the
conflict would instantly become invalid.  Either we add support for
this "invalidated" status, or we find a better way.  One possibility I
thought of, is that the link will point a specific version of its
referenced stackable (a point always reachable from new versions of
the referenced stackable through its patch/ref/stack/whatever-log),
and the user will need to explicitely stg-pull to get the new version,
with the option to "pull --undo" if he does not like it.

All these options leave room for innovative workflows :)


> >In current StGIT, in cases where
> >"name" matches both a local patch a git ref... well, we can still ask
> >for refs/heads/name as fully-qualified name - looks like I had
> >forgotten that one ;)
> 
> StGIT could default to patches and fall back to git commits if no ":"
> are found in the name.

I'd rather leave this fallback to the minimum (esp. if only "show" and
"pick" can make sense out of it).


> >I consider we have a couple of special cases:
> >
> >        clean currently does not care, but see task #5235
> >        rebase currently only needs patchets, do we need to extend that to 
> >        patches ?
> 
> 'rebase' could only work on the current patchset because of the
> possibility of getting conflicts during push (unless you implement the
> branch switching as well).

That's not what I was thinking about.  I was mentionning the
possibility to rebase to a given patch, so "pull" will follow later
versions of that patch.  Not sure it is useful, though, and it can
probably already be done by rebasing to refs/patches/<branch>/<patch>
(although that accesses implementation details, that rebasing to
<branch>:<patch> would not need to).


> >        new creates a patch in the current stack, we may want to unify
> >                this with "branch -c" in some way (maybe "stg
> >                (patch|stack|pool) new" ?)
> 
> This might be a possibility once we refactor the command line.

Right - that was subliminally suggesting to refactor the command-line
before 1.0, in fact ;)


> >> Also, shourt stgit/git.py be aware of the repository?
> >
> >I'd rather think that we should have git.Repository (and further
> >structurate git.py with more objects, like git.Branch), with
> >stgit-specific stuff in the stgit.Repository subclass.
> 
> Sounds good.

Cool.

Best regards,
-- 
Yann
