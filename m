From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Mon, 13 Mar 2006 08:26:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603130759320.3618@g5.osdl.org>
References: <200603130414.k2D4EXcX011651@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 17:31:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIpt4-000284-J1
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 17:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWCMQ1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 11:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWCMQ1M
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 11:27:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932180AbWCMQ1L (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 11:27:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2DGQuDZ010068
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Mar 2006 08:26:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2DGQuGq012767;
	Mon, 13 Mar 2006 08:26:56 -0800
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200603130414.k2D4EXcX011651@laptop11.inf.utfsm.cl>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17570>



On Mon, 13 Mar 2006, Horst von Brand wrote:
>> 
> > This breaks down with variadic functions, which have no typing
> > information. So doing this:
> >   execl("foo", "bar", my_struct_foo);
> > doesn't give the compiler a chance to do the implicit cast and you get
> > subtle breakage (in the same way that you would if you passed a long to
> > a variadic function expecting a short).
> 
> It just passes 3 "void *"'s, and casts back. What is so strange?

It doesn't actually pass 3 "void *".

Variadic functions pass their arguments as-is (apart from the normal 
integer promotion for small integer types: chars are passed as integers if 
"char" is smaller than "int").

So no actual casting takes place for the arguments, and

	execl("foo", "bar", my_struct_foo, NULL);

passes in four pointers: two of type "char *", one of whatever 
my_struct_foo is ("struct foo *") and finally hopefully one of "void *" 
(modulo broken compilers). They might - in theory - have different sizes 
and representations.

Now, the interesting effect of this is that simple things like

	printf("Pointer value %p\n", myfunction);

is actually NOT STRICTLY PORTABLE CODE! Why? Because "%p" wants a void 
pointer, but "myfunction" is of a different pointer type, which may 
actually have a different size and a different representation entirely, so 
you can get total garbage printed out.

So you have two choices:

 - be sane, and ignore insane architectures. In this case, the above is 
   perfectly fine C code.

 - be insane, and care about it. In this case, you really do have to add 
   the casts to be safe in theory.

The "%p" for printf() is actually a wonderful example of why you really 
really really should ignore language lawyers. According to language 
lawyers, you should add that "(void *)" cast. But look around for how many 
such casts you can find in real code, and realize that the language 
lawyers just don't matter. A C compiler environment that requires it is 
simply broken, and sane people will refuse to use it for anything than 
small embedded work, because it's simply not usable.

So while it's not true in theory, in _practice_ you should expect all 
pointers to be of the same size and use the same representation. Anything 
else is just too painful to be ever worth bothering with.

(Remember near and far pointers from 16-bit DOS/Windows? Those 
environments at least had _explicit_ pointer sizes, making the problem 
less horrible, but that was clearly a disaster nonetheless. Pointers that 
implicitly have different sizes because they point to different types are 
even _worse_).

			Linus

PS. Final words: while knowing that all pointer representations must be 
the same, and that NULL actually must be the bitwise binary "all zero" 
value (otherwise "memset(structptr, 0, structsize)" would break), it's 
equally important to know that the standard doesn't _guarantee_ it. Why? 

Because that way, when somebody tries to tell you that your code isn't 
standards conformant and might be unportable, you can say "yeah, I know, 
but only a total loser would ever care". Instead of incorrectly trying to 
argue that your code is "correct".
