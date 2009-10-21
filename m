From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 00:22:18 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910202310070.14365@iabervon.org>
References: <200910201947.50423.trast@student.ethz.ch> <alpine.LNX.2.00.0910201912390.14365@iabervon.org> <20091021030608.GA18997@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-38141353-1256098938=:14365"
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 21 06:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Sii-0002kz-5Q
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 06:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbZJUEWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 00:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbZJUEWP
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 00:22:15 -0400
Received: from iabervon.org ([66.92.72.58]:59757 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbZJUEWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 00:22:14 -0400
Received: (qmail 6353 invoked by uid 1000); 21 Oct 2009 04:22:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Oct 2009 04:22:18 -0000
In-Reply-To: <20091021030608.GA18997@atjola.homenet>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130882>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-38141353-1256098938=:14365
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 21 Oct 2009, Björn Steinbrink wrote:

> On 2009.10.20 19:56:01 -0400, Daniel Barkalow wrote:
> > But I don't really know; are there IRC logs you can quote or reference 
> > with people making the mistake you're trying to help them avoid?
> 
> "git pull" is kind of a jack of all trades WRT user errors, so I'll just
> pick up examples of all kinds, this might get long...
> 
> [If you read this and find out that you're quoted/referenced here: I
> don't mean to blame or embarrass you, or to point out that you're stupid
> or whatever. Quite contrary, I just want to show how git's pull UI _might_
> be responsible for your mistakes. The comments I made are purely my,
> possibly biased, reaction to what happened.]
> 
> That said, here we go:
> 
> 1) Unexpected fast-forward even with --no-ff
> 
> "git pull --no-ff abc:abc" with "abc" being checked out.
> 
> As pull explicitly allows fetches into the checked out branch head, this
> first fast-forwards abc, and updates the working tree/index. And then
> the --no-ff merge is a no-op.
> 
> http://colabti.de/irclogger/irclogger_log/git?date=2009-10-20#l2080
> (Should be a catchable special case, and the special --update-head-ok
> handling of "git pull" is from times where git didn't have remote
> tracking branches. I'd argue that that support should be dropped or at
> least disabled when you're using the modern setup, might be kept for
> oldtimers still using .git/remotes/*. Dunno...)

Yup, I think it would be good to ditch --update-head-ok and simplify the 
code; I also think it would be nice to prohibit fetching into refs/heads/* 
entirely, but there might be advanced users who actually want to do that.

In this case, "git fetch" has already done something the user didn't want, 
and the pull-specific portion doesn't actually do anything at all.

> 2) "git pull" taken as "reset --hard"
> git checkout -b foo; git pull origin bar
> 
> The user actually just wanted to look at things and thus was ok with:
> git fetch origin; git checkout origin/bar
> 
> http://colabti.de/irclogger/irclogger_log/git?date=2009-10-20#l1807
> (user seemed to be so inclined to use "pull" that he initially didn't
> even realize that he didn't want to merge when I asked whether that's
> what he wants)

I think that's a case where the user has been discouraged from using 
detached HEAD, and is using "pull" instead of "fetch" in order to update 
the junk branch he doesn't actually want. If you don't know you don't need 
a local branch, and you branch off of a common ancestor, "pull" does 
actually do something you want that "fetch" doesn't.

> 3) User expects "pull" to update all branch heads that have a configured
> upstream
> 
> 08:31 	dimsuz 	hi guys! suppose i'm currently on master. then run git
> 		fetch. which delivers updates to master and other
> 		branches. I don't merge anything, but do checkout some
> 		branch (which is not master).  Question: will these new
> 		updates get into this branch automatically after i check
> 		it out? question2: will branch master contain those
> 		updates when i ckeck it out later?
> 08:32 	Circuitsoft 	dimsuz. After a fetch, no.
> 08:33 	Circuitsoft 	However, if you pull, any branches that were set
> 			up as local tracking branches will get updated.
> 08:33 	Circuitsoft 	Otherwise, only remote tracking branches will be
> 			updated.
> 
> http://colabti.de/irclogger/irclogger_log/git?date=2009-10-20#l969
> (No idea about that one, have seen that once before, but it's definitely
> not even remotely as common as the others)

I'd guess that's due to having local branches with no local changes, just 
to avoid detached HEAD, and therefore thinking it's normal to have a bunch 
of local branches that could be updated without merges. But I'm on a crazy 
"everybody really wants detached HEAD and is needlessly scared" kick, and 
I'm probably reading too much into it.

> 4) User expects "pull" to create branches
> 
> 07:25 	fynn 	Hey, I just pulled a branch from remote, and I don't see
> 		it in "git branch"
> 07:25 	doener 	fynn: if you "pull" that means "fetch this and merge it
> 		to what I have checked out"
> 07:25 	fynn 	doener: hm, I just did "git pull" and it showed the new
> 		branch
> 07:26 	fynn 	but I don't see it in my branches...
> 07:26 	fynn 	doener: should I create that branch as a tracking branch
> 		first?
> 07:26 	doener 	fynn: you're looking at "git branch -r" or "git branch
> 		-a", right?
> 07:26 	fynn 	doener: yeah, I'm seeing it in origin/foo, but not
> 		local.
> 07:26 	doener 	fynn: the "git fetch" should have created a remote
> 		tracking branch, as usual, not a local branch head
> 		(which would be shown by just "git branch")
> 07:27 	fynn 	doener: OK, what should I do to create it locally then?
> 07:28 	doener 	fynn: just the usual "git branch foo origin/foo", or to
> 		checkout at the same time: "git checkout -b foo
> 		origin/foo" or "git checkout -t origin/foo" (shortcut)
> 
> http://colabti.de/irclogger/irclogger_log/git?date=2009-10-19#l830
> (Note how my "fetch this and merge it" is actually inaccurate for just
> "git pull", there is no "this" and that case. I took "pulled a branch"
> to mean that he did "git pull <remote> <branch>", which wouldn't have
> created/update the remote tracking branch [or did patches for that go
> in? I lost track...])

That sounds like a real converse of "push", including creating like-named 
local branches. Or, perhaps, this is someone expecting that "pull" is like 
"clone" in creating an initial local branch with the name and value of a 
specified remote branch.

> 4b) User expects pull to create a branch head
> 
> 09:58 	araujo 	git pull origin <new_branch>
> 09:58 	araujo 	will get me the new branch from repo right?
> 10:00 	charon 	araujo: no, that will fetch *and merge* that branch
> 10:00 	araujo 	charon, how to just pull?
> 
> http://colabti.de/irclogger/irclogger_log/git?date=2009-10-19#l1152
> (Note how he asked "how to just pull?", even after being told that pull
> isn't what he wants)

That's got to be hg usage. He knows the command isn't "pull", but he's 
stuck with the operation it performs being pulling. Or maybe he's thinking 
that the operation is pulling, and the command needs different arguments 
to not merge.

> 5) User possibly expecting "pull" to be able to act as "reset --hard"
> 
> 21:01 	aidan 	What do I do about this: html/config/core.php: needs
> 		update
> 21:02 	aidan 	git pull (gives that)
> 21:02 	Ilari 	aidan: You have uncommitted changes to that file...
> 21:15 	aidan 	Ilari: how can I just pull master and overwrite any
> 		changes?
> 
> http://colabti.de/irclogger/irclogger_log/git?date=2009-10-18#l2130
> (I'm not sure about that one, "overwrite any changes" might mean "drop
> uncommitted changes and merge" or "just get me the remote's state,
> dropping my commits and uncommitted changes". Most of the time I've seen
> similar requests, the user wanted the latter).

So I think that's a desire for "git checkout ." first of all (with the 
assumption that the content without modifications has to come from 
somewhere remote). I don't know what's up with people not wanting to save 
their commits, though.

> 6) User says "pull" but probably means "fetch"
> 
> 14:08 	Alien_Freak 	once I have a clone of a repo I know you can do
> 			a checkout tag but is there anyway to pull just
> 			the tag?
> 
> http://colabti.de/irclogger/irclogger_log/git?date=2009-10-16#l1664
> (There was no answer, thus it's hard to tell, but I guess he wanted
> something like:
> git init; git fetch --no-tags url tag <tag>; git checkout <tag>
> At least I'm quite sure he didn't mean "pull" as in "git pull")

I don't know; you can actually do:

$ git init; git pull --no-tags <url> tag <tag>

It updates the master branch and working directory from (nothing) to the 
fetched tag.

> 7) User expecting "pull" to just do fast-forwards (or so)
> 
> 13:18 	ohadlevy 	I'm getting a merge commit message after each
> 			time i do git pull, i didnt have it before,
> 			where should I look?
> 13:20 	charon 	ohadlevy: pull merges; you may just have hit lucky so
> 		far, and always had a fast-forward merge
> 13:20 	ohadlevy 	charon: any way I could avoid these commits?
> 			just rebasing? its a pure RO repo
> 
> http://colabti.de/irclogger/irclogger_log/git?date=2009-10-16#l1579
> (Apparently, user was tricked by the fast-forward behaviour he
> experienced earlier. I don't see any solution to this, except for
> defaulting to fast-forward-only and requiring a --merge flag (which
> might imply --no-ff), but I'm likely influenced by the "git update"
> stuff here)

Again, sounds like the user does want to update local branch state, if 
there is any. Probably doesn't want a local branch, what with being 
confused at the possibility of having history that's not from the remote.

> 8) "reset --hard" again
> 
> 20:10 	roger_padactor 	i commited then did a pull how do i get back to
> 			my commit. the pull over wrote the files
> 20:11 	merlin83 	roger_padactor: you can't, pull == fetch + hard
> 			reset to latest commit
> 
> http://colabti.de/irclogger/irclogger_log/git?date=2009-10-14#l2306
> (Someone being told that pull is fetch + reset --hard is actually new to
> me. Only saw that as an expectation previously.)

That's odd. How could you not notice that it doesn't actually do that, 
even if you try to get it to?

> 9) More "git pull <remote> A:A"
> 
> 19:10 	_hp_ 	another question, how do I add the remote branch to
> 		track so I don't have to constantly do git pull origin
> 		masterA:masterA ?
> 19:11 	Ilari 	_hp_: Don't use that src:dest with pull!
> (discussion died)
> 
> http://colabti.de/irclogger/irclogger_log/git?date=2009-10-12#l2427

Yup. Oh, and it strikes me that this user must have never made any 
commits, because that would give an error (not fast forward) on the fetch 
part.

> 10) "pull" mistaken for "cvs update"
> 
> 07:25 	Avrem 	how do I use "git pull" to do something like what "cvs
> 		update" does ?
> 07:25 	Avrem 	which is, replaces files I've deleted
> 07:25 	Avrem 	from that from the central repository
> 07:30 	omega 	I'm not sure, but can't you git checkout <deleted files>
> 		to get them back?
> 
> http://colabti.de/irclogger/irclogger_log/git?date=2009-10-11#l545
> (This adds a new twist to the "scm update" stuff, although svn/hg don't
> seem to have "restore individual files" in their "update" command, so
> this might be cvs-only. But it's so long since I used cvs, I don't even
> know whether this is correct. But it somehow got me thinking about how
> "update" is actually also "downgrade" in svn/hg, something git does via
> "checkout" [which happens to make more sense to me]. And I think it
> shows how "git pull" is taken to mean "update", even when ignoring the
> special behaviour described here. It's not taken to mean "merge this",
> but just "update to upstream").

"cvs update" can definitely discard uncommitted changes, according to the 
--help text.

Actually, I wonder if the right formula is update = fetch + checkout. 
There are a lot of people (IMHO) want "git fetch origin; git checkout 
origin/master", and I think their first idea is "git update", but that 
doesn't exist, and they find "pull" as the closest thing.

> So that's ten days of #git. I left out a bunch of duplications (most
> were "pull == fetch", "pull == update" and "pull to update
> non-checked-out branch").

Very interesting. I feel like this is a new thing since I last spent much 
time on IRC, when it was all people pushing into non-bare repositories. 
Thanks for taking the time to collect this.

	-Daniel
*This .sig left intentionally blank*
--1547844168-38141353-1256098938=:14365--
