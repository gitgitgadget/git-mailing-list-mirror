From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 14:46:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home> <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home> <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home> <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home> <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergey Vlasov <vsu@altlinux.ru>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 23:47:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZwlP-0002mU-Lv
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 23:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWJQVqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 17:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWJQVqQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 17:46:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750898AbWJQVqP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 17:46:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9HLk5aX003084
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 14:46:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9HLk4xQ006915;
	Tue, 17 Oct 2006 14:46:04 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610171706260.1971@xanadu.home>
X-Spam-Status: No, hits=-0.474 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29118>



On Tue, 17 Oct 2006, Nicolas Pitre wrote:
> 
> Because offsets into packs are expressed as unsigned long everywhere 
> else (except in the current pack index on-disk format).

Until your work, that "unsigned long" was totally just an internal thing 
that didn't actually bleed into anything else.

> > For some structure like this, it sounds positively wrong. Pack-files 
> > should be architecture-neutral, which means that they shouldn't depend on 
> > word-size, and they should be in some neutral byte-order.
> 
> But they do.  Please consider this code:

Right. The pack-file itself. But the code that actually _generates_ it 
mixes things in alarming ways.

> > In contrast, the new union introduced in "next" is just horrid. There's 
> > not even any way to know which member to use, except apparently that it 
> > expects that a SHA1 is never zero in the last 12 bytes. Which is probably 
> > true, but still - that's some ugly stuff.
> 
> This union should be looked at just like a sortable hash pointing to a 
> base object so that deltas with the same base object can be sorted 
> together.

.. and it sorts _differently_ on a big-endian vs little-endian thing, 
doesn't it?

So now the sort order depends on endianness and/or wordsize. That just 
sounds really really wrong.

			Linus
