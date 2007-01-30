From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Tue, 30 Jan 2007 17:41:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701301725190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 17:41:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBw32-0003G7-IB
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 17:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965381AbXA3Ql1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 11:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965571AbXA3Ql1
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 11:41:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:46801 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965381AbXA3Ql1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 11:41:27 -0500
Received: (qmail invoked by alias); 30 Jan 2007 16:41:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 30 Jan 2007 17:41:25 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38168>

Hi,

On Tue, 30 Jan 2007, Mike Coleman wrote:

> I recently decided to jump into the DVCS pool, and I've been studying 
> what seem to me to be the two leading candidates--git and mercurial--to 
> try to understand the differences between them in design and features.  
> I have some questions that I hope you can enlighten me on.

I don't know Mercurial, but I know git pretty well.

> 1.  As of today, is there any real safety concern with either tool's 
> repo format?  Is either tool significantly better in this regard? (Keith 
> Packard's post hints at a problem here, but doesn't really make the 
> case.)

I can't remember any post hinting at a problem with regard to git's 
safety.

Git is very conservative about data. In fact, even if you fsck up royally, 
chances are very good that you recover without losing any data (which was 
stored in the repo).

Of course, a "rm -rf ." will hurt in any case.

> 2.  Does the git packed object format solve the performance problem 
> alluded to in posts from a year or two ago?

I don't know what posts you mean.

In any case, if performance is an issue for you, you should keep your 
repository packed (with new Git, you should call "git gc" every once in a 
while).

> 3.  Someone mentioned that git bisect can work between any two commits, 
> not necessarily just one that happens to be an ancestor of the other.  
> This sounds really cool.  Can hg's bisect do this, too?

No idea.

> 4.  What is git's index good for?  I find that I like the idea of it, 
> but I'm not sure I could justify it's presence to someone else, as 
> opposed to having it hidden in the way that hg's dircache (?) is.  Can 
> anyone think of a good scenario where it's a pretty obvious benefit?

Git's index is a staging area. Every VCS has it, but most hide it. One of 
the moments where Git's index really shines is merge conflicts: you can 
inspect _just_ the conflicts by calling "git diff".

> 5.  I think I read that there'd been just one incompatible change over 
> time in the git repo format.  What was it?

Objects names were the hash of the _compressed_ contents. Now it's the 
uncompressed contents (which allows you to change the compression 
parameters without any hassle). This was _looong_ time ago.

> 6.  Does either tool use hard links?  This matters to me because I do 
> development on a connected machine and a disconnected machine, using a 
> usb drive to rsync between.  (Perhaps there'll be some way to transfer 
> changes using git or hg instead of rsync, but I haven't figured that out 
> yet.)

No idea about Mercurial, but you can clone using hard links with the 
--local option.

There is still a script called git-relink, which can hard link 
unpacked objects of two object databases, but since we usually keep 
everything packed nowadays, I deem this obsolete.

Of course, the better way is to use --shared with clone, so that a 
"virtual hard link" is set up: The alternates mechanism of Git is set up 
such that you reuse (even new) objects from the alternate repository.

> 7.  I'm a fan of Python, and I'm really a fan of using high-level 
> languages with performance-critical parts in a lower-level language, so 
> in that regard, I really like hg's implementation.  If someone wanted to 
> do it, is a Python clone of git conceivable?  Is there something about 
> it that just requires C?

I am not a fan of Python. I think that all the Perl hackers of old days 
migrated to Python, because the code _looks_ nicer. But it's the same old 
crap.

That said, nothing (least of which, me) hinders you reimplementing Git in 
Python. The performance critical parts are in the revision walking, and 
the diff machinery.

The revision walking is not really reentrant (yet), so you would have to 
fix that up a little before being able to link it natively.

> 8.  It feels like hg is not really comfortable with parallel development 
> over time on different heads within a single repo. Rather, it seems that 
> multiple repos are supposed to be used for this. Does this lead to any 
> problems?

Usually not. I do it all the time (keep the branches in the same repo).

> For example, is it harder or different to merge two heads if they're in 
> different repo than if they're in the same repo?

You _have_ to fetch it to merge it (this operation, fetch & merge, is 
called pull with Git), but there is no difference if the branch 
to-be-merged is local or remote. In fact, branches are not supposed to be 
"local" or "remote". You can _have_ them where you want. And you can tell 
if two branches are identical by the object name of their tip.

Hth,
Dscho
