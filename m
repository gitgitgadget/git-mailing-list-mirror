From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refuse to merge during a merge
Date: Sun, 31 May 2009 12:36:37 -0700
Message-ID: <7vd49prrne.fsf@alter.siamese.dyndns.org>
References: <20090527210410.GA14742@localhost>
	<43d8ce650905280912q71c749bn7146210a5838a453@mail.gmail.com>
	<20090530083721.GA12963@localhost> <20090531104359.GA19094@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dave Olszewski <cxreg@pobox.com>,
	John Tapsell <johnflux@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun May 31 21:36:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAqpp-0001ln-Fz
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 21:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbZEaTgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 15:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbZEaTgh
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 15:36:37 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49998 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZEaTgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 15:36:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090531193636.QDMO25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 May 2009 15:36:36 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id yKcd1b00B4aMwMQ03KcdEL; Sun, 31 May 2009 15:36:37 -0400
X-Authority-Analysis: v=1.0 c=1 a=C9IecrIIepwA:10 a=rCiRbmqKF_gA:10
 a=hfEFsvr2-C-2YoE9P8cA:9 a=OfUrvGZFy15SCmSNAGgA:7
 a=6wLdmER_m0Zn34G_JS7zFcSGMngA:4
X-CM-Score: 0.00
In-Reply-To: <20090531104359.GA19094@localhost> (Clemens Buchacher's message of "Sun\, 31 May 2009 12\:43\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120426>

Clemens Buchacher <drizzd@aon.at> writes:

> The following is an easy mistake to make for users coming from version
> control systems with an "update and commit"-style workflow.
>
>         1. git pull
>         2. resolve conflicts
>         3. git pull
>
> Step 3 overrides MERGE_HEAD, starting a new merge with dirty index.

I think the new condition that you added to stop the merge is more in line
with the original intent of the check.  We never wanted to check "do we
still have unmerged entries?" but wanted to see "is another merge in
progress?"; not checking MERGE_HEAD was a simple omission.

But I do not necessarily agree with the combined check nor with the new
message.  I think it would be more sensible to split the codepath like
this:

	if (we see MERGE_HEAD)
		die("You have not concluded your merge (MERGE_HEAD exists).");
	if (the index is unmerged)
		die("You are in the middle of a conflicted merge (index unmerged).");

Then in a _later_ patch, you could try to be more helpful by paying more
attention to the context.  E.g.

	if (we see MERGE_HEAD) {
        	figure out what was attempted by looking at
                MERGE_MSG and other cues;
		die("You have not concluded your merge with %s.\n"
		    "Perhaps you would want 'git reset' to recover?"
                    that);
	}
	if (the index is unmerged)
		die("You are in the middle of a conflicted merge");

The point is that combining the checks makes it harder to later give more
appropriate diagnosis and suggestion to the end user.

For example, "git merge" may learn "git merge --abort" like other commands
that have "attempt, stop, let the user fix up to conclude" modes of
operations (i.e. rebase and am), and we may suggest to use that to recover
in the message, instead of 'git reset'.  But that can only be used if we
stopped because we saw MERGE_HEAD; you definitely do not want to suggest
"git merge --abort" if the index is unmerged due to a conflicted rebase in
progress.

Note that I am not suggesting you to blow this up to one large patch by
adding fancier "what were we doing" logic; I am perfectly OK with the
minimum "detect MERGE_HEAD and refuse".  I am only saying that I am
unhappy with the way two different error conditions are conflated.

Personally, I'd suggest not to give "you can do this to recover" message.
