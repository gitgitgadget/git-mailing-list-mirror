From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix up some fallout from "setup_git_directory()" cleanups
Date: Mon, 31 Jul 2006 15:21:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607311508060.4168@g5.osdl.org>
References: <Pine.LNX.4.64.0607311311060.4168@g5.osdl.org>
 <7v7j1t5tgj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 00:21:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7g8P-0006zw-Th
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 00:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWGaWVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 18:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWGaWVK
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 18:21:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751383AbWGaWVJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 18:21:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6VML4nW011780
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Jul 2006 15:21:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6VML4gr024005;
	Mon, 31 Jul 2006 15:21:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j1t5tgj.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.49 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24551>



On Mon, 31 Jul 2006, Junio C Hamano wrote:
> 
> This would have been prevented if the rest of the sources were -Wshadow
> clean.

Well, the _real_ problem is that "-Wshadow" is such a crappy switch.

For example, there is absolutely no reason to warn about every local 
variable called "link", just because it shadows the unistd.h "link()" 
function.

So I tend to think that -Wshadow is actively wrong, because it makes 
people write crappier code by forcing them to avoid not just the (few) C 
keywords as variable names, but also the _millions_ of names exported by 
various standard header files.

Which is sad. "-Wshadow" _would_ be useful, if it had been designed right. 
But that definitely implies _not_ warning about name clashes that are also 
obvious type clashes.

For example, there's basically absolutely zero reason to warn about 
something clashing with a function. If you are crazy and use nested 
functions in gcc, it's still obvious _which_ function you'd ever mean. So 
"-Wshadow" simply should _never_ warn about clashing with the external 
"link()" declaration, and certainly not for a regular "int link" kind of 
automatic variable definition.

There's also seldom (if ever) any reason to warn about a pointer variable 
being shadowed by an integer one. If you use the wrong one, you'll get a 
type warning, so why would you really care? 

> I once tried to clean things up, but there are tons of
> warnings in the current code [*1*].

And, looking at your patch, they all (or a huge majority of them) seem to 
be totally bogus (ie the code is fine, the -Wshadow warning is crap).

> Another thing that would help us is to have more tests that run
> things from subdirectories.  Any takers?

This, btw, didn't just hit "git ls-files" when run in a subdirectory, it 
hit pretty much any use of "git ls-files" with a path specifier that 
included a directory. I don't think we have many uses of that, and at 
least one of the few tests for path specifiers (t3002) only tests in the 
current directory, no paths.

			Linus
