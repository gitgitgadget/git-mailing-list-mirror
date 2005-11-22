From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: auto-packing on kernel.org? please?
Date: Tue, 22 Nov 2005 09:58:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511220939540.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
 <20051121190151.GA2568@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
 <20051122172558.GA1935@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 19:08:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EecWA-0001ZN-0J
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 19:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVKVSFQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 13:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbVKVSFQ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 13:05:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965067AbVKVSFO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 13:05:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAMHwnnO032472
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 22 Nov 2005 09:58:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAMHwjwS018897;
	Tue, 22 Nov 2005 09:58:45 -0800
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20051122172558.GA1935@hpsvcnb.fc.hp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12563>



On Tue, 22 Nov 2005, Carl Baldwin wrote:

> On Mon, Nov 21, 2005 at 11:24:11AM -0800, Linus Torvalds wrote:
> > NOTE! Since that email, "git repack" has gotten a "local" option (-l), 
> > which is very useful if the repositories have pointers to alternates.
> > 
> > So do
> > 
> > 	git repack -l
> > 
> > instead, to get much better packs (and "-a -d" for the full case, of 
> > course).
> 
> I'm assuming that this option will have no effect on a repository with
> no alternates file.

Correct.

The only thing it does is that when it looks up an object, if it's not in 
our _own_ ".git/objects/" dir, it won't pack it.

Actually, that's not entirely true. It isn't smart enough to know where 
every object exists, so it only knows about remote _packs_. So what 
happens is that if you do

	git repack -l -a -d

it will create a pack-file that contains _all_ unpacked objects (whether 
local or not) and all objects that are in local packs (because of the 
"-a"), but not any objects that are in "alternate packs".

Which is actually exactly what you want, if you are in the situation that 
kernel.org is, and you have people who point their alternates to mine: 
when I repack my objects, they'll use my packs, but other than that, 
they'll prefer to use their own packs over any unpacked objects.

> > So right now, repacking a broken archive can actually break it even more.
> 
> Interesting.

Well, with the latest git repack script, that should no longer be true.

> > NOTE! Your "git verify-pack" wouldn't even catch this: the _pack_ is fine, 
> > it's just incomplete.
> 
> In my opinion, git repack did the right thing in creating the pack even
> if it is more broken.  Starting with a broken repository was the real
> problem.  git repack shouldn't need to worry too much about it.

Well, "git repack" did the wrong thing in that it never _noticed_, and it 
then removed all old packs - even though those old packs contained objects 
that we hadn't repacked because of the broken repository.

Of course, _usually_ a broken repository is just that - broken. The way 
you fix a broken repo is to find a non-broken one, and clone that. 
However, sometimes what you can do (if you literally just lost a few 
objects) is to find a non-broken repo, and make that the _alternates_, in 
which case you may be able to save any work you had in the broken one 
(assuming you only lost objects that were available somewhere else).

> Looking at it from the nervous repository admin's point of view I think
> he would want to make sure that the repository is good to begin with.

Doing an fsck is certainly always a good idea. I do a "shallow" fsck 
usually several times a day ("shallow" means that it doesn't fsck packs, 
only new objects that I have aquired since the last repacking), and I do a 
full fsck a couple of times a week.

I don't actually know why I do that, though. I don't think I've really 
_ever_ had a broken repo since some very early days, except for the cases 
where I break things on purpose (like remove an object to check whether 
"git repack" does the right thing or not). I'm just used to it, and the 
shallow fsck takes a fraction of a second, so I tend to do it after each 
pull.

So I really think that an admin has to be more than "nervous" to worry 
about it. He has to be really anal.

(Now, doing a repack and a fsck every week or so might be good, and 
automatic shallow fsck's daily is probably a great idea too. After all, it 
_is_ checking checksums, so if you worry about security and want to make 
sure that nobody is trying to break in and do bad things to your repo, a 
regular fsck is a good thing even if you're not otherwise worried about 
corruption).

> *NOTE*  There is one question that I feel remains unanswered.  Is it
> possible to split up the repack -a and repack -d so that the nervous
> repository owner can insert a git verify-pack in the middle.

They are already split up inside "git-repack", so we could add a hook 
there, I guess. See the git-repack.sh file, and notice how it does the 
"remove_redundant" part only after it has created the new pack-file and 
done a "sync".

> I don't mean to say that I don't trust git repack to do the right thing.
> Fundamentally, I just think that I shouldn't depend on it to do the
> right thing in order to avoid corruption in my repository.

That's good. However, as the previous failure of git repack showed, to 
some degree the more likely failure mode is actually that the pack 
generated by "git repack" is perfectly fine, but it's not _complete_. Say 
we have a bug in git repack, for example.

Another case where it's not complete is when you have deleted a branch. 
"git repack -a -d" will effectively do a "git prune" wrt objects that are 
no longer reachable, and that were in the old packs.

So I'd actually suggest a slightly different approach. When-ever you 
remove old objects (whether it's "git prune" or "git prune-packed" or "git 
repack -a -d"), you might want to have an option that doesn't actually 
_remove_ them, but just moves them into ".git/attic" or something like 
that.

Then you can clean up the attic after doing your weekly full fsck or 
something. And it has the advantage that if somebody has deleted a branch, 
and notices later that maybe he wanted that branch back, you can "unprune" 
all the objects, run "git-fsck-objects --full" to find any dangling 
commits, and you'll have all your branches back.

So in many ways it would perhaps be nicer to have that kind of "safe 
remove" option to the pruning commands?

			Linus
