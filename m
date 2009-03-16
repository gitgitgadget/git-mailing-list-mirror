From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/2] test-lib.sh: Allow running the test suite against installed git
Date: Mon, 16 Mar 2009 18:03:12 +0100
Message-ID: <1237222992-19421-3-git-send-email-git@drmicha.warpmail.net>
References: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 18:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjGFI-0007qy-R4
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 18:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbZCPRDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 13:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756055AbZCPRDe
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 13:03:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44201 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756039AbZCPRDd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 13:03:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7A63E2F0F0D;
	Mon, 16 Mar 2009 13:03:31 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 16 Mar 2009 13:03:31 -0400
X-Sasl-enc: JMQiDaROAde97y8tM1W2w16kqtz9GwiyzFpncjWRpsTT 1237223010
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D42FC125D3;
	Mon, 16 Mar 2009 13:03:30 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.149.g6462
In-Reply-To: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
In-Reply-To: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
References: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113345>

Introduce variables GIT_TEST_INSTALLED and GIT_TEST_EXEC_PATH such that
the test suite can be run against a git which is installed at
GIT_TEST_INSTALLED with subcommands at GIT_TEST_EXEC_PATH.
GIT_TEST_INSTALLED defaults to the git.git checkout, GIT_TEST_EXEC_PATH
defaults to the output of '$GIT_TEST_INSTALLED/git --exec-path'. Run the
suite e.g. as

GIT_TEST_INSTALLED=/some/path make test

but note that this requires and uses parts of a compiled git in the
git.git checkout: test helpers, templates and perl libraries are taken
from there.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/test-lib.sh |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b9da86e..c677904 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -514,8 +514,16 @@ test_done () {
 TEST_DIRECTORY=$(pwd)
 if test -z "$valgrind"
 then
-	PATH=$TEST_DIRECTORY/..:$PATH
-	GIT_EXEC_PATH=$TEST_DIRECTORY/..
+	if test -z "$GIT_TEST_INSTALLED"
+	then
+		PATH=$TEST_DIRECTORY/..:$PATH
+		GIT_EXEC_PATH=$TEST_DIRECTORY/..
+	else
+		GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
+		error "Cannot run git from $GIT_TEST_INSTALLED."
+		PATH=$GIT_TEST_INSTALLED:$TEST_DIRECTORY/..:$PATH
+		GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
+	fi
 else
 	make_symlink () {
 		test -h "$2" &&
-- 
1.6.2.149.g6462
