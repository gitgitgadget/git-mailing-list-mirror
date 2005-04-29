From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Val Henson's critique of hash-based content storage systems
Date: Fri, 29 Apr 2005 12:45:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291221250.18901@ppc970.osdl.org>
References: <loom.20050429T015434-928@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 21:39:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRbKU-0001rs-Iy
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 21:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVD2Too (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 15:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbVD2Tng
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 15:43:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:27780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262906AbVD2TnL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 15:43:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3TJh9s4031445
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 12:43:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3TJh87X032369;
	Fri, 29 Apr 2005 12:43:08 -0700
To: Rob Jellinghaus <robj@unrealities.com>
In-Reply-To: <loom.20050429T015434-928@post.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, Rob Jellinghaus wrote:
> 
> If an attacker used an SHA-1 attack to create a blob that matched the hash of
> some well-known git object (say, the tree for Linux 2.7-rc1), and spammed public
> git repositories with it ahead of Linus's release, what would be the potential
> for mischief, and what would the recovery process be?

I really think people should not consider the sha1 the "security". 

The real security is in distribution. 

With the distributed setup, developers don't use public trees. They use 
their own _private_ trees, and the public ones are just staging areas for 
synchronization.

So in order to actually replace a blob, let's say that you can create an 
object with the right sha1 trivially. What then?

You now have to break into _every_ repository that has that object, and 
replace it silently. Because if you don't, the good one will still be 
around.

That's just not going to happen.

So let's say that you break into kernel.org, and replace one of the blobs
in my repository.  What happens?

First off, I'll never notice, because it's not actually my repository, so 
I won't even have the corrupt copy. So what _will_ happen?

What will happen is that people who download new stuff from kernel.org
will get the "evil" object. Not all of them, though - just the ones that
hadn't downloaded the proper one. So first off, in order to be really
_effective_, the attack really has to not just replace an object, it
really wants to replace a pretty _recent_ object, because replacing an old
just just doesn't do a whole lot.

So they get the evil object. What happens? NOTHING. Absolutely nada.  
Either they use that evil object, or they don't. Not using it might be
because it's not even top-of-tree any more, and you really just replaced
some old version of a file. Or it might be because it's a object for a
driver that you don't have, so you'd never see it.

So let's ignore that case, and say that the attacker has successfully
replaced an object that is (a) recent enough to matter and (b) actually
used.

What now? You'll get a compile error. Big deal. People will notice that
something is wrong, complain about it, we'll think they have disk
corruption for a while, and then we'll figure it out, and replace the
object. Done.

Why? Because even if you successfully find an object with the same SHA1, 
the likelihood that that object actually makes _sense_ in that conctext is 
pretty damn near zero. 

Think about it. We've had this before: people whose files got flipped
around due to driver bugs or just hardware problems, and even just a
single bit error most of the time results in real honest-to-God compiler
errors.

And because we found the bad one, and we have the good one somewhere else, 
who cares? The security industry will be all atwitter about somebody 
finding a matching SHA1 object, and it will be _huge_ news, but did it 
actually hurt the kernel integrity? No.

So let's say that somebody breaks in to _my_ personal machine. I'm behind 
a few firewalls and a NAT setup, and I don't accept even incoming ssh, but 
hey, they could crowbar my door and break in that way. 

ONLY A TOTAL IDIOT would then replace an object in my database with
something else. That would be _stupid_. He'd just guarantee that all the 
same problems as above were true, except now we'd have to find the 
good object in some _other_ database than mine.

So if you actually wanted to corrupt the kernel tree, you'd do it by just
fooling me into accepting a crap patch. Hey, it happens all the time.  
People send me buggy stuff. We figure out the bugs. What's so different
here?

In other words, the security isn't in the hash. The hash is an added level 
to make it much harder to fool, but it's not "the security". 

And if we are really really unlucky, and a meteorite hits us, and we get
an object collision that has the same sha1 for _real_, and actually makes
sense, then hey, shit happens. We can fix it by "poisoning" that sha1, and
modifying both files trivially so that they don't match any more, and then
we add a list of "illegal" sha1's to fsck, and we'll make that list be ten
entries long, just in case the meteorite strikes ten times, but the fact
is it's simply not going to happen.

(It's going to be very very obvious, very very quickly, btw: the person
who actually created the object that happened to collide will not write
the new SHA1 out, because he already "had" the same object, so next time
somebody updates the tree, the file that matches will now have the "old
contents" from some other colliding file, and the new code simply won't do
what it was supposed to. So don't worry about it - collisions, even if
they happen, will be noticed as quite obvious _bugs_ in the end result,
the same way we find the common source of bugs - bad programming).

In other words: don't depend on hashes if you only have one copy of the
data. But if you have backups of old versions (which essentially the
distribution guarantees as long as we have "stupid" mirrors that just look
at the filename) having a hash collision doesn't mean that you lost any
real data.

So anybody who thinks that a hash collision is a fundamental problem just
hasn't thought things through. It's an _annoyance_, nothing more. But we
have tons of much more pressing annoyances, and pretty much all of them
are a hell of a lot more likely than a collission, whether intentional or
unintentional.

			Linus
