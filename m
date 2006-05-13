From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git diff: support "-U" and "--unified" options properly
Date: Sat, 13 May 2006 15:39:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605131518390.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
 <7vzmhlsksm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605131404391.3866@g5.osdl.org>
 <7vpsihsjq6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 00:39:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff2lt-0002tt-KT
	for gcvg-git@gmane.org; Sun, 14 May 2006 00:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWEMWje (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 18:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWEMWje
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 18:39:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964784AbWEMWje (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 May 2006 18:39:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4DMdTtH017685
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 May 2006 15:39:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4DMdTH8023037;
	Sat, 13 May 2006 15:39:29 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsihsjq6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19951>



On Sat, 13 May 2006, Junio C Hamano wrote:
> 
>  * built-in grep (jc/grep)
> 
>    Ready.

I'm not entirely convinced.

For the kernel, I currently can do a 

	git grep some-random-string

in about half a second.

The new built-in grep is about ten times slower.

Before:

   [torvalds@g5 linux]$ /usr/bin/time git grep some-random-string
   Command exited with non-zero status 123
   0.29user 0.30system 0:00.52elapsed 113%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (0major+3206minor)pagefaults 0swaps

After:

   [torvalds@g5 linux]$ /usr/bin/time git grep some-random-string
   Command exited with non-zero status 1
   4.60user 0.33system 0:04.98elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
   0inputs+0outputs (0major+7369minor)pagefaults 0swaps

and that "half a second" vs "five seconds" difference is really 
noticeable.

Right now I do "git grep" as a random "ok, where was it", and it works 
very well, because it's basically instantaneous. And the difference 
between "instantaneous" and "5 seconds" is very big (the five seconds is 
also long enough that the CPU fan comes on on my G5, which is my sign of 
"too much work for the CPU".

I haven't looked at _why_ the builtin grep is ten times slower. I suspect 
it's just the regexp library being a lot slower than the external 
optimized grep, but it may also be just overhead (it looks, for example, 
like the builtin grep does all matches just one line at a time. And it 
actually reads the file in, when mmap might be more efficient, I dunno). 

Regardless, it's a huge downer.

		Linus
