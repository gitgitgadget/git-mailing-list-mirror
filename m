From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: open(2) vs fopen(3)
Date: Thu, 14 Sep 2006 10:31:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609141023130.4388@g5.osdl.org>
References: <20060914091513.19826.qmail@web25812.mail.ukl.yahoo.com>
 <Pine.LNX.4.64.0609140835080.4388@g5.osdl.org> <7vr6ye4d64.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: moreau francis <francis_moreau2000@yahoo.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 19:32:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNv4u-00023n-Ep
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 19:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWINRbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 13:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWINRbe
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 13:31:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750747AbWINRbd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 13:31:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8EHVSnW024022
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Sep 2006 10:31:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8EHVRUT027170;
	Thu, 14 Sep 2006 10:31:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6ye4d64.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.511 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27019>



On Thu, 14 Sep 2006, Junio C Hamano wrote:
>
> Another issue related with this is that stdio implementations
> tend to have unintuitive interaction with signals, one fine
> example of it being the problem we fixed with commit fb7a653,
> where on Solaris fgets(3) did not restart the underlying read(2)
> upon SIGALRM.

Yeah. However, I think it's worth just posting the code in question to 
explain _why_ error handling with stdio sucks so badly, and why nobody 
does it..

Here's the snippet:

                if (!fgets(line, sizeof(line), stdin)) {
                        if (feof(stdin))
                                break;
                        if (!ferror(stdin))
                                die("fgets returned NULL, not EOF, not error!");
                        if (errno != EINTR)
                                die("fgets: %s", strerror(errno));
                        clearerr(stdin);

so with the <stdio.h> functions, you have to check FOUR DIFFERENT THINGS 
(1: return value, 2: feof() value, 3: ferror() value, and 4: errno) to get 
things right, and to add insult to injury, you then have to do an explicit 
clear.

In other words, the fundamental reason nobody bothers checking errors with 
stdio is that stdio just makes it a damn pain in the ass to do so - by 
having a million different thing you have to do (and ordering actually 
matters).

In contrast, the <unistd.h> interfaces are a paragon of clarity: you check 
just two things - the return value, and possibly "errno".

Now, <unistd.h> isn't perfect either, and in the kernel we have simplified 
things further, by getting rid of "errno", and just having the return 
value contain errno too. Making things not only trivially thread-safe, but 
also actually easier to code and understand, because you don't have 
anything to be confused about: the return value is always the only thing 
you need to look at in order to know what went wrong.

But unistd.h sure is a lot better than stdio in this area. Of course, 
stdio.h is just a lot easier to use when you don't actually care about the 
errors, which is also partly the _reason_ why caring about errors is so 
hard (the whole separate clearerr() and ferror() interfaces exist exactly 
_because_ people don't care about errors in many cases, and you're 
supposed to maybe have some way to test at the end whether an error 
happened or not).

So stdio.h is pretty much geared towards delayed error handling, which in 
practice ends up often meaning "no error handling at all".

			Linus
