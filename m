From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Fri, 23 Sep 2005 19:46:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter TB Brett <peter@peter-b.co.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 04:47:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJ042-00021i-C5
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 04:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVIXCqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 22:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVIXCqz
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 22:46:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1448 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751369AbVIXCqz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 22:46:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8O2km4s023461
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Sep 2005 19:46:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8O2kl6U022026;
	Fri, 23 Sep 2005 19:46:48 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9225>



On Sat, 24 Sep 2005, Johannes Schindelin wrote:
> 
> BTW I am fairly convinced that the same issues would trouble a git-pull, 
> once the networking is running, since the pack transfer relies on 
> fork()ing.

I'm not sure.

Almost all other fork() users end up doing a more-or-less immediate 
execve() after the fork. Yes, they do some other minor setup, but not a 
whole lot.

The diff.c fork() is somewhat different. It actually ends up doing malloc 
and stdio IO before it actually gets to the exec(), so that one is more 
likely to hit any bugs in the fork() implementation.

Actually, looking a bit closer, the create_pack_file() thing also does 
malloc inside the child, but at least there it would be trivial to move 
that argument setup code into the parent.

But looking at send_pack() or fetch_pack(), for example, they are both
_very_ traditional fork()+exec() calls, with just a few close() calls in
between.

Looking a bit closer at the diff() usage, I actually think that we could 
move the fork() closer to the exec - we'd just have to move it _into_ all 
the different cases (ie you'd have two different fork() calls: one for 
the "builtin" case, one for the external pgm case, but then the child in 
both cases would be very simple).

Oh. Actually, I wonder if we could mke them "vfork()" calls. Does anybody 
know if cygwin has an easier time with vfork() + eventual exec? That 
_should_ map better to a non-UNIX process model, so maybe we could do it 
that way?

> It sure would be nice to have a unified diff generator included, but I 
> doubt that a reliable (=simple) one is easy to come by.

Yeah, I looked at GNU diffutils, and I had to rinse out my eyes with soap 
and water.

		Linus
