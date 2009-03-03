From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 1/2] git submodule: Add test cases for git submodule add
Date: Tue,  3 Mar 2009 13:39:48 +0100
Message-ID: <1236083989-20526-2-git-send-email-git@drmicha.warpmail.net>
References: <7vtz6ht9ho.fsf@gitster.siamese.dyndns.org>
 <1236083989-20526-1-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 13:41:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeTwR-0006TI-8f
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 13:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbZCCMkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 07:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbZCCMkE
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 07:40:04 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40334 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751637AbZCCMkD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 07:40:03 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 6A7FE2D31E9;
	Tue,  3 Mar 2009 07:40:01 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 03 Mar 2009 07:40:01 -0500
X-Sasl-enc: rXOJcv3p8NM5ZVCvmYc38vlHvuaNtkbv13FSvNfijaUM 1236084000
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8B3681A02E;
	Tue,  3 Mar 2009 07:40:00 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2
In-Reply-To: <1236083989-20526-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112065>

Add simple test cases for adding and initialising submodules. The
init step is necessary in order to verify the added information.

The second test exposes a known breakage due to './' in the path: git
ls-files simplifies the path but git add does not, which leads to git
init looking for different lines in .gitmodules than git add adds.

The other tests add test cases for '//' and '..' in the path which
currently fail for the same reason.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
The init step test implicitly whether add and init treat the path in the
same way.

 t/t7400-submodule-basic.sh |   49 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b8cb2df..4f42585 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -47,6 +47,55 @@ test_expect_success 'Prepare submodule testing' '
 	GIT_CONFIG=.gitmodules git config submodule.example.url git://example.com/init.git
 '
 
+test_expect_success 'Prepare submodule add testing' '
+	submodurl=$(pwd)
+	(
+		mkdir addtest &&
+		cd addtest &&
+		git init
+	)
+'
+
+test_expect_success 'submodule add' '
+	(
+		cd addtest &&
+		git submodule add "$submodurl" submod &&
+		git submodule init
+	)
+'
+
+test_expect_failure 'submodule add with ./ in path' '
+	(
+		cd addtest &&
+		git submodule add "$submodurl" ././dotsubmod/./frotz/./ &&
+		git submodule init
+	)
+'
+
+test_expect_failure 'submodule add with // in path' '
+	(
+		cd addtest &&
+		git submodule add "$submodurl" slashslashsubmod///frotz// &&
+		git submodule init
+	)
+'
+
+test_expect_failure 'submodule add with /.. in path' '
+	(
+		cd addtest &&
+		git submodule add "$submodurl" dotdotsubmod/../realsubmod/frotz/.. &&
+		git submodule init
+	)
+'
+
+test_expect_failure 'submodule add with ./, /.. and // in path' '
+	(
+		cd addtest &&
+		git submodule add "$submodurl" dot/dotslashsubmod/./../..////realsubmod2/frotz//.. &&
+		git submodule init
+	)
+'
+
 test_expect_success 'status should fail for unmapped paths' '
 	if git submodule status
 	then
-- 
1.6.2.rc2
