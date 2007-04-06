From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: kde.git is now online
Date: Thu, 5 Apr 2007 18:24:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704051730460.6730@woody.linux-foundation.org>
References: <46152BF5.3050502@zytor.com> <Pine.LNX.4.64.0704051029240.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704051334590.28181@xanadu.home>
 <alpine.LFD.0.98.0704051532240.28181@xanadu.home>
 <Pine.LNX.4.64.0704051338290.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704051703140.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chris Lee <clee@kde.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 03:27:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZdEr-0002yM-JF
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 03:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767473AbXDFB1i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 21:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767480AbXDFB1i
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 21:27:38 -0400
Received: from smtp.osdl.org ([65.172.181.24]:60649 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767473AbXDFB1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 21:27:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l361ODPD016757
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Apr 2007 18:24:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l361OCD7031449;
	Thu, 5 Apr 2007 18:24:12 -0700
In-Reply-To: <alpine.LFD.0.98.0704051703140.28181@xanadu.home>
X-Spam-Status: No, hits=-0.456 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43893>



On Thu, 5 Apr 2007, Nicolas Pitre wrote:
> 
> Well.... still it certainly can be helped a bit.  I wouldn't mind it 
> spending half an hour of CPU if it needs to.  But I just interrupted it
> with ^C with the following result so far:
> 
> real    75m44.374s
> user    2m5.318s
> sys     0m54.059s

Well, the thing is, this is "normal", and doesn't really have a lot to do 
with git.

If the actual working set is larger than available memory, ~5% CPU time is 
actually pretty good. 

The only way to improve on it is to try to make the working set smaller. 
Sadly, that's often a really difficult thing to do ;(

> > I suspect you'll find that with 1GB or RAM you'll have other 
> > performance problems that are more pressing ("git clone" comes to mind 
> > ;)
> 
> Well... same issue actually.  git-pack-objects spent about 40 secs 
> firmly at 100% CPU usage counting objects.
> 
> Then it got stuck on:
> 
> 	remote: Done counting 4111366 objects.
> 
> again spending 3% CPU and the rest waiting for IO with the disk 
> definitely trashing.

Well, I seriously doubt it's the "same issue" except in the sense that 
yes, if you work with all objects, you are going to have a big working 
set.

Note that "working set" is different from "memory footprint". If you have 
good locality, the working set can be a *lot* smaller than the memory 
footprint, and that tends to be the best/only way to improve the working 
set: trying to not jump back-and-forth between different things.

One example of that kind of shrinkage of the working set was Junios commit 
57584d9eddc3482c5db0308203b9df50dc62109c to "git blame": by comparing the 
*pointers* rather than what they pointed to, you avoid having to follow 
the pointer all the way down.

However, doing that in general tends to be very difficult. We use hashes 
extensively (not just the obvious SHA1 hashes, but the object lookup 
itself is based on hash tables etc), and while they are nice and fast O(1) 
when you have enough memory, they do tend to spread things out so that you 
are using your memory potentially very sparsely, which is the last thing 
you want to do if you are paging.

Side note: I finally got the thing downloaded, and so I did a

	git checkout -f

and the trace is pretty horrid. It looks something like this:

	...
	lstat("kdeaccessibility/IconThemes/mono/scalable/apps/kimagemapeditor.svgz", 0x7fff6f8d29f0) = -1 ENOENT (No such file or directory)
	mkdir("kdeaccessibility", 0777)         = -1 EEXIST (File exists)
	unlink("kdeaccessibility")              = -1 EISDIR (Is a directory)
	stat("kdeaccessibility", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	mkdir("kdeaccessibility/IconThemes", 0777) = -1 EEXIST (File exists)
	unlink("kdeaccessibility/IconThemes")   = -1 EISDIR (Is a directory)
	stat("kdeaccessibility/IconThemes", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	mkdir("kdeaccessibility/IconThemes/mono", 0777) = -1 EEXIST (File exists)
	unlink("kdeaccessibility/IconThemes/mono") = -1 EISDIR (Is a directory)
	stat("kdeaccessibility/IconThemes/mono", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	mkdir("kdeaccessibility/IconThemes/mono/scalable", 0777) = -1 EEXIST (File exists)
	unlink("kdeaccessibility/IconThemes/mono/scalable") = -1 EISDIR (Is a directory)
	stat("kdeaccessibility/IconThemes/mono/scalable", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	mkdir("kdeaccessibility/IconThemes/mono/scalable/apps", 0777) = -1 EEXIST (File exists)
	unlink("kdeaccessibility/IconThemes/mono/scalable/apps") = -1 EISDIR (Is a directory)
	stat("kdeaccessibility/IconThemes/mono/scalable/apps", {st_mode=S_IFDIR|0775, st_size=12288, ...}) = 0
	open("kdeaccessibility/IconThemes/mono/scalable/apps/kimagemapeditor.svgz", O_WRONLY|O_CREAT|O_EXCL, 0666) = 5
	write(5, "\37\213\10\10\205\3\263A\0\3kimagemapeditor.svg\0\344Z"..., 10112) = 10112
	close(5)                                = 0
	lstat("kdeaccessibility/IconThemes/mono/scalable/apps/kimagemapeditor.svgz", {st_mode=S_IFREG|0664, st_size=10112, ...}) = 0
	...

and that repeats for every single file. There's 233,902 of them. Oops.

On the other hand, we do certain things pretty well.  A "git diff", with
enough memory, takes 0.65s.  That's just over *half*a*second* for 233
*thousand* files.  I'd want to have tons of memory to work with this
repository, but if I did, I'd still think git is the best thing since
sliced bread. 

And doing ops like "git blame" on some random file I looked at was
actually instantaneous.  I probably happened to pick a new file just by
luck, but still..  Most things definitely work pretty damn well. 

(Update: I did a

	git log --raw -r |
		grep '^:100644.*M' |
		cut -f2 |
		sort |
		uniq -c |
		sort -n

to see the file that was updated the most, to get some kind of
worst-case for "git blame".  The list looks like:

   ...
   1091 koffice/kword/kwview.cc
   1099 kdelibs/khtml/khtml_part.cpp
   1116 koffice/kpresenter/kpresenter_view.cc
   1171 kdevelop/ChangeLog
   1667 kde-common/accounts

and while "git blame" is slow on them, it's not *painfully* so.  It took
13s to get the kdevelop/ChangeLog blame, and 31s (probably because the
diffs are much more interesting) to get the kpresenter_view.cc blame. 
Too slow, but still usable, and "git gui" again made it more interesting
to wait for it.. 

That said, the more I look at this, the more I think that this is *the*
perfect example of why you shouldn't put everything in one big
repository.  Git should be able to handle it, but nobody should really
do things like that. It's just stupid.

I will think hard about submodules.

			Linus
