X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: If merging that is really fast forwarding creates new commit
 [Was: Re: how to show log for only one branch]
Date: Tue, 7 Nov 2006 09:23:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611070841580.3667@g5.osdl.org>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net>
 <454F31D7.1030202@gmail.com> <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
 <Pine.LNX.4.64.0611060928180.3667@g5.osdl.org> <45503CFC.7000403@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 7 Nov 2006 17:24:44 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45503CFC.7000403@gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31078>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhUgN-0002Rw-7j for gcvg-git@gmane.org; Tue, 07 Nov
 2006 18:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965586AbWKGRYP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 12:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965587AbWKGRYP
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 12:24:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55489 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S965586AbWKGRYO (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 12:24:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA7HNroZ032429
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 7
 Nov 2006 09:23:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA7HNnc5008858; Tue, 7 Nov
 2006 09:23:50 -0800
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org



On Tue, 7 Nov 2006, Liu Yubao wrote:
> 
> Fake commit is only for digging branch scope history, I can *outline* what has
> been merged to a branch and don't care about how these good work are done on
> earth.

The thing is, I think you see a good thing ("outlining"), and miss all the 
downsides ("extra noise", "incorrect outlining").

Yes, I can see it being useful for reading logs in a perfect world.

However, in real life, more than half of my fast-forwards are just me 
tracking another branch. An "outline" would be _wrong_. I _want_ to 
fast-forward, because I'm moving the trees from one machine to another, 
and the reason it's a fast-forward is exactly the fact that absolutely 
zero work had been done on the machine I'm pulling from - I'm pulling just 
to keep up-to-date.

So now, just to keep things sane, your scheme would require that people 
AHEAD OF TIME tell the system whether they want to fast-forward or whether 
they want to create a magic merge commit as a "outlining" marker.

See? Fast-forwarding is absolutely the right thing to do in 99% of all 
cases. For me, it's perhaps only half, because I do several true merges 
every day, but that's really quite unusual - I'm the top-level maintainer. 
Nobody else should EVER do it.

And the thing is, I refuse to work with a system that makes one person 
special. I _know_ I'm special, I'm the smartest, most beautiful, and just 
simply the best person on the planet. I don't need a tool that tells me 
so.

So deep down, what you're really suggesting that there be a special mode 
that is ONLY ever used for the top-level maintainer, so that he can create 
an "outline" in the history.

Put that way, it almost makes sense, until you realize that 99.9% of all 
people aren't top-level maintainers, and you don't want them creating crap 
like that. And that "outlining" is likely most easily done with

	( git log lastversion.. | git shortlog ;
	  git diff --stat --summary lastversion.. ) | less -S

instead.

But more importantly, I don't personally like the "top-level maintainer" 
model. Yes, it's how people do end up working a lot, but quite frankly, 
I'd rather not have the tool support it, especially if there is ever a 
schism in a development process. I want to support _forking_, which very 
much implies having somebody pulling the "wrong way".

Time for some purely philosophical arguments on why it's wrong to have 
"special people" encoded in the tools:

I think that "forking" is what keeps people honest. The _biggest_ downside 
with CVS is actually that a central repository gets so much _political_ 
clout, that it's effectively impossible to fork the project: the 
maintainers of a central repo have huge powers over everybody else, and 
it's practically impossible for anybody else to say "you're wrong, and 
I'll show how wrong you are by competing fairly and being better".

For example, gcc (and other tools) have gone through this phase. You've 
had splinter groups (eg pgcc) that did a hell of a lot better work than 
the main group, and the tools really made it really hard for them to make 
progress. I think the most important part of a distributed SCM is not even 
to support the "main trunk", but to support the notion that anybody can 
just take the thing and compete fairly.

With the kernel as an example, any group could literally just start their 
own kernel git tree, and git should make it as easy as humanly possible 
for them to track my tree WHILE _THEY_ STILL REMAIN IN CHARGE of their own 
tree. That doesn't mean that forking is easy - over the years people have 
simply grown so _used_ to me that they mostly trust me and they are comfy 
working with me, because even if I've got my quirks (or "major personality 
disorders" as some people might say), people mostly know how to work with 
them.

But the point is, there should be no _tool_ issues. As far as git is 
concerned, every single developer can feel like he is the top-level 
maintainer - it doesn't have to be a hierarchy, it really can be a 
"network of equal developers". I want the _tool_ to have that world-view, 
even if most projects in the end tend to organize more hierarcically than 
that. Because the "everybody is equal" worldview actually matters in the 
only case that _really_ matters: when problems happen.

For example: I use git to maintain a few other projects I've started too. 
I use git to maintain git itself, but I'm no longer the maintainer, simply 
because I think it's a lot better to step down than stand in the way of 
somebody better, and because I think it's hard to be the "lead person" on 
multiple projects. 

The same thing is happening to "sparse", which was dormant for a while (it 
worked, and I fixed problems as people reported them, but it did 
everything I had set out to do, so my motivation to develop it further had 
just gone down a lot). What happened? Somebody else came along, showed 
interest, started sending me patches, and I just suggested he start his 
own tree and start maintaining it.

Now, both of those transitions were very peaceful, but it should work that 
way even if the maintainer were to fight tooth and nail to hold on to his 
"top dog" status. And that's where it's important that the tool not 
separate out "top maintainers" from "other people".

> I want to separate a branch, not to separate commits by some author, for
> example, many authors can contribute to git's master branch, I want to
> know what happened in the master branch like this:
>      good work from A;
>      good work from C;
>      merge from next;   -----> I don't care how this feature is realized.
>      good work from A;

Really, "git log | git shortlog" will come quite close. I use it all the 
time for the kernel, and it's powerful.

Try it with the kernel archive, just for fun. Do

	git log v2.6.19-rc4.. | git shortlog | less -S

with the current kernel, and see how easy it is to get a kind of feel for 
what is going on. We do it by two means:

 - sorting by author. 

   This sounds silly, but it's actually very powerful. It's not so much 
   that it credits people better (it does) or that it makes the logs 
   shorter by mentioning the person just once (it does that too), it's 
   really nice because people tend to automatically do certain things. One 
   person does "random cleanups". Another one works on "networking". A 
   third one maintains one particular architecture, and so on..

 - encourage people to have a "topic: explanation" kind of top line of the 
   commit (and encourage people to have that "summary line" in the first 
   place: not every SCM does that, and everybody else is strictly much 
   worse than git)

In fact, when I do this, I usually _remove_ the merges, because they end 
up being just noise. Really: go and look at the current kernel repo, and 
do the above one-liner, and realize that I have a hunking big set of 
commits credited to me right now (it says 30 commits), and in fact I think 
I'm the #1 author right now on that list.

But when I send out the description, I actually use the "--no-merges" flag 
to "git log", because those merge messages are _useless_. They really 
don't do anything at all for me, or for anybody else. Re-run the above 
one-liner that way, and suddenly I drop to just 5 commits (and quite 
often, I'm much less - sometimes the _only_ commit I have for an -rc 
release is the commit that changes the version number). But it's actually 
more readable.

So I can kind of see what you want, but I'm 100% convinced that the 
information you _really_ want is better done totally differently.

So if you want to get the "big picture" thing, git does actually support 
you in several ways. That "git shortlog" is very useful, but so is the 
"drill down by subsystem". For example, you could do

	git log --no-merges v2.6.19-rc4.. arch/ | git shortlog | less -S

and you'd get the "summary view" of what happened in architecture- 
specific code. It's not the same thing as the "merge log", but it's 
actually very useful.

(You can do the same with git. Something like

	git log --no-merges v1.4.3.4.. | git shortlog | less -S

shows quite clearly that a lot of new stuff is gitweb-related, for 
example. 

Could we do better "reporting" tools? I'm absolutely sure we could. It 
might be interesting to be able to ignore not just commits, but "trivial 
patches" too. For example, if you're looking for what changed on a high 
level, you're not likely to care about patches that change just a few 
lines. You might want to see only the commits that change an appreciable 
fraction of code, and so it might be very interesting to have a "git 
shortlog" that would take patch size into account, for example.

So I'm not saying that git is perfect. I'm just saying that there are 
better ways (with much fewer downsides) to get what you want, than the way 
you _think_ you want.

