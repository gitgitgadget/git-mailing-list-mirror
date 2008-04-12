From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] bisect: fix bad rev checking in "git bisect good"
Date: Sat, 12 Apr 2008 09:03:35 +0200
Message-ID: <20080412090335.e92d3da3.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sat Apr 12 08:59:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkZhT-0004be-4A
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 08:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbYDLG6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 02:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbYDLG6P
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 02:58:15 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:50572 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753651AbYDLG6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 02:58:14 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7E3E01AB302;
	Sat, 12 Apr 2008 08:58:13 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 27F9D1AB301;
	Sat, 12 Apr 2008 08:58:13 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79337>

It seems that "git bisect good" and "git bisect skip" have never
properly checked arguments that have been passed to them. As soon
as one of them can be parsed as a SHA1, no error or warning would
be given.

This is because 'git rev-parse --revs-only --no-flags "$@"' always
"exit 0" and outputs all the SHA1 it can found from parsing "$@".

This patch fix this by using, for each "bisect good" argument, the
same logic as for the "bisect bad" argument.

While at it, this patch teaches "bisect bad" to give a meaningfull
error message when it is passed more than one argument.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |   18 +++++++-----------
 t/t6030-bisect-porcelain.sh |   13 +++++++++++++
 2 files changed, 20 insertions(+), 11 deletions(-)

	This new version should give a better error message
	than the previous one.

diff --git a/git-bisect.sh b/git-bisect.sh
index a1343f6..408775a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -155,20 +155,16 @@ bisect_state() {
 		rev=$(git rev-parse --verify HEAD) ||
 			die "Bad rev input: HEAD"
 		bisect_write "$state" "$rev" ;;
-	2,bad)
-		rev=$(git rev-parse --verify "$2^{commit}") ||
-			die "Bad rev input: $2"
-		bisect_write "$state" "$rev" ;;
-	*,good|*,skip)
+	2,bad|*,good|*,skip)
 		shift
-		revs=$(git rev-parse --revs-only --no-flags "$@") &&
-			test '' != "$revs" || die "Bad rev input: $@"
-		for rev in $revs
+		for rev in "$@"
 		do
-			rev=$(git rev-parse --verify "$rev^{commit}") ||
-				die "Bad rev commit: $rev^{commit}"
-			bisect_write "$state" "$rev"
+			sha=$(git rev-parse --verify "$rev^{commit}") ||
+				die "Bad rev input: $rev"
+			bisect_write "$state" "$sha"
 		done ;;
+	*,bad)
+		die "'git bisect bad' can take only one argument." ;;
 	*)
 		usage ;;
 	esac
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index f471c15..32d6118 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -71,6 +71,19 @@ test_expect_success 'bisect start with one bad and good' '
 	git bisect next
 '
 
+test_expect_success 'bisect good and bad fails if not given only revs' '
+	git bisect reset &&
+	git bisect start &&
+	test_must_fail git bisect good foo $HASH1 &&
+	test_must_fail git bisect good $HASH1 bar &&
+	test_must_fail git bisect bad frotz &&
+	test_must_fail git bisect bad $HASH3 $HASH4 &&
+	test_must_fail git bisect skip bar $HASH3 &&
+	test_must_fail git bisect skip $HASH1 foo &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4
+'
+
 test_expect_success 'bisect reset: back in the master branch' '
 	git bisect reset &&
 	echo "* master" > branch.expect &&
-- 
1.5.5.46.gb6f72.dirty
