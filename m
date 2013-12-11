From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 08/10] t6050: add tests for listing with --format
Date: Wed, 11 Dec 2013 08:46:11 +0100
Message-ID: <20131211074614.11117.53499.chriscool@tuxfamily.org>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 08:48:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqeWf-0007xL-O9
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 08:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271Ab3LKHsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 02:48:05 -0500
Received: from [194.158.98.14] ([194.158.98.14]:53318 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751275Ab3LKHru (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 02:47:50 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id C057E5D;
	Wed, 11 Dec 2013 08:47:29 +0100 (CET)
X-git-sha1: 31ac33547228fcd9eeb9df0cae0d4c8725c6cf42 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239175>

This patch adds tests for "git replace -l --format=<fmt>".

'short', 'medium' and 'full' are the only allowed values
for <fmt>.

'short' is the same as with no --format option.
Tests for 'medium' and 'full' are the most needed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index bb785ec..e1cc3b8 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -281,6 +281,43 @@ test_expect_success 'git cat-file --batch works on replace objects' '
 	echo $PARA3 | git cat-file --batch
 '
 
+test_expect_success 'test --format bogus' '
+	test_must_fail git replace --format bogus >/dev/null 2>&1
+'
+
+test_expect_success 'test --format short' '
+	git replace --format=short >actual &&
+	git replace >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'test --format medium' '
+	H1=$(git --no-replace-objects rev-parse HEAD~1) &&
+	HT=$(git --no-replace-objects rev-parse HEAD^{tree}) &&
+	MYTAG=$(git --no-replace-objects rev-parse mytag) &&
+	{
+		echo "$H1 -> $BLOB" &&
+		echo "$BLOB -> $REPLACED" &&
+		echo "$HT -> $H1" &&
+		echo "$PARA3 -> $S" &&
+		echo "$MYTAG -> $HASH1"
+	} | sort >expected &&
+	git replace -l --format medium | sort > actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'test --format full' '
+	{
+		echo "$H1 (commit) -> $BLOB (blob)" &&
+		echo "$BLOB (blob) -> $REPLACED (blob)" &&
+		echo "$HT (tree) -> $H1 (commit)" &&
+		echo "$PARA3 (commit) -> $S (commit)" &&
+		echo "$MYTAG (tag) -> $HASH1 (commit)"
+	} | sort >expected &&
+	git replace --format=full | sort > actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'replace ref cleanup' '
 	test -n "$(git replace)" &&
 	git replace -d $(git replace) &&
-- 
1.8.5.1.102.g090758b
