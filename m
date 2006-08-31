From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Trace into open fd and refactor tracing code.
Date: Thu, 31 Aug 2006 14:31:22 -0700
Message-ID: <7vsljc8udx.fsf@assigned-by-dhcp.cox.net>
References: <20060831084211.28d38764.chriscool@tuxfamily.org>
	<Pine.LNX.4.64.0608311409470.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 23:30:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIu7C-0000jA-4E
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 23:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWHaVaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 17:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWHaVaS
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 17:30:18 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38378 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751182AbWHaVaR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 17:30:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060831213016.FBMQ6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Thu, 31 Aug 2006 17:30:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GlWH1V0011kojtg0000000
	Thu, 31 Aug 2006 17:30:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608311409470.27779@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 31 Aug 2006 14:14:26 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26275>

Linus Torvalds <torvalds@osdl.org> writes:

> That way, if you want to do the fd thing, you can always just do
>
> 	GIT_TRACE=/proc/self/fd/9 make test 9>/var/tmp/trace.log
>
> although I really don't know how well that works across a fork/exec that 
> may or may not be closing the file descriptor (I think it's much simpler 
> and more obvious to just give the filename directly).

Actually it was me who suggested the use of fd directly, along
with trying to do one message in a single write (i.e. not doing
stdio as much as possible).

Process A has fd=9 opened to /var/tmp/trace.log and forks
process B.

(1) process B execs something else, and just writes into fd=9

or

(2) process B execs something else, perhaps after closing fd=9,
    and the exec'ed image opens /var/tmp/trace.log with
    "O_APPEND|O_CREAT" and gets a fd; it writes into this fd.

I somehow felt there would be less interference between writes
issued by process A and process B, but probably I am mistaken.
