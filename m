From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree rename detection bug
Date: Thu, 15 Sep 2005 01:17:16 -0700
Message-ID: <7vll1y9243.fsf@assigned-by-dhcp.cox.net>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
	<7vwtljjzc3.fsf@assigned-by-dhcp.cox.net>
	<59a6e583050914114054b1564d@mail.gmail.com>
	<Pine.LNX.4.58.0509141321180.26803@g5.osdl.org>
	<17192.56103.803096.526568@cargo.ozlabs.ibm.com>
	<17192.56292.867933.739867@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0509142032300.26803@g5.osdl.org>
	<17192.65054.520959.454610@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Wayne Scott <wsc9tt@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 10:18:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFovu-00066F-W4
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 10:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVIOIRU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 04:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVIOIRU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 04:17:20 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20352 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750953AbVIOIRS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 04:17:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915081716.GUXA6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 04:17:16 -0400
To: Paul Mackerras <paulus@samba.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8596>

Paul Mackerras <paulus@samba.org> writes:

> The strlen() in glibc for ppc is unbearably clever hand-coded
> assembly, which loads up 8 bytes at a time (once it has the address
> 8-byte aligned), and does various ANDs and ORs and ADDs and
> conditional branches.  If some of the 8 bytes aren't defined, it will
> in many cases branch one way or the other based on the undefined
> bytes, but end up computing the same result on either branch.

This reminds me of what I did in my previous life, writing a
memory allocation checker -- this was before Valgrind -- and
found out that strcpy in the C library that came with Solaris
had a similar clever trick.  What was interesting was that
copying a string starting at the (PAGESIZE-3)th byte on a page
and NUL terminated at the end of the same page ended up
prefetching the first word from the next page (please do not ask
me about the details -- I do not remember the disassembly of
that part of the code anymore).  It was not an inconvenience for
our memory checker but was a real bug -- the next page could
very well be unaccessible.

The bug was fixed in the next version of the C library when we
updated our Solaris box.
