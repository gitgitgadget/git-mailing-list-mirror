From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Avoid unnecessary 'lstat()' calls in 'get_stat_data()'
Date: Sun, 10 May 2009 09:50:41 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905100943370.3586@localhost.localdomain>
References: <alpine.LFD.2.01.0905091501460.3586@localhost.localdomain> <7v8wl5613c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 18:52:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3CFx-0001T0-FQ
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 18:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbZEJQv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 12:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbZEJQv5
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 12:51:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43802 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878AbZEJQv5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2009 12:51:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4AGogJU026033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 May 2009 09:51:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4AGogxs006320;
	Sun, 10 May 2009 09:50:42 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v8wl5613c.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.462 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118729>



On Sat, 9 May 2009, Junio C Hamano wrote:
>
> I have been processing the patches in my "after 1.6.3" mailbox from the rc
> freeze period and have already queued this one, but the re-integration of
> four branches is taking a bit longer than usual.  It takes too much time
> to run tests (and as a part of my build procedure I do docs, too) for all
> integration branches, and until they all pass tests on Debian5 (primary
> development box) and Fedora9 (at k.org) I do not push the result out, so
> it is a bit painful for me to replace a patch once a day's testing cycle
> begins.

Heh.

I can attest from personal experience that if some test-sequence takes a 
couple of hours, and keeps you from making sane changes from the source, 
you'll eventually go mad. It was one of the reasons I absolutely hated 
working with CVS at transmeta - not only did the pre-checking tests take 
forever, but you effectively couldn't do anything else while they were 
running due to the whole "branches don't work".

Now, at least you don't have _that_ issue, but if testing keeps you from 
doing the sane thing, you'll still end up having some of the same things 
happen.

I've found that "make -j64 test" does fairly well, bringing the cost down 
to something reasonable. Some of the SVN tests seem to sometimes randomly 
fail when done in parallel (I've not tried to debug it, I assume it's 
either some SVN bug, or just the test infrastructure having some shared 
SVN central repo thing), but it happens rarely enough that even if you 
have to run it twice, it's still worth it. 

[ Side note: the success output of "make test" makes it almost impossible 
  to debug the error cases when you do that "make -j64" thing. Sad. It 
  would be good to have the tests that fail clearly say exactly what test 
  failed, because when you run 64 tests at the same time, having "case 9" 
  fail is almost totally useless information - test 9 of _which_ 
  testsuite? ]

I don't generally build docs, but they should run in parallel too, and at 
least your fedora build on kernel.org has a nice quad-core machine with 
lots of memory, so "-j8" or something is reasonable.

				Linus
