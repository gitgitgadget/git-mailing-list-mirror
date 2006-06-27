From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Mon, 26 Jun 2006 23:29:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606262321270.3927@g5.osdl.org>
References: <7v7j35wp84.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606251033030.3747@g5.osdl.org> <7vpsgvf8jf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 27 08:29:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv755-0008Iz-5q
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 08:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWF0G3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 02:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWF0G3o
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 02:29:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932107AbWF0G3n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 02:29:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5R6TbnW004544
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Jun 2006 23:29:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5R6TaNe017507;
	Mon, 26 Jun 2006 23:29:37 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsgvf8jf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22707>



On Mon, 26 Jun 2006, Junio C Hamano wrote:
> 
> As long as none of the following does not dereference the NULL
> pointer that should work fine:
> 
> 	- memchr(NULL, ch, 0);
> 
>         - memcmp(NULL, ptr, 0);
> 
>         - stream.next_in = NULL;
>           stream.avail_in = 0;
>           deflate(&stream, Z_FINISH);

Well, they clearly _shouldn't_, but bugs happen in libraries too.

(The reason they shouldn't is simple: replace the NULL pointer with a 
perfectly normal pointer at the end of a page, and if you access past the 
length of the memory area, you'd get the same SIGSEGV that a NULL pointer 
should give you).

So the question is how much to trust the libraries for a special case that 
has a clearly "Right Answer", but is probably unusual in practice.

(That said, "malloc(0)" can validly return NULL, so the NULL+<zero length> 
thing can really happen in real code even if it's not explicit).

If people want to be anally defensive, we should give it a valid pointer. 
If there are known buggy libraries, I wouldn't object to something 
explicit like

	#define DUMMYPTR ((void *)"")

and hide it that way - the code may be the exact same thing that I 
objected to, but now you're showing that you know that the cast is crud, 
and you're just wanting to pass in some non-NULL valid pointer that can be 
dereferenced but never written to.

Personally, I think NULL is much better, until somebody shows an actual 
buggy library.

			Linus
