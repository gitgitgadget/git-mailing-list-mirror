From: Max Kirillov <max@max630.net>
Subject: [PATCH v3] git-show: fix 'git show -s' to not add extra terminator
 after merge commit
Date: Thu, 15 May 2014 01:12:45 +0300
Message-ID: <20140514221245.GA22918@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 15 00:12:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhPz-0004bv-8P
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbaENWMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:12:51 -0400
Received: from p3plsmtpa11-10.prod.phx3.secureserver.net ([68.178.252.111]:56279
	"EHLO p3plsmtpa11-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751407AbaENWMu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2014 18:12:50 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa11-10.prod.phx3.secureserver.net with 
	id 1yCj1o0033gsSd601yCoCG; Wed, 14 May 2014 15:12:50 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249006>

When git show -s is called for merge commit it prints extra newline
after any merge commit. This differs from output for commits with one
parent. Fix it by more thorough checking that diff output is disabled.

The code in question exists since commit 3969cf7db1. The additional
newline is really needed for cases when patch is requested, test
t4013-diff-various.sh contains cases which can demonstrate behavior when
the condition is restricted further.

Tests:

Added merge commit to 'set up a bit of history' case in t7007-show.sh to
cover the fix.

Existing tests are updated to demonstrate the new behaviour.  Earlier,
the tests that used "git show -s --pretty=format:%s", even though
"--pretty=format:%s" calls for item separator semantics and does not ask
for the terminating newline after the last item, expected the output to
end with such a newline.  They were relying on the buggy behaviour.  Use
of "--format=%s", which is equivalent to "--pretty=tformat:%s" that asks
for a terminating newline after each item, is a more realistic way to
use the command.

In the test 'merge log messages' the expected data is changed, because
it was explicitly listing the extra newline. Also the msg.nologff and
msg.nolognoff expected files are replaced by one msg.nolog, because they
were diffing because of the bug, and now there should be no difference.

Signed-off-by: Max Kirillov <max@max630.net>
---
Changes compared to v2:
* fixed && chaining
* squashed commit fixing test with commit fixing behavior.
  Also simplified t7600 a bit - now different expected data
  are not needed
* rephrased the commit message. Have made some experiments with
  changing the condition, added a note about it in place of
  assumptions. Also commented the tests change. After some
  struggling to explain choices with own words copied the
  Junio's paragraph.
 combine-diff.c                |  3 ++-
 t/t1507-rev-parse-upstream.sh |  2 +-
 t/t7007-show.sh               | 10 +++++++---
 t/t7600-merge.sh              | 11 +++++------
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 3b92c448..ff6ceaf 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1331,7 +1331,8 @@ void diff_tree_combined(const unsigned char *sha1,
 		if (show_log_first && i == 0) {
 			show_log(rev);
 
-			if (rev->verbose_header && opt->output_format)
+			if (rev->verbose_header && opt->output_format &&
+			    opt->output_format != DIFF_FORMAT_NO_OUTPUT)
 				printf("%s%c", diff_line_prefix(opt),
 				       opt->line_termination);
 		}
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 2a19e79..672280b 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -100,7 +100,7 @@ test_expect_success 'merge my-side@{u} records the correct name' '
 	git branch -D new ;# can fail but is ok
 	git branch -t new my-side@{u} &&
 	git merge -s ours new@{u} &&
-	git show -s --pretty=format:%s >actual &&
+	git show -s --pretty=tformat:%s >actual &&
 	echo "Merge remote-tracking branch ${sq}origin/side${sq}" >expect &&
 	test_cmp expect actual
 )
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index e41fa00..1b824fe 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -24,7 +24,8 @@ test_expect_success 'set up a bit of history' '
 	git tag -m "annotated tag" annotated &&
 	git checkout -b side HEAD^^ &&
 	test_commit side2 &&
-	test_commit side3
+	test_commit side3 &&
+	test_merge merge main3
 '
 
 test_expect_success 'showing two commits' '
@@ -109,8 +110,11 @@ test_expect_success 'showing range' '
 '
 
 test_expect_success '-s suppresses diff' '
-	echo main3 >expect &&
-	git show -s --format=%s main3 >actual &&
+	cat >expect <<-\EOF &&
+	merge
+	main3
+	EOF
+	git show -s --format=%s merge main3 >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 10aa028..b164621 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -57,11 +57,10 @@ create_merge_msgs () {
 		git log --no-merges ^HEAD c2 c3
 	} >squash.1-5-9 &&
 	: >msg.nologff &&
-	echo >msg.nolognoff &&
+	: >msg.nolognoff &&
 	{
 		echo "* tag 'c3':" &&
-		echo "  commit 3" &&
-		echo
+		echo "  commit 3"
 	} >msg.log
 }
 
@@ -71,7 +70,7 @@ verify_merge () {
 	git diff --exit-code &&
 	if test -n "$3"
 	then
-		git show -s --pretty=format:%s HEAD >msg.act &&
+		git show -s --pretty=tformat:%s HEAD >msg.act &&
 		test_cmp "$3" msg.act
 	fi
 }
@@ -620,10 +619,10 @@ test_expect_success 'merge early part of c2' '
 	git tag c6 &&
 	git branch -f c5-branch c5 &&
 	git merge c5-branch~1 &&
-	git show -s --pretty=format:%s HEAD >actual.branch &&
+	git show -s --pretty=tformat:%s HEAD >actual.branch &&
 	git reset --keep HEAD^ &&
 	git merge c5~1 &&
-	git show -s --pretty=format:%s HEAD >actual.tag &&
+	git show -s --pretty=tformat:%s HEAD >actual.tag &&
 	test_cmp expected.branch actual.branch &&
 	test_cmp expected.tag actual.tag
 '
-- 
1.8.5.2.421.g4cdf8d0
