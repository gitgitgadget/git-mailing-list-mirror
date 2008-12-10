From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: epic fsck SIGSEGV! (was Recovering from epic fail (deleted
 .git/objects/pack))
Date: Wed, 10 Dec 2008 15:40:28 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
References: <1228867861.14165.19.camel@starfruit.local>  <7vd4g051ax.fsf@gitster.siamese.dyndns.org>  <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net> <1228949523.27061.20.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:42:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAYhT-0004xx-Mj
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 00:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbYLJXlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 18:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbYLJXlW
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 18:41:22 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36473 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752386AbYLJXlV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 18:41:21 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBANeTDD021718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Dec 2008 15:40:30 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBANeSJl023133;
	Wed, 10 Dec 2008 15:40:28 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1228949523.27061.20.camel@starfruit.local>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.427 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102742>



On Wed, 10 Dec 2008, R. Tyler Ballance wrote:
> 
> I decided to endure the 30 minutes long this took on machine, and ran
> the operation in gdb. As a result, I got the SIGSEGV again, and a 13MB
> stacktrace.
> 
> In fact, the stack trace was probably longer, but this happened while I
> printed out `bt full`:

Wow. You even got _gdb_ to segfault.

You're my hero. If it can break, you will do it.

> I think I'm going to need to have a drink :-/

Have one for me too.

Anyway, that's a really annoying problem, and it's a bug in git. 
Admittedly it's probably brought on by you having a fairly small stack 
ulimit, which is also what likely brought gdb to its knees.

That stupid fsck commit walker walks the parents recursively. That's 
horribly bogus. So you have a recursion that goes from the top-level 
commit all the way to the root, doing

	fsck_walk_commit -> walk(parent) -> fsck_walk-commit -> ..

and you have a fairly deep commit tree. 

When it hits parent number 80,000+, you run out of stack space, and 
SIGSEGV. And judging by the fact that gdb also SIGSEGV's for you when 
doing the backtrace, it looks like the gdb backtrace tracer is _also_ 
recursive, and _also_ hits the same issue ;)

Anyway, with a 8M stack-size I can fsck the kernel repo without any 
problem, but while the kernel repo has something like 120k commits in it, 
it's a very "bushy" repository (lots of parallelism and merges), and the 
path from the top parent to the root is actually much shorter, at just 27k 
commits.

I take it that your project has a very long and linear history, which is 
why you have a long path from your HEAD to your root.

(You can do something like

	git rev-list --first-parent HEAD | wc -l

to get the depth of your history when just walking the first parent, and 
if I'm right you'll have a number that is bgger then 80k.)

So you have definitely found a real bug. Right now, you should be able to 
work around it by just making your stack depth rather bigger. The 
recursion is not very complicated, so even though it's 80,000 deep, each 
entry probably is about a hundred bytes on the stack. 

In fact, if you're on Linux, most default stack depths would be 8 MB, 
which would roughly match that "80k entries of 100 bytes each".

But we should definitely fix this braindamage in fsck. Rather than 
recursively walk the commits, we should add them to a commit list and just 
walk the list iteratively.

Junio?

		Linus
