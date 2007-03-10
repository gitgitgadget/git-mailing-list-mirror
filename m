From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Errors cloning large repo
Date: Fri, 9 Mar 2007 16:54:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703091641460.10832@woody.linux-foundation.org>
References: <20070309234846.7641.qmail@web52613.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Anton Tropashko <atropashko@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 01:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPprU-0008RB-5A
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 01:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767688AbXCJAy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 19:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767691AbXCJAy5
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 19:54:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55387 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767688AbXCJAyr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 19:54:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2A0sjo4022511
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Mar 2007 16:54:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2A0sijQ007477;
	Fri, 9 Mar 2007 16:54:45 -0800
In-Reply-To: <20070309234846.7641.qmail@web52613.mail.yahoo.com>
X-Spam-Status: No, hits=-0.493 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41827>


On Fri, 9 Mar 2007, Anton Tropashko wrote:
>
> > So you might be able to do just do
> > 
> >     git add dir1
> >     git add dir2
> >     git add dir3
> >     ..
> >     git commit
> > 
> > or something.
>
> For some reason git add . swallowed the whole thing
> but git commit did not and I had to split it up. I trimmed the tree a bit
> since then by removing c & c++ files ;-)

Ok, that's a bit surprising, since "git commit" actually should do less 
than "git add .", but it's entirely possible that just the status message 
generation ends up doing strange things for a repository with that many 
files in it.

I should try it out with some made-up auto-generated directory setup, but 
I'm not sure I have the energy to do it ;)

> > But one caveat: git may not be the right tool for the job. May I inquire 
> > what the heck you're doing? We may be able to fix git even for your kinds 
>
> I dumped a rather large SDK into it. Headers, libraries
> event crs.o from the toolchains that are part of SDK. The idea is to keep
> SDK versioned and being able to pull an arbitrary version once tagged.

Ok. Assuming most of this doesn't change very often (ie the crs.o files 
aren't actually *generated*, but come from some external thing), git 
should do well enough once it's past the original hump.

So your usage scheanrio doesn't sound insane, and it's something we should 
be able to support well enough. 

> > So I'm not saying that git won't work for you, I'm just warning that the 
> > whole model of operation may or may not actually match what you want to 
> > do. Do you really want to track that 8.5GB as *one* entity?
>
> Yes. It would be nice if I won't have to prune pdfs, txts, and who
> knows what else people put in there just to reduce the size.

Sure. 8.5GB is absolutely huge, and clearly you're hitting some problems 
here, but if we're talking things like having a whole development 
environment with big manuals etc, it might be a perfectly valid usage 
schenario.

That said, it might also be a good idea (regardless of anything else) to 
split things up, if only because it's quite possible that not everybody is 
interested in having *everything*. Forcing people to work with a 8.5GB 
repository when they might not care about it all could be a bad idea.

> >  - the file size is bigger than MAX_NON_LFS (2GB-1), and we don't use 
> >    O_LARGEFILE.
>
> Ok. I think you're correct:
> from ulimit -a:
> ...
> file size             (blocks, -f) unlimited

Ok, then it's the 2GB limit that the OS puts on you unless you tell it to 
use O_LARGEFILE.

Which is just as well, since the normal git pack-files won't index past 
that size *anyway* (ok, so it should index all the way up to 4GB, but it's 
close enough..)

> Good to know developers are ahead of the users.

Well, not "ahead enough" apparently ;)

I was seriously hoping that we could keep off the 64-bit issues for a bit 
longer, since the biggest real archive (firefox) we've seen so far was 
barely over half a gigabyte.

> Is there way to get rid of pending (uncommitted) changes?

"git reset --hard" will do it for you. As will "git checkout -f", for that 
matter.

"git revert" will just undo an old commit (as you apparently already found 
out)

		Linus
