From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Finally implement "git log --follow"
Date: Tue, 19 Jun 2007 14:35:30 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706191425240.3593@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:35:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0lMU-0001pO-8g
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 23:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbXFSVfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 17:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbXFSVfl
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 17:35:41 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53169 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752075AbXFSVfk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2007 17:35:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5JLZa03007395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Jun 2007 14:35:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5JLZUpC021719;
	Tue, 19 Jun 2007 14:35:30 -0700
In-Reply-To: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.52 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50513>



On Tue, 19 Jun 2007, Linus Torvalds wrote:
> 
> People who want to improve on it should get rid of the memory leak I 
> introduced - I decided to not bother cleaning up the whole rename diff 
> queue, I just reset it. I'm lazy, and I'm a *man*. I do the rough manly 
> stuff, others can clean up after me.
> 
> *Burp*. That hit the spot. *Scratch*

On that note, if people want to decide that "git log" should *default* to 
follow when one filename is given, that's ok by me. A few warnings:

 - You should only do it for the "single file" case, and that's very
   *different* from the "single pattern" case. I often do "git log" on a 
   single directory, and that had better not start doing any "filename 
   following" by default.

   So before turning on "follow" automatically, it should be checked that 
   that exact file exists right now (might be as simplistic as just doing 
   a "lstat()" and verifying that it's a file or symlink in the current 
   working tree)

 - the commit simplification isn't done. So you cannot do "--follow" 
   together with somethign that wants a contiguous history (like gitk) and 
   uses "--parents".

   This is pretty fundamental. The commit simplification is a separate 
   phase over the (non-linear!) commit space, and the "git log --follow" 
   logic is really a *different* logic over the _linear_ space (namely the 
   streaming "log output" space). 

   Two totally different things, in other words. And not compatible.

So if we want to turn on "follow" by default, then I'm certainly ok with 
it, but it needs to be done with care. so I'd almost suggest just adding 
an alias instead, aka

	git config alias.follow 'log --follow'

and then doing

	git follow filename

rather than changing the behaviour of "git log" itself.

			Linus
