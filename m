From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 2/2] git submodule: Fix adding of submodules at paths with ./, .. and //
Date: Tue,  3 Mar 2009 16:08:21 +0100
Message-ID: <1236092901-28500-3-git-send-email-git@drmicha.warpmail.net>
References: <49AD3A29.10404@drmicha.warpmail.net>
 <1236092901-28500-1-git-send-email-git@drmicha.warpmail.net>
 <1236092901-28500-2-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 16:10:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWFw-0007Qn-0R
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbZCCPIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 10:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbZCCPIi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:08:38 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60292 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753069AbZCCPIh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 10:08:37 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A0E7F2D23F2;
	Tue,  3 Mar 2009 10:08:34 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 03 Mar 2009 10:08:34 -0500
X-Sasl-enc: 1Pxo9G2mDdAb0NoceIxWPoQtMP8ZJyAfF/MGWIAmraKJ 1236092913
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EEA2535F71;
	Tue,  3 Mar 2009 10:08:33 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2
In-Reply-To: <1236092901-28500-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112082>

Make 'git submodule add' normalize the submodule path in the
same way as 'git ls-files' does, so that 'git submodule init' looks up
the information in .gitmodules with the same key under which 'git
submodule add' stores it.

This fixes 4 known breakages.
---
 git-submodule.sh           |   15 ++++++++++++---
 t/t7400-submodule-basic.sh |    8 ++++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 204aab6..0a27232 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -167,9 +167,18 @@ cmd_add()
 	;;
 	esac
 
-	# strip trailing slashes from path
-	path=$(echo "$path" | sed -e 's|/*$||')
-
+	# normalize path:
+	# multiple //; leading ./; /./; /../; trailing /
+	path=$(printf '%s/\n' "$path" |
+		sed -e '
+			s|//*|/|g
+			s|^\(\./\)*||
+			s|/\./|/|g
+			:start
+			s|\([^/]*\)/\.\./||
+			tstart
+			s|/*$||
+		')
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 35a0ede..af690ec 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -64,7 +64,7 @@ test_expect_success 'submodule add' '
 	)
 '
 
-test_expect_failure 'submodule add with ./ in path' '
+test_expect_success 'submodule add with ./ in path' '
 	(
 		cd addtest &&
 		git submodule add "$submodurl" ././dotsubmod/./frotz/./ &&
@@ -72,7 +72,7 @@ test_expect_failure 'submodule add with ./ in path' '
 	)
 '
 
-test_expect_failure 'submodule add with // in path' '
+test_expect_success 'submodule add with // in path' '
 	(
 		cd addtest &&
 		git submodule add "$submodurl" slashslashsubmod///frotz// &&
@@ -80,7 +80,7 @@ test_expect_failure 'submodule add with // in path' '
 	)
 '
 
-test_expect_failure 'submodule add with /.. in path' '
+test_expect_success 'submodule add with /.. in path' '
 	(
 		cd addtest &&
 		git submodule add "$submodurl" dotdotsubmod/../realsubmod/frotz/.. &&
@@ -88,7 +88,7 @@ test_expect_failure 'submodule add with /.. in path' '
 	)
 '
 
-test_expect_failure 'submodule add with ./, /.. and // in path' '
+test_expect_success 'submodule add with ./, /.. and // in path' '
 	(
 		cd addtest &&
 		git submodule add "$submodurl" dot/dotslashsubmod/./../..////realsubmod2/a/b/c/d/../../../../frotz//.. &&
-- 
1.6.2.rc2
