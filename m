From: Adam Spiers <git@adamspiers.org>
Subject: Re: improvements to checks for core.notesRef / GIT_NOTES_REF / --ref
Date: Mon, 29 Apr 2013 22:40:51 +0100
Message-ID: <20130429214051.GA1704@pacific.linksys.moosehall>
References: <20130427132118.GA25295@pacific.linksys.moosehall>
 <20130429133205.GA4672@pacific.linksys.moosehall>
 <20130429163909.GA19014@pacific.linksys.moosehall>
 <7vmwshjm4j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Johan Herland <johan@herland.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 23:41:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWvp1-0008Ut-Mm
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 23:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759073Ab3D2VlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 17:41:15 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:41001 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758077Ab3D2VlO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 17:41:14 -0400
Received: from localhost (4.3.1.2.f.7.0.2.5.1.9.5.4.a.0.0.0.d.3.7.6.a.1.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:11a6:73d0:a4:5915:207f:2134])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 133FB2EAD2;
	Mon, 29 Apr 2013 22:40:52 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vmwshjm4j.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222869>

On Mon, Apr 29, 2013 at 10:13:32AM -0700, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> >     static struct notes_tree *init_notes_check(const char *subcommand)
> >     ...
> > Can we relax this to "refs/", to allow better isolation of namespaces
> > for remote notes?  Also, the check is applied for GIT_NOTES_REF and
> > core.notesRef, but not for values passed via --ref.  Therefore I would
> > propose that init_notes_check() is not only relaxed but also moved
> > from builtin/notes.c to notes.c, so that it can be consumed by
> > default_notes_ref().  Thoughts?
> 
> Such a policy decision at the application level should be done in
> builtin/notes.c, and not notes.c, I think.  It is OK to have a
> sharable check routine in notes.c and help different notes
> applications to implement their own sanity checking, though.  "git
> notes" that operates only on local notes might restrict its
> operation to refs/notes, while "git notes-merge" may allow it to
> read from other hierarchies but still write only into refs/notes,
> for example.

OK, makes sense.

> I am not sure if it is a good idea in general to have a separate
> remotes-notes/ hierarchy in the first place, though.  Wouldn't the
> notes be less like branches (private view) and more like tags
> (common world view)?

I didn't have anything to do with the design, but the existence of
certain "git notes" subcommands (in particular append, edit, and
merge) gave me the distinct impression that users are expected to edit
notes simultaneously, and handle any merge conflicts which may arise.
These actions are modelled by commits to refs/notes/$GIT_NOTES_REF,
which as a result is used as a sort of inferior 3rd-class branch.  In
contrast, tags do not seem to be mutable (in the accumulative sense,
at least), and have no history (not even in the reflog, AFAICS).

As stated earlier in the thread, my particular use case is to use
notes to mark commits which should be excluded from a long list of
commits which "git cherry" says need to be upstreamed.  In our
project, there are many commits for which it does not make sense to
upstream them, and even for the ones which it does, cherry-picking can
sometimes result in a different patch-id due to changed context.  In
both of these cases, git notes is a great mechanism for blacklisting
these commits from the upstreaming process, and I've already written
"git icing" which wraps "git cherry" to support that.  However, the
substantial size of the upstreaming work means that it needs to be
done by multiple people across multiple clones of the repository,
hence the need for branch-like tracking of notes.

> > Also, are there any plans in the future for making "git notes merge"
> > provide an index, so that a proper 3-way merge with ancestor can be
> > done using git mergetool?
> 
> Are we committed that all notes leaves must be blobs (I do not
> personally mind it)?

No idea - perhaps someone else can comment on this.  Sounds reasonable
to me too.

> I do think we need a way to call a custom low level 3-way merge
> driver once we identify which notes blobs correspond to each other
> with what common ancestor notes blob while merging two notes trees.

Right.

> But I do not think that "an index" that we use for the usual working
> tree merge is necessarily a good representation for driving such a
> ll-merge driver and recording its result.  Each side likely has a
> note for the same object to be merged in a different fan-out layout,
> and fan-out is merely a performance hack to spread the objects in
> smaller trees.  As mergetools only work with the usual working tree
> with the usual index, they may be a poor substitute for ll-merge
> drivers to handle merging notes trees.

I won't pretend to have fully understood that ;-) I'm certainly not
religious about how such a merge workflow would be implemented.  I
just wanted to point out that the current mechanism doesn't readily
expose the common ancestor in a way which makes the merge convenient.
IMHO the more similar the merge's user experience is to a standard
merge, the better, since that would minimise the number of merging
workflows the user needs to learn.

On this theme, I think ideally rebase should be supported too, and
that does make me wonder if there's a good reason why notes shouldn't
be stored in real branches, or at least something which looks more
like a branch (even if "git branch" doesn't list it).  In particular,
applying the concept of remote tracking branches to notes would be
most useful.  Currently my "git rnotes" wrapper is faking remote
tracking branches via refs/notes/$remote/$GIT_NOTES_REF, but that
means that if I want to push a set of notes to a remote repository,
it's not sufficient to do the following:

    git push $remote refs/notes/$GIT_NOTES_REF:refs/notes/$GIT_NOTES_REF

I also have to manually update the fake tracking "branch":

    git update-ref refs/notes/$remote/$GIT_NOTES_REF refs/notes/$GIT_NOTES_REF

    # or if I want to make really sure this only happens if the push worked
    git fetch $remote refs/notes/$GIT_NOTES_REF:refs/notes/$remote/$GIT_NOTES_REF

That's pretty ugly.  Couldn't we instead just reuse the existing
mechanisms?

    remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
    remote.origin.fetch=+refs/notes/*:refs/note-remotes/origin/*
    branch.notes/commits.remote=origin
    branch.notes/commits.merge=refs/notes/commits

Just an idea ...

Adam
