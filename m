From: Ben Woosley <Ben.Woosley@gmail.com>
Subject: [PATCH] git-rebase--merge: don't include absent parent as a base
Date: Wed, 20 Apr 2016 18:20:56 +0000
Message-ID: <0102015434e7556a-2d9848cb-93c3-4883-96ec-c0c70098796b-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 20:21:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aswkL-0001H3-SK
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 20:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbcDTSU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 14:20:59 -0400
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:33788
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbcDTSU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 14:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1461176456;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=n9ratpyfb8lCRj9Fg0YZyapVUI2CZr6sM9C7pB33I7M=;
	b=M0iZobdHAQUrn8pMofYgWHq6QlLkVvTSmX+mDFAWxoivyBdx2SRrwDOh1QB9j3oW
	I1fVZvfMAjF0D0kxvdk0x+Uq0bg59k1u/XyygzlO4HNQLI6FrNLYvqqbvrSS9yXZiG7
	F8V2KA65yXup7p0fGHM008jUig61eMJK6f+lhpj8=
X-SES-Outgoing: 2016.04.20-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292051>

From: Ben Woosley <ben.woosley@gmail.com>

Absent this fix, attempts to rebase an orphan branch with --strategy recursive
will fail with:

    $ git rebase ORPHAN_TARGET_BASE -s recursive
    First, rewinding head to replay your work on top of it...
    fatal: Could not parse object 'ORPHAN_ROOT_SHA^'
    Unknown exit code (128) from command: git-merge-recursive ORPHAN_ROOT_SHA^ -- HEAD ORPHAN_ROOT_SHA

To fix, this will only include the rebase root's parent as a base if it exists,
so that in cases of rebasing an orphan branch, it is a simple two-way merge.

Note the default rebase behavior does not fail:

    $ git rebase ORPHAN_TARGET_BASE
    First, rewinding head to replay your work on top of it...
    Applying: ORPHAN_ROOT_COMMIT_MSG
    Using index info to reconstruct a base tree...

Signed-off-by: Ben Woosley <ben.woosley@gmail.com>
---
 git-rebase--merge.sh    | 4 +++-
 t/t3402-rebase-merge.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 2cc2a6d..8d43db9 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -67,7 +67,9 @@ call_merge () {
 		GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
 	fi
 	test -z "$strategy" && strategy=recursive
-	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
+	# If cmt doesn't have a parent, don't include it as a base
+	base=$(git rev-parse --verify --quiet $cmt^)
+	eval 'git-merge-$strategy' $strategy_opts $base ' -- "$hd" "$cmt"'
 	rv=$?
 	case "$rv" in
 	0)
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 8f64505..488945e 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -85,6 +85,15 @@ test_expect_success 'rebase -Xtheirs' '
 	! grep 11 original
 '
 
+test_expect_success 'rebase -Xtheirs from orphan' '
+	git checkout --orphan orphan-conflicting master~2 &&
+	echo "AB $T" >> original &&
+	git commit -morphan-conflicting original &&
+	git rebase -Xtheirs master &&
+	grep AB original &&
+	! grep 11 original
+'
+
 test_expect_success 'merge and rebase should match' '
 	git diff-tree -r test-rebase test-merge >difference &&
 	if test -s difference

--
https://github.com/git/git/pull/228
