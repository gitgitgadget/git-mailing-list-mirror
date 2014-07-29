From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 3/2] stash: show combined diff with "stash show"
Date: Tue, 29 Jul 2014 08:07:33 -0400
Message-ID: <20140729120732.GA9302@peff.net>
References: <20140729115334.GA8976@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 14:07:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC6Bw-00027a-JW
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 14:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbaG2MHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 08:07:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:42420 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752557AbaG2MHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 08:07:36 -0400
Received: (qmail 14219 invoked by uid 102); 29 Jul 2014 12:07:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 07:07:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 08:07:33 -0400
Content-Disposition: inline
In-Reply-To: <20140729115334.GA8976@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254423>

A stash may store not only working tree changes, but also
changes to the index. However, "git stash show" will only
ever show the working tree changes. We can instead show both
as a combined diff, but use "--simplify-combined-diff" so
that we show a normal pairwise diff in the common case that
there were no index changes.

Signed-off-by: Jeff King <peff@peff.net>
---
I also considered this on top of the other two, but it probably _isn't_
a good idea. People might be doing things like "git stash show | git
apply", and would want to ignore the index content (of course it could
still work in the cases where the index was unchanged, and maybe it is a
good thing that it would break when there are index changes that the
user might be forgetting about).

As you can see from the changes in the test scripts, though, the
implementation isn't quite there either. There's no way to convince "git
show" to produce _no_ pretty-printed output (the best we can do is an
extra blank line). And of course the resulting diffs are single-parent
combined diffs, not "real" pairwise diffs.

We can fix those, but as I said, I'm not sure it is a good change even
without those warts.

 git-stash.sh     |  3 ++-
 t/t3903-stash.sh | 42 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index a0246d5..9b13853 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -304,7 +304,8 @@ list_stash () {
 show_stash () {
 	assert_stash_like "$@"
 
-	git diff ${FLAGS:---stat} $b_commit $w_commit
+	git show --pretty=format: --simplify-combined-diff \
+		${FLAGS:---stat} $w_commit
 }
 
 #
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 54154d2..045db51 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -460,6 +460,7 @@ test_expect_success 'stash show format defaults to --stat' '
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
+
 	 file | 1 +
 	 1 file changed, 1 insertion(+)
 	EOF
@@ -477,7 +478,7 @@ test_expect_success 'stash show - stashes on stack, stash-like argument' '
 	echo bar >> file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	echo "1	0	file" >expected &&
+	{ echo; echo "1	0	file"; } >expected &&
 	git stash show --numstat ${STASH_ID} >actual &&
 	test_cmp expected actual
 '
@@ -493,11 +494,12 @@ test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
-	diff --git a/file b/file
-	index 7601807..935fbd3 100644
+
+	diff --cc file
+	index 7601807..935fbd3
 	--- a/file
 	+++ b/file
-	@@ -1 +1,2 @@
+	@@ -1,1 +1,2 @@
 	 baz
 	+bar
 	EOF
@@ -512,7 +514,7 @@ test_expect_success 'stash show - no stashes on stack, stash-like argument' '
 	echo foo >> file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	echo "1	0	file" >expected &&
+	{ echo; echo "1	0	file"; } >expected &&
 	git stash show --numstat ${STASH_ID} >actual &&
 	test_cmp expected actual
 '
@@ -525,11 +527,12 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
-	diff --git a/file b/file
-	index 7601807..71b52c4 100644
+
+	diff --cc file
+	index 7601807..71b52c4
 	--- a/file
 	+++ b/file
-	@@ -1 +1,2 @@
+	@@ -1,1 +1,2 @@
 	 baz
 	+foo
 	EOF
@@ -537,6 +540,29 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
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
+
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
