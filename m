From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 4/7] t7008: demonstrate behavior of grep with textconv
Date: Tue, 23 Apr 2013 14:11:56 +0200
Message-ID: <5137a5a48ae6c70ad716d985a22d53ec311ee05a.1366718624.git.git@drmicha.warpmail.net>
References: <517298D4.3030802@drmicha.warpmail.net>
Cc: Matthieu.Moy@grenoble-inp.fr, jeremy.rosen@openwide.fr,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 14:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUc4x-0002Fq-7b
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 14:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865Ab3DWMMC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 08:12:02 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57173 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755835Ab3DWML6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Apr 2013 08:11:58 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8F7172090F;
	Tue, 23 Apr 2013 08:11:58 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 23 Apr 2013 08:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=ii
	GSu5EKcM6vJTQCKNPkZXC0feQ=; b=Bgc5f2z++SwqOXHrCQASKdhiRmRHP/ER4d
	EebQAzaSO/INuhrU6BLw5phVF3e20AnuhQQxyusD8LRKcZchyyLHDHP3t4JiQl79
	qO+b7wo1jBtFMY8Zrzv9t7q8ZsJlu/fSMDBBGmmzdLw8yoiPjHVbT3sjf+fncB1n
	4biVhwKPk=
X-Sasl-enc: jCQNl9zmIEGVaBehwegwr+y6rUP4xxQdsC6Y9/O0iJEb 1366719118
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2DAE8C80008;
	Tue, 23 Apr 2013 08:11:58 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.799.g1ac2534
In-Reply-To: <517298D4.3030802@drmicha.warpmail.net>
In-Reply-To: <cover.1366718624.git.git@drmicha.warpmail.net>
References: <cover.1366718624.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222149>

Currently, "git grep" does not honor any textconv filters. Demonstrate
this in the tests.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7008-grep-binary.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 26f8319..126fe4c 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -145,4 +145,27 @@ test_expect_success 'grep respects not-binary diff attribute' '
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
+test_expect_failure 'grep does not honor textconv' '
+	echo "a:binaryQfile" >expect &&
+	git grep Qfile >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep blob does not honor textconv' '
+	echo "HEAD:a:binaryQfile" >expect &&
+	git grep Qfile HEAD:a >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.2.1.799.g1ac2534
