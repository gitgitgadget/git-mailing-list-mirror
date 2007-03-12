From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Errors cloning large repo
Date: Mon, 12 Mar 2007 11:40:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703121057530.9690@woody.linux-foundation.org>
References: <315943.12751.qm@web52606.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Anton Tropashko <atropashko@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:40:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQpRs-0001D9-TC
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 19:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbXCLSkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 14:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbXCLSkl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 14:40:41 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36491 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbXCLSkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 14:40:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2CIedo4019232
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Mar 2007 11:40:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2CIecNs010913;
	Mon, 12 Mar 2007 10:40:39 -0800
In-Reply-To: <315943.12751.qm@web52606.mail.yahoo.com>
X-Spam-Status: No, hits=-0.486 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42057>



On Mon, 12 Mar 2007, Anton Tropashko wrote:
> 
> > Its very likely this did fit in just under 4 GiB of packed data,
> > but as you said, without O_LARGEFILE we can't work with it.
> 
> .git is 3.5GB according to du -H :)

Ok, that's good.  That means that we really can use git without any major 
issues, and that it's literally apparently only receive-pack that has 
problems.

I didn't even realize that we have

	#define _FILE_OFFSET_BITS 64

in the header file, but not only is that a glibc-specific thing, it also 
won't really even cover all issues.

For example, if a file is opened from the shell (ie we're talking shell 
re-direction etc), that means that since the program that used 
_FILE_OFFSET_BITS wasn't the one opening, it was opened without 
O_LARGEFILE, and as such a write() will hit the LFS 31-bit limit.

That said, I'm not quite seeing why the _FILE_OFFSET_BITS trick doesn't 
help. We don't have any shell redirection in that path.

I just did an "strace -f" on a git clone on x86, and all the git open's 
seemed to use O_LARGEFILE, but that's with a very recent git.

I think you said that you had git-1.4.1 on the client, and I think that 
the _FILE_OFFSET_BITS=64 hack went in after that, and if your client just 
upgrades to the current 1.5.x release, it will all "just work" for you.

> Just curious why won't you use something like 
> PostgreSQL for data storage at this point, but, then
> I know nothing about git internals :)

I can pretty much guarantee that if we used a "real" database, we'd have

 - really really horrendously bad performance
 - total inability to actually recover from errors.

Other SCM projects have used databases, and it *always* boils down that. 
Most either die off, or decide to just do their own homegrown database (eg 
switching to FSFS for SVN).

Even database people seem to have figured it out lately: relational 
databases are starting to lose ground to specialized ones. These days you 
can google for something like

	relational specialized database performance

and you'll see real papers that are actually finally being taken seriously 
about how specialized databases often have performance-advantages of 
orders of magnitude. There's a paper (the above will find it, but if you 
add "one size fits all" you'll probably find it even better) that talks 
about benchmarking specialized databases against RDBMS, and they are 
*literally* talking about three and four *orders*of*magnitude* speedups 
(ie not factors of 2 or three, but factors of _seven_hundred_).

In other words, the whole relational database hype is so seventies and 
eighties. People have since figured out that yeah, they are convenient to 
program in if you want to do Visual Basic kind of things, but they really 
are *not* a replacement for good data structures.

So git has ended up writing its own data structures, but git is a lot 
better for it.

		Linus
