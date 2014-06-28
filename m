From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 7/7] replace: add test for --graft with signed commit
Date: Sat, 28 Jun 2014 20:11:16 +0200
Message-ID: <20140628181117.5687.83337.chriscool@tuxfamily.org>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 20:20:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0xEe-0007p4-1P
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 20:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173AbaF1SUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 14:20:14 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:36042 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756034AbaF1STt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 14:19:49 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id CAC2738;
	Sat, 28 Jun 2014 20:19:47 +0200 (CEST)
X-git-sha1: b82fc496e6219728fa1e5a4976b8adbe8dd722de 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140628171731.5687.30308.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252616>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index ca45a84..80b85e3 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -7,6 +7,7 @@ test_description='Tests replace refs functionality'
 exec </dev/null
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 add_and_commit_file()
 {
@@ -363,4 +364,25 @@ test_expect_success '--graft with and without already replaced object' '
 	git replace -d $HASH5
 '
 
+test_expect_success GPG 'set up a signed commit' '
+	echo "line 17" >> hello &&
+	echo "line 18" >> hello &&
+	git add hello &&
+	test_tick &&
+	git commit --quiet -S -m "hello: 2 more lines in a signed commit" &&
+	HASH8=$(git rev-parse --verify HEAD) &&
+	git verify-commit $HASH8
+'
+
+test_expect_success GPG '--graft with a signed commit' '
+	git cat-file commit $HASH8 >orig &&
+	git replace --graft $HASH8 &&
+	git cat-file commit $HASH8 >repl &&
+	test_must_fail grep gpgsig repl &&
+	diff -u orig repl | grep "^-parent $HASH7" &&
+	diff -u orig repl | grep "^-gpgsig -----BEGIN PGP SIGNATURE-----" &&
+	test_must_fail git verify-commit $HASH8 &&
+	git replace -d $HASH8
+'
+
 test_done
-- 
2.0.0.421.g786a89d.dirty
