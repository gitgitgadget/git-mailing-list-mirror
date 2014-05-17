From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 08/10] replace: add tests for --edit
Date: Sat, 17 May 2014 08:41:30 +0200
Message-ID: <20140517064133.18932.74476.chriscool@tuxfamily.org>
References: <20140517062418.18932.21200.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 08:44:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlYLf-0006qT-QG
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 08:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135AbaEQGny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 02:43:54 -0400
Received: from [194.158.98.45] ([194.158.98.45]:61588 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756956AbaEQGnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 02:43:35 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id E9CCA6E;
	Sat, 17 May 2014 08:43:13 +0200 (CEST)
X-git-sha1: eb9379001b1e8b48c58141e9d7f2c2bf0f843966 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140517062418.18932.21200.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249446>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 719a116..7609174 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -318,6 +318,35 @@ test_expect_success 'test --format long' '
 	test_cmp expected actual
 '
 
+test_expect_success 'setup a fake editor' '
+	cat >fakeeditor <<-\EOF &&
+		#!/bin/sh
+		sed -e "s/A U Thor/A fake Thor/" "$1" >"$1.new"
+		mv "$1.new" "$1"
+	EOF
+	chmod +x fakeeditor
+'
+
+test_expect_success '--edit with and without already replaced object' '
+	GIT_EDITOR=./fakeeditor test_must_fail git replace --edit "$PARA3" &&
+	GIT_EDITOR=./fakeeditor git replace --force --edit "$PARA3" &&
+	git replace -l | grep "$PARA3" &&
+	git cat-file commit "$PARA3" | grep "A fake Thor" &&
+	git replace -d "$PARA3" &&
+	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
+	git replace -l | grep "$PARA3" &&
+	git cat-file commit "$PARA3" | grep "A fake Thor"
+'
+
+test_expect_success '--edit and change nothing or command failed' '
+	git replace -d "$PARA3" &&
+	GIT_EDITOR=true test_must_fail git replace --edit "$PARA3" &&
+	GIT_EDITOR="./fakeeditor;false" test_must_fail git replace --edit "$PARA3" &&
+	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
+	git replace -l | grep "$PARA3" &&
+	git cat-file commit "$PARA3" | grep "A fake Thor"
+'
+
 test_expect_success 'replace ref cleanup' '
 	test -n "$(git replace)" &&
 	git replace -d $(git replace) &&
-- 
1.9.rc0.17.g651113e
