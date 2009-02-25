From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/4] git submodule: Add test cases for git submodule add
Date: Wed, 25 Feb 2009 14:26:29 +0100
Message-ID: <1235568392-19705-2-git-send-email-git@drmicha.warpmail.net>
References: <49A541D3.4030001@viscovery.net>
 <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net>
Cc: Andrei Thorp <garoth@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 14:28:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcJo6-0001ls-W1
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 14:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266AbZBYN0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 08:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756246AbZBYN0r
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 08:26:47 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60630 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756046AbZBYN0p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 08:26:45 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A6E7C2A62DF;
	Wed, 25 Feb 2009 08:26:43 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 25 Feb 2009 08:26:43 -0500
X-Sasl-enc: csqGwap6TiW1ubaQOWTqb+v2Hd2aEzyGW2dw3YRSOS75 1235568403
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 14F193B349;
	Wed, 25 Feb 2009 08:26:42 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc1.30.gd43c
In-Reply-To: <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111453>

Add two simple test cases for adding and initialising submodules. The
init step is necessary in order to verify the added information.

The second test exposes a known breakage due to './' in the path: git
ls-files simplifies the path but git add does not, which leads to git
init looking for different lines in .gitmodules than git add adds.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Note: Tests for add and init are somewhat interdependent in the sense
that you need either in order to test success for the other. I put the
add tests first because you need to add a submodule before you can init
it.

 t/t7400-submodule-basic.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b8cb2df..b154050 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -47,6 +47,25 @@ test_expect_success 'Prepare submodule testing' '
 	GIT_CONFIG=.gitmodules git config submodule.example.url git://example.com/init.git
 '
 
+test_expect_success 'Prepare submodule add testing' '
+	submodurl=$(pwd)
+	mkdir addtest &&
+	pushd addtest &&
+	git init
+'
+
+test_expect_success 'submodule add' '
+	git submodule add "$submodurl" submod &&
+	git submodule init
+'
+
+test_expect_failure 'submodule add with ./ in path' '
+	git submodule add "$submodurl" ././dotsubmod/./frotz/./ &&
+	git submodule init
+'
+# end of submodule add testing
+popd >/dev/null
+
 test_expect_success 'status should fail for unmapped paths' '
 	if git submodule status
 	then
-- 
1.6.2.rc1.30.gd43c
