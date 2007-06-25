From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Mon, 25 Jun 2007 16:16:56 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org>
References: <87r6nzu666.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
 <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 01:17:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2xnv-0000YX-8M
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 01:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbXFYXRG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 19:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbXFYXRF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 19:17:05 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51111 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751708AbXFYXRE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 19:17:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PNH1jX018653
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jun 2007 16:17:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PNGuGL013516;
	Mon, 25 Jun 2007 16:16:56 -0700
In-Reply-To: <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
X-Spam-Status: No, hits=-4.604 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50936>



On Mon, 25 Jun 2007, Linus Torvalds wrote:
> 
> There's also another issue: regular files really *are* different from 
> pipes and sockets and other things. Not because of EPIPE, but because you 
> want different buffering behaviour. For a regular file, we really don't 
> even care about the line buffering, and we'd actually be better off (from 
> a performance angle) without it.

Just for fun, I tried this out.

Doing

	time git log > logfile

on the kernel repo with and without the patch I just sent out, I get:

Without:

	real    0m1.361s
	user    0m1.312s
	sys     0m0.040s

With:

	real    0m1.687s
	user    0m1.392s
	sys     0m0.284s

so doing the extra flushing does actually cost us (it's just fundamentally 
more expensive to do disk IO on non-block-boundaries).

It would be much nicer if we only did it for sockets and pipes, which 
don't have the same block-boundary issues anyway (there's still the system 
call cost, but on a pipe/socket, the real costs tend to be elsewhere).

Again, this is something that a non-stdio-based buffering library would 
easily handle. You could just test the file descriptor _once_ at the 
beginning, to see if it's a regular file or not. And then you could have 
the error handling where it belongs (when the IO is actually done, and the 
error actually happens) rather than in the callers using a bad interface 
that sometimes loses 'errno'.

Btw, to balance the above performance comment: doing the flush_or_die() 
obviously *does* mean that you get better performance in the odd cases. 
For example, if you do

	[torvalds@woody linux]$ trap '' SIGPIPE
	[torvalds@woody linux]$ time git log | head

I get get 0.002s, while it used to be:

	real    0m1.382s
	user    0m1.340s
	sys     0m0.028s

just because it did the whole thing regardless of any EPIPE errors.

Of course, that case probably isn't very usual, but I could imagine that 
some users of "git blame -C --incremental" could actually cause situations 
like this (ie just stop listening when they got the part they're 
interested in, and maybe they'd have some strange reason to ignore 
SIGPIPE).

So I'm not opposed to the patch I sent out, I just wanted to point out 
that this is an area we *could* improve upon if we didn't do that stdio 
thing.

		Linus
