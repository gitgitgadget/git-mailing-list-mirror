From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sat, 9 Jul 2005 22:02:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507092158290.17536@g5.osdl.org>
References: <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <12c511ca05070716526954edd@mail.gmail.com>
 <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org> <12c511ca050707170964a2cc92@mail.gmail.com>
 <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org> <20050709225818.A31045@flint.arm.linux.org.uk>
 <20050709232955.B31045@flint.arm.linux.org.uk> <7vpstrv8z6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Russell King <rmk@arm.linux.org.uk>,
	Tony Luck <tony.luck@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 07:03:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrTyQ-0004LF-TH
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 07:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVGJFDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 01:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVGJFDM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 01:03:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38366 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261843AbVGJFDK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 01:03:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6A52njA009681
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 9 Jul 2005 22:02:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6A52mXE032539;
	Sat, 9 Jul 2005 22:02:48 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpstrv8z6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 9 Jul 2005, Junio C Hamano wrote:
>
> >>>>> "RK" == Russell King <rmk@arm.linux.org.uk> writes:
> 
> >> $ mv .git/objects/pack/* .git/
> >> $ for i in .git/*.pack; do git-unpack-objects < $i; done
> >> Unpacking 55435 objects
> >> fatal: inflate returned -3

Ahh, damn. 

> >> so it seems that the pack is corrupt... or something.

No, I htink you're using cogito-0.12, and I fixed this one-liner that 
didn't make it into cogito:

	diff-tree 291ec0f2d2ce65e5ccb876b46d6468af49ddb82e (from 72347a233e6f3c176059a28f0817de6654ef29c7)
	Author: Linus Torvalds <torvalds@g5.osdl.org>
	Date:   Tue Jul 5 17:06:09 2005 -0700
	
	    Don't special-case a zero-sized compression.
	
	    zlib actually writes a header for that case, and while ignoring that
	    header will get us the right data, it will also end up messing up our
	    stream position.  So we actually want zlib to "uncompress" even an empty
	    object.
	
	diff --git a/unpack-objects.c b/unpack-objects.c
	--- a/unpack-objects.c
	+++ b/unpack-objects.c
	@@ -55,8 +55,6 @@ static void *get_data(unsigned long size
	        z_stream stream;
	        void *buf = xmalloc(size);
	
	-       if (!size)
	-               return buf;
	        memset(&stream, 0, sizeof(stream));
	
	        stream.next_out = buf;

(well, I guess it's a two-liner.).

What happens is that there's one zero-sized blob in the kernel archive 
history, and when we pack it, we pack it as a 8-byte "compressed" thing 
(hey, zlib has a header, that's normal), but when we unpack it, because we 
notice that the result is zero, we'd just skip the zlib header.

Which was wrong, because now the _next_ object will try to unpack at the 
wrong offset, and that explains why you get -3 ("bad data").

			Linus
