From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: three-way diff performance problem
Date: Tue, 21 Jul 2009 11:10:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907211038120.19335@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 20:12:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTJp1-0006Ho-Qo
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 20:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbZGUSK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 14:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbZGUSKZ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 14:10:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44006 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751507AbZGUSKY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 14:10:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6LIA1jP015937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 21 Jul 2009 11:10:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6LIA1M5028121;
	Tue, 21 Jul 2009 11:10:01 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123681>


Ok, so I decided to abuse git today, because I actually had a problem 
where git could potentially solve it. Sadly, it's now 55 minutes later, 
and my single git command hasn't completed yet :(

What did I do?

We have a really odd bug-report for the kernel where switching the 
compiler from using '-fwrapv' to using '-fno-strict-overflow' causes a 
non-working kernel.

So the exact same kernel sources work fine with either 'fwrapv' or, 
indeed, with neither option, but with '-fno-strict-overflow' it just hangs 
at boot. 

Now, the problem is that I can't actually see the issue, so I just have 
three kernel binaries, two of which work, and one which does not. I can 
disassemble them, and I did, and the end result are three files with 
roughly 1.14 million lines.

The diffs between them are in the 40- to 90-thousand line area, and it's 
really hard to read diffs of assembly code and try to figure out what the 
problem with the generated code is. Yeah, I'm pretty good at reading 
assembler, but I'm not _that_ good. Just scanning 40 thousand lines takes 
a while, looking at it _closely_ is just incredibly hard and isn't going 
to ever really work out.

But there's a saving grace: I have two working kernels. And the 
differences are often silly things like different register allocation, and 
they are _different_. Many functions end up being the same between one 
working kernel and the failing one, while being different in another 
working kernel.

So what I want is the differences that are different from _both_ working 
kernels, since being the same as _one_ of them means that it's not a bug.

Now, being a git person, what does that say? Right: just check in the 
working kernels as two branches under the same filename, then merge the 
branches, and force the merge result to be the non-working kernel, and do 
a three-way combined context diff! So I did exactly that.

An hour later, it's still thinking.

So I used our nice new 'perf' tool from the kernel on a run that I killed 
after five minuets, and lookie here:

	#
	# (17566764 samples)
	#
	# Overhead           Command  Shared Object              Symbol
	# ........  ................  .........................  ......
	#
	    96.26%               git  /home/torvalds/bin/git     [.] consume_line
	...

it says we're spending pretty much all our time in a single function.

In fact, on the instruction-level profile, it looks like it's all spent on 
four instructions:

    3.51 :        45aec0:       4c 85 72 10             test   %r14,0x10(%rdx)
   86.27 :        45aec4:       48 0f 45 ca             cmovne %rdx,%rcx
         :              if (sline->lost_head) {
         :                      struct lline *last_one = NULL;
         :                      /* We cannot squash it with earlier one */
         :                      for (lline = sline->lost_head;
         :                           lline;
         :                           lline = lline->next)
    6.69 :        45aec8:       48 8b 12                mov    (%rdx),%rdx
         :
         :              /* Check to see if we can squash things */
         :              if (sline->lost_head) {
         :                      struct lline *last_one = NULL;
         :                      /* We cannot squash it with earlier one */
         :                      for (lline = sline->lost_head;
    3.51 :        45aecb:       48 85 d2                test   %rdx,%rdx
    0.01 :        45aece:       75 f0                   jne    45aec0 <consume_line+0xc0>

(ok, five, I included the 0.01% of the branch instruction that finishes 
the loop - the way Nehalem works, it will merge those test+jne 
instructions into one macro-instruction internally, which is why the 
branch that is obviously part of the loop doesn't get a lot of hits)

Just FYI, those four instructions come from inlining 'append_lost()'. It's 
compiled that first for-loop into some very good assembly language, but 
the problem is that this all looks very much quadratic in number of 
lost_lines. The quality of the compiler thus sadly in no way helps make up 
for a really really expensive algorithm.

Any ideas?

For any git people who want to look at the horror that caused this, feel 
free to download the (fairly small) git repository from

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/git-merge-test.git

and try to do a

	git show --color fno-strict-overflow

just for fun. Do "gitk --all" to see the simple nature of the repository, 
but if you do, you'll need to kill the "git diff-tree -r -p --textconv .." 
process that gitk will start (and which will take forever).

The code in question is all Junio's, and is over three years old. So it's 
obviously been working fine. And the load is obviously not really 
appropriate, but at the same time I think it's an interesting thing to 
try. An it doesn't seem to be about memory use - It's now been running for 
85 minutes (ok, this email took long to write, and I uploaded the thing 
etc in the meantime etc), and it's holding steady at roughly 175MB RSS.

			Linus
