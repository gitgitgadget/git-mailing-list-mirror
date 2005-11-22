From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: auto-packing on kernel.org? please?
Date: Tue, 22 Nov 2005 10:25:58 -0700
Organization: Hewlett Packard
Message-ID: <20051122172558.GA1935@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> <20051121190151.GA2568@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 18:29:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EebuG-000870-GS
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 18:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbVKVR0H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 12:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVKVR0G
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 12:26:06 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:49792 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S965011AbVKVR0E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 12:26:04 -0500
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.11.136.119])
	by atlrel8.hp.com (Postfix) with ESMTP id F2F5145F2;
	Tue, 22 Nov 2005 12:26:03 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id 766AD38729; Tue, 22 Nov 2005 17:25:58 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 581218FCA; Tue, 22 Nov 2005 10:25:58 -0700 (MST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12557>

On Mon, Nov 21, 2005 at 11:24:11AM -0800, Linus Torvalds wrote:
> NOTE! Since that email, "git repack" has gotten a "local" option (-l), 
> which is very useful if the repositories have pointers to alternates.
> 
> So do
> 
> 	git repack -l
> 
> instead, to get much better packs (and "-a -d" for the full case, of 
> course).

I'm assuming that this option will have no effect on a repository with
no alternates file.

> Other that than, the old email suggestion should still be fine.

[snip]

> You can certainly do that if you are nervous. It might even be a good 
> idea: just for fun, I just did
> 
> 	git clone -l git git-clone
> 	cd git-clone
> 
> 	# pick an object at random
> 	rm .git/objects/f7/c3d39fe3db6da3a307da385a7a1cb563ed15f7
> 
> 	git repack -a -d
> 
> and it said:
> 
> 	error: Could not read f7c3d39fe3db6da3a307da385a7a1cb563ed15f7
> 	fatal: bad tree object f7c3d39fe3db6da3a307da385a7a1cb563ed15f7
> 
> but then it created the pack _anyway_, and said:
> 
> 	Packing 27 objects
> 	Pack pack-13bfca704078175c1c1c59964553b14f7b952651 created.
> 
> and happily removed all the old ones.
> 
> So right now, repacking a broken archive can actually break it even more.

Interesting.

> NOTE! Your "git verify-pack" wouldn't even catch this: the _pack_ is fine, 
> it's just incomplete.

In my opinion, git repack did the right thing in creating the pack even
if it is more broken.  Starting with a broken repository was the real
problem.  git repack shouldn't need to worry too much about it.

Looking at it from the nervous repository admin's point of view I think
he would want to make sure that the repository is good to begin with.  I
think this should be left up to the repository owner and maybe not git
repack.  Although, the check that you do following this is probably a
good idea.

> Of course, this only happens if the repository was broken to begin with, 
> so arguably it's not that bad. But it does show that git-repack should be 
> more careful and return an error more aggressively.
> 
> Can anybody tell me how to do that sanely? Right now we do
> 
> 	..
> 	name=$(git-rev-list --objects $rev_list $(git-rev-parse $rev_parse) |
> 	        git-pack-objects --non-empty $pack_objects .tmp-pack) ||
> 	        exit 1
> 	..
> 
> and the thing is, the "git-pack-objects" thing is happy, it's the 
> "git-rev-list" that fails. So because the last command in the pipeline 
> returns ok, we think it all is ok..
> 
> (This is one of the reasons I much prefer working in C over working in 
> shell: it may be twenty times more lines, but when you have a problem, the 
> fix is always obvious..)
> 
> Anyway, with that fixed, a "git repack" in many ways would be a mini-fsck, 
> so it should be very safe in general. Modulo any other bugs like the 
> above.
> 
> 		Linus

*NOTE*  There is one question that I feel remains unanswered.  Is it
possible to split up the repack -a and repack -d so that the nervous
repository owner can insert a git verify-pack in the middle.

I'm not nearly this nervous about repositories that I keep for myself
but I have ownership of some repositories on which many people may
depend.  I will feel better if I can verify the pack separately from
git-repack before I do the (potentially destructive) -d to remove old
packs.

I don't mean to say that I don't trust git repack to do the right thing.
Fundamentally, I just think that I shouldn't depend on it to do the
right thing in order to avoid corruption in my repository.

Carl

PS  I love that the git object store is designed so that object files
never *need* to be removed, renamed, modified or otherwise touched in
any way after being written to disk.  I think this makes git inherently
extremely safe from corruption unlike many other older repository
designs.  The only thing that breaks this inherent safety is the desire
to pack repositories to avoid bloat.

That is why I want to be a little paranoid when I do the repacking.  I
want to maintain some inherent safety in the process that I use to pack
them.  This kind of inherent safety is much more valuable then even the
highest quality code written to actually do the packing.

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
