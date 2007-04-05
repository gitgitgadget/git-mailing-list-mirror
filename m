From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-fetch: use fetch--tool pick-rref to avoid local fetch from alternate
Date: Thu, 05 Apr 2007 03:22:55 -0700
Message-ID: <7v1wizrugw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
	<db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	<Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704031625050.28181@xanadu.home>
	<Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
	<20070403210319.GH27706@spearce.org>
	<Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
	<20070403211709.GJ27706@spearce.org>
	<Pine.LNX.4.64.0704031425220.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704031427050.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 12:23:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZP7P-00087P-1T
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 12:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966051AbXDEKW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 06:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966063AbXDEKW6
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 06:22:58 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47804 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966051AbXDEKW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 06:22:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405102256.RYB373.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 06:22:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jNNv1W00K1kojtg0000000; Thu, 05 Apr 2007 06:22:56 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43813>

When we are fetching from a repository that is on a local
filesystem, first check if we have all the objects that we are
going to fetch available locally, by not just checking the tips
of what we are fetching, but with a full reachability analysis
to our existing refs.  In such a case, we do not have to run
git-fetch-pack which would send many needless objects.  This is
especially true when the other repository is an alternate of the
current repository (e.g. perhaps the repository was created by
running "git clone -l -s" from there).

The useless objects transferred used to be discarded when they
were expanded by git-unpack-objects called from git-fetch-pack,
but recent git-fetch-pack prefers to keep the data it receives
from the other end without exploding them into loose objects,
resulting in a pack full of duplicated data when fetching from
your own alternate.

This also uses fetch--tool pick-rref on dumb transport side to
remove a shell loop to do the same.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Strictly speaking, there is no need to even check if $remote
   is a local directory for this to operate properly, as
   rev-list would barf and die as soon as it finds something
   unavailable, while limiting the traversal to stop immediately
   after it hits what are known to be reachable locally.  On the
   other hand, if we really want to limit this to the case to a
   repository with an alternate to "clone -l -s" origin, we
   could add 'test -f "$GIT_OBJECT_DIRECTORY/info/alternates"',
   but I chose not to.

 git-fetch.sh |   41 ++++++++++++++++++++++++++++-------------
 1 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index fd70696..5dc3063 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -173,9 +173,32 @@ fetch_all_at_once () {
 	    git-bundle unbundle "$remote" $rref ||
 	    echo failed "$remote"
 	else
-	  git-fetch-pack --thin $exec $keep $shallow_depth $no_progress \
-		"$remote" $rref ||
-	  echo failed "$remote"
+		if	test -d "$remote" &&
+
+			# The remote might be our alternate.  With
+			# this optimization we will bypass fetch-pack
+			# altogether, which means we cannot be doing
+			# the shallow stuff at all.
+			test ! -f "$GIT_DIR/shallow" &&
+			test -z "$shallow_depth" &&
+
+			# See if all of what we are going to fetch are
+			# connected to our repository's tips, in which
+			# case we do not have to do any fetch.
+			theirs=$(git-fetch--tool -s pick-rref \
+					"$rref" "$ls_remote_result") &&
+
+			# This will barf when $theirs reach an object that
+			# we do not have in our repository.  Otherwise,
+			# we already have everything the fetch would bring in.
+			git-rev-list --objects $theirs --not --all 2>/dev/null
+		then
+			git-fetch--tool pick-rref "$rref" "$ls_remote_result"
+		else
+			git-fetch-pack --thin $exec $keep $shallow_depth \
+				$no_progress "$remote" $rref ||
+			echo failed "$remote"
+		fi
 	fi
       ) |
       (
@@ -235,16 +258,8 @@ fetch_per_ref () {
 	  fi
 
 	  # Find $remote_name from ls-remote output.
-	  head=$(
-		IFS='	'
-		echo "$ls_remote_result" |
-		while read sha1 name
-		do
-			test "z$name" = "z$remote_name" || continue
-			echo "$sha1"
-			break
-		done
-	  )
+	  head=$(git-fetch--tool -s pick-rref \
+			"$remote_name" "$ls_remote_result")
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
 		die "No such ref $remote_name at $remote"
 	  echo >&2 "Fetching $remote_name from $remote using $proto"
-- 
1.5.1.45.g1ddb
