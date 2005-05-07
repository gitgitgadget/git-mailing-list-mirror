From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Broken adding of cache entries
Date: Sun, 8 May 2005 00:41:16 +0200
Message-ID: <20050507224116.GF9495@pasky.ji.cz>
References: <1115408460.32065.37.camel@localhost.localdomain> <20050506231447.GG32629@pasky.ji.cz> <1115421933.32065.111.camel@localhost.localdomain> <20050506233003.GJ32629@pasky.ji.cz> <1115423450.32065.138.camel@localhost.localdomain> <20050507001409.GP32629@pasky.ji.cz> <1115431767.32065.182.camel@localhost.localdomain> <20050507152849.GD9495@pasky.ji.cz> <7vhdhealjm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 00:34:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUXsd-000187-Ux
	for gcvg-git@gmane.org; Sun, 08 May 2005 00:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVEGWla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 18:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVEGWla
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 18:41:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58565 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262759AbVEGWlR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2005 18:41:17 -0400
Received: (qmail 14132 invoked by uid 2001); 7 May 2005 22:41:16 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhdhealjm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 07, 2005 at 09:22:21PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Kay Sievers noticed that you can have both path and path/file in
> the cache and write-tree happily creates a tree object from such
> a state.  Since a merge can result in such situation and the
> user should be able to see the situation by looking at the
> cache, rather than forbidding add_cache_entry() to create such
> conflicts, fix it by making write-tree refuse to write such an
> nonsensical tree.

I'd still prefer add_cache_entry() to just replace the original entry
(as it does otherwise). Only make it to care about which stage it is
working in, to make merges to work. IOW, I think you are solving this at
the wrong workflow point. It is too "late" to know at that point, and
(a huge) PITA for the higher levels to deal with it then - that all when
it shouldn't fail _at all_ in the first place.

What about

--- b7ae63ab415e556c2f0f0ad2803f701b4a6d6956/read-cache.c  (mode:100644)
+++ uncommitted/read-cache.c  (mode:100644)
@@ -68,9 +68,9 @@
                return -1;
        if (len1 > len2)
                return 1;
-       if (flags1 < flags2)
+       if (flags1 & CE_STAGEMASK < flags2 & CE_STAGEMASK)
                return -1;
-       if (flags1 > flags2)
+       if (flags1 & CE_STAGEMASK > flags2 & CE_STAGEMASK)
                return 1;
        return 0;
 }

then? (Completely untested and everything.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
