From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Fri, 02 Feb 2007 19:04:21 -0800
Message-ID: <7v4pq4djre.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
	<200702021308.48599.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 04:04:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDBCU-0006uS-Pv
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 04:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946300AbXBCDEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 22:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946301AbXBCDEX
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 22:04:23 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:64195 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946300AbXBCDEW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 22:04:22 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203030421.HCZW1302.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Feb 2007 22:04:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jr4M1W00B1kojtg0000000; Fri, 02 Feb 2007 22:04:21 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38548>

Andy Parkins <andyparkins@gmail.com> writes:

> Please, please, HEAD@{} should /always/ be an alias for <current_branch>@{}.

I was confused, and after thinking about it a bit, I agree with
Nico's new @{} shorthand.

HEAD means "current" everywhere in git, but it does not
necessarily mean "current branch" (i.e. detached HEAD).  

But it almost always means the "current commit".  It is the
commit "git commit" builds on top of, and "git diff --cached"
and "git status" compare against.  It means the current branch
only in very limited contexts (exactly when we want a branch
name to operate on --- resetting and growing the branch tip via
commit/rebase/etc.).

Reflog is a vehicle to go back in time and time machines have
interesting interaction with the notion of "current".

HEAD@{5.minutes.ago} could mean "dereference HEAD symref to find
out what branch we are on RIGHT NOW, and then find out where the
tip of that branch was 5 minutes ago".  Alternatively it could
mean "what is the commit I would have referred to as HEAD 5
minutes ago, e.g. if I did "git show HEAD" back then".

I think both are useful, and the former semantics is given by
the "emptiness followed by @{} refers to the current branch"
shorthand, while yet-to-be-implemented HEAD@{} would give the
latter.

And I think the way Nico defined 'HEAD@{...}' is more consistent
with the way 'master@{...}' behaves; they both mean "what commit
did I mean if I said this at time ...".

I am not going to seriously suggest this, but it is conceivable
to want to be able to say things like "master^2~28@{yesterday}".
Naturally it would mean the 28th generation parent of the other
branch I merged into my 'master' branch yesterday (i.e. it asks
the question: "which commit would I have seen if I said "git
show master^2~28" yesterday?").
