From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bug: git-rebase goofs up \n in commit messages
Date: Fri, 25 May 2007 21:59:43 -0700
Message-ID: <7vps4onps0.fsf@assigned-by-dhcp.cox.net>
References: <465750FE.9000406@iii.hu>
	<20070526004028.GA8940@sigill.intra.peff.net>
	<20070526011036.GA4169@gondor.apana.org.au>
	<20070526034236.GA18169@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Szekeres Istvan <szekeres@iii.hu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 26 06:59:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HroNh-0006PX-0m
	for gcvg-git@gmane.org; Sat, 26 May 2007 06:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbXEZE7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 00:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbXEZE7p
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 00:59:45 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36295 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbXEZE7p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 00:59:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526045943.PSAS15717.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 26 May 2007 00:59:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3gzj1X00U1kojtg0000000; Sat, 26 May 2007 00:59:44 -0400
In-Reply-To: <20070526034236.GA18169@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 25 May 2007 23:42:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48448>

It turns out that git-commit also shares the same problem under
dash.

-- >8 --
git-commit: use printf "%s\n" instead of echo on user-supplied strings

This adds a test to verify the earlier fix to git-am by Jeff
King, and fixes the same issue in git-commit that is exposed by
the new test while at it.

Cleverly enough, this commit's log message is a good test case
at the same time.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I suspect we would declare either "war on echo" or "harder push
   for builtins" triggered by these.

 git-commit.sh           |    8 ++++----
 t/t4014-format-patch.sh |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 292cf96..f3f9a35 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -376,12 +376,12 @@ t,)
 			rm -f "$TMP_INDEX"
 		fi || exit
 
-		echo "$commit_only" |
+		printf "%s\n" "$commit_only" |
 		GIT_INDEX_FILE="$TMP_INDEX" \
 		git-update-index --add --remove --stdin &&
 
 		save_index &&
-		echo "$commit_only" |
+		printf "%s\n" "$commit_only" |
 		(
 			GIT_INDEX_FILE="$NEXT_INDEX"
 			export GIT_INDEX_FILE
@@ -432,7 +432,7 @@ fi
 
 if test "$log_message" != ''
 then
-	echo "$log_message"
+	printf "%s\n" "$log_message"
 elif test "$logfile" != ""
 then
 	if test "$logfile" = -
@@ -475,7 +475,7 @@ if test -f "$GIT_DIR/MERGE_HEAD" && test -z "$no_edit"; then
 	echo "#"
 	echo "# It looks like you may be committing a MERGE."
 	echo "# If this is not correct, please remove the file"
-	echo "#	$GIT_DIR/MERGE_HEAD"
+	printf "%s\n" "#	$GIT_DIR/MERGE_HEAD"
 	echo "# and try again"
 	echo "#"
 fi >>"$GIT_DIR"/COMMIT_EDITMSG
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 4795872..42aa9e4 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -16,16 +16,16 @@ test_expect_success setup '
 
 	for i in 1 2 5 6 A B C 7 8 9 10; do echo "$i"; done >file &&
 	git update-index file &&
-	git commit -m "Side change #1" &&
+	git commit -m "Side changes #1" &&
 
 	for i in D E F; do echo "$i"; done >>file &&
 	git update-index file &&
-	git commit -m "Side change #2" &&
+	git commit -m "Side changes #2" &&
 	git tag C2 &&
 
 	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >file &&
 	git update-index file &&
-	git commit -m "Side change #3" &&
+	git commit -m "Side changes #3 with \\n backslash-n in it." &&
 
 	git checkout master &&
 	git diff-tree -p C2 | git apply --index &&
