From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/6] t7008: demonstrate behavior of grep with textconv
Date: Fri, 19 Apr 2013 18:44:47 +0200
Message-ID: <b5e2a5d967855df362319edfb511686236b176ad.1366389739.git.git@drmicha.warpmail.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 18:45:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTERe-0000Ao-V4
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031145Ab3DSQpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:45:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60647 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030840Ab3DSQpm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Apr 2013 12:45:42 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7B37220C80
	for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:45:42 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 19 Apr 2013 12:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=6nmQYgQQdcH1P4kH7eru29Yu2
	a8=; b=sNDMBhHh3CZlkcQ+j+RNY32TWBo38rkoSTeTBjqRKareduuluX4lIRDZy
	BqmmiMxet+20sVTOMtsGVHSjE8oh/1SdHfSjjh6JpIGAJgmHvzn6UOJ3h0r2h+6A
	PaElsLvyOzToo9+y90mo0fzLSBw0L3k/o3HF4akfnFt7wMEvjI=
X-Sasl-enc: 2VKTiFoUpXwz22mpJ7lUKJmptRXgi6IFjk4zORqdrzYf 1366389942
Received: from localhost (unknown [46.115.51.241])
	by mail.messagingengine.com (Postfix) with ESMTPA id 025892001A3;
	Fri, 19 Apr 2013 12:45:41 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.728.ge98e8b0
In-Reply-To: <cover.1366389739.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221774>

Currently, "git grep" does not invoke any textconv filters. Demonstrate
this in the tests.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7008-grep-binary.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 26f8319..a1fd0b2 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -145,4 +145,23 @@ test_expect_success 'grep respects not-binary diff attribute' '
 	test_cmp expect actual
 '
 
+cat >nul_to_q_textconv <<'EOF'
+#!/bin/sh
+"$PERL_PATH" -pe 'y/\000/Q/' < "$1"
+EOF
+chmod +x nul_to_q_textconv
+
+test_expect_success 'setup textconv filters' '
+	echo a diff=foo >.gitattributes &&
+	git config diff.foo.textconv "\"$(pwd)\""/nul_to_q_textconv
+'
+
+test_expect_success 'grep does not obey textconv' '
+	test_must_fail git grep Qfile
+'
+
+test_expect_success 'grep blob does not obey textconv' '
+	test_must_fail git grep Qfile HEAD:a
+'
+
 test_done
-- 
1.8.2.1.728.ge98e8b0
