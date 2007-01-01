From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] fail pull/merge early in the middle of conflicted merge
Date: Sun, 31 Dec 2006 23:21:50 -0800
Message-ID: <7vwt478b5d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 01 08:22:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1HUh-0007Dq-1I
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 08:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923AbXAAHVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 02:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932924AbXAAHVw
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 02:21:52 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46503 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923AbXAAHVv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 02:21:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070101072151.WGZR29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Mon, 1 Jan 2007 02:21:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5jM41W00C1kojtg0000000; Mon, 01 Jan 2007 02:21:04 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35728>

After a pull that results in a conflicted merge, a new user
often tries another "git pull" in desperation.  When the index
is unmerged, merge backends correctly bail out without touching
either index nor the working tree, so this does not make the
wound any worse.

The user will however see several lines of messsages during this
process, such as "filename: needs merge", "you need to resolve
your current index first", "Merging...", and "Entry ... would be
overwritten by merge. Cannot merge.".  They are unnecessarily
alarming, and makes useful conflict messages from the first pull
scroll off the top of the terminal.

This changes pull and merge to run "git-ls-files -u" upfront and
stop them much earlier than we currently do.

Old timers may know better and would not to try pulling again
before cleaning things up; this change adds extra overhead that
is unnecessary for them.  But this would be worth paying for to
save new people from needless confusion.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I've seen some people on #git channel got totally confused
   after a conflicted merge at least three times, and they paste
   the diagnostics from the second and subsequent pull, assuming
   that the messages would help diagnosing the situation in any
   way (unfortunately they typically don't).  But it is not the
   user's fault not to know it.  With this what they can give us
   when asking for help will only be from the first pull.  In a
   sense, the real motivation of this patch is to make life
   easier for people who want to help these new people.

 git-merge.sh |    3 +++
 git-pull.sh  |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index ba42260..f43fa69 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -8,6 +8,9 @@ USAGE='[-n] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commi
 . git-sh-setup
 set_reflog_action "merge $*"
 
+test -z "$(git ls-files -u)" || 
+	die "You are in a middle of conflicted merge."
+
 LF='
 '
 
diff --git a/git-pull.sh b/git-pull.sh
index 28d0819..49130d5 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -9,6 +9,9 @@ LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEA
 . git-sh-setup
 set_reflog_action "pull $*"
 
+test -z "$(git ls-files -u)" || 
+	die "You are in a middle of conflicted merge."
+
 strategy_args= no_summary= no_commit= squash=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
 do
