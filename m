From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 16:20:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605171614250.10823@g5.osdl.org>
References: <8aa486160605161507w3a27152dq@mail.gmail.com>
 <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org> <8aa486160605161542u704ccf03w@mail.gmail.com>
 <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com>
 <8aa486160605170641p2ab8704o@mail.gmail.com> <e4f9eo$b60$1@sea.gmane.org>
 <1147893786.16654.5.camel@dv> <20060517153903.6b896fdd.seanlkml@sympatico.ca>
 <1147895816.30618.6.camel@dv> <Pine.LNX.4.64.0605171325200.10823@g5.osdl.org>
 <e4g1f4$anv$1@sea.gmane.org> <Pine.LNX.4.64.0605171342370.10823@g5.osdl.org>
 <7vd5ecb688.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 01:21:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgVJq-0008GE-CH
	for gcvg-git@gmane.org; Thu, 18 May 2006 01:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWEQXUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 19:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWEQXUd
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 19:20:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750700AbWEQXUc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 19:20:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HNKRtH015551
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 16:20:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HNKR6R032417;
	Wed, 17 May 2006 16:20:27 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5ecb688.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20250>



On Wed, 17 May 2006, Junio C Hamano wrote:
> 
> If you give a pattern that would match two files but one of them
> were hidden by .gitignore, this approach would not help you
> much.

Correct. On the other hand, what could you do?

I think that the common case for that is literally something like

	git add dirname/

or

	git add file*

and it turns out that there are object files under the directory, or that 
there's a file.c, file.h _and_ a already-compiled file.o file.

Under both of those circumstances (one pattern that matches multiple files 
but ignores others - or several different patterns where _some_ of the 
patterns are ignored), we actually do what I think is the only sane thing. 

Namely to just silently add everything that makes sense to add.

> Even if we wanted to say something like "if the user explicitly
> tells us to add etc/mtab~ by spelling it out, we should ignore
> *~ entry in .gitignore", the shell expansion bites us because it
> is done before we get to what the user give us.  We cannot
> distinguish that with the user typing etc/?tab* for example.

Right.

The only case that we cando anything at all about is really the case where 
we didn't add anything at all, and then we might reasonably ask "do you 
know what the heck you're doing".

That's kind of what my last patch did. It's a total special case, but it's 
the _only_ special case that I can see that is at all relevant (ie in all 
other cases it would just be annoying as _hell_ if we started talking 
about how we're ignoring object files. Of _course_ we're ignoring them, 
and that's why they are listed in .gitignore).

So I'd love to have the built-in "git add", but quite frankly, if you drop 
that last patch as "too ugly to live", I certainly won't complain. I sent 
it out more as a "we -could- do this" thing rather than anything more 
serious.

			Linus
