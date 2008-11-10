From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/4] git-remote rename: support branches->config migration
Date: Mon, 10 Nov 2008 21:43:02 +0100
Message-ID: <b32cf68df41e417079a49dc02e46ffc0c571029b.1226349595.git.vmiklos@frugalware.org>
References: <cover.1226349595.git.vmiklos@frugalware.org>
 <95e56b46e30b41af31da86789625c93511f1faef.1226349595.git.vmiklos@frugalware.org>
 <033bc63195299e494791e4e6d8a41f142d848bba.1226349595.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:43:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzdc3-0003ug-LO
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbYKJUmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYKJUmO
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:42:14 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57753 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbYKJUmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:42:07 -0500
Received: from vmobile.example.net (dsl5401C2D3.pool.t-online.hu [84.1.194.211])
	by yugo.frugalware.org (Postfix) with ESMTPA id 56DF7446CD0;
	Mon, 10 Nov 2008 21:42:04 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B349D19DB15; Mon, 10 Nov 2008 21:43:04 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <033bc63195299e494791e4e6d8a41f142d848bba.1226349595.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1226349595.git.vmiklos@frugalware.org>
References: <cover.1226349595.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100568>

This is similar to the remotes->config one, but it makes the
branches->config conversion possible.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-remote.c  |    2 ++
 t/t5505-remote.sh |   12 ++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index d9d0ba3..3af1876 100644
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
