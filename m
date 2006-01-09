From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect is magical
Date: Mon, 9 Jan 2006 15:38:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601091516460.5588@g5.osdl.org>
References: <dpuoqf$3rp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 00:38:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew6ap-0002W0-DJ
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 00:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbWAIXiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 18:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWAIXiY
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 18:38:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63927 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751337AbWAIXiY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 18:38:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k09NcLDZ003294
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Jan 2006 15:38:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k09NcKEC029567;
	Mon, 9 Jan 2006 15:38:21 -0800
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dpuoqf$3rp$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14389>



On Mon, 9 Jan 2006, walt wrote:
>
> Arthur C. Clarke's Third Law states:  Any sufficiently advanced
> technology is indistinguishable from magic.
> 
> You guys have done it -- I can't distinguish git-bisect from
> magic.  It's wonderful, and thank you!

Hey, I'm pretty damn happy with it myself, if I may say so ;)

It's the _one_ feature that we really never had with BK, and that git does 
really really well.

> I have one minor suggestion for howto/isolate-bugs-with-bisect.
> Linus states:
>        git bisect good ORIG_HEAD       <- mark ORIG_HEAD as good (or
>                                            whatever other known-good
>                                            thing you booted last)
> 
> Well, in my case, I new the last good kernel was *two* updates ago,
> so ORIG_HEAD wasn't the right thing to use.  I had to guess what
> to type instead of 'ORIG_HEAD'.

Well, instead of guessing, you can always do the safe thing, and just try, 
or just going far enough back to be really safe.

The "go far back" case is obviously wasteful, and if you go _too_ far 
back, you'll just spend a long time bisecting, but on the other hand, 
a binary search is pretty damned efficient, so even going back _way_ too 
far usually just results in a couple more bisection attempts.

But if you're unsure, before marking somethng "good", you can just test it 
out first, by doing something like

	git checkout -b test <version-to-test-here>

and compiling and testing that one. If it's good, you can just do a simple 
"git bisect good" to say that the current state was good..

Oh, and in general you don't ever have to name the good/bad ones: the 
example in Documentation/howto states that you should say

	git bisect bad master
	git bisect good ORIG_HEAD

but the fact is, whenever you leave off the version specifier, it will 
just assume that "current HEAD" is it. So quite often, a "git bisect" run 
will start with just a simple

	git bisect bad

to mark that the current head is bad (of course, that's 100% equivalent to 
saying "git bisect bad master" if you are on the master branch right 
then).

And if you don't remember what your last good kernel was, but you're sure 
that the last full release was good, you can just do

	git bisect good v2.6.15

and be done with it.

(Of course, right now there's 2075 commits in my git tree after 2.6.15, so 
that's a fair amount of bisecting.. But let's say that you had known more 
exactly, and been able to start off with just 300 commits - you only have 
to do three "bisect" runs to whittle the 2075 commits down to that range 
anyway - so it's not like you are totally screwed even if you don't know 
where the good one was).

> Which leads to one more question:  I have my kernel configured to
> add the -gxxxxxxxx localversion string to the kernel name.

Good man.

>						 I took
> a wild guess that the xxxxxxxx was the right thing to substitute
> for 'ORIG_HEAD' and I got lucky.

Yes. I guess we should document what the "-gxxxxx" thing means in the 
kernel, and that it's simply the short-hand git name for the top commit 
when the kernel was compiled. So you did exactly the right thing.

>			  But what about someone who
> doesn't know the magic 'xxxxxxxx' to use?  If I didn't know enough
> to keep a week's worth of daily kernel-builds with the 'xxxxxxxx'
> to guide me, would I still be able to do what I did today?

Yes. See above. It certainly takes you more effort, but it's not _hugely_ 
more effort.

> (For example, if this had been a 'git' bug instead of a kernel bug,
> I don't think I could have figured out how to use git-bisect to find
> the bug -- could I?)

Well, if you know how git works internally, it's actually fairly easy to 
do with any random project. You could, for example, just test whether 
git-1.0.6 was good first. Or, again, just use a sledge-hammer, and go for 
the original 1.0.

The alternative is to just ignore tagged versions altogether, and go by 
date. For example, you could do something like

	git log --since=1.week.ago

and just go to the end (right now, for me, that would be commit 8b32572, 
aka "git-init-db(1): Describe --shared and .."). Again, just do

	git checkout -b test 8b32572

and try that. If it was good, just mark it good and go from there. The 
test cycle for git is going to be a lot faster than the test cycle for the 
kernel, so you'll find any bug in no time.

		Linus
