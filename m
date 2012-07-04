From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t3404: make test 57 work with dash and others
Date: Wed,  4 Jul 2012 13:32:04 +0200
Message-ID: <40eccb55835575b4a73131d1dced857ba7d4ecc3.1341401445.git.git@drmicha.warpmail.net>
Cc: Chris Webb <chris@arachsys.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 13:32:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmNod-0004ab-6A
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 13:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661Ab2GDLcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 07:32:10 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48371 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752063Ab2GDLcH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2012 07:32:07 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D1E7A20FCF;
	Wed,  4 Jul 2012 07:32:06 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 04 Jul 2012 07:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=nP1vc44Dup+GcDpXsSFdibUJxEQ=; b=JeljFmULwxOWEk+zqgYm
	fsmPFxFZnpeXuI2IP4Q6PsqJufHwFDPUrDVae0V5BJuTSNlbzY/ML9wbjX3PJP2u
	NFzTCGVPGeoR20teMBWDmMdp5sg7QqPmC2G6CX96bTwC6q/OORHMyPhJgrzi86gF
	hjDm6FTCUYVGHPj0IT7nL4U=
X-Sasl-enc: UQoet+IHq1DgtiuDH4/zUo/Um4tdW1ENBPMlBwu8dDzI 1341401526
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 50626483803;
	Wed,  4 Jul 2012 07:32:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.214.g6a2db03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201002>

The construct

VAR=value test_must_fail command args

works only for some shells (such as bash) but not others (such as dash)
because VAR=value does not end up in the environment for command when it
is called by the shell function test_must_fail. That is why we write

( VAR=value &&
export VAR &&
test_must_fail command args)

in most places already, bar the newly introduced 57 from
b64b7fe (Add tests for rebase -i --root without --onto, 2012-06-26).

Make test 57 use that construct also.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t3404-rebase-interactive.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 6ffc9c2..2f060ec 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -777,7 +777,9 @@ test_expect_success 'rebase -i --root retain root commit author and message' '
 
 test_expect_success 'rebase -i --root temporary sentinel commit' '
 	git checkout B &&
-	FAKE_LINES="2" test_must_fail git rebase -i --root &&
+	( FAKE_LINES="2" &&
+	export FAKE_LINES &&
+	test_must_fail git rebase -i --root ) &&
 	git cat-file commit HEAD | grep "^tree 4b825dc642cb" &&
 	git rebase --abort
 '
-- 
1.7.11.1.214.g6a2db03
