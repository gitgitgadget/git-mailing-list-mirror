From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 4/4] git submodule: Fix handling of // and /.. in paths for added submodules
Date: Wed, 25 Feb 2009 14:26:32 +0100
Message-ID: <1235568392-19705-5-git-send-email-git@drmicha.warpmail.net>
References: <49A541D3.4030001@viscovery.net>
 <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-2-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-3-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-4-git-send-email-git@drmicha.warpmail.net>
Cc: Andrei Thorp <garoth@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 14:29:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcJpH-00029T-A8
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 14:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756331AbZBYN05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 08:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756290AbZBYN0z
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 08:26:55 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51537 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756331AbZBYN0w (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 08:26:52 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C0DF42A2811;
	Wed, 25 Feb 2009 08:26:49 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 25 Feb 2009 08:26:49 -0500
X-Sasl-enc: ZuvsUO9co1Fgu8gnrSzBwfzsQu9drU2whQFcgGzi/QHP 1235568409
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1C089AF66;
	Wed, 25 Feb 2009 08:26:48 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc1.30.gd43c
In-Reply-To: <1235568392-19705-4-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111456>

This hopefully brings "git submodule add"'s parsing of paths in line
with "git submodule init"'s (which uses "git ls-files"), at least for
practical purposes.

It fixes 2 known breakages which are marked "success" now.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-submodule.sh           |    6 ++++++
 t/t7400-submodule-basic.sh |    4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4f26be4..375362e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -167,6 +167,12 @@ cmd_add()
 	;;
 	esac
 
+	# simplify multiple /
+	path=$(echo "$path" | sed -e 's|/\+|/|g')
+
+	# resolve /.. (add trailing / for matching /..$)
+	path=$(echo "$path/" | sed -e 's|\([^/]*\)/../||g')
+
 	# strip superfluous ./ from path
 	path=$(echo "$path" | sed -e 's|^\(\./\)*||' -e's|/\./|/|g')
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 21bdfeb..473d0e8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -64,12 +64,12 @@ test_expect_success 'submodule add with ./ in path' '
 	git submodule init
 '
 
-test_expect_failure 'submodule add with // in path' '
+test_expect_success 'submodule add with // in path' '
 	git submodule add "$submodurl" slashslashsubmod///frotz// &&
 	git submodule init
 '
 
-test_expect_failure 'submodule add with /.. in path' '
+test_expect_success 'submodule add with /.. in path' '
 	git submodule add "$submodurl" dotdotsubmod/../realsubmod/frotz/.. &&
 	git submodule init
 '
-- 
1.6.2.rc1.30.gd43c
