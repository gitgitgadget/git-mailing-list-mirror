From: Junio C Hamano <junkio@cox.net>
Subject: Re: "Patch is empty.  Was is split wrong?"
Date: Fri, 16 Mar 2007 20:54:26 -0700
Message-ID: <7v3b44v825.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703161925190.3910@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 04:54:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSQ0E-00082h-3c
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 04:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbXCQDy3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 23:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753714AbXCQDy2
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 23:54:28 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58505 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbXCQDy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 23:54:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070317035426.TGNX28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Mar 2007 23:54:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bfuS1W00P1kojtg0000000; Fri, 16 Mar 2007 23:54:27 -0400
In-Reply-To: <Pine.LNX.4.64.0703161925190.3910@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 16 Mar 2007 19:26:57 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42420>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> My usage of "git-applymbox -u" these days always results in these bogus 
> warnings:
>
> 	Patch is empty.  Was is split wrong?
> 	/home/torvalds/bin/git-applymbox: line 82: stop_here: command not found
>
> but then it applies the patch anyway.
>
> Hmm? I've not looked into it any more yet.

Sounds like two new bugs from the mailinfo series we added last
week, primarily 87ab7992 and f0658cf2.  I suspect mailinfo
thinks there is an empty patch (which may be one bug), and the
change to applymbox tries to catch it, but there is no
corresponding stop_here shell function defined as in git-am and
barfs (which would be another bug).

A fix for the latter bug would be the attached, and that would
expose the former bug-suspect which may indicate you indeed have
a non-patch in your mailbox (in which case there is no bug) or
the updated mailinfo is misidentifying something as a non-patch
(which would be a bug).



diff --git a/git-applymbox.sh b/git-applymbox.sh
index 2cbdc7e..c8637a8 100755
--- a/git-applymbox.sh
+++ b/git-applymbox.sh
@@ -79,7 +79,7 @@ do
 		.dotest/msg .dotest/patch <$i >.dotest/info || exit 1
 	    test -s $dotest/patch || {
 		echo "Patch is empty.  Was is split wrong?"
-		stop_here $this
+		exit 1
 	    }
 	    git-stripspace < .dotest/msg > .dotest/msg-clean
 	    ;;
