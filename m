From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] stash: default listing to "--cc --simplify-combined-diff"
Date: Tue, 29 Jul 2014 08:03:20 -0400
Message-ID: <20140729120320.GB9175@peff.net>
References: <20140729115334.GA8976@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 14:03:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC68M-0000bM-S9
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 14:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbaG2MDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 08:03:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:42414 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753771AbaG2MDX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 08:03:23 -0400
Received: (qmail 13956 invoked by uid 102); 29 Jul 2014 12:03:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 07:03:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 08:03:20 -0400
Content-Disposition: inline
In-Reply-To: <20140729115334.GA8976@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254422>

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
I don't think anybody should complain about these defaults changing,
given how useless "git stash list -p" is now. You can negate
--simplify-combined-diff if you want to, but I don't think there is a
way to turn off "--cc" (though why would you want to?).

Anyway, I don't think we need to worry too much about flexibility here.
If you really want to go wild, you can run "git log -g refs/stash"
yourself.

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
index 5b79b21..54154d2 100755
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
+	diff --cc file
+	index 257cc56..d26b33d
+	--- a/file
+	+++ b/file
+	@@ -1,1 +1,1 @@
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
