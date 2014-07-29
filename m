From: Jeff King <peff@peff.net>
Subject: [PATCH v2 5/6] stash: default listing to "--cc
 --simplify-combined-diff"
Date: Tue, 29 Jul 2014 13:57:25 -0400
Message-ID: <20140729175725.GE31181@peff.net>
References: <20140729175300.GA21536@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 19:57:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCBee-0001XH-GG
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 19:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbaG2R5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 13:57:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:42616 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752245AbaG2R5a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 13:57:30 -0400
Received: (qmail 2541 invoked by uid 102); 29 Jul 2014 17:57:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 12:57:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 13:57:25 -0400
Content-Disposition: inline
In-Reply-To: <20140729175300.GA21536@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254456>

When you list stashes, you can provide arbitrary git-log
options to change the display. However, adding just "-p"
does nothing, because each stash is actually a merge commit.

This implementation detail is easy to forget, leading to
confused users who think "-p" is not working. We can make
this easier by specifying "--cc" as a default ourselves
(which does nothing if no diff format is requested by the
user).

The resulting diff would then be a combined diff between the
base commit and the stashed index state. In many cases,
though, the user did not stash anything in the index. We can
further simplify this to a normal pairwise diff by using
"--simplify-combined-diff".

Signed-off-by: Jeff King <peff@peff.net>
---
 git-stash.sh     |  3 ++-
 t/t3903-stash.sh | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index bcc757b..a0246d5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -297,7 +297,8 @@ have_stash () {
 
 list_stash () {
 	have_stash || return 0
-	git log --format="%gd: %gs" -g "$@" $ref_stash --
+	git log --format="%gd: %gs" -g --cc --simplify-combined-diff \
+		"$@" $ref_stash --
 }
 
 show_stash () {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5b79b21..465f824 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -685,4 +685,67 @@ test_expect_success 'handle stash specification with spaces' '
 	grep pig file
 '
 
+test_expect_success 'stash list implies --cc' '
+	git stash clear &&
+	git reset --hard &&
+	echo index >file &&
+	git add file &&
+	echo working >file &&
+	git stash &&
+	git stash list -p >actual &&
+	cat >expect <<-\EOF &&
+	stash@{0}: WIP on master: b27a2bc subdir
+
+	diff --cc file
+	index 257cc56,9015a7a..d26b33d
+	--- a/file
+	+++ b/file
+	@@@ -1,1 -1,1 +1,1 @@@
+	- foo
+	 -index
+	++working
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'stash list implies --simplify-combined-diff' '
+	git stash clear &&
+	git reset --hard &&
+	echo working >file &&
+	git stash &&
+	git stash list -p >actual &&
+	cat >expect <<-\EOF &&
+	stash@{0}: WIP on master: b27a2bc subdir
+
+	diff --git a/file b/file
+	index 257cc56..d26b33d 100644
+	--- a/file
+	+++ b/file
+	@@ -1 +1 @@
+	-foo
+	+working
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--no-simplify-combined-diff overrides default' '
+	git stash clear &&
+	git reset --hard &&
+	echo working >file &&
+	git stash &&
+	git stash list -p --no-simplify-combined-diff >actual &&
+	cat >expect <<-\EOF &&
+	stash@{0}: WIP on master: b27a2bc subdir
+
+	diff --cc file
+	index 257cc56,257cc56..d26b33d
+	--- a/file
+	+++ b/file
+	@@@ -1,1 -1,1 +1,1 @@@
+	--foo
+	++working
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.0.rc0.286.g5c67d74
