From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/4] git submodule: Fix adding of submodules at paths with ./
Date: Wed, 25 Feb 2009 14:26:30 +0100
Message-ID: <1235568392-19705-3-git-send-email-git@drmicha.warpmail.net>
References: <49A541D3.4030001@viscovery.net>
 <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-2-git-send-email-git@drmicha.warpmail.net>
Cc: Andrei Thorp <garoth@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 14:28:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcJo7-0001ls-OO
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 14:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291AbZBYN0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 08:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756267AbZBYN0t
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 08:26:49 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40771 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756236AbZBYN0r (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 08:26:47 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B10FD2A6122;
	Wed, 25 Feb 2009 08:26:45 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 25 Feb 2009 08:26:45 -0500
X-Sasl-enc: by8GrUhxAuORllqgZg4vLRLzYzRjxekulAhP8TYYpEx1 1235568405
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 17C7DAF66;
	Wed, 25 Feb 2009 08:26:44 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc1.30.gd43c
In-Reply-To: <1235568392-19705-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111454>

Make 'git submodule add' strip './' from the submodule path in the same
way as 'git ls-files' does, so that 'git submodule init' looks up the
information in .gitmodules with the same key under which 'git submodule
add' stores it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Note that the init step implicitly tests whether add recorded the correct path.
 
   git-submodule.sh           |    3 +++
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 204aab6..4f26be4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -167,6 +167,9 @@ cmd_add()
 	;;
 	esac
 
+	# strip superfluous ./ from path
+	path=$(echo "$path" | sed -e 's|^\(\./\)*||' -e's|/\./|/|g')
+
 	# strip trailing slashes from path
 	path=$(echo "$path" | sed -e 's|/*$||')
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b154050..1757732 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -59,7 +59,7 @@ test_expect_success 'submodule add' '
 	git submodule init
 '
 
-test_expect_failure 'submodule add with ./ in path' '
+test_expect_success 'submodule add with ./ in path' '
 	git submodule add "$submodurl" ././dotsubmod/./frotz/./ &&
 	git submodule init
 '
-- 
1.6.2.rc1.30.gd43c
