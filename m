X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git "next"
Date: Fri, 27 Oct 2006 19:09:20 -0700
Message-ID: <7vr6wtb38v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 02:13:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30358>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdddZ-0004wo-2E for gcvg-git@gmane.org; Sat, 28 Oct
 2006 04:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751606AbWJ1CJW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 22:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWJ1CJW
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 22:09:22 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:11731 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1751606AbWJ1CJV
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 22:09:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028020920.DSOL13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Fri, 27
 Oct 2006 22:09:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id fe921V00S1kojtg0000000 Fri, 27 Oct 2006
 22:09:03 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I've fixed up merge-recursive not to warn "working file will be
clobbered" when unneeded, and merged it to "next" tonight.  This
is a usability fix but if done incorrectly we can break a safety
valve.

The "next" version changes behaviour from the traditional one
when (1) paths that are untracked in our branch exists in the
common ancestor and the other branch we merge into our branch,
(2) the other branch did not make any changes to these paths,
and (3) the working tree has these paths as untracked files.

Under this condition, 3-way merge decides the path should not
exist in the result.  This has not been changed (and shouldn't
be).  But what is being fixed is what "should not exist" means.
We used to say "we have that path in our working tree, which
will be lost by the merge, so we won't merge".  Which was
perhaps safer but was inconvenient.  The corrected behaviour
should be "the path is not tracked in our branch, and the result
of the merge won't have it tracked either, and we will leave
those untracked working tree files as they were".

I added a handful tests to t6022 to catch potential breakages,
and the code still passes them, but that does not mean it is
perfect.  If the program refuses to proceed when it can, you
found a safer breakage I do not worry too much about.  If the
program overwrites or loses an untracked working tree file as a
result of the merge, then that means the updated merge-recursive
relaxed the check too much.

So please handle this with a bit of extra care than usual; I'd
appreciate extra sets of eyeballs to sanity check.
