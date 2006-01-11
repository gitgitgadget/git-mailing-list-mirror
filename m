From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect is magical
Date: Tue, 10 Jan 2006 18:58:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601101846170.3294@g5.osdl.org>
References: <dpuoqf$3rp$1@sea.gmane.org> <Pine.LNX.4.64.0601091516460.5588@g5.osdl.org>
 <dq11c6$g15$1@sea.gmane.org> <Pine.LNX.4.64.0601101131540.4939@g5.osdl.org>
 <Pine.LNX.4.64.0601101143180.4939@g5.osdl.org> <dq168p$3kt$1@sea.gmane.org>
 <Pine.LNX.4.64.0601101308540.4939@g5.osdl.org> <dq1o88$1bm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 03:59:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwWCi-0004oj-4U
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 03:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWAKC7B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 21:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030687AbWAKC7A
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 21:59:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030466AbWAKC7A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 21:59:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0B2wvDZ021104
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 18:58:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0B2wuHc032295;
	Tue, 10 Jan 2006 18:58:56 -0800
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dq1o88$1bm$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14476>



On Tue, 10 Jan 2006, walt wrote:
>
> Linus Torvalds wrote:
> [...]
> > So when you say "git checkout origin", it actually _switches_ to the
> > origin branch (which is just my state) and checks that out.
> 
> I think we are finally homing in on the very roots of my ignorance!
> 
> When you use the word 'switches' my eyes go glassy, just like when
> my wife starts telling me everything I've done wrong today...

Ahhah.

> Please --> what am I switching *from* when I switch to 'origin'?
> (Think:  this guy is a total dumbshit!  How can I possibly dumb-
> down this basic knowledge any dumber?)

Ok, this clearly isn't described well enough in any docs, so let me try, 
and hopefully somebody (hint hint) will go "Ahh, I wish that had been 
described in xyz - here's a patch to do so".

Anyway, the notion of multiple "branches" aka "heads of development" is 
pretty ingrained in git. It's really how _everything_ subtle gets done 
(merging, you name it - sometimes the branch may be a temporary unnamed 
head that is just inside a script, but the _concept_ is always there).

There's one _special_ branch, which is the "active" one. The only git 
trees without an active branch are the so-called "bare" git trees, which 
are the .git directory contents directly, without any checked-out state. 
Those are only used for distribution - no development can ever happen in 
them, because they simply don't have any active branch to do development 
_in_.

But for any normal git repository, you'll have one active branch, which is 
the one that your working directory actually represents. It's also the one 
we call "HEAD", since the HEAD thing is the thing that points to the 
active branch.

Your HEAD can point to _any_ branch, but the default one is called 
"master". That's the branch you get when you clone another repository, or 
when you just start a new git repository from scratch with "git-init-db".

But you can "switch" between branches at any time by just doing a simple 
"git checkout <branchname>". That will conceptually totally blow away your 
working directory contents (well, all of it that git knows about, anyway), 
and replace them with the contents that the _other_ branch contains. Now, 
I say "conceptually", because in practice this is heavily optimized, so 
that any files that don't change aren't actually re-written, so you can 
switch between two branches that are similar quite cheaply.

So when you did "git checkout origin", you basically blew away all the 
development you had done in the default "master" branch, and switched to 
_another_ branch. The "origin" branch is the one that is generated for you 
automatically when you clone a repository from somewhere else: it 
initially contains the state of that other repository at the time of the 
clone, and a "git pull origin" will actually both "fetch" that branch (so 
that the "origin" branch is kept up-to-date with the original source) 
_and_ merge that branch into your HEAD (normally "master").

> I know this is really bone-head-basic-stuff, but I'm quite sure
> that this lies at the heart of my confusion.
> 
> When I finally understand this kindergarten material I can graduate
> to first grade  :o)

Well, at least _some_ of this is described in Documentation/git-pull.txt 
and Documentation/tutorial.txt. So if you haven't looked into those 
before, try them now. And if you have, they clearly need more effort.

I'm really bad at documentation. I'm more than happy trying to answer 
emailed questions (at least if I get the feeling that the person asking 
the questions is really trying to learn, which you've done admirably), but 
that doesn't mean that I'm good at writing the docs. So I'm hoping that 
some of this can find itself into a FAQ or one of the existing docs, 
thanks to somebody else editing it..

		Linus
