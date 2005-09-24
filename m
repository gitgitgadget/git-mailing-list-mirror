From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sat, 24 Sep 2005 11:10:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter TB Brett <peter@peter-b.co.uk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 20:12:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJETs-0005Rs-6J
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 20:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVIXSKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 14:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVIXSKV
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 14:10:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40626 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932215AbVIXSKU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 14:10:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8OIAG4s019950
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 24 Sep 2005 11:10:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8OIAEFl020770;
	Sat, 24 Sep 2005 11:10:15 -0700
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9240>



On Fri, 23 Sep 2005, Davide Libenzi wrote:
> 
> If you have only to run diff/patch, just use the native Win32 CreateProcess().
> You abstract that on a git_exec(), and you use fork/exec on Unix and 
> CreateProcess() on Winblows. If fork() is slow on Cygwin, fork+exec is 
> pathetic. They do all that work to give you a fork(), and you throw it 
> away with an exec().

CreateProcess doesn't work all that well, since we want to dup file 
descriptors around and close them in the child.

In general, CreateProcess() is a totally crap interface. I realize it's 
common (and especially in the VMS/Windows world it's how things are done), 
but hey, at that point it's better if somebody just waits until git is 
stable, and just makes a totally separate "git for windows" thing. The 
interfaces are certainly simple. There's no point in trying to maintain 
one tree.

However, vfork() really _is_ a nice interface. It's faster even on UNIX,
and at least in theory it should be possible to do an efficient vfork()  
implementation on top of crap like windows. Does cygwin support that well?

Yes, git uses lots of filesystem stuff, and they suck under windows. Maybe 
cygwin adds its own overhead, but from everything I've ever been able to 
tell, filesystem access sucks under Windows regardless of any cygwin 
stuff. Add to an already slow FS interface the fact that virus checkers 
tend to hook into it and make it _even_slower_, and hey, you have a truly 
sucky OS. 

But at least with pack-files, the filesystem access patterns are much 
less common. Opening one pack-file and mapping it gets the FS out of the 
way. So I don't think that's necessarily a huge problem.

		Linus
