From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 13:51:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home> <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home> <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home> <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergey Vlasov <vsu@altlinux.ru>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 22:51:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZvuS-0000fr-C0
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 22:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWJQUv3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 16:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWJQUv3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 16:51:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750704AbWJQUv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 16:51:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9HKp9aX032441
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 13:51:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9HKp8s7004745;
	Tue, 17 Oct 2006 13:51:09 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610171615340.1971@xanadu.home>
X-Spam-Status: No, hits=-0.475 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29114>



On Tue, 17 Oct 2006, Nicolas Pitre wrote:
> On Tue, 17 Oct 2006, Sergey Vlasov wrote:
> > 
> > Yes, on x86_64 this is 24 because of 8-byte alignment for longs:
> 
> Ah bummer.  Then this is most likely the cause.  And here's a simple 
> fix (Junio please confirm):

Why do you use "unsigned long" in the first place?

For some structure like this, it sounds positively wrong. Pack-files 
should be architecture-neutral, which means that they shouldn't depend on 
word-size, and they should be in some neutral byte-order.

Quite frankly, this all makes me go "Eww..". The original pack-file (well, 
v2) format was well-defined and had none of these issues. In contrast, the 
new code in 'next' is just _ugly_.

And the thing about "ugly" is that it also tends to mean "fragile" and 
"buggy" and "hard to extend later".

And maybe it's just me, but I consider unions to be bug-prone on their 
own. The "master" branch has exactly two unions: the "grep_expr" structure 
contains one (where the union member is clearly defined by the node type 
in that structure), and object.c has a "union any_object" that _literally_ 
exists as purely an allocation size issue (ie it is used _only_ to 
allocate the maximum size of any of the possible structures).

In contrast, the new union introduced in "next" is just horrid. There's 
not even any way to know which member to use, except apparently that it 
expects that a SHA1 is never zero in the last 12 bytes. Which is probably 
true, but still - that's some ugly stuff.

Is this something you want to bet a big project on?

			Linus
