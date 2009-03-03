From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 1/2] git submodule: Add test cases for git submodule add
Date: Tue,  3 Mar 2009 16:08:20 +0100
Message-ID: <1236092901-28500-2-git-send-email-git@drmicha.warpmail.net>
References: <49AD3A29.10404@drmicha.warpmail.net>
 <1236092901-28500-1-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 16:10:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWFv-0007Qn-7Z
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbZCCPIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 10:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZCCPIf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:08:35 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56699 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858AbZCCPIe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 10:08:34 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7F23F2D2F62;
	Tue,  3 Mar 2009 10:08:32 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 03 Mar 2009 10:08:32 -0500
X-Sasl-enc: bYyfAG2TXgLQaIO5x/pjYKYv1UeagY5Fh6XrKojUBTbi 1236092911
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C8D201529D;
	Tue,  3 Mar 2009 10:08:31 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2
In-Reply-To: <1236092901-28500-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112081>

Add simple test cases for adding and initialising submodules. The
init step is necessary in order to verify the added information.

The second test exposes a known breakage due to './' in the path: git
ls-files simplifies the path but git add does not, which leads to git
init looking for different lines in .gitmodules than git add adds.

The other tests add test cases for '//' and '..' in the path which
currently fail for the same reason.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7400-submodule-basic.sh |   49 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b8cb2df..35a0ede 100755
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
+		git submodule add "$submodurl" dot/dotslashsubmod/./../..////realsubmod2/a/b/c/d/../../../../frotz//.. &&
+		git submodule init
+	)
+'
+
 test_expect_success 'status should fail for unmapped paths' '
 	if git submodule status
 	then
-- 
1.6.2.rc2
