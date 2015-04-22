From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] stash: require a clean index to apply
Date: Wed, 22 Apr 2015 15:31:02 -0400
Message-ID: <20150422193101.GC27945@peff.net>
References: <20150422192948.GA27656@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Gutov <dgutov@yandex.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:31:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0Mb-0004W1-4T
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbbDVTbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:31:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:48770 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753820AbbDVTbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:31:04 -0400
Received: (qmail 11065 invoked by uid 102); 22 Apr 2015 19:31:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 14:31:04 -0500
Received: (qmail 13188 invoked by uid 107); 22 Apr 2015 19:31:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 15:31:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 15:31:02 -0400
Content-Disposition: inline
In-Reply-To: <20150422192948.GA27656@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267621>

If you have staged contents in your index and run "stash
apply", we may hit a conflict and put new entries into the
index. Recovering to your original state is difficult at
that point, because tools like "git reset --keep" will blow
away anything staged.  We can make this safer by refusing to
apply when there are staged changes.

It's possible we could provide better tooling here, as "git
stash apply" should be writing only conflicts to the index
(so we know that any stage-0 entries are potentially
precious). But it is the odd duck; most "mergy" commands
will update the index for cleanly merged entries, and it is
not worth updating our tooling to support this use case
which is unlikely to be of interest (besides which, we would
still need to block a dirty index for "stash apply --index",
since that case _would_ be ambiguous).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-stash.sh     | 2 ++
 t/t3903-stash.sh | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index d4cf818..cc28368 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -442,6 +442,8 @@ apply_stash () {
 	assert_stash_like "$@"
 
 	git update-index -q --refresh || die "$(gettext "unable to refresh index")"
+	git diff-index --cached --quiet --ignore-submodules HEAD -- ||
+		die "$(gettext "Cannot apply stash: Your index contains uncommitted changes.")"
 
 	# current index state
 	c_tree=$(git write-tree) ||
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f179c93..0746eee 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -45,6 +45,13 @@ test_expect_success 'applying bogus stash does nothing' '
 	test_cmp expect file
 '
 
+test_expect_success 'apply requires a clean index' '
+	test_when_finished "git reset --hard" &&
+	echo changed >other-file &&
+	git add other-file &&
+	test_must_fail git stash apply
+'
+
 test_expect_success 'apply does not need clean working directory' '
 	echo 4 >other-file &&
 	git stash apply &&
-- 
2.4.0.rc2.498.g02440db
