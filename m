From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Which freedesktop.org "design flaws" in git are still
 relevant?
Date: Fri, 29 Feb 2008 16:58:16 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802291614230.19665@iabervon.org>
References: <51419b2c0802291232w166b3100yabd30ba30df6ef1f@mail.gmail.com> <m3hcfrjwnk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 22:59:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVDFt-0004Jw-BB
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbYB2V6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbYB2V6U
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:58:20 -0500
Received: from iabervon.org ([66.92.72.58]:56208 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932446AbYB2V6S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:58:18 -0500
Received: (qmail 12764 invoked by uid 1000); 29 Feb 2008 21:58:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Feb 2008 21:58:16 -0000
In-Reply-To: <m3hcfrjwnk.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75575>

On Fri, 29 Feb 2008, Jakub Narebski wrote:

> "Elijah Newren" <newren@gmail.com> writes:
> 
> > The page http://www.freedesktop.org/wiki/Infrastructure/git/UIFlaws
> > contains a number of claimed UI flaws of git.  I suspect that a number
> > of them are out-of-date; it doesn't seem to jive with my recent
> > reading of the documentation.  Could anyone point out which are still
> > accurate with recent git, and which aren't?
> 
> I'll examine them point by point, and write replies when I know the
> answer. Probably should correct wiki page, too...
> 
> 
> > * git-revert will refuse to back out multi-parent commits, ie,
> >   merges. The obvious behaviour is to do basically what git-show
> >   [commit] | patch -p1 -R would do, ie, roll back the tree state to
> >   the branch you came from.
> 
> If I remember correctly there was some work done on cherry-picking,
> reverting (revert is cherry-picking reverse of a commit in the diff -R
> or patch -R sense) and rebase with multiparent commits, telling which
> of parent to treat. But I do not remember details.
> 
> The advice is of no use: git-show for merge (multi-parent) commits
> either doesn't show diff at all, or show compact combined diff 
> (diff --cc) which cannot be applied. Another issue of note is that
> "git revert" does not roll back the tree state, but applies reversion
> of given change, i.e. reverts / undoes given _changeset_.

I think the idea there is "git diff $1 $1^ | git-apply"; that is, 
reverting the content changes between the merge and its (first) parent.

> > * 'git-rebase foo' is a noop, when foo is the name of local
> >   branch. You would expect it to fetch the branch named foo from
> >   upstream, and rebase your foo branch on top of it.
> 
> No, I would never expect git-rebase to fetch somthing. And "git rebase
> <upstream>" is *not* no-op: it rebases (rebuilds) _current_ branch on
> top of given branch.

Furthermore, you can rebase branches on other local branches. (E.g., if I 
realize that I need in speculative branch A a fix I made in maintence 
branch B, I'll rebase A on B so that, when B hits mainline, rebasing A on 
it will do the right thing and get B out of the series.)

> To do fetch+rebase, i.e. update branch in rebase based workflow, use
> "git pull --rebase".
> 
> > * git-fetch requires that the branch be named on both sides of
> >   the :. It should treat 'foo' as an alias for 'foo:foo'.
> 
> From git-fetch(1):
> 
>    - A parameter <ref> without a colon is equivalent to <ref>: when
>      pulling/fetching, so it merges <ref> into the current branch
>      without storing the remote branch anywhere locally
> 
> So 'foo' is treated as 'foo:' (which means fetch, and not store), and
> not as 'foo:foo'. It is perhaps a bit strange, but backward
> compatibility would I think prohibit us to change it, even if it would
> make more sense to have it be shortcut for 'foo:foo' instead.

Actually, what would make sense would be, perhaps, to update local 
tracking branches that match a fetch "foo:". For that matter, you *really* 
don't want "foo" to mean "foo:foo", because "foo:foo" is undesireable; you 
want "foo:origin/foo" or something of that sort.

> > * git-rebase claims you should git-rebase --continue after you fix
> >   up the merges; it really means you should git-update-index
> >   followed by git-rebase --continue.
> 
> It is git-add now, not git-update-index.
> 
> I'm not sure what is exact wording of interrupted rebase in current
> git, as it was some time since I used it, but IIRC it talks about
> "resolving conflicts", and doing "git add"[*1*] is a part of this
> step.
> 
> [*1*] There is/was a floating idea to add "git resolved" command,
> which would be limited porcelain calling git-update-index, used _only_
> to mark resolved conflicts, and having checks etc. for that.

I think it's still not terribly explicit in the instructions for resolving 
the conflicts. I think the worse thing is that you have to pick out the 
conflicting files from the ones that were handled, rather than getting a 
section of "fix <list of files>, mark them handled with "git add", and 
continue".

> > * The command to merge branch B onto branch A is not 
> >   "git-merge A B". Instead it's "git-checkout A && git-pull . B".
> 
> Long fixed, although not in the matter mentioned. To merge branch B
> into _current_ branch (you cannot merge to non-current branch because
> of possibility of conflicts) you can use "git merge B".

I have to wonder if this person actually wants:
"git merge A && git push . A" (which is to say, resolve the conflicts on 
the topic branch and update the mainline branch with the now-fast-forward 
result). Of course, there's no major need for a local A branch, but that's 
often not obvious to new users.

> > * There is no way to tell git-fetch (or therefore git-pull) to grab
> >   all newly available branches. You have to ask for them by two
> >   names (as above), and then there's no way to get those names
> >   automatically into your remotes list (also as above).
> 
> It is possible with globbing refspec, like this example:
> "refs/heads/*:refs/remotes/origin/*". You can use git-remote to do
> this for you.

Heck, git clone does this for you these days.

> > * The index should be second-class, i.e. no -a flags to avoid the
> >   index.
> 
> To much opposition for that. Adding '-a' option is not such a burden
> (you most probably ass '-s' option anyway), and you can always use
> alias for this.

I wonder if commit shouldn't use -a by default if there are changes but 
none staged. But people adding new files would trip over that.

> > * branch:branch should be the default push for all branches, but
> >   only push the current branch unless a flag is added.
> 
> You can now push only current branch with "git push <remote> HEAD",
> and IIRC also with magic "git push HEAD".

The *real* magic is "remote.*.push: HEAD". (The reason it's real magic is 
that I implemented it, and I didn't know I'd implemented it until Junio 
mentioned it in release notes. Validation of the design of a weak UI 
around a strong core.)

> > * An update command should be created that:
> >     * fetches the current branch's upstream to its -origin locally
> >       (or all branches, perhaps);
> >     * merges the current branch origin to the branch locally;
> >     * commits if it was a fast-forward, and leaves uncommitted diffs
> >       otherwise.
> 
> Not done, and probably has no much sense otherwise (merging is done
> using 3-way merge, not by taking diff and applying it as a patch).

Actually, isn't this "git pull --no-commit"? It:

 * fetches the current branch's remote, updating the tracking refs for it 
   (not branch-origin, but remotes/origin/*, a better name)
 * merges the remote branch in "merge" for the current branch into the 
   current branch
 * if it was not a fast-forward (if it was, there's no new state to leave 
   uncommitted), it doesn't commit it, but leaves the changes merged (or 
   conflicting, if there were conflicts) in the index.

Nobody agrees on what, exactly, "git update" should do, but I think all of 
the sane options are easy aliases. Maybe we should have a recipies section 
of them. (Actually, it would be amusing to have recipies in a man page for 
"git update": "It's up to you to make this do what you want. Here are some 
suggestions...").

I wonder if it would be nice to have per-branch aliases, so that you could 
have "git update" do whatever is appropriate to update this particular 
branch, whether it be "git pull --no-commit" or "git reset --hard 
origin/next && git merge" or "git rebase".

	-Daniel
*This .sig left intentionally blank*
