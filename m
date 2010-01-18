From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] Threaded grep
Date: Mon, 18 Jan 2010 10:05:19 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001180947140.13231@localhost.localdomain>
References: <20100118103334.GA17361@fredrik-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 19:07:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWw0j-00030A-JS
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 19:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349Ab0ARSH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 13:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049Ab0ARSH1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 13:07:27 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54194 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753529Ab0ARSH0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2010 13:07:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0II5JeA030020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 Jan 2010 10:05:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0II5J2N028521;
	Mon, 18 Jan 2010 10:05:19 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20100118103334.GA17361@fredrik-laptop>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.95 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137396>



On Mon, 18 Jan 2010, Fredrik Kuivinen wrote:
>
> Make git grep use threads when it is available.

Ok, this is much better.

On my machine (4 cores with HT, so 8 threads total), I get the 
following:

 [ Note: the --no-ext-grep is because I'm comparing with a git that has 
  the original grep optimization, but hasn't removed the external grep 
  functionality yet. I just used the same command line when then comparing 
  to next+your patch, so don't mind it.

  Also, the three examples are chosen to be: "trivial single match", 
  "regex single match", and "trivial lots of matches" ]

Before (all best-of-five), with the non-threaded internal grep:

 - git grep --no-ext-grep qwerty

	real	0m0.311s
	user	0m0.164s
	sys	0m0.144s

 - git grep --no-ext-grep qwerty.*as

	real	0m0.555s
	user	0m0.416s
	sys	0m0.132s

 - git grep --no-ext-grep function

	real	0m0.461s
	user	0m0.276s
	sys	0m0.180s

After, with threading:

 - git grep --no-ext-grep qwerty

	real	0m0.152s
	user	0m0.788s
	sys	0m0.212s

 - git grep --no-ext-grep qwerty.*as

	real	0m0.148s
	user	0m0.724s
	sys	0m0.284s

 - git grep --no-ext-grep function

	real	0m0.241s
	user	0m1.436s
	sys	0m0.216s

so now it's a clear win in all cases. And as you'd expect, the "complex 
case with single output" is the one that wins most, since it's the one 
that should have the most CPU usage, with the least synchronization.

That said, it still does waste quite a bit of time doing this, and while 
it almost doubles performance in the last case too, it does so at the cost 
of quite a bit of overhead.

(Some overhead is natural, especially since I have HT. Running two threads 
on the same core does _not_ give double the performance, so the CPU time 
almost doubling - because the threads themselves run slower - is not 
unexpected. It's when the CPU time more than quadruples that I suspect 
that it could be improved a bit).

		Linus
