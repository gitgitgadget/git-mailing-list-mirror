From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some index-base bug in "next" branch ("git-applymbox"-related?)..
Date: Thu, 12 Apr 2007 17:22:00 -0700
Message-ID: <7vbqhti0nr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 02:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc9YG-0007bB-UW
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 02:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbXDMAWD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 20:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753943AbXDMAWD
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 20:22:03 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:47735 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbXDMAWB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 20:22:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413002200.LILU1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Apr 2007 20:22:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id mQN01W00T1kojtg0000000; Thu, 12 Apr 2007 20:22:01 -0400
In-Reply-To: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 12 Apr 2007 15:43:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44373>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That "80584ff.." commit is the commit *before* the "dotest", and HEAD is 
> (correctly) 6a04de.. that is the end result of the "dotest". That "dotest" 
> thing is just because "git-applymbox" isn't in my brain stem:
>
> 	[torvalds@woody linux]$ alias dotest
> 	alias dotest='git-applymbox -u'
>
> so it's not actually anything strange.

This will teach applymbox the index base safety, but it shows
that the division between applymbox and applypatch makes things
less efficient than how git-am can do the same.  In 5ddb93e that
teaches the same to git-am, we need to deal with the index base
only once at the beginning to check and once at the end to
update.  applypatch being a separate program means we cannot do
that easily inside applymbox.

-- >8 --
[PATCH] Teach applypatch about the index base

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-applypatch.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-applypatch.sh b/git-applypatch.sh
index 8df2aee..c6d88e4 100755
--- a/git-applypatch.sh
+++ b/git-applypatch.sh
@@ -14,6 +14,8 @@
 USAGE='<msg> <patch> <info> [<signoff>]'
 . git-sh-setup
 
+check_base || exit
+
 case "$#" in 3|4) ;; *) usage ;; esac
 
 final=.dotest/final-commit
@@ -205,6 +207,7 @@ parent=$(git-rev-parse --verify HEAD) &&
 commit=$(git-commit-tree $tree -p $parent <"$final") || exit 1
 echo Committed: $commit
 git-update-ref -m "applypatch: $SUBJECT" HEAD $commit $parent || exit
+git update-index --set-base "$commit"
 
 if test -x "$GIT_DIR"/hooks/post-applypatch
 then
-- 
1.5.1.1.772.gab9f7
