From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Sun, 25 Jun 2006 10:47:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606251033030.3747@g5.osdl.org>
References: <7v7j35wp84.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 19:47:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuYhc-00082g-PP
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 19:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWFYRrR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 13:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWFYRrR
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 13:47:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58761 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964876AbWFYRrQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 13:47:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5PHlBnW007624
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 25 Jun 2006 10:47:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5PHlACs004231;
	Sun, 25 Jun 2006 10:47:11 -0700
To: Junio C Hamano <junkio@cox.net>, Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <7v7j35wp84.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22641>



On Sun, 25 Jun 2006, Junio C Hamano wrote:
> 
>    Timo Hirvonen:
>       Clean up diff.c

THIS IS CRAP!

Dammit, anybody who claims that casting a constant string to "(char *)" is 
a _cleanup_ is doing something seriously wrong.

That's crap, crap, crap, CRAP!

If the "cleanup" was about hiding compiler warnings, then dammit, those 
warnings should be fixed by fixing the code, not by casting the warning 
away but leaving the broken code.

If the ptr really is never accessed, and doesn't matter, then don't use a 
constant empty string, use NULL.

And if it _is_ accessed, then casting a constant string to "char *" is 
_wrong_. 

The whole and only point about the "const" warnings is not to hide them, 
but to fix the code. If you're not going to fix the code, then you 
shouldn't ask the compiler to warn about it, it's that simple. Adding 
bogus casts is not the answer.

I really hate how many _bogus_ casts we're growing. Casts are one of the 
most important features of C (it's what allows you to break the type 
system if you need to, and turns C into the truly extensible language it 
is), but they should be used with reverence and care, not to shut up a 
compiler.

I'm _especially_ disgusted by how this was claimed to be a "cleanup". 
Adding a cast is _never_ a cleanup.

Dammit, don't do crap like this!

THIS is a cleanup:

-               char *prefix = "";
+               const char *prefix = "";

but THESE are total and utter CRAP:

-               mf->ptr = ""; /* does not matter */
+               mf->ptr = (char *)""; /* does not matter */
-                               s->data = "";
+                               s->data = (char *)"";

and we're better off with the warning than with the new code.

I suspect that both could have been made to use NULL instead to indicate 
that no pointer exists.

			Linus
