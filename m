From: Jeff King <peff@peff.net>
Subject: [PATCH 04/12] t: stop using GIT_CONFIG to cross repo boundaries
Date: Thu, 20 Mar 2014 19:15:24 -0400
Message-ID: <20140320231524.GD8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:15:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmBO-0008Ak-SD
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760088AbaCTXP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:15:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:43572 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759810AbaCTXP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:15:26 -0400
Received: (qmail 27799 invoked by uid 102); 20 Mar 2014 23:15:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:15:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:15:24 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244606>

Some tests want to check or set config in another
repository. E.g., t1000 creates repositories and makes sure
that their core.bare and core.worktree settings are what we
expect. We can do this with:

  GIT_CONFIG=$repo/.git/config git config ...

but it better shows the intent to just enter the repository
and let "git config" do the normal lookups:

  (cd $repo && git config ...)

In theory, this would cause us to use an extra subshell, but
in all such cases, we are actually already in a subshell.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0001-init.sh        | 4 ++--
 t/t5701-clone-local.sh | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index ddc8160..9b05fdf 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -12,8 +12,8 @@ check_config () {
 		echo "expected a directory $1, a file $1/config and $1/refs"
 		return 1
 	fi
-	bare=$(GIT_CONFIG="$1/config" git config --bool core.bare)
-	worktree=$(GIT_CONFIG="$1/config" git config core.worktree) ||
+	bare=$(cd "$1" && git config --bool core.bare)
+	worktree=$(cd "$1" && git config core.worktree) ||
 	worktree=unset
 
 	test "$bare" = "$2" && test "$worktree" = "$3" || {
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index c490368..3c087e9 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -12,8 +12,8 @@ test_expect_success 'preparing origin repository' '
 	: >file && git add . && git commit -m1 &&
 	git clone --bare . a.git &&
 	git clone --bare . x &&
-	test "$(GIT_CONFIG=a.git/config git config --bool core.bare)" = true &&
-	test "$(GIT_CONFIG=x/config git config --bool core.bare)" = true &&
+	test "$(cd a.git && git config --bool core.bare)" = true &&
+	test "$(cd x && git config --bool core.bare)" = true &&
 	git bundle create b1.bundle --all &&
 	git bundle create b2.bundle master &&
 	mkdir dir &&
@@ -24,7 +24,7 @@ test_expect_success 'preparing origin repository' '
 test_expect_success 'local clone without .git suffix' '
 	git clone -l -s a b &&
 	(cd b &&
-	test "$(GIT_CONFIG=.git/config git config --bool core.bare)" = false &&
+	test "$(git config --bool core.bare)" = false &&
 	git fetch)
 '
 
-- 
1.9.0.560.g01ceb46
