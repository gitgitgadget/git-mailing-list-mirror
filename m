From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH +1] Dissociating a repository from its alternates
Date: Thu, 15 Feb 2007 01:37:00 -0800
Message-ID: <7vsld7g3sz.fsf@assigned-by-dhcp.cox.net>
References: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 10:37:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHd3C-0007cY-De
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 10:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbXBOJhF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 04:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbXBOJhF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 04:37:05 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33798 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbXBOJhC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 04:37:02 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070215093701.GHON4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 04:37:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Pld01W00U1kojtg0000000; Thu, 15 Feb 2007 04:37:01 -0500
In-Reply-To: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 14 Feb 2007 23:51:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39803>

On top of the previous patch.  This is needed to:

 - reject "repack -A -l", which does not make any sense; you
   want to repack the objects you borrow from the alternates.

 - make "repack -A" without "-a" to work.

These operations corrupted the repository with the previous
patch alone.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-repack.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 774286e..66b5039 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -25,6 +25,10 @@ do
 	esac
 	shift
 done
+if test "$nuke_alternates,$local" = "t,--local"
+then
+	die "-A and -l are incompatible"
+fi
 
 # Later we will default repack.UseDeltaBaseOffset to true
 default_dbo=false
@@ -45,7 +49,7 @@ case ",$all_into_one,$nuke_alternates," in
 	args='--unpacked --incremental'
 	;;
 ,,t,)
-	args='--incremental --ignore-alternate-pack'
+	args='--ignore-alternate-pack'
 	;;
 ,t,*)
 	if [ -d "$PACKDIR" ]; then
