From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 5 May 2006 10:48:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605050944200.3622@g5.osdl.org>
References: <20060505005659.9092.qmail@science.horizon.com>
 <20060505163629.GZ27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 05 19:48:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc4QB-0003rC-5h
	for gcvg-git@gmane.org; Fri, 05 May 2006 19:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWEERsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 13:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWEERsw
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 13:48:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3208 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751711AbWEERsw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 13:48:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k45HmdtH010091
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 May 2006 10:48:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k45HmclD008909;
	Fri, 5 May 2006 10:48:39 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060505163629.GZ27689@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19620>



On Fri, 5 May 2006, Petr Baudis wrote:
> 
> It's a philosophical question here, but I'd say that Git is much closer
> to Monotone than to any other version control system

Some historical background..

Before I dropped BK, I ended up being involved in trying to get Larry and 
Tridge to come to some agreement about how to solve the issues Tridge had 
with BK not being open-source. That actually went on for maybe two months 
or so, and I kept on hoping that we'd find some acceptably middle ground. 

I thought we could find somethign that would actually work for everybody: 
to hopefully both make BK technically better, _and_ to make the end result 
more palatable to the "free software or bust" contingency.

One of the suggestions that I tried to push as an acceptable middle ground 
was to make a "generic" BK repository export format, so that people who 
didn't want to use BK could still get all the information, and not in a 
broken format like CVS (yes, CVS makes sense as an interchange format, 
since _everybody_ speaks CVS, but it's a horrible, horrible, horrible 
format from any technical standpoint).

My example export format was really a strange mixture of patches with 
parenthood information, where the history information was described with 
hashes (MD5 rather than SHA1, but that was just an implementation thing, 
and mostly because BK used MD5 sums). Not something really useful as a 
real SCM, but it wasn't designed for that - it was just meant to be a 
useful and unambiguous interoperability format.

Now, that didn't work out, and I was a little bummed. I thought it would 
have made both sides happy, because it would actually have been a better 
format than CVS (and yes, I'm somewhat biased: in my opinion, having a 
million monkeys throwing crap at the walls and encoding the information in 
the patterns on monkey shit is a better format than CVS), so it would 
actually have improved BK, while also making it possible to interoperate 
if you didn't want to use BK itself.

But Tridge didn't believe that it would actually have exported all the 
information in a BK tree, even if both I and Larry told him it would. I'm 
not a hundred percent sure that Larry would have gone for the export 
format either, but hey, one sign of a good compromise is that neither side 
really gets what they really want. Whatever. It didn't work.

So it didn't actually resolve the deadlock, but when it became clear that 
I couldn't work with BK any more, I thought I might use something like 
that "patch + parenthood" representation as a way to maintain my tree 
while looking at other alternatives.

So in many ways, when I started looking around for distributed SCM's, I 
came into the game with the background of keeping the history around as 
chains of hashes describing it, and then just having patches to describe 
the differences between versions.

So that was really my "fallback" position: if nothing out there worked, 
I'd rather go back to lists of patches than use CVS. 

Now, if you keep track of just patches, one of the issues is that you 
can't afford to re-create the tree every time by walking patches forward 
from the beginning, so I also was planning to have an "cache" that 
maintained the current state of the tree as a separate state from the 
working tree, so that I would always have the "working tree" and the 
"result of patches up to this moment" as two separate things (so that I 
could do the "bk diff" that I was used to doing to see the difference 
between my last state and the current state of the working tree).

In other words, I was already working on the git "index" file. And I was 
planning to just have a patch-based system behind it, with a hashed 
history. Kind of "quilt with history and an index to speed things up".

The index itself would be backed-up with whole files (all hidden in the 
".dircache" directory), and the patch series would thus normally never 
actually be _used_. So the inefficiency of working with patches would 
never be much of an issue. A "commit" would create a new patch from the 
current working directory and the previous shadow tree, and update the 
shadow tree and add a new entry to the history list.

And then I found Monotone.

Now, monotone was slow. Monotone was so _horrendously_ slow that I had to 
do special hacks just to import _one_ version of Linux into it in less 
than two hours. It was something stupid like an O(N**3) algorithm in the 
number of filenames (and the kernel had 17,291 files at that time: 
v2.6.12-rc2), and it was just totally unusable for me.

I also thought (and still think) that the whole signing thing was a waste 
of time and misdesigned, and I obviously am not a huge fan of databases. 
So in many ways I disliked the monotone implementation decisions (and some 
of its design decisions). But at the same time, I immediately liked the 
SHA1 object naming concept of Monotone.

It also already matched how I had conceptually planned on doing on the 
history anyway, and had some ideas for, but it took that whole "history 
hashing" all the way.

And thus git was born. 

So git really has three parents. In a very real sense, BK (or, perhaps 
more appropriately - the way I personally used BK, which is not 
necessarily how others have used it) was the biggest thing from the 
standpoint of what I wanted my _workflow_ to be like. It was simply how I 
had done things for the last few years, so a lot of my mental model for 
how things are supposed to _work_ came from BK. 

I still don't think people give Larry enough credit for actually pushing 
this whole distributed SCM thing as a _usable_ model. Very few of the 
open-source distributed SCM's are actually usable even today, and as far 
as I've been able to gather, the commercial ones aren't really any closer 
either. Larry didn't have the kind of examples of what _can_ work that I 
had.

The other parent was the stupid "series of patches" model, which was what 
really resulted in the "index" thing. I realize that people don't always 
much like the index, but it's really a pretty central part of git history, 
and one of the distinguising marks of git. It may be trivial, and to some 
degree it's been overshadowed by all the tree operations we do (the 
combination of revision walking and tree diffing), but it was very central 
to how git came to be.

The index also ended up being central to how we did merges - even if some 
day we may end up doing more of that on a pure tree level (ie the current 
git-merge-tree model), I think the way we ended up doing merges owes a lot 
to the index as a staging area.

(Historically, the "index" was called the "cache". Exactly because it came 
from the notion of "caching" the top commit state in a patch series, and 
then working with patches either backwards or forwards from that top 
cached state. Similarly, we didn't have a ".git" directory: it was 
called ".dircache", exactly because it was all about caching the state 
of the previous commit directory layout).

And finally, Monotone for the "everything is an object named by its SHA1" 
model, which to some degree is perhaps the central - or at least the most 
obvious - part of git. It largely was designed really just to be the 
"backing store" for the "cache", and to not be _that_ important. That also 
explains why I didn't worry too much about disk usage etc initially: the 
object store wasn't even the most important part, and I envisioned just 
moving old objects that weren't needed into some "backup storage" kind of 
thing.

			Linus
