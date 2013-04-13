From: Torstein Hegge <hegge@resisty.net>
Subject: [PATCH] bisect: Store first bad commit as comment in log file
Date: Sat, 13 Apr 2013 17:22:57 +0200
Message-ID: <20130413152257.GB16040@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 13 17:23:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR2IB-0007P6-1Y
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 17:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101Ab3DMPW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 11:22:59 -0400
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:40010 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab3DMPW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 11:22:58 -0400
Received: from torstehe by microbel.pvv.ntnu.no with local (Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1UR2I5-0002Pv-7s; Sat, 13 Apr 2013 17:22:57 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221065>

When bisect successfully finds a single revision, the first bad commit
should be shown to human readers of 'git bisect log'.

This resolves the apparent disconnect between the bisection result and
the log when a bug reporter says "I know that the first bad commit is
$rev, as you can see from $(git bisect log)".

Signed-off-by: Torstein Hegge <hegge@resisty.net>
---
I don't know how useful the added test is, I didn't find any existing
tests that looks at the comment parts of bisect log.

 git-bisect.sh               |    8 +++++++-
 t/t6030-bisect-porcelain.sh |   18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 99efbe8..c58eea7 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -311,7 +311,13 @@ bisect_next() {
 	res=$?
 
 	# Check if we should exit because bisection is finished
-	test $res -eq 10 && exit 0
+	if test $res -eq 10
+	then
+		bad_rev=$(git show-ref --hash --verify refs/bisect/bad)
+		bad_commit=$(git show-branch $bad_rev)
+		echo "# first bad commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"
+		exit 0
+	fi
 
 	# Check for an error in the bisection process
 	test $res -ne 0 && exit $res
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 2fce99a..6e65cdf 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -741,4 +741,22 @@ test_expect_success 'bisect: demonstrate identification of damage boundary' "
 	git bisect reset
 "
 
+cat > expected.bisect-log <<EOF
+# bad: [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hello>.
+# good: [7b7f204a749c3125d5224ed61ea2ae1187ad046f] Add <2: A new day for git> into <hello>.
+git bisect start '32a594a3fdac2d57cf6d02987e30eec68511498c' '7b7f204a749c3125d5224ed61ea2ae1187ad046f'
+# good: [3de952f2416b6084f557ec417709eac740c6818c] Add <3: Another new day for git> into <hello>.
+git bisect good 3de952f2416b6084f557ec417709eac740c6818c
+# first bad commit: [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hello>.
+EOF
+
+test_expect_success 'bisect log: successfull result' '
+	git bisect reset &&
+	git bisect start $HASH4 $HASH2 &&
+	git bisect good &&
+	git bisect log >bisect-log.txt &&
+	test_cmp expected.bisect-log bisect-log.txt &&
+	git bisect reset
+'
+
 test_done
-- 
1.7.10.4
