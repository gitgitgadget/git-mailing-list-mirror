From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [OT?] git tools at SourceForge ?
Date: Fri, 12 Aug 2005 16:46:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508121631420.3295@g5.osdl.org>
References: <20050812190739.AC222352633@atlas.denx.de> 
 <Pine.LNX.4.63.0508121634570.12816@iabervon.org>  <Pine.LNX.4.58.0508121513530.3295@g5.osdl.org>
 <46a038f90508121617560d00c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 01:47:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3jES-0005iH-Ff
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 01:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVHLXqV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 19:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVHLXqV
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 19:46:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751244AbVHLXqU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 19:46:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7CNkCjA020872
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Aug 2005 16:46:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7CNkBQZ018785;
	Fri, 12 Aug 2005 16:46:12 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90508121617560d00c@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 13 Aug 2005, Martin Langhoff wrote:
> 
> >    Yes, developers can just merge with each other directly
> 
> I take it that you mean an exchange of patches that does not depend on
> having public repos. What are the mechanisms available on that front,
> other than patchbombs?

Just have a shared trusted machine.

A lot of "core" developers end up having machines that they may not 
control, and that they may not be able to use as major distribution 
points, but that they _can_ share with others.

For example, "master.kernel.org" ends up being that for the kernel: you 
don't have to have an account on master, but most of the core developers 
do, so they can use it as a short-cut that is independent of the actual 
"public" site. 

Similarly, some people are perfectly willing to give other trusted
developers a ssh login on their machine - and that's a perfectly fine way
to sync repositories directly if you have even a slow DSL link. You'd 
never want to _distribute_ the result over DSL, though.

The point being that you can certainly sync up to others without going 
through a public site. 

[ We _could_ also just send pack-files as email attachments. There's
  nothing fundamentally wrong with doing the object discovery that
  "git-send-pack" does on its own manually over email.

  In other words: you could easily do something like "Hey, I've got your
  commit as of yesterday, ID <sha1>, can you send me your current
  top-of-tree SHA1 name and the pack-file between the two?" and have 
  direct git-to-git synchronization even over email.

  NOTE NOTE NOTE! BK did this, with a "bk send" and "bk receive". I hated 
  it, which is why I'd never do scripts like that. But I think it's a 
  valid thing to do when you're cursing the fact that the central
  repository is down, and has been down for five hours, and you don't know
  how long it will take to get back up, and you don't have _any_ other
  choices ]

> >    This is _exactly_ where something like SF really ends up being helpful.
> >    It's a _hosting_ service, and git is eminently suitable to being
> 
> Not sure whether SF is offering rsync, but they do support hosting of
> arbitrarty data -- and a project using GIT can use that to host
> several developer trees.

The problem with the arbitrary data approach (and rsync) is that the git 
repositories can get out of sync.

We haven't seen it very often on kernel.org, but we _do_ see it. I think 
I've got something like three bug reports from people saying "your tree is 
corrupted" because it so happened that the mirroring was on-going at the 
same time I did a push, and the mirroring caught an updated HEAD without 
actually having caught all of the objects that HEAD referenced.

Now, all the git tools do write things in the right order, and mirror 
scripts etc _tend_ to mirror in alphabetical order (and "objects" come 
before "refs" ;), so you really have to hit the right window where a git 
tool updates the git repository at the same time as a mirroring sweep is 
going on, but it definitely _does_ happen.

It just happens seldom enough that most people haven't noticed. But if 
you've seen the gitweb page go blank for one of the projects, you now know 
why it can happen..

And this is inevitable when you have a non-git-aware server. You really 
need to update the objects in the right order, and to get the right order 
you do have to be git-aware.

> It'd be nice if SF offered gitweb and
> similar niceties. As my usage of GIT increases, I may add support for
> it on Eduforge.org

I think we'll find that it's a learning process, to just find out what
drives site managers mad (we certainly found the problem with lots of
small files on kernel.org out ;). Having a few sites that do it and tell
the others what gotchas there are involved with it (and what scripts they
use for maintaining stuff like auto-packing etc) is all a learning
experience.

			Linus
