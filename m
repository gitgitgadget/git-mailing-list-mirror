From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] git submodule: Fix adding of submodules at paths with ./
Date: Wed, 25 Feb 2009 12:03:40 +0100
Message-ID: <1235559820-3096-3-git-send-email-git@drmicha.warpmail.net>
References: <80055d7c0902241556s4d24285bqd171275f58bdb37d@mail.gmail.com>
 <1235559820-3096-1-git-send-email-git@drmicha.warpmail.net>
 <1235559820-3096-2-git-send-email-git@drmicha.warpmail.net>
Cc: Andrei Thorp <garoth@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 12:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcHaW-0000te-3I
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 12:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760967AbZBYLD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 06:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760882AbZBYLD6
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 06:03:58 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36574 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760829AbZBYLDz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 06:03:55 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id E19932A5950;
	Wed, 25 Feb 2009 06:03:53 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 25 Feb 2009 06:03:53 -0500
X-Sasl-enc: 3WM4b6xzEKePl7PUT3lN1IKBBBycXOtvBhqyj6utO7iP 1235559833
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5306E2B96C;
	Wed, 25 Feb 2009 06:03:53 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc1.30.gd43c
In-Reply-To: <1235559820-3096-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111444>

Make 'git submodule add' strip './' from the submodule path in the same
way as 'git ls-files' does, so that 'git submodule init' looks up the
information in .gitmodules with the same key under which 'git submodule
add' stores it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
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
