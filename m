From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] cg-commit --review may permanently delete changes
Date: Fri, 28 Jul 2006 19:11:52 +0200
Message-ID: <20060728171152.G3a9ef049@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 19:12:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Vsc-00010U-TM
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 19:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbWG1RL5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 13:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbWG1RL5
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 13:11:57 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:13235 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1752051AbWG1RL4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 13:11:56 -0400
Received: from leonov.stosberg.net (p213.54.90.253.tisdip.tiscali.de [213.54.90.253])
	by ncs.stosberg.net (Postfix) with ESMTP id F38C4589C004;
	Fri, 28 Jul 2006 19:11:45 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id C130311B659; Fri, 28 Jul 2006 19:11:52 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Fri, 28 Jul 2006 18:40:12 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24397>

If the patch is changed in the editor in such a way that cg-patch
can not apply it, all changes made since the last commit are
irrecoverably lost, which is _really_ bad.

This patch lets cg-commit reapply the old patch and keep the edited
patch for manual fix-up.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 cg-commit |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/cg-commit b/cg-commit
index 0cec58f..9604ad7 100755
--- a/cg-commit
+++ b/cg-commit
@@ -524,8 +524,11 @@ if [ "$review" ]; then
 		fi
 		echo "Applying the edited patch..."
 		if ! cg-patch < "$PATCH2"; then
-			rm "$PATCH" "$PATCH2" "$LOGMSG"
-			die "unable to apply the edited patch"
+			echo "The edited patch does not apply. Reapplying old patch."
+			cg-patch <"$PATCH" >/dev/null
+			edited_patch="$(mktemp -t edited-patch.XXXXXX)"
+			mv "$PATCH2" "$edited_patch"
+			die "You can find the edited patch in \"$edited_patch\" for manual review."
 		fi
 	fi
 fi
-- 
1.4.1
