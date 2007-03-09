From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Errors cloning large repo
Date: Fri, 9 Mar 2007 13:37:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703091312530.10832@woody.linux-foundation.org>
References: <284107.69764.qm@web52601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Anton Tropashko <atropashko@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 22:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPmmJ-0001kT-A6
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 22:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767550AbXCIVhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 16:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766898AbXCIVhY
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 16:37:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50212 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637AbXCIVhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 16:37:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l29LbJo4017214
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Mar 2007 13:37:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l29LbIIK003392;
	Fri, 9 Mar 2007 13:37:18 -0800
In-Reply-To: <284107.69764.qm@web52601.mail.yahoo.com>
X-Spam-Status: No, hits=-0.494 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41812>



On Fri, 9 Mar 2007, Anton Tropashko wrote:
>
> I managed to stuff 8.5 GB worth of files into a git repo (two two git commits since
> it was running out of memory when I gave it -a option)

Heh. Your usage schenario may not be one where git is useful. If a single 
commit generates that much data, git will likely perform horribly badly. 
But it's an interesting test-case, and I don't think anybody has really 
*tried* this before, so don't give up yet.

First off, you shouldn't really need two commits. It's true that "git 
commit -a" will probably have memory usage issues (because a single "git 
add" will keep it all in memory while it generates the objects), but it 
should be possible to just use "git add" to add even 8.5GB worth of data 
in a few chunks, and then a single "git commit" should commit it.

So you might be able to do just do

	git add dir1
	git add dir2
	git add dir3
	..
	git commit

or something.

But one caveat: git may not be the right tool for the job. May I inquire 
what the heck you're doing? We may be able to fix git even for your kinds 
of usage, but it's also possible that 
 (a) git may not suit your needs
 (b) you might be better off using git differently

Especially when it comes to that "(b)" case, please realize that git is 
somewhat different from something like CVS at a very fundamental level.

CVS in many ways can more easily track *humongous* projects, for one very 
simple reason: CVS really deep down just tracks individual files.

So people who have used CVS may get used to the notion of putting 
everything in one big repository, because in the end, it's just a ton of 
small files to CVS. CVS never really looks at the big picture - even doing 
something like merging or doing a full checkout is really just iterating 
over all the individual files.

So if you put a million files in a CVS repository, it's just going to 
basically loop over those million files, but they are still just 
individual files. There's never any operation that works on *all* of the 
files at once.

Git really is *fundamentally* different here. Git takes completely the 
opposite approach, and git never tracks individual files at all at any 
level, really. Git almost doesn't care about file boundaries (I say 
"almost", because obviously git knows about them, and they are visible in 
myriads of ways, but at the same time it's not entirely untrue to say that 
git really doesn't care).

So git scales in a very different way from CVS. Many things are tons 
faster (because git does many operations a full directory structure at a 
time, and that makes merges that only touch a few subdirectories *much* 
faster), but on the other hand, it means that git will consider everything 
to be *related* in a way that CVS never does.

So, for example, if your 8.5GB thing is something like your whole home 
directory, putting it as one git archive now ties everything together and 
that can cause issues that really aren't very nice. Tying everything 
together is very important in a software project (the "total state" is 
what matters), but in your home directory, many things are simply totally 
independent, and tying them together can be the wrong thing to do.

So I'm not saying that git won't work for you, I'm just warning that the 
whole model of operation may or may not actually match what you want to 
do. Do you really want to track that 8.5GB as *one* entity?

> but when I'm cloning to another linux box I get:
> 
> Generating pack...
> Done counting 152200 objects.
> Deltifying 152200 objects.

.. this is the part makes me think git *should* be able to work for you. 
Having lots of smallish files is much better for git than a few DVD 
images, for example. And if those 152200 objects are just from two 
commits, you obviously have lots of files ;)

However, if it packs really badly (and without any history, that's quite 
likely), maybe the resulting pack-file is bigger than 4GB, and then you'd 
have trouble (in fact, I think you'd hit trouble at the 2GB pack-file 
mark).

Does "git repack -a -d" work for you?

> /usr/bin/git-clone: line 321:  2072 File size limit exceededgit-fetch-pack --all -k $quiet "$repo"

"File size limit exceeded" sounds like SIGXFSZ, which is either:

 - you have file limits enabled, and the resulting pack-file was just too 
   big for the limits.

 - the file size is bigger than MAX_NON_LFS (2GB-1), and we don't use 
   O_LARGEFILE.

I suspect the second case. Shawn and Nico have worked on 64-bit packfile 
indexing, so they may have a patch / git tree for you to try out.

			Linus
