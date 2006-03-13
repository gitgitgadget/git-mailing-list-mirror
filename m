From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 21:22:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603122103440.3618@g5.osdl.org>
References: <20060311192954.GQ16135@artsapartment.org>
 <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org>
 <slrne18of5.fr9.mdw@metalzone.distorted.org.uk> <4414747B.7040700@gmail.com>
 <4414E000.9030902@zytor.com> <4414F6B1.9080107@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Mark Wooding <mdw@distorted.org.uk>
X-From: git-owner@vger.kernel.org Mon Mar 13 06:22:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIfVk-0005aA-LG
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 06:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWCMFWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 00:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWCMFWZ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 00:22:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751463AbWCMFWY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 00:22:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2D5MHDZ014110
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 21:22:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2D5MGkb027450;
	Sun, 12 Mar 2006 21:22:16 -0800
To: git@vger.kernel.org
In-Reply-To: <4414F6B1.9080107@gmail.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17550>



On Sun, 12 Mar 2006, A Large Angry SCM wrote:
> 
> 3.2.2.3 Pointers
> 	A pointer to *void* may be converted to or from a pointer to any
> incomplete or object type. A pointer to any incomplete or object type may be
> converted to a pointer to *void* and back again; the result shall compare
> equal to the original pointer.

Large, you're missing the point.

"void *" is guaranteed to be a _superset_ of all pointers.

But that dos not mean that any "void *" pointer can be cast to any other 
pointer. BUT IF IT STARTED OUT AS A POINTER OF THAT TYPE, IT'S GUARANTEED 
THAT IT CAN BE CAST _BACK_ TO THAT TYPE.

(And furthermore, NULL is special in that it will always compare equal 
regardless of how it has ever been cast).

This means, for example, that it's perfectly legal for a C implementation 
to have a 128-bit "void *", where the low bits are the "real pointer" and 
the high 64 bits are the "type descriptor". You could only cast such a 
pointer to that proper type, but you could not cast it to any other type 
(except for the special case of NULL).

My argument boils down to the fact that we don't care one whit about those 
theoretical architectures. It so happens that ia64 function pointers are 
sometimes described this way (due to totally broken reasons - don't ask), 
and that function pointers could indeed be seen as 128-bit quantities. But 
that is such a horribly broken thing, that what compilers on ia64 actually 
do is to instead of having a 128-bit "void *" (which would be legal per 
the standard), they make function pointers actually point to the function 
description (128-bit datum) rather than the actual start of the function.

(I think. I forget the exact details. I think the whole architecture is a 
total mess, and should never have been done in the firstplace).

Similarly, there are certain tagged architectures where the pointer 
actually contains the type it points to, and again, C _allows_ that, and 
if you want to be strictly conforming, you can't do certain things that 
seem obviously correct.

HOWEVER. The undeniable fact is that no sane architecture that anybody 
cares about today (and that, in turn, implies that nobody will care about 
it in the next quarter century - these things have a tendency to 
re-inforce themselves) actually does that. 

Another example is two's complement. C as a language actually allows other 
type representations than two's complement for integers, and there's lots 
of verbiage in the standard about how overflow is undefined etc. Then they 
go to pains to explain how "unsigned" integers are guaranteed to behave as 
if the machine was a regular binary machine, even though the language 
lawyers in general went to great pain to make it clear that if the integer 
representation is binary-packed-decimal, it's still legal from a C 
stanpoint.

But again, nobody sane would ever care. The likelihood that we'll see a 
ternary machine in the next few decades is pretty damn small, because 
while the C standard allows for something else, it would be painful in the 
extreme for anybody to actually convert all the programs that effectively 
depend on 8-bit bytes etc.

So again, in _theory_ the C standard works for some really odd crap out 
there. In practice, there are only certain pretty standard setups (ILP32, 
I32LP64, IL32P64), and some old ones (I16LP32) that nobody cares about, 
and then the really odd ones (36-bit word-addressable monsters where char, 
short, int, long and pointer are all the same size) that have a C 
compiler, but that you will never be able to port _any_ normal program 
to..

In other words, the C standard allows some really strange stuff. Trying to 
even worry about it is just not worth it. It often makes the code just 
much harder to read for absolutely zero gain.

So in practice, the strangest setup you'll ever really care about is 
actually Windows. And it's strange because it can have a totally broken 
size model (IL32LLP64 - although I think that's usually just a compiler 
switch), and because it has such strange system libraries and filesystem 
behaviour (which is sadly more than just a compiler switch).

Even windows (or, perhaps, Windows _in_particular_) will never have things 
like a "char" that isn't 8 bits, etc that could be possible in theory if 
you were to just read the C standard.

		Linus
