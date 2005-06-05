From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pull: gracefully recover from delta retrieval failure.
Date: Sun, 05 Jun 2005 10:46:24 -0700
Message-ID: <7vekbg3de7.fsf@assigned-by-dhcp.cox.net>
References: <7v4qcde3j9.fsf@assigned-by-dhcp.cox.net>
	<1117989532.10424.7.camel@port.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 19:44:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dez9Z-0003jy-5W
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 19:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFERql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 13:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVFERql
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 13:46:41 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25586 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261594AbVFERqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 13:46:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605174626.SVJH7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 13:46:26 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <1117989532.10424.7.camel@port.evillabs.net> (Jason McMullan's
 message of "Sun, 05 Jun 2005 12:38:52 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JM" == Jason McMullan <jason.mcmullan@timesys.com> writes:

JM> Sorry about being a pest, but this worries me. Please assuage my fears.

Earlier I said I suspected that the original code mishandled
recovery from a botched tree/commit dependent transfer, but that
was not the case.  The last test in the new test script I added
in the patch you are responding to covers that case.

JM> (Or, if you'd like, I can rework pull.c to use the
JM>  verification-before-store technique I used in my git-daemon patch, so
JM>  all the *-pull mechanisms will be 'safe')

I would appreciate the offer.  I, however, would have to warn
you that the "problem" lies in the way the current pull
structure devides responsibility between the pull.c and transfer
backends.  The pull.c implements the dependency logic, and
transfer backends are to populate the database while being
oblivious of that logic.  From the purist point of view (I am
sympathetic to your "place only the verified objects in the
database" principle), I am not entirely happy with that
division, but at the same time I understand why it is done that
way and even like it from practical standpoint.  Otherwise you
need to keep a bunch of objects somewhere outside the database
along with the list of "things to rename to the final database
name when we are done".  You would somehow need to do clean-up
when we fail in the middle _anyway_.

In other words, the current structure is optimized for non-
failure case, as it should be.  The original implementation
(credit goes to Dan Barkalow) knew how to recover from failed
transfer (including the case that you first pull with -c or -t
without using -a to miss some required objects to satisfy -a) by
simply running pull again, and with the --recover flag, it now
knows how to recover from failed deltified object transfer as
well.

