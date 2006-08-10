From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Thu, 10 Aug 2006 00:59:26 -0700
Message-ID: <7v1wrpxbq9.fsf@assigned-by-dhcp.cox.net>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
	<20060810033448.GH8776@1wt.eu>
	<7vu04lxjsv.fsf@assigned-by-dhcp.cox.net>
	<7vfyg5xi02.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608100945430.13885@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 09:59:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5S1-0007Uj-1K
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 09:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWHJH73 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 03:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbWHJH73
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 03:59:29 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:59610 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161089AbWHJH72 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 03:59:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810075927.JCMZ6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 03:59:27 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608100945430.13885@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 10 Aug 2006 09:47:27 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25164>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> While in this particular case, desc.alloc cannot be smaller than desc.size 
> (and therefore the condition in the if() is misleading), it might be 
> better to write "desc.alloc = desc.size + 1;" for others to understand...

We overallocate desc.alloc in apply_one_fragment for growth, so
that if() is needed, but after this part of the code we discard
the desc hence the increment is not needed ;-).

diff --git a/builtin-apply.c b/builtin-apply.c
index c159873..be2c715 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1700,10 +1700,8 @@ static int apply_data(struct patch *patc
 		return -1;
 
 	/* NUL terminate the result */
-	if (desc.alloc <= desc.size) {
+	if (desc.alloc <= desc.size)
 		desc.buffer = xrealloc(desc.buffer, desc.size + 1);
-		desc.alloc++;
-	}
 	desc.buffer[desc.size] = 0;
 
 	patch->result = desc.buffer;
