From: Nix <nix@esperi.org.uk>
Subject: Re: Handling very large numbers of symbolic references?
Date: Wed, 26 Jul 2006 00:08:27 +0100
Message-ID: <87psftb7v8.fsf@hades.wkstn.nix>
References: <87psfteb4l.fsf@hades.wkstn.nix>
	<Pine.LNX.4.64.0607251508540.29649@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 01:08:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5W13-0001Jo-7P
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 01:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWGYXIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 19:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWGYXIg
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 19:08:36 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:5647 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030241AbWGYXIf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jul 2006 19:08:35 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id k6PN8R2l014746;
	Wed, 26 Jul 2006 00:08:28 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id k6PN8RQX001191;
	Wed, 26 Jul 2006 00:08:27 +0100
To: Linus Torvalds <torvalds@osdl.org>
X-Emacs: or perhaps you'd prefer Russian Roulette, after all?
In-Reply-To: <Pine.LNX.4.64.0607251508540.29649@g5.osdl.org> (Linus Torvalds's message of "Tue, 25 Jul 2006 15:23:57 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24192>

On Tue, 25 Jul 2006, Linus Torvalds noted:
> That said, you can certainly use a hierarchy of refs, and just have them 
> as
> 
> 	.git/refs/heads/00/000-999
> 			01/000-999
> 			02/000-999
> 			...
> 
> if you want to avoid the dreaded filesystem meltdown.

That's what I was hoping would work, but...

> I suspect it would suck, though. You'd still end up with tens of thousands 
> of small files, with no good way to pack them together.

... that is, indeed, the problem.

>>  - the vast majority of these bugs are closed. They still need to be got
>>    at now and again for branch merges, but they could be got out of
>>    .refs/heads at delete_branch time, and pushed into a tree consisting
>>    entirely of deleted branches, which would in turn be pointed at from
>>    some new place under .refs; perhaps .refs/heads/heavy (by analogy to
>>    non-lightweight tags). The problem here is that whenever we delete
>>    a tag, we'll leak that tree (at least we will if it's in a pack), and
>>    that leakage really could add up in the end.
> 
> Well, the problem to some degree is that a number of git routines will 
> look up all heads (eg things like "git pull" and "git ls-remote" and "git 
> push", not to mention all the visualizers that want to show all the heads.

Ick. Yes, that would be a bit of a sod. git-ls-remote showing >30,000 heads
is... not ideal. Not at all. (It's growing by ~50 a day...)

It's a sort of `hidden head' I meant. Hm. I think I see a way: see below.

> So so if you really en dup doing them as individual heads, I'm afraid that 
> performance will suck big-time. And it wouldn't really help to put them 
> under .git/refs/heads/heavy, you'd still be in trouble.

OK, so it has to go somewhere else.

>> I'm not sure which way is preferable. Suggestions? Is the entire idea
>> lunatic?
> 
> I think you _can_ use git in the way you propose, but it's going to be 
> fundamentally pretty inefficient. The diskspace usage will be inefficient 
> (tens of thousands of files, all just 41 characters in size), but even 
> more importantly, as mentioned, you'll have things like cloning or pulling 
> a repository always havign to get tens of thousands of references, and 
> that's just going to be very very slow.
> 
> So yes, I think it's a bit lunatic.

It's perhaps unusual, but, well, the version control system we're
switching from takes over an *hour* just to check out some classes of
files! (SCCS's handling of large binary files is... inefficient if
naively kludged by uuencoding everything before committing it; we have
some s-files whose size is approaching a gigabyte as a result, being
accessed over very slow NFS. git, of course, doesn't need such crud,
although I may need to teach the deltifier about xdelta or something of
that nature to keep sizes down in the long run.)

> Git scales much better in _other_ ways. For example, one thing you could 
> do is to have each bug-report be described as a _file_ instead of as a 
> tag, and then have just one (or a few branches), and you'd have nice 
> naming of bugs just because the filenames can be nice. That would allow 
> git to shine because it scales well in things git is good at, ie the 
> database itself.
> 
> You'd probably want to introduce the notion of a nice specialized "merge" 
> for those files (assuming you really want to do _distributed_ reporting, 
> and actually merge two different databases that have the same bugs), but 

That's the sort of unlikely thing which is *certain* to happen :) but in
practice until those database merges actually take place I can't be sure
how the renumbering would be done :/ but no, the heaps-of-refs seems
like the only practical way, because in practice people treat these bugs
as little sets of changed files that they can merge all over the place,
and, well, that's a branch as far as I can see. Of course, the
difference between a branch and a `tree of commits which has a ref-like
thing pointing to it' is minimal: I'd have to teach git-fsck-objects
about it anyway to stop it ditching things as unreachable when they
weren't...

> git should actually be quite good at supporting something like that, even 
> if you might have to do some infrastructure yourself.
> 
> OR, you could actually teach git about other ways of looking up names. So 

This is what I was thinking of doing.

> if you decide that you do want to have one branch per bug, you might want 
> to teach git about a new "ref" file format that has multiple name/ref 
> translations in the same file. That would solve the disk usage problem, 
> even if it would _not_ solve the ineffiency of tools that might be 
> slightly unhappy to see thousands and thousands of refs.

Well, actually I was considering trying a combination of two things:

 - a new type of multi-entry ref (as you suggested), perhaps in a file
   refs/inactive-heads, which is merged with the heads list by lookup
   operations only (so merge would see them, but ls-remote would not:
   `invisible heads' if you will); git-branch moves head refs there upon
   deletion; so even deleted head refs are referenceable by name
   forever. The merging for lookup would scale as O(n), of course, but
   that can probably be ignored until we have hundreds of thousands of
   them (whereupon the right thing to do is probably to change the
   inactive-heads file format and lookup code and keep the general idea).

   (This might mean rejigging code that assumes that looking up a ref is
   an open() away, but that shouldn't be all that terribly hard, one new
   tool, `git-lookup-ref', sort of like git-symbolic-ref only applying
   to refs that aren't symbolic).

 - dependency information could be handled by rebasing the depending
   branch on the heads of the branches which it depends upon, but, well,
   that seems extremely icky to me, especially if those branches are
   still changing: we'd have to re-rebase all the time to stay up to
   date. I suspect that a new object type, or perhaps a new type of ref,
   would be right here. The idea is that you express a mapping from one
   branch ref to another set of branch refs (*not* sha1 id, because there
   is no fixed sha1 id that corresponds to a given branch in the presence
   of commit and git-rebase).

   A new object type seems ideal for this (sort of like a commit only
   with ref names instead of sha1 ids), but I'm under the impression
   that adding new object types to git is quite tricky and introduces
   inter-repository incompatibilities, so I might just make it a
   refs/dependencies directory with one file per depending bug, containing
   many ref names for the bugs it depends on. (There will likely be many
   fewer dependencies than inactive bug branches, anyway.)

This should be fun!

> Anyway, whatever approach you select, send patches to Junio. I'm sure that 
> we can try to make git support even some rather strange models.

Yeah, I'm planning to make this general enough that anyone can use it:
there'll be an outer layer of glaze around the porcelain which is
specifically to change the command-line syntax to be similar to the tool
that the poor sods at work are moving from, but I'll maintain that in a
branch that nobody sane will pull and that I won't push to anyone, and
keep it out of the tree meant for sane people. (I'm not sure if `local
branch' is really the right term for it: I mean, this is git, *all*
branches are local, or none are...)

-- 
`We're sysadmins. We deal with the inconceivable so often I can clearly 
 see the need to define levels of inconceivability.' --- Rik Steenwinkel
