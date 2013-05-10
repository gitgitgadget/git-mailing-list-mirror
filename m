From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 1/7] t4030: demonstrate behavior of show with textconv
Date: Fri, 10 May 2013 17:10:10 +0200
Message-ID: <280dde30d949c9c449ecb2b99f020de583c2079b.1368197380.git.git@drmicha.warpmail.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 17:11:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaoys-0006ox-HP
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab3EJPL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:11:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48293 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752663Ab3EJPL2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 May 2013 11:11:28 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4658320CA6;
	Fri, 10 May 2013 11:11:28 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 10 May 2013 11:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=R1
	t5bfmnFMosdEfa7EKa/BddDEc=; b=ujGnvFAzNltBuKlLuiApV8MEcVqK1eUhOc
	34eSwkCzldJ9kdRtQHe8dTHFx6aO18yXEbvre1Xlm+jpc/1t9jJdpNwvGK1M13Fd
	4cNlHAWzDV7OpTdhWjaS6YBoGHykGkzPsoXJ3eZ+8iZ9Qh25/XhH6sH4E6B/WUnz
	HWwm5O8yg=
X-Sasl-enc: RdWf++FnBuyZv/2EZaiSYRmTei+KU4QfqsgakhLTSsNb 1368198687
Received: from localhost (unknown [213.221.117.228])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9D963200182;
	Fri, 10 May 2013 11:11:27 -0400 (EDT)
X-Mailer: git-send-email 1.8.3.rc1.406.gf4dce7e
In-Reply-To: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1368197380.git.git@drmicha.warpmail.net>
References: <cover.1368197380.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223863>

"git show <commit>" honors the --textconv option while "git show <blob>"
does not. Demonstrate this in the test.

Since the current behavior is supposed to stay as is, we expect the
default for "git show <blob>" to remain --no-textconv.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t4030-diff-textconv.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 53ec330..3950fc9 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -58,6 +58,12 @@ test_expect_success 'diff produces text' '
 	test_cmp expect.text actual
 '
 
+test_expect_success 'show commit produces text' '
+	git show HEAD >diff &&
+	find_diff <diff >actual &&
+	test_cmp expect.text actual
+'
+
 test_expect_success 'diff-tree produces binary' '
 	git diff-tree -p HEAD^ HEAD >diff &&
 	find_diff <diff >actual &&
@@ -84,6 +90,24 @@ test_expect_success 'status -v produces text' '
 	git reset --soft HEAD@{1}
 '
 
+test_expect_success 'show blob produces binary' '
+	git show HEAD:file >actual &&
+	printf "\\0\\n\\01\\n" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'show --textconv blob produces text' '
+	git show --textconv HEAD:file >actual &&
+	printf "0\\n1\\n" >expect &&
+	test_cmp expect actual
+'
+
+test_success 'show --no-textconv blob produces binary' '
+	git show --textconv HEAD:file >actual &&
+	printf "\\0\\n\\01\\n" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'grep-diff (-G) operates on textconv data (add)' '
 	echo one >expect &&
 	git log --root --format=%s -G0 >actual &&
-- 
1.8.3.rc1.406.gf4dce7e
