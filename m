From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git network protocol
Date: Sun, 13 Aug 2006 23:42:33 -0700
Message-ID: <7vk65bg6na.fsf@assigned-by-dhcp.cox.net>
References: <20060814062117.GC10476@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 08:42:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCW9n-0006lD-IE
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 08:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWHNGmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 02:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWHNGmg
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 02:42:36 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:31707 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751269AbWHNGmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 02:42:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814064234.XVYA6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 02:42:34 -0400
To: jeffpc@josefsipek.net (Josef "Jeff" Sipek)
In-Reply-To: <20060814062117.GC10476@josefsipek.net> (Josef Sipek's message of
	"Mon, 14 Aug 2006 02:21:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25325>

jeffpc@josefsipek.net (Josef "Jeff" Sipek) writes:

> I'm trying to implement the git protocol, and I am having a bit of an issue
> with the lack of information available about it (please correct me if I
> missed some source of information.)

Documentation/technical/pack-protocol.txt, and "git show 1bd8c8f0".

> So, I can _assume_ that "done" tells the server that it is time to make a
> pack. Why does the server use NAK during the clone operation, but ACK
> during fetch? Why does the server ACK the same SHA1 twice? And why does the
> client "want" the same SHA1 twice? It just seems odd.

During the initial "SHA-1 name"/"want" exchange, the server and
the client negotiate the protocol extension (the document needs
to be updated at least for "multi-ack" extension).

After that, the client and the server try to determine what
commits the client has that are recent ancestors of "want"
commits.  This exchange is done by client sending bunch of
"have" to the server.  The server responds "ACK" (in the
original protocol) to say "I've seen enough and know a common
ancestor to use".  In multi-ack protocol (which is used in
modern git, v0.99.9 and later), the server can respond "ACK
continue" to say "I've seen enough on that branch so do not
bother sending 'have's for its ancestors, but do keep sending
from other branch."  If the server does not feel it saw enough,
it does not send either.

The client can send "flush" -- this asks the server to give NAK
if more "have"s need to be sent.  If there is no more "have"s to
be sent, "done" is sent.

The protocol streams; if you see an ACK from server it does not
usually mean it is ACKing the last 'have' client has sent.
