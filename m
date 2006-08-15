From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git network protocol
Date: Mon, 14 Aug 2006 17:59:37 -0700
Message-ID: <7vwt9aak5i.fsf@assigned-by-dhcp.cox.net>
References: <20060814062117.GC10476@josefsipek.net>
	<7vk65bg6na.fsf@assigned-by-dhcp.cox.net>
	<20060814234826.GA21861@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 02:59:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCnHS-0006DR-5D
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 02:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWHOA7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 20:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWHOA7j
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 20:59:39 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:9129 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965067AbWHOA7i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 20:59:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815005938.MPXN27846.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 20:59:38 -0400
To: jeffpc@josefsipek.net (Josef "Jeff" Sipek)
In-Reply-To: <20060814234826.GA21861@josefsipek.net> (Josef Sipek's message of
	"Mon, 14 Aug 2006 19:48:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25432>

jeffpc@josefsipek.net (Josef "Jeff" Sipek) writes:

> So, if I understand this correctly, multi_ack allows for multiple branches
> to be fetched using the same connection?

The original protocol without extension already allowed it.
Suppose the global history was like this:

       o-----------------------o---o---o---o---o---o---o---c---c---c
      /
 o---o---o---o---o---o---o---o---s---s---s

where the server side had 's', the client side had 'c', and both
of them had 'o'.  The objective is to update client with three 's'
commits.

The exchange would go like this without multi-ack:

	S: SHA-1 name1 -- for the rightmost 'o' on the top branch
        S: SHA-2 name2 -- for the rightmost 's' on the bottom branch
	C: want SHA-2 -- ask for the second branch tip
	C: have SHA1 -- the rightmost 'c' on the top branch
	C: have SHA1 -- the parent of the above
	C: have SHA1 -- the parent of the above
        C: have SHA1 -- the parent of the above, rightmost 'o' on the top.
        C: ... more have from the top branch.
	S: ACK -- for the rightmost 'o' on the top branch

During this exchange, the server learns that the client and the
server shares the rightmost 'o' on the top branch, but does not
learn about all the 'o' commits on the bottom branch, so it ends
up sending everything from the fork point to complete three 's'
commits.

The multi-ack extension was invented by Johannes to improve this
exchange.  It changes the protocol to let the server ACK with
"ACK continue".  After that, the client is expected to stop
traversing the parents of ACK-continue'd commit -- so it has a
chance to send the rightmost 'o' on the bottom branch.  When the
server sees it, it again gives an ACK, and the client soon runs
out have's to send and says "done".  In this case, the server
would have the rightmost 'o' commits on both branches to work
out the minimum set of objects to complete three 's' commits
that are missing from the client.
