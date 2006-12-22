From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Fri, 22 Dec 2006 13:44:25 -0800
Message-ID: <7vac1fy5ae.fsf@assigned-by-dhcp.cox.net>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net>
	<86k60jsvh8.fsf@blue.stonehenge.com>
	<86fyb7sv9f.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0612221902490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<861wmrsstc.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0612221949490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virg3zo1k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612222141060.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Dec 22 22:44:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxsBq-0002jS-61
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 22:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbWLVVo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 16:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbWLVVo1
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 16:44:27 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40241 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbWLVVo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 16:44:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222214426.VBOJ15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 16:44:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1xjj1W00E1kojtg0000000; Fri, 22 Dec 2006 16:43:44 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612222141060.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 22 Dec 2006 21:44:34 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35225>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So, if I understand your option (2) correctly, it complains _only_ if 
> there is at least one branch.*.merge in the config, but not for the 
> current branch?
>
> I think that would safeguard the existing repositories _and_ the new ones, 
> because git-clone sets them up with such an entry to begin with.
>
> If that behaviour was meant by (2), I am all for it.

I am not quite sure about that.  An old timer would work in a
newly cloned repository after all, and what this "newbie
protection" is breaking is not existing repositories but
expectation from existing users.

In any case, here is a patch for discussion.

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index f163821..b4d071b 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -145,10 +145,22 @@ canon_refs_list_for_fetch () {
 			merge_branches=$(git-repo-config \
 			    --get-all "branch.${curr_branch}.merge")
 		fi
-		# If we are fetching only one branch, then first branch
-		# is the only thing that makes sense to merge anyway,
-		# so there is no point refusing that traditional rule.
-		if test $# != 1 && test "z$merge_branches" = z
+		if test "z$merge_branches" = z &&
+			# If we are fetching only one branch, then
+			# first branch is the only thing that makes
+			# sense to merge anyway, so there is no point
+			# refusing that traditional rule.
+			test $# != 1 &&
+
+			# Also, old timers have been happily working
+			# with the first branch rule without having
+			# any branch.*.merge configuration, so if
+			# there is none, do not bother with this
+			# "newbie protection".  A newly cloned
+			# repository would have branch.master.merge
+			# set for it.
+			git repo-config --get-regexp \
+				'^branch\..*\.merge$' >/dev/null
 		then
 			merge_branches=..this..would..never..match..
 		fi
