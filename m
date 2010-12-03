From: Russell Yanofsky <russ@yanofsky.org>
Subject: [PATCH 1/1] git-submodule.sh: fix relative paths with ssh urls
Date: Thu,  2 Dec 2010 21:53:41 -0500
Message-ID: <1291344821-20964-1-git-send-email-russ@yanofsky.org>
Cc: Russell Yanofsky <russ@yanofsky.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 04:02:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POLuO-0007qW-AN
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 04:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758428Ab0LCDB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 22:01:26 -0500
Received: from mail.yanofsky.org ([66.197.174.29]:32995 "EHLO
	mail.yanofsky.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758407Ab0LCDB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 22:01:26 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2010 22:01:26 EST
Received: from toaster.earthlink.net (user-12ld9hv.cable.mindspring.com [69.86.166.63])
	(Authenticated sender: russ@yanofsky.org)
	by mail.yanofsky.org (Postfix) with ESMTPA id 5C532124C006;
	Fri,  3 Dec 2010 02:53:47 +0000 (UTC)
X-Mailer: git-send-email 1.7.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162761>

Fix handling of submodule urls starting with ../ when the remote url is
an scp-style URL with the format user@host.xz:repo.git. For example, if
the remote url is user@host.xz:repo.git and the submodule URL is
../submodule.git, the combined default URL will now be
user@host.xz:submodule.git instead of
user@host.xz:repo.git/submodule.git.
---
 git-submodule.sh |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c291eed..533cf5d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -36,13 +36,25 @@ resolve_relative_url ()
 	remoteurl=$(git config "remote.$remote.url") ||
 		die "remote ($remote) does not have a url defined in .git/config"
 	url="$1"
+	sep="/"
 	remoteurl=${remoteurl%/}
 	while test -n "$url"
 	do
 		case "$url" in
 		../*)
 			url="${url#../}"
-			remoteurl="${remoteurl%/*}"
+			remoteparent="${remoteurl%/*}"
+			if test "$remoteparent" != "$remoteurl"
+			then
+				remoteurl="$remoteparent"
+			else
+				remoteparent="${remoteurl%:*}"
+				if test "$remoteparent" != "$remoteurl"
+				then
+					remoteurl="$remoteparent"
+					sep=":"
+				fi
+			fi
 			;;
 		./*)
 			url="${url#./}"
@@ -51,7 +63,7 @@ resolve_relative_url ()
 			break;;
 		esac
 	done
-	echo "$remoteurl/${url%/}"
+	echo "$remoteurl$sep${url%/}"
 }
 
 #
-- 
1.7.3.2
