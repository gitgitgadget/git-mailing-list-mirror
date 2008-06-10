From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 16:00:49 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101554490.3101@woody.linux-foundation.org>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>  <m3abhtp42o.fsf@localhost.localdomain>  <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>  <200806102159.02875.jnareb@gmail.com>  <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
  <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>  <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>  <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>  <6dbd4d000806101422j39709906x1b4b03b82b504e62@mail.gmail.com>
  <alpine.LFD.1.10.0806101431410.3101@woody.linux-foundation.org> <6dbd4d000806101509l516cf467me06fadee6ead0964@mail.gmail.com> <alpine.LFD.1.10.0806101518590.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 01:01:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Cqa-0003pS-9z
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 01:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbYFJXAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 19:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbYFJXAy
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 19:00:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60674 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752143AbYFJXAy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 19:00:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AN0oqg020211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 16:00:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AN0n09001557;
	Tue, 10 Jun 2008 16:00:50 -0700
In-Reply-To: <alpine.LFD.1.10.0806101518590.3101@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.38 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84560>



On Tue, 10 Jun 2008, Linus Torvalds wrote:
> 
> It's going to make big "git add" calls *much* slower, so I'm not very 
> happy about it (especially since we don't actually care that deeply about 
> the files really being there until much later, so doing something 
> asynchronous would be perfectly acceptable), but for you this is 
> definitely worth-while.

For me, on the whole kernel, on a pretty good system:

 - before:

	[torvalds@woody test-it-out]$ time git add .

	real    0m7.986s
	user    0m6.404s
	sys     0m1.456s

 - after:

	[torvalds@woody test-it-out]$ time ~/git/git-add .

	real    0m52.693s
	user    0m7.416s
	sys     0m2.516s

so it's definitely quite noticeable in that simplistic form. 

A more interesting patch would use aio_fsync(), and then just wait for 
them at the end with aio_return(). Not that I love AIO, but this is 
definitely a case where it would make sense to do (of course, systems 
without AIO support would then fall back to regular fsync()).

I will have to think about this.

			Linus
