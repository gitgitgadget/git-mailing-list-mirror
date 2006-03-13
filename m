From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix up diffcore-rename scoring
Date: Sun, 12 Mar 2006 22:44:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603122241100.3618@g5.osdl.org>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Mar 13 07:44:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIgnQ-0007uL-7X
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 07:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWCMGop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 01:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWCMGop
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 01:44:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59594 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751765AbWCMGop (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 01:44:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2D6ifDZ017031
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 22:44:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2D6ie2V030120;
	Sun, 12 Mar 2006 22:44:41 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17555>



On Sun, 12 Mar 2006, Linus Torvalds wrote:
> 
> The "score" calculation for diffcore-rename was totally broken.
> 
> It scaled "score" as
> 
> 	score = src_copied * MAX_SCORE / dst->size;
> 
> which means that you got a 100% similarity score even if src and dest were 
> different, if just every byte of dst was copied from src, even if source 
> was much larger than dst (eg we had copied 85% of the bytes, but _deleted_ 
> the remaining 15%).
> 
> That's clearly bogus. We should do the score calculation relative not to 
> the destination size, but to the max size of the two.
> 
> This seems to fix it.

Btw, interestingly, this seems to actually improve on the rename 
detection from your previous one, even though at the face of it, it 
should just have made the scores go down.

I'm not quite sure why, but perhaps it gave a bogus high score to some 
rename that wasn't very good, allowing the _real_ rename to make itself 
seen.

Or maybe I did some mistake in testing it.

		Linus

PS. You can still get a "similarity score" of 100 with the fixed scaling 
even if the source and the destination were different. That happens if 
every byte was marked as "copied" by the similarity estimator. Which can 
happen if you just move things around in the file - the end result is 
different, but all the bytes are copied from the source.

At least with the fixed heuristic, that "perfect similarity" score can be 
_somehow_ be explained. The files are very similar in that they have the 
same content, just in a different order ;)
