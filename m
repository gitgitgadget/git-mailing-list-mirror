From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 2/2] git submodule: Fix adding of submodules at paths with ./, .. and //
Date: Tue,  3 Mar 2009 13:39:49 +0100
Message-ID: <1236083989-20526-3-git-send-email-git@drmicha.warpmail.net>
References: <7vtz6ht9ho.fsf@gitster.siamese.dyndns.org>
 <1236083989-20526-1-git-send-email-git@drmicha.warpmail.net>
 <1236083989-20526-2-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 13:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeTwS-0006TI-14
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 13:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbZCCMkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 07:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbZCCMkK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 07:40:10 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59386 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904AbZCCMkF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 07:40:05 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 8FD292D31FC;
	Tue,  3 Mar 2009 07:40:03 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 03 Mar 2009 07:40:03 -0500
X-Sasl-enc: ojSjTkurERDClogJG2Oa+QSxiXTr6O2V3jQW/nh4r1nP 1236084002
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CA0C447F23;
	Tue,  3 Mar 2009 07:40:02 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2
In-Reply-To: <1236083989-20526-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112067>

Make 'git submodule add' normalize the submodule path in the
same way as 'git ls-files' does, so that 'git submodule init' looks up
the information in .gitmodules with the same key under which 'git
submodule add' stores it.

This fixes 4 known breakages.
---
Note that sed on AIX does not like comments, which is why they are not
in the sed expression.

 git-submodule.sh           |   15 ++++++++++++---
 t/t7400-submodule-basic.sh |    8 ++++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 204aab6..7a25f47 100755
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
+			s|\([^/]*\)/\.\./||g
+			tstart
+			s|/*$||
+		')
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 4f42585..1c82f8c 100755
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
 		git submodule add "$submodurl" dot/dotslashsubmod/./../..////realsubmod2/frotz//.. &&
-- 
1.6.2.rc2
