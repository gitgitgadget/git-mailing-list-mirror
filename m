From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: unable to run gc (or git repack -Adl )
Date: Fri, 29 Jan 2010 21:14:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001292025260.1681@xanadu.home>
References: <cccedfc61001291429q7dfa2045x18134439ad1e7c94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jon Nelson <jnelson@jamponi.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 03:18:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb2v2-0005Ks-U6
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 03:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813Ab0A3CPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 21:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755787Ab0A3CPD
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 21:15:03 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42371 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab0A3CPB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 21:15:01 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX1005RVFKNUVJ1@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 21:14:48 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <cccedfc61001291429q7dfa2045x18134439ad1e7c94@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138425>

On Fri, 29 Jan 2010, Jon Nelson wrote:

> Using 1.6.4.2 on openSUSE 11.2 (x86_64).
> 
> I have a beefy repo (du of 14GB) that I can't seem to run 'gc' on.
> 
> After running for over 2 hours, this is what I get:
> 
> Counting objects: 267676, done.
> Compressing objects: 100% (217424/217424), done.
> fatal: Unable to create temporary file: Too many open files
> error: failed to run repack

Ouch!!  Impressive.

> Ugh!

Indeed.

> I have 3 GB of memory (and 1GB of swap).
> When I strace the various processes, I see some things I don't understand:
> 
> 1. I see the 'git-repack' shell process scanning for .keep files. I
> don't have any. Is there a shortcut to this?
> 
> It's also hugely inefficient. In this case, the code to identify non
> .keep packs takes *4 minutes, 45 seconds*, lots of disk I/O, and lots
> of CPU (it pegs one CPU at 100% for the entire duration). With a wee
> bit of awk, I have reduced that to 2.3 seconds with VASTLY reduced I/O
> and CPU requirements. Patch attached.

Your patch will pick any .pack file in the repo not only from the 
.git/objects/pack directory.  There is no such thing as *.pack.keep 
either.

> 2. When git-pack-objects is being run, around the time it's 85% done
> "compressing" it's very very very slow. Like, 2-5 objects every
> second. The largest object in the repo is about 1MB.

You probably consumed all RAM and started swapping at that point.

Or... you have many of those 1MB objects.  If so try 
using --window-memory=8M or similar.

> 3. When git pack objects is running and counting up the number of
> objects, it is stat'ing files that aren't in the working directly, and
> should not be, according to the index. If I switch the repo to be a
> "bare" repository, then it doesn't do that, however, why is it doing
> that in the first place?

A bare repository has no index.  When the index is present though, it is 
necessary to also pack objects it references.  Why working directory 
files would be stat()'d in that case I don't know.

> 4. Should git-pack-objects be reading the pack.idx files for counting
> objects instead of the .pack files themselves?

No.  The whole point when "counting objects" is to perform a walk of the 
history graph and capture the set of objects that are actually 
referenced from your branches/tags and leave the unreferenced objects 
behind.  Also the order in which those objects are encountered during 
that history walk is very important for efficient object placement in 
the final pack.  So this is much more involved than only listing the 
objects contained in every packs.

> 5. There is no 5

I'm a flying buldozer.

> 6. Should git-pack-objects be closing .pack files after opening them?
> I have 6559 .pack files.

No wonder why you exhausted your file handles.  And your repository must 
be _horribly_ slow to work with, which might explain the 
slowness/swappiness.

> 7. Ultimately, how do I get "git gc" to work on this repo?

... because you really really want to repack this mess ASAP of course.

Having so many packs means they must be relatively small.  Yet, Git 
allows up to 8GB of pack data to be mmap()'d at once on x86_64.  This 
means that an average of 3700 packs might be mapped at once, plus their 
respective .idx files.

You could try:

	git config core.packedGitLimit 256m
	git config core.packedGitWindowSize 32m
	git config pack.deltaCacheSize 1

and try repacking again with 'git gc --prune=now'.  After the repack 
succeeds, you should be able to remove the above configs from your 
.git/config file.


Nicolas
