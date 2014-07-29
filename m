From: Jeff King <peff@peff.net>
Subject: [PATCH v2 6/6] stash: show combined diff with "stash show"
Date: Tue, 29 Jul 2014 13:58:20 -0400
Message-ID: <20140729175820.GF31181@peff.net>
References: <20140729175300.GA21536@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 19:58:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCBfR-0001xC-SD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 19:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbaG2R60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 13:58:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:42618 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbaG2R6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 13:58:25 -0400
Received: (qmail 2605 invoked by uid 102); 29 Jul 2014 17:58:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 12:58:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 13:58:20 -0400
Content-Disposition: inline
In-Reply-To: <20140729175300.GA21536@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254457>

A stash may store not only working tree changes, but also
changes to the index. However, "git stash show" will only
ever show the working tree changes. We can instead show both
as a combined diff, but use "--simplify-combined-diff" so
that we show a normal pairwise diff in the common case that
there were no index changes.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm still a little iffy on this one in case somebody really doesn't want
to see the saved index state. But with the earlier cleanups, you can at
least see that it doesn't even impact any existing tests.

 git-stash.sh     |  3 ++-
 t/t3903-stash.sh | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index a0246d5..ae73ba4 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -304,7 +304,8 @@ list_stash () {
 show_stash () {
 	assert_stash_like "$@"
 
-	git diff ${FLAGS:---stat} $b_commit $w_commit
+	git show --format= --simplify-combined-diff \
+		${FLAGS:---stat} $w_commit
 }
 
 #
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 465f824..36b97a4 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -537,6 +537,28 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	test_cmp expected actual
 '
 
+test_expect_success 'stash show -p will show modified index' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo index >file &&
+	git add file &&
+	echo working >file &&
+	git stash &&
+	cat >expect <<-\EOF &&
+	diff --cc file
+	index 7601807,9015a7a..d26b33d
+	--- a/file
+	+++ b/file
+	@@@ -1,1 -1,1 +1,1 @@@
+	- baz
+	 -index
+	++working
+	EOF
+	git stash show -p >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stash drop - fail early if specified stash is not a stash reference' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
-- 
2.1.0.rc0.286.g5c67d74
