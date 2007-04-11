From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] git-clone: Error meaningfully on failed HTTP fetches of HEAD
Date: Thu, 12 Apr 2007 10:05:19 +1200
Message-ID: <11763291192402-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 12 00:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbkwW-0001QO-Aj
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 00:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbXDKWF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 18:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbXDKWF3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 18:05:29 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:53984 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030308AbXDKWF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 18:05:28 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1HbkwR-0002ab-9K; Thu, 12 Apr 2007 10:05:27 +1200
X-Mailer: git-send-email 1.5.1.106.ga32037
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44266>

A common problem when cloning over http is that the repo has
a symlink for HEAD, and apache refuses to serve symlinks by
default.

Without this patch, the clone succeeds as a "bare" and "HEADless"
clone, but does not give any indication that things have gone
wrong.

A bare clone that fails to fetch HEAD will still complete
"successfully". I'm not sure if that's expected/desired. Is a
HEADless repo valid in any situation?

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 git-clone.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 513b574..ef8cd26 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -65,6 +65,11 @@ Perhaps git-update-server-info needs to be run there?"
 	rm -fr "$clone_tmp"
 	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
 	rm -f "$GIT_DIR/REMOTE_HEAD"
+
+	if test -z "$bare" && test ! -f "$GIT_DIR/REMOTE_HEAD"
+	then
+		die "Could not retrieve $1/HEAD - perhaps it is a symlink?"
+	fi
 }
 
 quiet=
-- 
1.5.1.106.ga32037
