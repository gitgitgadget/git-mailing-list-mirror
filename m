From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-am: Keep index in case of abort with dirty index
Date: Thu, 26 Feb 2009 10:52:53 +0100
Message-ID: <1235641973-18307-1-git-send-email-git@drmicha.warpmail.net>
References: <7v8wnu2x67.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 10:54:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lccws-0006IE-HA
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 10:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbZBZJxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 04:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbZBZJxF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 04:53:05 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57327 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751562AbZBZJxD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 04:53:03 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 84C7E2A4690;
	Thu, 26 Feb 2009 04:53:01 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 26 Feb 2009 04:53:01 -0500
X-Sasl-enc: 8YHwsxb2l4KC6bMKAFnAWS/eM0mJu25Q3ypUprAQ8qOH 1235641980
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E02A213C06;
	Thu, 26 Feb 2009 04:53:00 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc1.30.gd43c
In-Reply-To: <7v8wnu2x67.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111546>

git am --abort resets the index unconditionally. But in case a previous
git am exited due to a dirty index it is preferable to keep that index.
Make it so.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Something like this?

 git-am.sh |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 8bcb206..7013fea 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -230,8 +230,10 @@ then
 		;;
 	,t)
 		git rerere clear
-		git read-tree --reset -u HEAD ORIG_HEAD
-		git reset ORIG_HEAD
+		test -f "$dotest/dirtyindex" || {
+			git read-tree --reset -u HEAD ORIG_HEAD
+			git reset ORIG_HEAD
+		}
 		rm -fr "$dotest"
 		exit ;;
 	esac
@@ -287,7 +289,11 @@ fi
 case "$resolved" in
 '')
 	files=$(git diff-index --cached --name-only HEAD --) || exit
-	test "$files" && die "Dirty index: cannot apply patches (dirty: $files)"
+	if test "$files"
+	then
+		: >"$dotest/dirtyindex"
+		die "Dirty index: cannot apply patches (dirty: $files)"
+	fi
 esac
 
 if test "$(cat "$dotest/utf8")" = t
-- 
1.6.2.rc1.30.gd43c
