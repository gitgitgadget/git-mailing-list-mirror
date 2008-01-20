From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sun, 20 Jan 2008 10:20:46 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801200942191.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 19:21:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGene-0006zh-Gc
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 19:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbYATSVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 13:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754522AbYATSVM
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 13:21:12 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47967 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753677AbYATSVK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 13:21:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0KIKov1021084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Jan 2008 10:20:51 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0KIKkIp029853;
	Sun, 20 Jan 2008 10:20:47 -0800
In-Reply-To: <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.72 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71182>


On Sun, 20 Jan 2008, Steffen Prohaska wrote:
> 
> Here are timings for Windows XP running in a virtual machine on a
> Laptop.  The work tree contains 7k files.  I stripped user and
> sys times because they are apparently meaningless for MINGW.
> 
> Best time before:
> 
>    $ time git commit >/dev/null
>    real    0m1.662s
> 
> Best time after:
> 
>    $ time git commit >/dev/null
>    real    0m1.196s

Ok, very interesting.

That's a 28% reduction in running time (or, alternatively, if you want to 
make it sound better, a 39% performance improvement ;), but quite frankly, 
I was hoping for even more. On my tests (with the kernel tree), the patch 
series literally removed half of the system calls, and I was really hoping 
that performance would be almost linear in system calls, especially on 
Windows where they are more expensive.

But I guess that was a bit optimistic. On Linux, we still had about 50% 
user time, and I guess the same is _largely_ true on Windows. Cutting the 
system time in half only gives you about a quarter performance 
improvement, and I was just incorrect in expecting system calls to be the 
limiting factor.

That's still a nice performance improvement, of course, but I was really 
hoping for more, since people have claimed that git is slow on windows. 
Maybe that's simply not true any more now that (a) people use the thinner 
mingw layers and (b) many things - like git-commit - are built-in, so that 
there simply isn't the horrible process creation overhead.

I have absolutely no idea how to do performance analysis or even something 
simple as getting a list of system calls from Windows (even if I had a 
Windows machine, which I obviously don't ;), so I'm afraid I have no clue 
why git might be considered slow there. I was hoping this was it

> And here are the timings for the host system, which is Mac OS X,
> on the same work tree.
> 
> Best time before:
> 
>    $ time git commit >/dev/null
>    real    0m0.571s
>    user    0m0.332s
>    sys     0m0.237s
> 
> Best time after:
> 
>    $ time git commit >/dev/null
>    real    0m0.463s
>    user    0m0.273s
>    sys     0m0.186s
> 
> Interestingly, the relative improvements are even smaller on Mac
> OS X.

Well, you're testing something with 7k files, and I was testing something 
with 23k files. The changes in question only affect the number of lstat's 
on those files, they don't affect things like the basic setup overhead we 
have for doign things like checking that refs are unique.

So your test-case does have relatively more overhead (compared to what got 
optimized) than the numbers I quoted. 

We also do know that while Linux has a very low-overhead lstat(), the real 
problem on OS X has been the memory management, not the filesystem. We had 
some case where the page fault overhead was something like two orders of 
magnitude bigger, didn't we?

(Yeah - just checked. Commit 6d2fa7f1b489c65e677c18eda5c144dbc5d614ab: 
"index-pack usage of mmap() is unacceptably slower.."). That took a minute 
on Linux, and an hour on OS X)

It would be good to have a system-level profile of something like this. On 
Linux, it's now mostly in user space with "git commit", and oprofile 
shows:

	samples  %        image name               app name                 symbol name
	23318    11.5388  git                      git                      cache_name_compare
	11910     5.8936  git                      git                      excluded
	9775      4.8371  libcrypto.so.0.9.8b      libcrypto.so.0.9.8b      (no symbols)
	7990      3.9538  libc-2.7.so              libc-2.7.so              strlen
	7468      3.6955  vmlinux                  vmlinux                  __d_lookup
	7137      3.5317  libc-2.7.so              libc-2.7.so              internal_fnmatch
	7047      3.4872  libz.so.1.2.3            libz.so.1.2.3            (no symbols)
	6317      3.1259  git                      git                      index_name_pos
	5537      2.7400  git                      git                      unpack_trees_rec
	5079      2.5133  vmlinux                  vmlinux                  ext3fs_dirhash
	4774      2.3624  libc-2.7.so              libc-2.7.so              strcmp
	4005      1.9819  vmlinux                  vmlinux                  __link_path_walk
	3436      1.7003  vmlinux                  vmlinux                  ext3_htree_store_dirent
	3421      1.6929  vmlinux                  vmlinux                  __kmalloc
	3188      1.5776  vmlinux                  vmlinux                  _atomic_dec_and_lock
	3041      1.5048  libc-2.7.so              libc-2.7.so              _int_malloc
	2904      1.4370  libc-2.7.so              libc-2.7.so              fnmatch@@GLIBC_2.2.5
	2727      1.3494  vmlinux                  vmlinux                  str2hashbuf
	...

and one thing to look out for would be that some of these things might be 
relatively much more costly on other systems.

fnmatch? It's certainly visible on Linux, I wonder if the Windows/OSX 
version is more expensive due to trying to be case-insensitive or 
something?

				Linus
