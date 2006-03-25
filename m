From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 08:09:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603250759090.15714@g5.osdl.org>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
 <81b0412b0603250456o7f5925e6kbbfc0054aec564a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 17:09:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNBKt-0004T5-JN
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 17:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWCYQJv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 11:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWCYQJv
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 11:09:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751356AbWCYQJu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 11:09:50 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2PG9jDZ015682
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Mar 2006 08:09:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2PG9hpY002236;
	Sat, 25 Mar 2006 08:09:44 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0603250456o7f5925e6kbbfc0054aec564a1@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17988>



On Sat, 25 Mar 2006, Alex Riesen wrote:
> 
> Even more impressive on Cygwin (>50x!):
> 
> .../git-win$ time git --exec-path=$(pwd) diff initial.. > /dev/null
> real    0m1.485s
> user    0m0.567s
> sys     0m0.840s
> 
> ../git-win$ time git diff initial.. >/dev/null
> real    1m20.781s
> user    0m31.806s
> sys     0m20.717s

Yeah. That's the difference between "unusable" and "retty damn good".

Now, if we didn't even bother to write temporary files (and just did the 
object entirely in memory) I'd be even happier. I suspect it would help 
cygwin more too.

I've done a "strace" on "git-diff-tree" doing the 5-second diff of the 
kernel tree, and almost all of it looks like this:

	..
	open("/tmp/.diff_WgWi1X", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
	write(3, "/*\n * Driver for Digigram pcxhr "..., 6121) = 6121
	close(3)                                = 0
	open("/tmp/.diff_hCzrFe", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
	write(3, "/*\n * Driver for Digigram pcxhr "..., 6138) = 6138
	close(3)                                = 0
	rt_sigaction(SIGINT, {0x1000f650, [INT], SA_RESTART}, {0x1000f650, [INT], SA_RESTART}, 8) = 0
	open("/tmp/.diff_WgWi1X", O_RDONLY)     = 3
	fstat64(3, {st_mode=S_IFREG|0600, st_size=6121, ...}) = 0
	read(3, "/*\n * Driver for Digigram pcxhr "..., 6121) = 6121
	close(3)                                = 0
	open("/tmp/.diff_hCzrFe", O_RDONLY)     = 3
	fstat64(3, {st_mode=S_IFREG|0600, st_size=6138, ...}) = 0
	read(3, "/*\n * Driver for Digigram pcxhr "..., 6138) = 6138
	close(3)                                = 0
	unlink("/tmp/.diff_WgWi1X")             = 0
	unlink("/tmp/.diff_hCzrFe")             = 0
	..

which is just ridiculous. Those are _literally_ the only system calls we 
do any more after the conversion, if you ignore a few "brk()" calls here 
and there to allocate/free memory and obviously a number of "write(1,..." 
calls to actually write out the result!

(This is with a fully packed tree, so we just set up the object store with 
a single mmap at the beginning, which is why there are no reads to read 
the actual source contents).

Now, Linux is good at temp-files, but still: it adds nothing but overhead 
to first write out and then read back in over three _thousand_ filepairs 
(only to delete them immediately after reading), when the new code 
actually just wants to do the diff in memory anyway.

		Linus
