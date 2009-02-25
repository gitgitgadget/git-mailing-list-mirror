From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] git submodule: Add test cases for git submodule add
Date: Wed, 25 Feb 2009 12:03:39 +0100
Message-ID: <1235559820-3096-2-git-send-email-git@drmicha.warpmail.net>
References: <80055d7c0902241556s4d24285bqd171275f58bdb37d@mail.gmail.com>
 <1235559820-3096-1-git-send-email-git@drmicha.warpmail.net>
Cc: Andrei Thorp <garoth@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 12:06:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcHaV-0000te-BB
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 12:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760832AbZBYLD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 06:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760825AbZBYLDz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 06:03:55 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45899 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760774AbZBYLDy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 06:03:54 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id E09832A4B81;
	Wed, 25 Feb 2009 06:03:51 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 25 Feb 2009 06:03:51 -0500
X-Sasl-enc: OY+kToVhaJ/8BKg8R1gQmg7DIP38U2cktu0yGaLkC1OD 1235559831
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 404CAAD9D;
	Wed, 25 Feb 2009 06:03:51 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc1.30.gd43c
In-Reply-To: <1235559820-3096-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111446>

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
