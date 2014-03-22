From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 02/10] t4209: factor out helper function test_log()
Date: Sat, 22 Mar 2014 18:15:52 +0100
Message-ID: <1395508560-19893-3-git-send-email-l.s.r@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 18:16:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRPX6-0001ov-1v
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 18:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbaCVRQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 13:16:27 -0400
Received: from mout.web.de ([212.227.15.14]:58991 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948AbaCVRQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 13:16:27 -0400
Received: from debian.fritz.box ([79.253.149.120]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LpO8D-1X3VYw2xyn-00f9ei; Sat, 22 Mar 2014 18:16:15
 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
X-Provags-ID: V03:K0:c9/ZY6eF/kWHHAbi3la3+IQYkttNlKa5QM5JsJvGQNzhNuirY/C
 VJWmprMzY80opG8uAUpwhP0Oq5DNEoZNwE8TMJRXEsnYaHYyJMbRfUyPQBYQlyxy6bfzbgC
 dCuYZf2nrUhGgY65R2mCGnTBBXwch6S44if1tOBViEhEFYyRoncCtogorN3X0P782gKC7aH
 e6zq+GzvLsaltMNRCPHTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244772>

Twelve tests in t4209 follow the same simple pattern for description,
git log call and checking.  Extract that shared logic into a helper
function named test_log.  Test specifications become a lot more
compact, new tests can be added more easily.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4209-log-pickaxe.sh | 92 +++++++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 58 deletions(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index ff668b5..9f3bb40 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -3,6 +3,28 @@
 test_description='log --grep/--author/--regexp-ignore-case/-S/-G'
 . ./test-lib.sh
 
+test_log() {
+	expect=$1
+	kind=$2
+	needle=$3
+	shift 3
+	rest=$@
+
+	case $expect in
+	expect_nomatch)
+		match=nomatch
+		;;
+	*)
+		match=match
+		;;
+	esac
+
+	test_expect_success "log $kind${rest:+ $rest} ($match)" "
+		git log $rest $kind $needle --format=%H >actual &&
+		test_cmp $expect actual
+	"
+}
+
 test_expect_success setup '
 	>expect_nomatch &&
 
@@ -44,35 +66,12 @@ test_expect_success 'log --author -i' '
 	test_cmp expect_second actual
 '
 
-test_expect_success 'log -G (nomatch)' '
-	git log -Gpicked --format=%H >actual &&
-	test_cmp expect_nomatch actual
-'
-
-test_expect_success 'log -G (match)' '
-	git log -GPicked --format=%H >actual &&
-	test_cmp expect_second actual
-'
-
-test_expect_success 'log -G --regexp-ignore-case (nomatch)' '
-	git log --regexp-ignore-case -Gpickle --format=%H >actual &&
-	test_cmp expect_nomatch actual
-'
-
-test_expect_success 'log -G -i (nomatch)' '
-	git log -i -Gpickle --format=%H >actual &&
-	test_cmp expect_nomatch actual
-'
-
-test_expect_success 'log -G --regexp-ignore-case (match)' '
-	git log --regexp-ignore-case -Gpicked --format=%H >actual &&
-	test_cmp expect_second actual
-'
-
-test_expect_success 'log -G -i (match)' '
-	git log -i -Gpicked --format=%H >actual &&
-	test_cmp expect_second actual
-'
+test_log expect_nomatch -G picked
+test_log expect_second  -G Picked
+test_log expect_nomatch -G pickle --regexp-ignore-case
+test_log expect_nomatch -G pickle -i
+test_log expect_second  -G picked --regexp-ignore-case
+test_log expect_second  -G picked -i
 
 test_expect_success 'log -G --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
@@ -87,35 +86,12 @@ test_expect_success 'log -G --no-textconv (missing textconv tool)' '
 	rm .gitattributes
 '
 
-test_expect_success 'log -S (nomatch)' '
-	git log -Spicked --format=%H >actual &&
-	test_cmp expect_nomatch actual
-'
-
-test_expect_success 'log -S (match)' '
-	git log -SPicked --format=%H >actual &&
-	test_cmp expect_second actual
-'
-
-test_expect_success 'log -S --regexp-ignore-case (match)' '
-	git log --regexp-ignore-case -Spicked --format=%H >actual &&
-	test_cmp expect_second actual
-'
-
-test_expect_success 'log -S -i (match)' '
-	git log -i -Spicked --format=%H >actual &&
-	test_cmp expect_second actual
-'
-
-test_expect_success 'log -S --regexp-ignore-case (nomatch)' '
-	git log --regexp-ignore-case -Spickle --format=%H >actual &&
-	test_cmp expect_nomatch actual
-'
-
-test_expect_success 'log -S -i (nomatch)' '
-	git log -i -Spickle --format=%H >actual &&
-	test_cmp expect_nomatch actual
-'
+test_log expect_nomatch -S picked
+test_log expect_second  -S Picked
+test_log expect_second  -S picked --regexp-ignore-case
+test_log expect_second  -S picked -i
+test_log expect_nomatch -S pickle --regexp-ignore-case
+test_log expect_nomatch -S pickle -i
 
 test_expect_success 'log -S --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-- 
1.9.1
