From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] pull: gracefully recover from delta retrieval failure.
Date: Sun, 05 Jun 2005 12:38:52 -0400
Message-ID: <1117989532.10424.7.camel@port.evillabs.net>
References: <7v4qcde3j9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 18:36:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dey60-0004fi-Sx
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 18:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFEQi5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 12:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVFEQi5
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 12:38:57 -0400
Received: from c-67-163-246-116.hsd1.pa.comcast.net ([67.163.246.116]:38342
	"EHLO port.evillabs.net") by vger.kernel.org with ESMTP
	id S261594AbVFEQiz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 12:38:55 -0400
Received: by port.evillabs.net (Postfix, from userid 500)
	id AD65740C5A; Sun,  5 Jun 2005 12:38:52 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4qcde3j9.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.4-3mdk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-06-04 at 23:11 -0700, Junio C Hamano wrote:
> This addresses a concern raised by Jason McMullan in the mailing
> list discussion.  After retrieving and storing a potentially
> deltified object, pull logic tries to check and fulfil its delta
> dependency.  When the pull procedure is killed at this point,
> however, there was no easy way to recover by re-running pull,
> since next run would have found that we already have that
> deltified object and happily reported success, without really
> checking its delta dependency is satisfied.

I still think it would be much better if you didn't place unverified
objects in the database in the first place. You've taken care of delta
object recovery, yes, but what about unsatisfied tree objects? Or commit
objects? Does your algorithm require full depth scanning of the
entire repository that is descended from the commit head?

I much prefer to always leave the database in a consistent state, that
way you only have to do O(number-of-retrieved-objects) verifications,
not O(number-of-commit-tree-ancestors) verifications.

Or am I misunderstanding your technique here? 

Sorry about being a pest, but this worries me. Please assuage my fears.

(Or, if you'd like, I can rework pull.c to use the
 verification-before-store technique I used in my git-daemon patch, so
 all the *-pull mechanisms will be 'safe')

