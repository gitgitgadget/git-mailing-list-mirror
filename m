From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 11:42:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610211102250.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
 <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
 <20061020225917.GA30584@coredump.intra.peff.net> <20061021174056.GA29927@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 20:43:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbLoT-0006Hi-Ls
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 20:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422787AbWJUSnO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 14:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422788AbWJUSnO
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 14:43:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422787AbWJUSnN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 14:43:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9LIgxaX002364
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 Oct 2006 11:43:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9LIgwFO030406;
	Sat, 21 Oct 2006 11:42:59 -0700
To: Jan Hudec <bulb@ucw.cz>
In-Reply-To: <20061021174056.GA29927@artax.karlin.mff.cuni.cz>
X-Spam-Status: No, hits=-0.981 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29654>



On Sat, 21 Oct 2006, Jan Hudec wrote:
>
> [ On not moving files that weren't moved originally, but whose
>   directories were moved ]
> 
> I still consider it a bug, but different problems of the file-id
> solution have already been described in this thread that I consider bugs
> as well.
> 
> Besides I start to think that it should be actually possible to solve
> this case with the git-style approach.

It's certainly _possible_ to figure out, but one reason git does what it 
does is that it's just simpler (ie just ignore the whole "directory move" 
situation entirely, and just consider it to be "many files moved"). 

Another reason is that this really is an ambigious case. When the 
directory was moved, the file in question really didn't exist. So when it 
was created independently of the move, it really _is_ somewhat ambiguous 
whether the intention was to move it with the other files or whether the 
new creation point is the right one.

I think that for a human, the details would likely be obvious (and I 
suspect that in most cases it would indeed move with the directory). But 
it really isn't totally clear: what does moving a directory imply for the 
future? Does it imply that the directory should never exist in the future, 
or does it just imply that the _current_ contents move?

Git "tends to" have a policy of not caring about directories at all. For 
example, git will not track an empty directory by default. You _can_ make 
it track one in your commits (the data structures support it), but you're 
really just better of just thinking of git as tracking individual files, 
and nor really directories. So as far as git is concerned, "directories" 
mostly don't really have any existence on their own, they only exist as 
paths to reach files.

In that kind of mindset, renaming a directory really is about renaming the 
files that are in that directory, and that explains the git behaviour. It 
may not necessarily be what you expect, but it _is_ consistent, and it's 
not really "wrong" either. It's just another way of looking at the thing.

Also, I'd like to point out that people worry way too much about merges. 
There are much harder merge conflicts to fix up. If you notice that things 
didn't go the way you expected in a merge, even if it was done 
automatically, you can just do a

	git mv unexpected/directory/file expected/directory/file
	git commit --amend

which basically "fixes up" the automatic merge (that's what the "--amend" 
means: it means "re-do the last commit with _this_ state instead).

(Of course, you could also just make a separate commit to move the file, 
but I think the "manual fixup of the merge" is just cleaner - just add a 
note in the commit message to say you fixed it up by hand. When you do 
your "git commit --amend", it will automatically just give you an editor 
to edit up the commit message too while you're at it).

So again: merges are certainly fairly "hard" from a SCM standpoint, but 
from a user standpoint, they tend to be not at all as important. I would 
again argue that more important than the merge itself (which you can 
trivially just fix up to match your expectations) is to make it easy to 
later _show_ what happened, ie if you examine the file later, you should 
be able to see where it came from.

(And again, with git, things like "git pickaxe" - think of it as just a 
"better annotate" - will indeed pick up the similarity, regardless of 
whether the rename was done manually or automatically as part of the 
merge - exactly because git only really cares about actual contents).

Btw, just to be honest: git _mostly_ thinks in terms of "constant 
pathname patterns" as opposed to "individual paths that move around". 
That's at least partly because of how I work. I actually fairly seldom 
look at an individual file, and tend to much more often look at a group of 
files, and then it's a _lot_ more convenient to do

	gitk drivers/usb include/linux/usb*

where those argument pathnames are _not_ a set of filenames that we track, 
but really somethign more generic, namely a "repository pathname subset" 
which is constant. The above will show the _subset_ of the kernel 
repository history that is relevant for all the named pathnames, but the 
pathnames are _fixed_. It won't follow files that move out of the 
subdirectories: it will show the history as seen from the viewpoint of a 
certain subset of pathnames.

This also extends to things like "git log". So when you do

	git log kernel/sched.c

if you have a "file ID" mentality, you expect the above to follow renames. 
It doesn't - even though git -can- follow renames, what the above actually 
_means_ is "show the log for the fixed pathname set that only includes one 
single path". 

So if "kernel/sched.c" had originally been called something else, the 
above wouldn't show the rename at all. It would just show that "oh, this 
pathname suddenly was created as a new file", because from the viewpoint 
of that fixed pathname, that's _exactly_ what happens.

We've discussed adding a "--follow" flag to tell "git log" to consider the 
argument to not be a "pathname filter", but a "individual file" kind of 
thing, and I think there was even a patch for it, but I suspect it hasn't 
been a big issue, probably partly because you get rather used to the 
"pathname filter" approach fairly quickly. If you knew what the old 
pathname was, for example, you could get git to _tell_ you about the 
rename by doing

	git log -M -- <set-of-all-pathnames-we're-interested-in-old-included>

and git would happily see the renames that happen _within_ that pathname 
filter (the "-M" is there because by default "git log" doesn't show any 
patches at all, of course, so if you want to see the rename, you need to 
tell git so).

As a particular example of this behaviour, if you do

	git log -M kernel/

you'll always see any renames that happen _within_ that subdirectory, but 
any files that are moved into (or out of) the subdirectory will be 
considered to be "create" or "delete" events - because you've literally 
told git to ignore all history that is not relevant to the kernel/ 
subdirectory (so they really _are_ "create/delete" events as far as that 
subdirectory is concerned).

Is this different from other SCM's? Hell yes. git does a lot of things 
differently. Is it useful? Again, hell yes. Especially for a maintainer, 
the ability to talk about pathname _patterns_ is generally much more 
important than talking about any particular file.

[ The pathname thing also means that it's trivial to ask questions like 
  "ok, so what happened to file xyz that I _know_ we used to have, but 
  clearly don't have any more?".

  You just do "git log -- xyz", and you'll see exactly what you wanted to 
  see. The "--" here (and in a previous example) is because to avoid 
  ambiguity, git requires that if you name files that don't actually 
  exist, you make it clear that they are filenames, not just mistyped 
  revision ID's or something else. ]

In general, git gives you the best of both worlds. It knows how to follow 
individual files if you want to, but by default it uses this much more 
generic concept of "pathname filters". The default is definitely 
influenced both by my usage, and my (obviously very strong) opinions on 
what is more important (and thus the git "mental model").

		Linus
