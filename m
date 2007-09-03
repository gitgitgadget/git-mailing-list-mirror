From: Johan Herland <johan@herland.net>
Subject: Re: strbuf API
Date: Mon, 03 Sep 2007 07:43:44 +0200
Message-ID: <200709030743.44188.johan@herland.net>
References: <20070902224213.GB431@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 07:44:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS4jp-0006kV-TL
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 07:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbXICFoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 01:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbXICFoM
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 01:44:12 -0400
Received: from smtp.getmail.no ([84.208.20.33]:60102 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbXICFoL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 01:44:11 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JNS00D032LLQX00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 03 Sep 2007 07:44:09 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JNS00LTO2KW1800@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 03 Sep 2007 07:43:44 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JNS00JHI2KWU1K0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 03 Sep 2007 07:43:44 +0200 (CEST)
In-reply-to: <20070902224213.GB431@artemis.corp>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57429>

On Monday 03 September 2007, Pierre Habouzit wrote:
> 
>   I read the recent thread Timo Sirainen raised about string APIs in
> git. ANd I went read the strbuf.[hc] module.
> 
>   I believe that the choice made in that module are wrong and could be
> made better. I actually use to work with a string buffer API (that
> interested readers can look at on [0]), that work almost the same
> (except for the eof flag, but it's trivial to keep), but have
> two significant differences:
> 
>   First, and that's the most important one: the buffer is always NUL
> terminated, after its official "len". That means, in terms of strbuf
> API, that "alloc" is always greater or equal to len+1 to be able to
> store the ending NUL[1]. The advantages are obvious: you can pass the
> buffer to any legacy C string function without any fear of read
> overflow.  strtol comes to mind, and atm, git has to explicitely use
> strbuf_end to put that ending nul to be able to call legacy
> applications. But once done, the NUL is accounted into the string (aka
> it's in "len") which makes it a non C-string (I mean you cannot append
> any more data in it anymore). So current implementations tries to
> workaround an issue (the non systematical NUL-termination) but IMHO the
> wrong way.
> 
>   The other shortcoming is that you cannot tell the buffer "Hey, it's
> very likely that you'll end up being _that_ long. That's why, in some
> parts of the code (see write_tar_entry in archive-tar.c e.g.) the
> programmer actually messes with the buffer allocation, outside from the
> strbuf module, which makes it well, useless. In my API, I have a
> "buffer_ensure" call, that is supposed to do that: "please ensure that
> this buffer still has _this_ amount of free and allocated space to put
> more data".
> 
> 
>   So my question is, do people think I raise a valid point

Yes.

>   , and would 
> patches that would refactor the strbuf module to have those functions,
> and would fix the code that uses strbuf's to interact properly, be
> accepted ?

I don't know. Keep in mind that there is a parallel process (cf. the 
continuation of the "Buffer overflows" thread) to evaluate the Bstring 
library ( http://bstring.sourceforge.net/ ), and possibly substitute that 
for the strbuf "module".

I wouldn't want the work done by you or others to be wasted (depending on 
which solution wins out in the end), so I suggest you take a look at 
bstring and offer up arguments why your solution would be better for git.

>   Also, the efficiency of the buffer module API I use has a lot to do
> with the fact that copying functions, and length tests are inlined in
> the .h, so that the compiler can optimize the ones it already tested 10
> calls before. I'm not sure if this is frowned upon or if it makes sense.
> 
> 
>   [0] http://git.madism.org/?p=pfixtools.git;a=blob;f=buffer.h;hb=HEAD
>       http://git.madism.org/?p=pfixtools.git;a=blob;f=buffer.c;hb=HEAD
> 
>   [1] Of course, ensuring the NUL-termination has a cost, though it's
>       often benign, and for performance-critical places where characters
>       are copied one by one, it's always possible to use an "unsafe"
>       addch (that would not maintain the invariant), and then call an
>       equivalent of strbuf_end (that would not append a \0 like it does
>       now, but just would fix the invariant that for any strbuf,
>       buf->buf[buf->len] == '\0') explicitely. For places where the
>       invariant generate negligible cost (like concatenating two paths
>       parts with a middle '/' e.g.) then we gain safety without even
>       having to think about it.

All the points you raise are valid, but please have in mind that all 
programmers write their own string library at some point. (Writing a string 
library is right up there with "discovering why 'goto' is bad" and "2nd 
system syndrome" on the top list of rites of passage all programmers (need 
to) go through. I'm guessing 99% of the people on this list have written 
their own string library. Why not 100%? Well, Linus have obviously not, 
else we'd be using his already... ;)

I'd like to know how your solution compare with the alternatives (in this 
case bstring): What's the performance compared to bstring? How much thought 
has been given to the usability of the API? What functionality is covered 
(compared to bstring)? In short: Why is your alternative the best for git?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
