From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 19:20:00 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 04:20:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTnv1-000611-V8
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 04:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZGWCUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 22:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbZGWCUG
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 22:20:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57528 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751676AbZGWCUE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 22:20:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N2K0U4030772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jul 2009 19:20:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N2K0Ed004061;
	Wed, 22 Jul 2009 19:20:00 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090723012207.GA9368@Pilar.aei.mpg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123821>



On Thu, 23 Jul 2009, Carlos R. Mafra wrote:
> > Let me guess: if you do a "ls -ld .git/refs/heads" you get a very big 
> > directory, despite it only having three entries in it. 
> 
> [mafra@Pilar:linux-2.6]$ ls -ld .git/refs/heads
> drwxr-xr-x 2 mafra mafra 4096 2009-07-22 23:01 .git/refs/heads/

Hmm. That's just a single block. 

Then I really don't see why the lstat takes so long.

> After 'echo 3 > /proc/sys/vm/drop_caches' it still takes too long,
> 
> 1248310449.693085 munmap(0x7f50bcd11000, 164) = 0
> 1248310449.693187 lstat(".git/refs/heads/sparse", 0x7fff618c0960) = -1 ENOENT (No such file or directory)
> 1248310449.719112 lstat(".git/refs/heads/stern", 0x7fff618c0960) = -1 ENOENT (No such file or directory)
> 1248310453.014041 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 3), ...}) = 0
> 1248310453.014183 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f50bcd11000

Use 'strace -T', which shows how long the actual system calls take, rather 
than '-tt' which just shows when they started.

Maybe the four seconds is something else than the lstat - page faults on 
the pack-file in between the lstat and the fstat, for example.

> Perhaps I should delete the "stern" branch, but I would like to learn why
> it is slowing things, because it also happened before (in fact it is always
> like this, afaicr)

Absolutely. Don't delete it until we figure out what takes so long there.

> Do you have another theory? (now .git/refs/heads is empty)

Clearly it's IO, but if that 'lstat()' was just a red herring, then I 
suspect it's IO on the pack-file. If so, I'd further guess that your VAIO 
has some pitiful 4200rpm harddisk that is slow as hell and has horrible 
seek latencies, and the CPU is way overpowered compared to the cruddy 
disk.

It probably does the object lookup. You can see some debug output if you 
do

	GIT_DEBUG_LOOKUP=1 git branch

and that will show you the patterns. It won't be very pretty, especially 
if you have several pack-files, but maybe we can figure out what's up.

Hmm. I wonder.. I suspect 'git branch' looks up _all_ refs, and then 
afterwards it filters them. So even though it only prints out a few 
branches, maybe it will look at all the tags etc of the whole repository.

Ooh yes. That would do it. It's going to peel and look up every single ref 
it finds, so it's going to look up _hundreds_ of objects (all the tags, 
all the commits they point to, etc etc). Even if it then only shows a 
couple of branches.

Junio, any ideas?

		Linus
