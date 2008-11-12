From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/4] git-remote rename: support branches->config migration
Date: Wed, 12 Nov 2008 18:11:03 +0100
Message-ID: <c3744d00a3d612a637cf520d2719492265e4f061.1226508805.git.vmiklos@frugalware.org>
References: <cover.1226508805.git.vmiklos@frugalware.org>
 <95e56b46e30b41af31da86789625c93511f1faef.1226508805.git.vmiklos@frugalware.org>
 <d99804ad3579d4882e8241d9dcaee1b7dd6508af.1226508805.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:12:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0JFt-00065i-Ec
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbYKLRKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbYKLRKN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:10:13 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:50003 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbYKLRKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:10:06 -0500
Received: from vmobile.example.net (dsl5401C37A.pool.t-online.hu [84.1.195.122])
	by yugo.frugalware.org (Postfix) with ESMTPA id 696BE446CD1;
	Wed, 12 Nov 2008 18:10:03 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D421419DB16; Wed, 12 Nov 2008 18:11:04 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <d99804ad3579d4882e8241d9dcaee1b7dd6508af.1226508805.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1226508805.git.vmiklos@frugalware.org>
References: <cover.1226508805.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100772>

This is similar to the remotes->config one, but it makes the
branches->config conversion possible.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-remote.c  |    6 +++++-
 t/t5505-remote.sh |   12 ++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 4fa64a2..5b525c7 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -384,6 +384,8 @@ static int migrate_file(struct remote *remote)
 					remote->fetch_refspec[i], buf.buf);
 	if (remote->origin == REMOTE_REMOTES)
 		path = git_path("remotes/%s", remote->name);
+	else if (remote->origin == REMOTE_BRANCHES)
+		path = git_path("branches/%s", remote->name);
 	if (path && unlink(path))
 		warning("failed to remove '%s'", path);
 	return 0;
@@ -411,7 +413,9 @@ static int mv(int argc, const char **argv)
 	if (!oldremote)
 		die("No such remote: %s", rename.old);
 
-	if (!strcmp(rename.old, rename.new) && oldremote->origin == REMOTE_REMOTES)
+	if (!strcmp(rename.old, rename.new) &&
+			(oldremote->origin == REMOTE_REMOTES ||
+			 oldremote->origin == REMOTE_BRANCHES))
 		return migrate_file(oldremote);
 
 	newremote = remote_get(rename.new);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 1567631..1f59960 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -364,4 +364,16 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
 '
 
+test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
+	git clone one six &&
+	origin_url=$(pwd)/one &&
+	(cd six &&
+	 git remote rm origin &&
+	 echo "$origin_url" > .git/branches/origin &&
+	 git remote rename origin origin &&
+	 ! test -f .git/branches/origin &&
+	 test "$(git config remote.origin.url)" = "$origin_url" &&
+	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
+'
+
 test_done
-- 
1.6.0.2
