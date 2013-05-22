From: Torstein Hegge <hegge@resisty.net>
Subject: [PATCH] bisect: Fix log output for multi-parent skip ranges
Date: Thu, 23 May 2013 00:27:53 +0200
Message-ID: <20130522222753.GD5357@pvv.ntnu.no>
References: <20130413152257.GB16040@pvv.ntnu.no>
 <20130415.063809.1055555229072260139.chriscool@tuxfamily.org>
 <20130415095339.GA28480@pvv.ntnu.no>
 <20130422210229.GE5650@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 23 00:28:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfHVy-0001z6-6H
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 00:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667Ab3EVW2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 18:28:05 -0400
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:35329 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757564Ab3EVW2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 18:28:04 -0400
Received: from torstehe by microbel.pvv.ntnu.no with local (Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1UfHVh-0005s4-Ih; Thu, 23 May 2013 00:27:53 +0200
Content-Disposition: inline
In-Reply-To: <20130422210229.GE5650@pvv.ntnu.no>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225199>

On Mon, Apr 22, 2013 at 23:02:29 +0200, Torstein Hegge wrote:
> There has to be a better way to get the range of possible first bad
> commits, similar to the output of 'git log --bisect --format="%H"'.

I just realized that this felt clunky because I didn't understand what
'--not' does in git rev-list.

In the case where the range of skipped commits include a merge and
points in each parent marked good, I want

    git rev-list bad --not good-1 good-2

or 

    git rev-list bad ^good-1 ^good-2

but instead I did

    git rev-list bad --not good-1 --not good-2

which will include commits outside the range of skipped commits. Sorry
about that :/

--- >8 ---
Subject: [PATCH] bisect: Fix log output for multi-parent skip ranges

The bisect log output of skipped commits introduced in f989cac "bisect:
Log possibly bad, skipped commits at bisection end" should obtain the range of
skipped commits from

    git rev-list bad --not good-1 good-2

not

    git rev-list bad --not good-1 --not good-2

when the skipped range contains a merge with good points in each parent.

Signed-off-by: Torstein Hegge <hegge@resisty.net>
---
 git-bisect.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index d7518e9..9f064b6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -320,8 +320,8 @@ bisect_next() {
 	elif test $res -eq 2
 	then
 		echo "# only skipped commits left to test" >>"$GIT_DIR/BISECT_LOG"
-		good_revs=$(git for-each-ref --format="--not %(objectname)" "refs/bisect/good-*")
-		for skipped in $(git rev-list refs/bisect/bad $good_revs)
+		good_revs=$(git for-each-ref --format="%(objectname)" "refs/bisect/good-*")
+		for skipped in $(git rev-list refs/bisect/bad --not $good_revs)
 		do
 			skipped_commit=$(git show-branch $skipped)
 			echo "# possible first bad commit: $skipped_commit" >>"$GIT_DIR/BISECT_LOG"
-- 
1.8.3.rc1.377.g7010c6b
