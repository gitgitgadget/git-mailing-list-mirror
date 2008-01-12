From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: performance problem: "git commit filename"
Date: Sat, 12 Jan 2008 14:46:08 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 23:47:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDp8Y-0000Do-20
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 23:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759360AbYALWrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 17:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759350AbYALWrF
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 17:47:05 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37837 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759302AbYALWrE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2008 17:47:04 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0CMk9B8009997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Jan 2008 14:46:10 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0CMk8Yr018048;
	Sat, 12 Jan 2008 14:46:08 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70362>


I thought we had fixed this long long ago, but if we did, it has 
re-surfaced.

Using an explicit filename with "git commit" is _extremely_ slow. Lookie 
here:

	[torvalds@woody linux]$ time git commit fs/exec.c
	no changes added to commit (use "git add" and/or "git commit -a")

	real    0m1.671s
	user    0m1.200s
	sys     0m0.328s

that's closer to two seconds on a fast machine, with the whole tree 
cached!

And for the uncached case, it's just unbearably slow: two and a half 
*minutes*.

In contrast, without the filename, it's much faster:

	[torvalds@woody linux]$ time git commit
	no changes added to commit (use "git add" and/or "git commit -a")
	
	real    0m0.387s
	user    0m0.220s
	sys     0m0.168s

with the cold-cache case now being "just" 18s (which is still long, but 
we're talking eight times faster, and certainly not unbearable!)

Doing an "strace -c" on the thing shows why. In the filename case, we 
have:

	% time     seconds  usecs/call     calls    errors syscall
	------ ----------- ----------- --------- --------- ----------------
	 32.69    0.000868           0     92299        37 lstat
	 17.40    0.000462           0     29958      3993 open
	 15.78    0.000419           0      5522           getdents
	 15.56    0.000413           0     23165           mmap
	 11.37    0.000302           0     23118           munmap
	  5.76    0.000153           0     25966         2 close
	  1.43    0.000038           0      2845           fstat
	...

and in the non-filename case we have

	% time     seconds  usecs/call     calls    errors syscall
	------ ----------- ----------- --------- --------- ----------------
	 53.67    0.000600           0     69227        31 lstat
	 23.35    0.000261           0      5522           getdents
	 11.09    0.000124           2        55           munmap
	  4.20    0.000047           0       285           write
	  3.31    0.000037           0      5537      2638 open
	  2.33    0.000026           0      2899         1 close
	  2.06    0.000023           0      2844           fstat
	...

notice how the expensive case has a lot of successful open/mmap/munmap 
calls: it is *literally* ignoring the valid entries in the old index 
entirely, and re-hashing every single file in the tree! No wonder it is 
slow!

Just counting "lstat()" calls, it's worth noticing that the non-filename 
case seems to do three lstat's for each index entry (and yes, that's two
too many), but the named file case has upped that to *four* lstats per 
entry, and then added the one open/mmap/munmap/close on top of that!

I'm pretty sure we didn't use to do things this badly. And if this is a 
regression like I think it is, it should be fixed before a real 1.5.4 
release.

I'll try to see if I can see what's up, but I thought I'd better let 
others know too, in case I don't have time. I *suspect* (but have nothing 
what-so-ever to back that up) that this happened as part of making commit 
a builtin.

			Linus
