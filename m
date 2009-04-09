From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: buglet: 'git apply' doesn't handle criss-cross renames
Date: Thu, 9 Apr 2009 11:59:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904091147290.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Al Viro <viro@ZenIV.linux.org.uk>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 09 21:03:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrzWi-0006K2-JW
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 21:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765446AbZDITB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 15:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761630AbZDITB2
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 15:01:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54575 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758180AbZDITB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 15:01:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n39IxdlU023526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Apr 2009 12:00:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n39Ixc3W004182;
	Thu, 9 Apr 2009 11:59:39 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.443 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116198>


Ok, this doesn't come up in real life very much, but it's not impossible, 
and I was generating this test-case to show Al how it's probably going to 
be a real bitch to teach 'patch' how to handle git rename patches (or git 
copy patches) in the general case.

Of course, the way git patches work is that the same source file may show 
up several times (due to copies) or as both a source and a destination 
(criss-cross renames or just rename + create new file), and we always look 
at the _original_ state when we apply a patch fragment. Which makes it 
hard for something like GNU "patch" that is purely linear.

And I was going to send Al an example of git doing that, and I was sure 
that we had handled this at some point, but maybe I'm just wrong. I didn't 
really go back and test it.

The point is, git itself fails here. Although not for any really 
fundamental reason - but simply because we are a bit too tight on some 
error handling, and do some checks wrong.

Git can _generate_ criss-cross merges correctly (although you have to use 
the -B flag to make git try to break the names up):

	mv kernel/sched.c a
	mv kernel/exit.c kernel/sched.c
	mv a kernel/exit.c
	git diff -B -M > diff

and we get a nice correct diff:

	diff --git a/kernel/sched.c b/kernel/exit.c
	similarity index 100%
	rename from kernel/sched.c
	rename to kernel/exit.c
	diff --git a/kernel/exit.c b/kernel/sched.c
	similarity index 100%
	rename from kernel/exit.c
	rename to kernel/sched.c

but if you actually try to apply such a patch, we fail miserably (you need 
to got a 'git reset --hard' or similar to get back the original tree to 
apply the diff on, obviously):

	[torvalds@nehalem linux]$ git apply diff
	error: kernel/exit.c: already exists in working directory
	error: kernel/sched.c: already exists in working directory

which is really sad.

I don't have a patch for it, and I don't think it's a huge deal in 
practice, but I do think it's seriously wrong how we can generate a diff 
that we then refuse to apply.

			Linus
