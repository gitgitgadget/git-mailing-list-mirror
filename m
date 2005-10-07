From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: First cut at git port to Cygwin
Date: Fri, 7 Oct 2005 08:34:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org>
References: <433B3B10.5050407@zytor.com>  <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
  <434299DB.7020805@zytor.com>  <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com>
  <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com> 
 <20051005155457.GA30303@trixie.casa.cgf.cx>  <20051005191741.GA25493@steel.home>
  <20051005202947.GA6184@trixie.casa.cgf.cx> 
 <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com> 
 <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
 <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Christopher Faylor <me@cgf.cx>,
	Junio C Hamano <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 17:42:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENuFD-0003an-V0
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 17:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbVJGPep (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 11:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbVJGPep
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 11:34:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030420AbVJGPeo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 11:34:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j97FYK4s018878
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 7 Oct 2005 08:34:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j97FYJ8l027538;
	Fri, 7 Oct 2005 08:34:20 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9803>



On Fri, 7 Oct 2005, Alex Riesen wrote:
>
> it suddenly get worse: now I'm stuck on git-pull.
> 
> git-merge-index (called at some point by git-pull) maps the index in, and starts
> git-merge-one-file for each (or the given) entry in the index.
> git-merge-one-file
> calls git-update-index, which wants to update the index. Which doesn't work,
> because it's locked by that piece of s$%^.

NOTE! git doesn't use mmap() because it _needs_ to use mmap(), but because 
it was simple to do that way, and it's a total idiosyncracy of mine that I 
often try to mmap the data. I often also tend to do my own allocators 
instead of using malloc() (see my "sparse" project in case you're 
interested in other idiosyncracies of mine - macros to do list traversal 
etc).

The fact is, "mmap()" isn't really any better than "read()": it has some 
advantages wrt memory management for the kernel, which is probably one big 
reason why I do it, but quite frankly, if you were to change every single 
mmap() to be a "map_file()" instead, and made it optional whether it used 
mmap() or "malloc + read()", I personally don't think it would be 
horrible.

And it might make things much simpler for portability. The "use mmap" 
approach is very much a unixism, particularly the way unix people do it 
(mmap followed by close, making the file descriptor "go away"). Sure, 
other OS's have mmap too, but I think on them it tends to be less commonly 
used.

			Linus
