X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames with spaces and non-ascii characters.
Date: Sat, 09 Dec 2006 17:18:48 -0800
Message-ID: <7v3b7o8s5j.fsf@assigned-by-dhcp.cox.net>
References: <20061209232919.31863.58547.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 01:19:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061209232919.31863.58547.stgit@lathund.dewire.com> (Robin
	Rosenberg's message of "Sun, 10 Dec 2006 00:29:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33861>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtDLA-0008CZ-Rb for gcvg-git@gmane.org; Sun, 10 Dec
 2006 02:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758877AbWLJBSu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 20:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758882AbWLJBSu
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 20:18:50 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64592 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758877AbWLJBSt (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 20:18:49 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210011848.HHWY22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sat, 9
 Dec 2006 20:18:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id wpJz1V00J1kojtg0000000; Sat, 09 Dec 2006
 20:18:59 -0500
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> This patch uses git-apply to do the patching which simplifies the code a lot.
>
> Removed the test for checking for matching binary files when deleting them
> since git-apply happily deletes the file. This is matter of taste since we
> allow some fuzz for text patches also.
>
> Error handling was cleaned up, but not much tested.

Interesting.

I think you should be able to generate the patchfile once, and
use git-apply to figure out additions, deletions and binaryness,
and then use the same patchfile to apply the changes.  Currently
checking for binaryness is not easy with git-apply, so we would
want to fix git-apply first, instead of forcing you to have a
change like this:

   # the --binary format is harder to grok for names of binary
   # files so we execute a new diff
   # if it looks like binary files exists to find out
   if (grep /^GIT binary patch$/, @diff) {
       @binfiles = grep m/^Binary files/,
       safe_pipe_capture('git-diff-tree', '-p', $parent, $commit);

which is way too ugly.

	... goes to look and comes back, with a big grin ...

Well, have you tried this?

	git diff-tree -p --binary fe142b3a | git apply --summary --numstat

The numstat part would let you see the binaryness, so we do not
have to "fix" git-apply.

Another thing that _might_ be interesting is to use rename
detection when preparing the patch, and make the matching rename
on the CVS side, but I do not recall the details of how one
would make CVS pretend to support renamed paths ;-).  I think it
involved copying the ,v file to a new name, and marking the
older revisions in that new ,v file as nonexistent or something
like that, but I did it only in my distant past and forgot the
details.

By the way, I am not sure if giving fuzz by default is such a
good idea, though.
