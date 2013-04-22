From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH] bisect: Store first bad commit as comment in log file
Date: Mon, 22 Apr 2013 23:02:29 +0200
Message-ID: <20130422210229.GE5650@pvv.ntnu.no>
References: <20130413152257.GB16040@pvv.ntnu.no>
 <20130415.063809.1055555229072260139.chriscool@tuxfamily.org>
 <20130415095339.GA28480@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 23:02:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUNsi-0004jV-0H
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247Ab3DVVCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:02:31 -0400
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:52727 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab3DVVCa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:02:30 -0400
Received: from torstehe by microbel.pvv.ntnu.no with local (Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1UUNsb-0005Od-LA; Mon, 22 Apr 2013 23:02:29 +0200
Content-Disposition: inline
In-Reply-To: <20130415095339.GA28480@pvv.ntnu.no>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222091>

On Mon, Apr 15, 2013 at 11:53:39 +0200, Torstein Hegge wrote:
> On Mon, Apr 15, 2013 at 06:38:09 +0200, Christian Couder wrote:
> > I wonder if we should also write something into the bisect log if for
> > example the bisection stopped because there are only 'skip'ped commits
> > left to test. But maybe this could go into another patch after this
> > one.
> 
> Yes, that would be useful, but I wasn't able to determine all the cases
> that would be relevant to log. Only skipped commits left to test is one,
> but bisect--helper also exits on various problems related to merge base
> handling. The handling of problems related to inconsistent user input is
> probably not relevant to log.

I took another look at this. I wasn't able to come up with anything
useful for the "The merge base $rev is bad" case, but for the "only
skipped commits left to test" case one could do something like this.

There has to be a better way to get the range of possible first bad
commits, similar to the output of 'git log --bisect --format="%H"'.

--- >8 ---
Subject: [PATCH] bisect: Log possibly bad, skipped commits at bisection end

If the bisection completes with only skipped commits left to as possible
first bad commit, output the list of possible first bad commits to human
readers of the bisection log.

Signed-off-by: Torstein Hegge <hegge@resisty.net>
---
 git-bisect.sh               |   10 ++++++++++
 t/t6030-bisect-porcelain.sh |   20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/git-bisect.sh b/git-bisect.sh
index c58eea7..d7518e9 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -317,6 +317,16 @@ bisect_next() {
 		bad_commit=$(git show-branch $bad_rev)
 		echo "# first bad commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"
 		exit 0
+	elif test $res -eq 2
+	then
+		echo "# only skipped commits left to test" >>"$GIT_DIR/BISECT_LOG"
+		good_revs=$(git for-each-ref --format="--not %(objectname)" "refs/bisect/good-*")
+		for skipped in $(git rev-list refs/bisect/bad $good_revs)
+		do
+			skipped_commit=$(git show-branch $skipped)
+			echo "# possible first bad commit: $skipped_commit" >>"$GIT_DIR/BISECT_LOG"
+		done
+		exit $res
 	fi
 
 	# Check for an error in the bisection process
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 4d3074a..064f5ce 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -759,4 +759,24 @@ test_expect_success 'bisect log: successfull result' '
 	git bisect reset
 '
 
+cat > expected.bisect-skip-log <<EOF
+# bad: [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hello>.
+# good: [7b7f204a749c3125d5224ed61ea2ae1187ad046f] Add <2: A new day for git> into <hello>.
+git bisect start '32a594a3fdac2d57cf6d02987e30eec68511498c' '7b7f204a749c3125d5224ed61ea2ae1187ad046f'
+# skip: [3de952f2416b6084f557ec417709eac740c6818c] Add <3: Another new day for git> into <hello>.
+git bisect skip 3de952f2416b6084f557ec417709eac740c6818c
+# only skipped commits left to test
+# possible first bad commit: [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hello>.
+# possible first bad commit: [3de952f2416b6084f557ec417709eac740c6818c] Add <3: Another new day for git> into <hello>.
+EOF
+
+test_expect_success 'bisect log: only skip commits left' '
+	git bisect reset &&
+	git bisect start $HASH4 $HASH2 &&
+	test_must_fail git bisect skip &&
+	git bisect log >bisect-skip-log.txt &&
+	test_cmp expected.bisect-skip-log bisect-skip-log.txt &&
+	git bisect reset
+'
+
 test_done
-- 
1.7.10.4
