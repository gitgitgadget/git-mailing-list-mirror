From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] Make git-recursive the default strategy for git-pull.
Date: Tue, 08 Nov 2005 08:21:28 -0800
Message-ID: <7vbr0vjek7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 17:27:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZWE0-0002Kg-VP
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 17:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVKHQVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 11:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVKHQV3
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 11:21:29 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:34510 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932403AbVKHQV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 11:21:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108162025.DSGR24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 11:20:25 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 7 Nov 2005 16:33:56 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11334>

This does two things:

 - It changes the hardcoded default merge strategy for two-head
   git-pull from resolve to recursive.

 - .git/config file acquires two configuration items.
   pull.twohead names the strategy for two-head case, and
   pull.octopus names the strategy for octopus merge.

IOW you are paranoid, you can have the following lines in your
.git/config file and keep using git-merge-resolve when pulling
one remote:

	[pull]
		twohead = resolve

OTOH, you can say this:

	[pull]
		twohead = resolve
		twohead = recursive

to try quicker resolve first, and when it fails, fall back to
recursive.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Linus Torvalds <torvalds@osdl.org> writes:

  > Hmm. True. The _really_ trivial in-index case triggers for me pretty 
  > often, but I haven't done any statistics. It might be only 50% of the 
  > time.
  >...
  > It's certainly an option to just do what I just did, namely use the 
  > default one until it breaks, and then just do "git reset --hard" and re-do 
  > the pull with "-s recursive". A bit sad, and it would be good to have 
  > coverage on the recursive strategy..

  Hopefully something like this would make people aware of
  recursive and give it a wider coverage and chance to mature.

 git-pull.sh |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

applies-to: 75922cf23cc070e2d5220d961a8f645f1bc8bb60
3acc20beaf0df9ce11a1b7aabf8c9dc7507a9b44
diff --git a/git-pull.sh b/git-pull.sh
index 2358af6..3b875ad 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -79,10 +79,22 @@ case "$merge_head" in
 	exit 0
 	;;
 ?*' '?*)
-	strategy_default_args='-s octopus'
+	var=`git-var -l | sed -ne 's/^pull\.octopus=/-s /p'`
+	if test '' = "$var"
+	then
+		strategy_default_args='-s octopus'
+	else
+		strategy_default_args=$var
+	fi
 	;;
 *)
-	strategy_default_args='-s resolve'
+	var=`git-var -l | sed -ne 's/^pull\.twohead=/-s /p'`
+	if test '' = "$var"
+	then
+		strategy_default_args='-s recursive'
+	else
+		strategy_default_args=$var
+	fi
 	;;
 esac
 
---
0.99.9.GIT
