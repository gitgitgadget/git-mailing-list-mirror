From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling very large numbers of symbolic references?
Date: Tue, 25 Jul 2006 15:23:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607251508540.29649@g5.osdl.org>
References: <87psfteb4l.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 00:24:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5VJz-0003uS-DO
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 00:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWGYWYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 18:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWGYWYH
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 18:24:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932359AbWGYWYG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 18:24:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6PMNwnW022054
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Jul 2006 15:23:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6PMNvX0012475;
	Tue, 25 Jul 2006 15:23:57 -0700
To: Nix <nix@esperi.org.uk>
In-Reply-To: <87psfteb4l.fsf@hades.wkstn.nix>
X-Spam-Status: No, hits=-0.528 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24191>



On Tue, 25 Jul 2006, Nix wrote:
> 
> However, this causes a potential problem. There are tens of thousands of
> these bugs, and the .git/refs/heads directory gets *enormous* and thus
> the system gets terribly terribly slow (crappy old Solaris filesystem
> syndrome).

I would really suggest you use some lookup logic of your own to handle 
this, because having that many refs will slow down a lot of things.

That said, you can certainly use a hierarchy of refs, and just have them 
as

	.git/refs/heads/00/000-999
			01/000-999
			02/000-999
			...

if you want to avoid the dreaded filesystem meltdown.

I suspect it would suck, though. You'd still end up with tens of thousands 
of small files, with no good way to pack them together.

> It seems to me there are two ways to fix this:
> 
>  - restructure .git/refs/* in a similar way to .git/objects, i.e. as a
>    one- or two-level tree.

So this work already.

>  - the vast majority of these bugs are closed. They still need to be got
>    at now and again for branch merges, but they could be got out of
>    .refs/heads at delete_branch time, and pushed into a tree consisting
>    entirely of deleted branches, which would in turn be pointed at from
>    some new place under .refs; perhaps .refs/heads/heavy (by analogy to
>    non-lightweight tags). The problem here is that whenever we delete
>    a tag, we'll leak that tree (at least we will if it's in a pack), and
>    that leakage really could add up in the end.

Well, the problem to some degree is that a number of git routines will 
look up all heads (eg things like "git pull" and "git ls-remote" and "git 
push", not to mention all the visualizers that want to show all the heads.

So so if you really en dup doing them as individual heads, I'm afraid that 
performance will suck big-time. And it wouldn't really help to put them 
under .git/refs/heads/heavy, you'd still be in trouble.

> I'm not sure which way is preferable. Suggestions? Is the entire idea
> lunatic?

I think you _can_ use git in the way you propose, but it's going to be 
fundamentally pretty inefficient. The diskspace usage will be inefficient 
(tens of thousands of files, all just 41 characters in size), but even 
more importantly, as mentioned, you'll have things like cloning or pulling 
a repository always havign to get tens of thousands of references, and 
that's just going to be very very slow.

So yes, I think it's a bit lunatic.

Git scales much better in _other_ ways. For example, one thing you could 
do is to have each bug-report be described as a _file_ instead of as a 
tag, and then have just one (or a few branches), and you'd have nice 
naming of bugs just because the filenames can be nice. That would allow 
git to shine because it scales well in things git is good at, ie the 
database itself.

You'd probably want to introduce the notion of a nice specialized "merge" 
for those files (assuming you really want to do _distributed_ reporting, 
and actually merge two different databases that have the same bugs), but 
git should actually be quite good at supporting something like that, even 
if you might have to do some infrastructure yourself.

OR, you could actually teach git about other ways of looking up names. So 
if you decide that you do want to have one branch per bug, you might want 
to teach git about a new "ref" file format that has multiple name/ref 
translations in the same file. That would solve the disk usage problem, 
even if it would _not_ solve the ineffiency of tools that might be 
slightly unhappy to see thousands and thousands of refs.

Anyway, whatever approach you select, send patches to Junio. I'm sure that 
we can try to make git support even some rather strange models.

		Linus
