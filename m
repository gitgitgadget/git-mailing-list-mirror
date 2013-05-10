From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 5/7] t7008: demonstrate behavior of grep with textconv
Date: Fri, 10 May 2013 17:10:14 +0200
Message-ID: <16e83cb70df76071a993612d4b69c5c528f4b1a5.1368197380.git.git@drmicha.warpmail.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 17:11:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaoz0-0006zX-M4
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714Ab3EJPLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:11:38 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43155 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754135Ab3EJPLh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 May 2013 11:11:37 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A619520C08;
	Fri, 10 May 2013 11:11:36 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 10 May 2013 11:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=OA
	TLXtO5OEzdU2DQmI2xOBdnKEA=; b=P3RA1lxirzr5H6hIYVbOXwgmfdzaiTCjJh
	oDChJxJFzNqiQrpc6eW5fPYsoRTLRl2fuKE/AtvBPzHMXLdvtUarT/tJftE2nfU9
	qH2mr7oRo0eFD/5ae2gZJGHL345hJGzL1Qb9fQ0uWTBNM5GoqTaIfoHCu41gdKmQ
	FDA2xS9Cg=
X-Sasl-enc: maZ7OaJbnwjPHnWh3mlK1cd4PMPHv44N1FNJAlGbr3NU 1368198695
Received: from localhost (unknown [213.221.117.228])
	by mail.messagingengine.com (Postfix) with ESMTPA id C3A5F200161;
	Fri, 10 May 2013 11:11:35 -0400 (EDT)
X-Mailer: git-send-email 1.8.3.rc1.406.gf4dce7e
In-Reply-To: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1368197380.git.git@drmicha.warpmail.net>
References: <cover.1368197380.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223864>

Currently, "git grep" does not honor any textconv filters, with nor
without --textconv. Demonstrate this in the tests.

The default is expected to remain unchanged.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7008-grep-binary.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 26f8319..1c0946f 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -145,4 +145,35 @@ test_expect_success 'grep respects not-binary diff attribute' '
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
+test_expect_success 'grep does not honor textconv' '
+	test_must_fail git grep Qfile
+'
+
+test_expect_failure 'grep --textconv honors textconv' '
+	echo "a:binaryQfile" >expect &&
+	git grep --textconv Qfile >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --no-textconv does not honor textconv' '
+	test_must_fail git grep --no-textconv Qfile
+'
+
+test_expect_failure 'grep --textconv blob honors textconv' '
+	echo "HEAD:a:binaryQfile" >expect &&
+	git grep --textconv Qfile HEAD:a >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.3.rc1.406.gf4dce7e
