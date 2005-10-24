From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: daemon.c broken on OpenBSD
Date: Mon, 24 Oct 2005 10:14:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510241002180.10477@g5.osdl.org>
References: <867jc336f4.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510240901020.10477@g5.osdl.org>
 <86irvmzyq9.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510240936450.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 19:17:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU5uP-0007gw-QP
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 19:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVJXROu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 13:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVJXROu
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 13:14:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8147 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751161AbVJXROu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 13:14:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9OHEmFC002845
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 24 Oct 2005 10:14:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9OHEktB032353;
	Mon, 24 Oct 2005 10:14:47 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <Pine.LNX.4.64.0510240936450.10477@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10549>



On Mon, 24 Oct 2005, Linus Torvalds wrote:
> 
> So yes, it's ugly, but it definitely is safe in practice, as long as the 
> local headers are included before the system ones.

Side note: "safe in practice" isn't necessarily the same as "safe in 
theory".

I think that strictly speaking, if you include <ctype.h>, the "isxxxx()" 
format is always reserved (where "x" is lowercase letters), and in theory 
you could have a compiler that recognizes them even before the 
pre-processor as being something built-in.

In _practice_, such a compiler would be incredibly broken (it would have 
to do the recognition after preprocessing too), and I doubt you'd ever see 
such a thing, but from a pure language-lawyer standpoint it might 
technically be possible.

However, I'm surprised that you see <ctype.h> at all. The OpenBSD headers 
seem to be including <ctype.h> from <sys/poll.h>, which doesn't make any 
sense. It may not be strictly against POSIX, but it's definitely strange 
and bad form to do unnecessary name pollution that the user didn't ask 
for.

So git actually tries to be pretty good about things. Not only does it try 
to handle any existing system <ctype.h> by doing the #undef, it actually 
doesn't include the system ctype.h at _all_ when it includes "cache.h". 
And OpenBSD is being a bit strange.

		Linus
