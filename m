From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 08/10] t6050: add tests for listing with --format
Date: Sat, 28 Dec 2013 12:00:13 +0100
Message-ID: <20131228110016.2272.66623.chriscool@tuxfamily.org>
References: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 12:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwreF-0007rw-Tp
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 12:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab3L1LBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 06:01:20 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:46914 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755110Ab3L1LAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 06:00:50 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id C8C7232;
	Sat, 28 Dec 2013 12:00:49 +0100 (CET)
X-git-sha1: 52fd6150a9213a3dc1c04e6224618fa19fe49dfc 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239777>

This patch adds tests for "git replace -l --format=<fmt>".

'short', 'medium' and 'long' are the only allowed values
for <fmt>.

'short' is the same as with no --format option.
Tests for 'medium' and 'long' are the most needed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index bb785ec..9d05101 100755
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
+test_expect_failure 'test --format long' '
+	{
+		echo "$H1 (commit) -> $BLOB (blob)" &&
+		echo "$BLOB (blob) -> $REPLACED (blob)" &&
+		echo "$HT (tree) -> $H1 (commit)" &&
+		echo "$PARA3 (commit) -> $S (commit)" &&
+		echo "$MYTAG (tag) -> $HASH1 (commit)"
+	} | sort >expected &&
+	git replace --format=long | sort > actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'replace ref cleanup' '
 	test -n "$(git replace)" &&
 	git replace -d $(git replace) &&
-- 
1.8.4.1.616.g07f5c81
