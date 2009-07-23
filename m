From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 17:21:48 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 02:22:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTm4P-0006qm-4L
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 02:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbZGWAVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 20:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbZGWAVu
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 20:21:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56847 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751331AbZGWAVu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 20:21:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N0LmAT021456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jul 2009 17:21:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N0LmH8012832;
	Wed, 22 Jul 2009 17:21:48 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090722235914.GA13150@Pilar.aei.mpg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123813>



On Thu, 23 Jul 2009, Carlos R. Mafra wrote:
> 
> When I run 'git branch' in the linux-2.6 repo I think it takes
> too long to finish (with cold cache):
> 
> [mafra@Pilar:linux-2.6]$ time git branch
>   27-stable
>   28-stable
>   29-stable
>   30-stable
>   dev-private
> * master
>   option
>   sparse
>   stern
> 0.00user 0.05system 0:05.73elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (209major+1380minor)pagefaults 0swaps
> 
> This is with git 1.6.4.rc1.10.g2a67 and the kernel is 2.6.31-rc3+. The
> machine is a 64bit Vaio laptop which is 1+ year old (so it is not "slow").

When have you last repacked the repository?

What you're descibing is basically IO overhead, and if you don't have 
packed references, it's going to read a lot of small files.

> I use git to track linux-2.6 for 2 years now, and I remember that
> 'git branch' is slow for quite some time, so it is not a regression
> or something. It is just now that I took the courage to report this
> small issue.
> 
> I did a 'strace' and this is where it spent most of the time:
> 
> 1248301060.654911 open(".git/refs/heads/sparse", O_RDONLY) = 6
> 1248301060.654985 read(6, "60afdf6a4065a170ad829b4d79a86ec0"..., 255) = 41
> 1248301060.655056 read(6, "", 214)      = 0
> 1248301060.655116 close(6)              = 0
> 1248301060.680754 lstat(".git/refs/heads/stern", 0x7fff80bfa8d0) = -1 ENOENT (No such file or directory)
> 1248301064.018491 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
> 1248301064.018641 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f409ffa7000
> 1248301064.018722 write(1, "  27-stable\33[m\n", 15) = 15
> 
> I don't know why .git/refs/heads/stern does not exist and why it takes
> so long with it. That branch is functional ('git checkout stern' succeeds),
> as well as all the others. But strangely .git/refs/heads/ contains only
> 
> [mafra@Pilar:linux-2.6]$ ls .git/refs/heads/
> dev-private  master  sparse
> 
> which, apart from "master", are the last branches that I created.

Ok, this actually means that you _have_ repacked the repo, and the rest of 
the branches are all nicely packed in .git/packed-refs.

But that four _second_ lstat() is really disgusting.

Let me guess: if you do a "ls -ld .git/refs/heads" you get a very big 
directory, despite it only having three entries in it. And your filesystem 
doesn't have name hashing enabled, so searching for a non-existent file 
involves looking through _all_ of the empty slots.

Try this:

	git pack-refs --all

	rmdir .git/refs/heads
	rmdir .git/refs/tags

	mkdir .git/refs/heads
	mkdir .git/refs/tags

and see if it magically speeds up.

			Linus
