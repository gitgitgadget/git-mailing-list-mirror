From: Bryan Drewery <bryan@shatow.net>
Subject: [PATCH] Fix git-push --mirror also mirroring refs/remotes/
Date: Sun, 10 May 2009 14:35:36 -0500
Message-ID: <1241984136-2578-1-git-send-email-bryan@shatow.net>
Cc: Bryan Drewery <bryan@shatow.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 22:16:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3FS1-0004Vt-Ra
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 22:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbZEJUQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 16:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbZEJUQe
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 16:16:34 -0400
Received: from data.xzibition.com ([64.18.130.122]:59455 "EHLO
	data.xzibition.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbZEJUQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 16:16:34 -0400
X-Greylist: delayed 2454 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 May 2009 16:16:33 EDT
Received: from 209-240-91-84.static.iphouse.net
	([209.240.91.84] helo=localhost.localdomain ident=bryan)
	by data.xzibition.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <bryan@shatow.net>)
	id 1M3EoP-0006Qx-Ic; Sun, 10 May 2009 15:35:49 -0400
X-Mailer: git-send-email 1.6.2.5
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - data.xzibition.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [26 6] / [26 6]
X-AntiAbuse: Sender Address Domain - shatow.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118742>

git-push --mirror was incorrectly mirroring refs/remotes/
previously. This patch fixes it to follow the documentation
which is to mirror only refs/heads/ and refs/tags/.

Signed-off-by: Bryan Drewery <bryan@shatow.net>
---
 remote.c               |    4 +++-
 t/t5517-push-mirror.sh |   21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index d66e2f3..70cfab8 100644
--- a/remote.c
+++ b/remote.c
@@ -1123,8 +1123,10 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 			 * "matching refs"; traditionally we pushed everything
 			 * including refs outside refs/heads/ hierarchy, but
 			 * that does not make much sense these days.
+			 * Push only refs/heads/ and refs/tags/ when mirroring
+			 * otherwise only matching refs/heads/
 			 */
-			if (!send_mirror && prefixcmp(src->name, "refs/heads/"))
+			if ((!send_mirror || prefixcmp(src->name, "refs/tags/")) && prefixcmp(src->name, "refs/heads/"))
 				continue;
 			dst_name = xstrdup(src->name);
 
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index ea49ded..3fc7dc2 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -264,4 +264,25 @@ test_expect_success 'remote.foo.mirror=no has no effect' '
 
 '
 
+# REMOTES test
+test_expect_success 'push mirror does not push remotes' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git push --mirror up &&
+		git remote update &&
+		git push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master" &&
+	(
+		cd mirror &&
+		invert git show-ref -s --verify refs/remotes/up/master
+	)
+'
+
+
 test_done
-- 
1.6.2.5
