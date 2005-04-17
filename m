From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [patch] git: fix 1-byte overflow in show-files.c
Date: Mon, 18 Apr 2005 01:59:20 +0200
Message-ID: <20050417235920.GY1461@pasky.ji.cz>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu> <20050414121819.GA14380@elte.hu> <20050414125354.GB15420@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 01:55:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJbv-0007kB-J0
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVDQX7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVDQX7X
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:59:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20378 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261572AbVDQX7V (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 19:59:21 -0400
Received: (qmail 30953 invoked by uid 2001); 17 Apr 2005 23:59:20 -0000
To: Ingo Molnar <mingo@elte.hu>
Content-Disposition: inline
In-Reply-To: <20050414125354.GB15420@elte.hu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 14, 2005 at 02:53:54PM CEST, I got a letter
where Ingo Molnar <mingo@elte.hu> told me that...
> 
> this patch fixes a 1-byte overflow in show-files.c (looks narrow is is 
> probably not exploitable). A specially crafted db object (tree) might 
> trigger this overflow.
> 
> 'fullname' is an array of 4096+1 bytes, and we do readdir(), which 
> produces entries that have strings with a length of 0-255 bytes. With a 
> long enough 'base', it's possible to construct a tree with a name in it 
> that has directory whose name ends precisely at offset 4095. At that 
> point this code:
> 
>                         case DT_DIR:
>                                 memcpy(fullname + baselen + len, "/", 2);
> 
> will attempt to append a "/" string to the directory name - resulting in 
> a 1-byte overflow (a zero byte is written to offset 4097, which is 
> outside the array).

The name ends precisely at offset 4095 with its NUL character:

     {PATH_MAX}
     Maximum number of bytes in a pathname, including the terminating
null character.
[ http://www.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html ]

So, if I'm not mistaken, '/' will be written at offset 4095 instead of
the NUL and the NUL will be written at 4096. Everything's fine, right?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
