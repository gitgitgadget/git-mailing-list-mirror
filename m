X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rerere: record (or avoid misrecording) resolved, skipped or aborted rebase/am
Date: Sat, 09 Dec 2006 12:08:49 -0800
Message-ID: <7vbqmcbzn2.fsf@assigned-by-dhcp.cox.net>
References: <20061208212830.GB13944@localdomain>
	<11656133963055-git-send-email-normalperson@yhbt.net>
	<1165613397460-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 20:08:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33830>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt8VB-0005Cc-Pm for gcvg-git@gmane.org; Sat, 09 Dec
 2006 21:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761889AbWLIUIu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 15:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761875AbWLIUIu
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 15:08:50 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46340 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1761889AbWLIUIu (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 15:08:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061209200849.CZTF25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Sat, 9
 Dec 2006 15:08:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id wk901V00A1kojtg0000000; Sat, 09 Dec 2006
 15:09:00 -0500
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

I looked at your previous 5-patch series but will replace with
this updated 2-patch series.

The rerere command started its life as a mere helper for
Porcelains, but with 'status' and 'diff', you are making it
somewhat Porcelain-ish.  I still have not decided myself, but I
think we probably would want to treat this as a Porcelain and
give a bit of usability to it, so what I've committed has two
changes from your version:

 (1) 'diff' without @ARGV defaults to '-u';
 (2) running rerere with unknown sub command die()s instead of
     silently exiting with 0.

The difference between your previous 5-patch series and this
round raises an interesting issue.

You used to have a safety valve in git-commit to prevent users
from running it while rebase/am is in progress, which I imagine
would be a common mistake.

There are three commands in git suite that a user would use to
eventually make new commits, out of something other than what
was edited and prepared in the working tree, that can stop in
the middle.

 (1) git-am is used to make new commits from e-mailed patches,
     and stops in the middle when a patch does not apply.
     "git-am --resolved/--skip" are the ways to continue.

 (2) git-rebase is used to rewrite the history of a branch, and
     stops in the middle when a patch does not apply or merge
     conflicts.  "git-rebase --continue/--skip/--abort" are
     possible exits [*1*].

 (3) git-pull/git-merge are used to make merge commits with
     another branch, and stops in the middle when it conflicts.
     Possible exits are "git commit" or "git reset".

Now, I am not going to propose to fix this inconsistency and
forbid use of "git commit" to resolve "git-merge" (instead, the
user would say "git-merge --resolved/--abort").  As the workflow
goes, these are very different operations and the user is often
well aware which workflow is in progress; having different
commands for different exit route is fine.

But in order to implement the safety valve like you did cleanly,
we should first have an enumeration of states (the above is a
subset --- there is the "base state" in which you are working
towards a commit based on HEAD, which is obviously concluded
with a "git commit", and "bisect in progress") and make it easy
for commands to communicate what state the working tree is in.
That would also help 'git-explain'.

[Footnote]

*1* Resuming rebase was much worse before Sean updated it with
commit 031321c6 to hide that it uses git-am as its backend,
which is purely its implementation detail.
