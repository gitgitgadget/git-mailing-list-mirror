X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: If merging that is really fast forwarding creates new commit
 [Was: Re: how to show log for only one branch]
Date: Tue, 7 Nov 2006 08:05:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611070729370.3667@g5.osdl.org>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net>
 <454F31D7.1030202@gmail.com> <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
 <45503553.3020605@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 7 Nov 2006 16:08:39 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45503553.3020605@gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31075>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhTUx-00015Y-AO for gcvg-git@gmane.org; Tue, 07 Nov
 2006 17:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964973AbWKGQHz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 11:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWKGQHz
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 11:07:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14216 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S964973AbWKGQHx (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 11:07:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA7G5coZ026390
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 7
 Nov 2006 08:06:32 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA7G5MOW006258; Tue, 7 Nov
 2006 08:05:22 -0800
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org



On Tue, 7 Nov 2006, Liu Yubao wrote:
>
> > If a fast-forward were to do a "merge commit", you'd never get into the
> > situation where two people merging each other would really ever get a stable
> > result. They'd just keep doing merge commits on top of each other.
>
> They can stop merging a fake commit with a real commit that point to same
> tree object, here they reach a stable result: we have same tree content.

That's flawed for two reasons:

 - identical trees is meaningless. You can have identical trees that had 
   different histories and just happened to end up in the same state, and 
   you'd still generate a merge commit (because what merges do is show the 
   history of the data, and the _history_ merges). 

   So you're really just introducing a special case, and not even one that 
   makes any sense. Either history matters, or it doesn't.

 - a distributed system fundamnetally means that nobody is "special". And 
   a merge is a _joining_ of two threads. Neither of which is special. 

   Let's say that we have

	A:	a -> b -> c -> d

	B:	a -> b -> c

   and B pulls. You think that it should result in

	B:	a -> b -> c  --->  e
		            \    /
		             > d

   and I say that that is crazy, because in a distributed system, A and B 
   are _equivalent_ and have the same branches, and tell me what would 
   have happened if _A_ had pulled from _B_ instead?

   That's right: if A had pulled from B, then obviously nothing at all 
   would happen, because A already had everything B had.

   So the only _logical_ thing to happen is that the end result doesn't 
   depend on who merged. And that means that if B merged from A, then the 
   end result _has_ to be the same as if A merged from B, namely_

	B:	a -> b -> c -> d

   and nothing else. Anything else is insane. It's not a distributed 
   system any more.



> > Git tracks history, not "your view of history". Trying to track "your view"
> > is fundamentally wrong, because "your wiew" automatically means that the
> > project history would not be distributed any more - it would be centralized
> > around what _you_ think happened. That is not a sensible thing to have in a
> > distributed system.
>
> It's not my view, it's branch scope view, I can see how a branch evolves
> relatively independently.

No you CAN NOT. You think that "A" is special. But because you think that 
A is special, you ignore that B had the exact same branch, so your "branch 
scope view" is inherently flawed - it's not "branch scope" at all, it's 
literally a "one person is special" view.

> In git, branch scope view is more or less neglected. After fast 
> forwarding merge, I can' tell where a branch come from -- I mean the 
> track of a branch.

Sure you can. In your reflog. It's only _you_ who care about _your_ 
history. Nobody else cares one whit about what your tree looks like.

> If Junio publishes his reflog, I don't see what conflict will happen between
> his local view (but now public, and naming it branch scope view seems more
> sensible) and git's global view.

Why would anybody ever care about Junio's reflog?

Also, you're ignoring the issue that both I and Martin mentioned: you're 
making history harder to read, and adding crud that doesn't actually _do_ 
anything. Your approach is nonsensical from a distributed system 
standpoint, but it's also _worse_ than just fast-forwarding. If git did 
what you suggested, we'd have a lot of extra merge commits that simply 
don't _help_ anything, and only make things worse.

> What's the mean of upstream branch then? I have to know I should track
> Junio's public repository.

"Upstream" really should have absolutely zero meaning. That's the whole 
point of distributed. You can merge things sideways, down, up, and the end 
result doesn't matter. "upstream" can merge from you, and you can merge 
from him. Thats' the _technology_.

The only thing that matters is "trust". But trust is not something you get 
from technology, and trust is something you have to earn. And trust does 
NOT come from digital signatures like some people believe: digital 
signatures are a way of _verifying_ the trust you have, but they are very 
much secondary (or tertiary) to the real issues.

And _trust_ is why you'd pull from Junio. Git makes it somewhat easier by 
giving you default shorthands for the original place you cloned from when 
you clone a new repository, because often you'd obviously keep trusting 
the same source, but an important thing here is to realize that it really 
is "often". Not always. And it's not about technology.

> When does one say two branches reach a common point? have same commit(must
> point to same tree) or have same tree(maybe a fake commit and a real commit)?
> I think git takes the first way.

Very much so. To git, the only (and I really mean _only_) thing that 
matters from a commit history view is the commit relationships. NOTHING 
else. What the trees are doesn't matter at all. Where the commits came 
from doesn't matter. Who made them doesn't matter either - those are just 
"documentation".

So the _only_ thing that matters for a commit is what its place in history 
was. We never even look at the trees at all to decide what to do about 
merging. The only time the trees start to matter is when we've figured out 
what the merge relationship is, and then obviously the trees matter, but 
even then they only matter as far as the resulting _tree_ is concerned. 

> Fast forwarding style merge tends to *automatically* centralize many
> branches

Yes. Except I wouldn't say "centralize", I would very much say "join". 
That's the point of a merge. Two commit histories "join" and become one.

But the reason I don't agree with your choice of wording ("centralize")
thing is fundamental:

 - it only happens on one side. The side that does the merge is not 
   necessarily the "central" one at all.

 - there isn't necessarily even such a thing as a "central" branch in git 
   (and there _shouldn't_ be).

In fact, the thing I absolutely _detest_ about CVS is how it makes it 
almost impossible to have multiple "equally worthy" branches. Look at the 
git repository itself that Junio maintains, and please tell me which is 
the "trunk" branch?

Git doesn't even have that concept. There is the concept of a _default_ 
branch ("master"), and yes, the git repository has it. But at the same 
time, it really is just a default. There are three "main" branches that 
Junio maintains, and they only really differ in the degree of development. 
And "master" isn't even the most stable one - it's just the default one, 
because it's smack dab in the middle: recent enough to be interesting, but 
still stable enough to be worth tracking for just about anybody.

But really, "maint" is the stable branch, and in many ways you could say 
that "maint" is the trunk branch, since that's what Junio still cuts 
releases from. And "next" is the development branch, that gets interesting 
features before they hit the "master" branch (and "pu" is so far out that 
it's a whole different issue, since it jumps around and doesn't even 
become a real history at all).

See? All of these are _equal_. There is no trunk. There is no "central" 
branch, and if you were to have to decide which one is the most central 
one, it's not even the default one, that would probably be "maint", since 
that's the one that keeps getting merged into the other branches.

So doing a merge doesn't really "centralize" anything. It just joins the 
two development threads together in that particular line. If "master" 
merges the work in "maint", master doesn't really get any more 
centralized, it just gets the work that "maint" did since last time. And 
if there was no other work done at all, then the two branches end up 100% 
identical - there was no "merge" of the work.

They still have their own identities, though. It's still two branches. 
It's still "maint" and "master". They just have the exact same state, and 
that is as it should be, since they've had the exact same development 
history.

