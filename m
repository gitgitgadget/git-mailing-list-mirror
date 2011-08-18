From: Jeff King <peff@peff.net>
Subject: [PATCH 03/10] t7006: use test_config helpers
Date: Wed, 17 Aug 2011 22:02:06 -0700
Message-ID: <20110818050204.GC2889@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 07:02:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtukC-0006yo-Q6
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 07:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab1HRFCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 01:02:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35430
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268Ab1HRFCL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 01:02:11 -0400
Received: (qmail 18262 invoked by uid 107); 18 Aug 2011 05:02:51 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 01:02:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 22:02:06 -0700
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179560>

In some cases, this is just making the test script a little
shorter and easier to read. However, there are several
places where we didn't take proper precautions against
polluting downstream tests with our config; this fixes them,
too.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7006-pager.sh |   39 ++++++++++++++++++---------------------
 1 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index c0a3135..2ac729f 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -13,7 +13,7 @@ cleanup_fail() {
 
 test_expect_success 'setup' '
 	sane_unset GIT_PAGER GIT_PAGER_IN_USE &&
-	test_might_fail git config --unset core.pager &&
+	test_unconfig core.pager &&
 
 	PAGER="cat >paginated.out" &&
 	export PAGER &&
@@ -94,21 +94,19 @@ test_expect_success TTY 'no pager with --no-pager' '
 
 test_expect_success TTY 'configuration can disable pager' '
 	rm -f paginated.out &&
-	test_might_fail git config --unset pager.grep &&
+	test_unconfig pager.grep &&
 	test_terminal git grep initial &&
 	test -e paginated.out &&
 
 	rm -f paginated.out &&
-	git config pager.grep false &&
-	test_when_finished "git config --unset pager.grep" &&
+	test_config pager.grep false &&
 	test_terminal git grep initial &&
 	! test -e paginated.out
 '
 
 test_expect_success TTY 'git config uses a pager if configured to' '
 	rm -f paginated.out &&
-	git config pager.config true &&
-	test_when_finished "git config --unset pager.config" &&
+	test_config pager.config true &&
 	test_terminal git config --list &&
 	test -e paginated.out
 '
@@ -116,8 +114,7 @@ test_expect_success TTY 'git config uses a pager if configured to' '
 test_expect_success TTY 'configuration can enable pager (from subdir)' '
 	rm -f paginated.out &&
 	mkdir -p subdir &&
-	git config pager.bundle true &&
-	test_when_finished "git config --unset pager.bundle" &&
+	test_config pager.bundle true &&
 
 	git bundle create test.bundle --all &&
 	rm -f paginated.out subdir/paginated.out &&
@@ -150,7 +147,7 @@ test_expect_success 'tests can detect color' '
 
 test_expect_success 'no color when stdout is a regular file' '
 	rm -f colorless.log &&
-	git config color.ui auto ||
+	test_config color.ui auto ||
 	cleanup_fail &&
 
 	git log >colorless.log &&
@@ -159,7 +156,7 @@ test_expect_success 'no color when stdout is a regular file' '
 
 test_expect_success TTY 'color when writing to a pager' '
 	rm -f paginated.out &&
-	git config color.ui auto ||
+	test_config color.ui auto ||
 	cleanup_fail &&
 
 	(
@@ -172,7 +169,7 @@ test_expect_success TTY 'color when writing to a pager' '
 
 test_expect_success 'color when writing to a file intended for a pager' '
 	rm -f colorful.log &&
-	git config color.ui auto ||
+	test_config color.ui auto ||
 	cleanup_fail &&
 
 	(
@@ -221,7 +218,7 @@ test_default_pager() {
 
 	$test_expectation SIMPLEPAGER,TTY "$cmd - default pager is used by default" "
 		sane_unset PAGER GIT_PAGER &&
-		test_might_fail git config --unset core.pager &&
+		test_unconfig core.pager &&
 		rm -f default_pager_used ||
 		cleanup_fail &&
 
@@ -244,7 +241,7 @@ test_PAGER_overrides() {
 
 	$test_expectation TTY "$cmd - PAGER overrides default pager" "
 		sane_unset GIT_PAGER &&
-		test_might_fail git config --unset core.pager &&
+		test_unconfig core.pager &&
 		rm -f PAGER_used ||
 		cleanup_fail &&
 
@@ -277,7 +274,7 @@ test_core_pager() {
 
 		PAGER=wc &&
 		export PAGER &&
-		git config core.pager 'wc >core.pager_used' &&
+		test_config core.pager 'wc >core.pager_used' &&
 		$full_command &&
 		${if_local_config}test -e core.pager_used
 	"
@@ -307,7 +304,7 @@ test_pager_subdir_helper() {
 		PAGER=wc &&
 		stampname=\$(pwd)/core.pager_used &&
 		export PAGER stampname &&
-		git config core.pager 'wc >\"\$stampname\"' &&
+		test_config core.pager 'wc >\"\$stampname\"' &&
 		mkdir sub &&
 		(
 			cd sub &&
@@ -324,7 +321,7 @@ test_GIT_PAGER_overrides() {
 		rm -f GIT_PAGER_used ||
 		cleanup_fail &&
 
-		git config core.pager wc &&
+		test_config core.pager wc &&
 		GIT_PAGER='wc >GIT_PAGER_used' &&
 		export GIT_PAGER &&
 		$full_command &&
@@ -405,8 +402,8 @@ test_expect_success TTY 'command-specific pager' '
 	sane_unset PAGER GIT_PAGER &&
 	echo "foo:initial" >expect &&
 	>actual &&
-	git config --unset core.pager &&
-	git config pager.log "sed s/^/foo:/ >actual" &&
+	test_unconfig core.pager &&
+	test_config pager.log "sed s/^/foo:/ >actual" &&
 	test_terminal git log --format=%s -1 &&
 	test_cmp expect actual
 '
@@ -415,8 +412,8 @@ test_expect_success TTY 'command-specific pager overrides core.pager' '
 	sane_unset PAGER GIT_PAGER &&
 	echo "foo:initial" >expect &&
 	>actual &&
-	git config core.pager "exit 1"
-	git config pager.log "sed s/^/foo:/ >actual" &&
+	test_config core.pager "exit 1"
+	test_config pager.log "sed s/^/foo:/ >actual" &&
 	test_terminal git log --format=%s -1 &&
 	test_cmp expect actual
 '
@@ -425,7 +422,7 @@ test_expect_success TTY 'command-specific pager overridden by environment' '
 	GIT_PAGER="sed s/^/foo:/ >actual" && export GIT_PAGER &&
 	>actual &&
 	echo "foo:initial" >expect &&
-	git config pager.log "exit 1" &&
+	test_config pager.log "exit 1" &&
 	test_terminal git log --format=%s -1 &&
 	test_cmp expect actual
 '
-- 
1.7.6.10.g62f04
