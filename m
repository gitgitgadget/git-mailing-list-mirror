From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 07/10] replace: add test for --graft with signed commit
Date: Mon, 07 Jul 2014 08:35:36 +0200
Message-ID: <20140707063540.3708.33700.chriscool@tuxfamily.org>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:37:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X42Xo-0007iA-KC
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 08:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbaGGGgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 02:36:49 -0400
Received: from [194.158.98.45] ([194.158.98.45]:37418 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751727AbaGGGgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 02:36:37 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 49E446D;
	Mon,  7 Jul 2014 08:36:16 +0200 (CEST)
X-git-sha1: 3a2b18b8f10cd015978165bf9b357482a6c348ea 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140707063342.3708.83493.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252952>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index d80a89e..15fd541 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -7,6 +7,7 @@ test_description='Tests replace refs functionality'
 exec </dev/null
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 add_and_commit_file()
 {
@@ -391,4 +392,28 @@ test_expect_success '--graft with and without already replaced object' '
 	git replace -d $HASH5
 '
 
+test_expect_success GPG 'set up a signed commit' '
+	echo "line 17" >>hello &&
+	echo "line 18" >>hello &&
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
+	commit_buffer_contains_parents $HASH8 &&
+	commit_has_parents $HASH8 &&
+	test_must_fail git verify-commit $HASH8 &&
+	sed -n -e "/^tree /p" -e "/^author /p" -e "/^committer /p" orig >expected &&
+	echo >>expected &&
+	sed -e "/^$/q" repl >actual &&
+	test_cmp expected actual &&
+	git replace -d $HASH8
+'
+
 test_done
-- 
2.0.0.421.g786a89d.dirty
