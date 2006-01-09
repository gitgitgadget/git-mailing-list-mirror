From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 17:13:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601081643090.3169@g5.osdl.org>
References: <20060108212057.79825.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 02:14:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvlcL-0006kh-6S
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 02:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWAIBOf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 20:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWAIBOf
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 20:14:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751496AbWAIBOd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 20:14:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k091DnDZ006169
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 8 Jan 2006 17:13:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k091Dljw011391;
	Sun, 8 Jan 2006 17:13:47 -0800
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20060108212057.79825.qmail@web31815.mail.mud.yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14342>



On Sun, 8 Jan 2006, Luben Tuikov wrote:
>
> How about this usage (branch == tree):
> 
> Tree A    (your tree)
>   Tree B     (project B, dependent on Tree A)
>      Tree C     (project C, dependent on project B)
> 
> (i.e. diff(C-A) = diff(C-B) + diff(B-A))
> 
> Your tree is pulled into Tree A as often as your tree
> changes and it just fast forwards.
> 
> If I want to run project B with your latest tree, then
> I resolve/merge from tree A to tree B, compile B
> and run it.
> 
> If I want to run project C and project B with your
> latest tree, I resolve/merge from tree A to tree B
> and from tree B to tree C, compile C and run it.

No.

If tree B is based on _some_point_in_ A, then you just test that.

Because development line B is _independent_ of development line A. The 
fact that A changes doesn't change B - unless they have some real 
dependencies (which we should try to avoid).

So when you update ("fetch" in git parlance) branch A from me, that 
shouldn't affect branch B _nor_ branch C in any way. They clearly do not 
depend on the new stuff in A, since they do their own independent 
development. The fact that they _started_ at some random point during the 
development of A doesn't change that fact.

Now, if you want to _test_ the combined "new stuff in branch A and new 
stuff in branch B", feel free to do that. But realize that that is _not_ 
appropriate in either branch A _nor_ branch B.

So you'd be much better off with a separate "test" branch that you test 
stuff out in, and you then resolve ("pull" in git parlance) both branch A 
and branch B into that test branch.

See? Testing the combination of two branches doesn't actually have 
anything to do with either branch.

At some point, you decide that you want to merge what you've done in 
branch B. That's a _different_ and independent thing from deciding that 
you want to test the combination of two development branches. Clearly, 
it's great to test often, but that has nothing to do with releasing a 
branch.

> In such cases, are you saying that you'd prefer to
> pull from Tree B and Tree C (depending on your needs)?

I'm saying that mixing up the "let's test the combination" and "let's 
merge the two branches" are totally different things and should not be 
mixed up.

One is a random event (and then it makes sense to have, for example, a 
"automated test branch" that automatically merges every day and tests the 
results. I don't think you should expose those random merges to others, 
because they actually hinder the readability of the history for _both_ 
sides.

The other is a _directed_ event. It's the event of saying "branch B" is 
now ready to be merged. Usually that's best done by just saying "please 
pull now" - ie not by merging branch A into branch B (because that's not 
what you actually want, is it? What you want is for the development in 
branch B to show up in branch A - so you want branch A to do the pull).

Now, there's a third kind of event, which is again independent of the 
other two. It's more of a "let's try to keep the 'topic branch' 
development up-to-date with the branch we eventually want to merge the 
topic changes into". That's where you can now do two things:

 - David often "rebases" all of the changes in his "topic branch" (ie 
   conceptually "branch B") to the new top-of-head of "branch A". In other 
   words, he re-writes branch B entirely _as_if_ it was based on the newer 
   state "branch A". This is what "git rebase" is all about.

 - You can just pull from branch A into branch B, as a way to keep branch 
   B more up-to-date with the work in the "main trunk" or whatever. This 
   is ok, but it shouldn't be a common event. It should be something that 
   happens when you (for example) notice during testing that the test 
   merge no longer works cleanly. Or it might be "It's now been two weeks 
   since I synchronized, let's just synchronize to be safe".

See? I'm not objecting to topic branches pulling from my tree in general. 
It's just that they should have a _reason_. There's never any reason to 
pull into a development tree that you haven't done any development in, 
just because you also want to use that development tree for testing.

> Another question:
> Sometimes, a fix for project B finds its way into
> tree C (project C) (since C depended on that fix in B).
> Now I'd like to pull that particular fix, identified by
> its SHA, into project B, and nothing else, for this I can
> use git-cherry-pick, right?

That's one way. It's often the best way, especially if it's a really 
obvious bugfix. Or you could just fix it in your tree yourself. It will 
mean that the two branches have the same fix, but especially if it really 
is an identical fix, it won't be a merge problem.

You _can_ just decide to pull branch B into branch C, but that has a real 
problem, namely that it inexorably links the two together, so that nobody 
can then pull branch C without pulling indirectly branch B at the time 
that B->C merge happened. Sometimes that is ok. But it's nice to avoid it 
if you can.

But for example, if somebody fixed something in the trunk, and you 
actually do need that fix from the trunk for your topic branch 
development, then just doing a pull is _fine_. Now we're back to doing a 
merge that actually has a perfectly good reason.

IOW, don't cherry-pick to avoid merges when the merge really does make 
tons of sense. Merges are good, it's just that _too_ much of a good thing 
is bad.

> And lastly, is there a tool whereby I can "see" changes
> between repos, kind of like git-diff but being able to
> give URLs too?

No, all the good tools really are based on fetching (NOT "pulling") the 
other branch into your local tree as a separate branch. At that point, 
there are tons of wonderful tools you can use.

In other words, say that you want to know what has happened in another 
repository, at git://git.kernel.org/xyzzy. You aren't interested in the 
stuff that is already part of the trunk, you're just interested in what is 
only in that "xyzzy" branch, and how it relates to your code. 

What you'd do is

	git fetch git://git.kernel.org/xyzzy master:xyzzy-snapshot

which says "fetch the 'master' branch from that xyzzy repository, and call 
it 'xyzzy-snapshot' locally.

You can then (for example) fetch the code that is in _my_ tree by doign 
the same time (just call that branch 'linus'), and you can now do

	gitk linus..xyzzy-snapshot HEAD

which looks strange (you give "gitk" _both_ a range from the "linus" 
branch to the "xyzzy-snapshot" _and_ your own HEAD at this time), but what 
it basically does is that the "linus.." syntax tells git that you're not 
interested in anything that is already in the 'linus' branch.

So the above command line will actually graphically show _both_ your 
current HEAD branch _and_ the 'xyzzy-snapshot' branch, in parallel. You 
can see how (if at all) they are related to each other, ignoring all the 
commits that have already made it into my tree.

(You can also do "linus..HEAD" instead of just HEAD and effectively repeat 
the "don't show 'linus' branch any more" twice. It's perfectly equivalent, 
of course. You may also want to use the "-d" flag to "gitk" which tells it 
to show things in date order, instead of a simplified history order).

Or just do "what has xyzzy-snapshot that I do not have in my HEAD":

	git log HEAD..xyzzy-snapshot

(or gitk), or the other way around: what do _I_ have in my HEAD that 
hasn't been pushed to xyzzy-snapshot yet:

	git log xyzzy-snapshot..HEAD

(or do diffs, "git whatchanged -p", or whatever).

In other words, using a few different branches (you can make them up 
dynamically) can be very powerful.

		Linus
