From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/4] git-remote rename: support remotes->config migration
Date: Mon, 10 Nov 2008 21:43:01 +0100
Message-ID: <033bc63195299e494791e4e6d8a41f142d848bba.1226349595.git.vmiklos@frugalware.org>
References: <cover.1226349595.git.vmiklos@frugalware.org>
 <95e56b46e30b41af31da86789625c93511f1faef.1226349595.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzdc4-0003ug-Cq
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbYKJUmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYKJUmQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:42:16 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57755 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbYKJUmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:42:07 -0500
Received: from vmobile.example.net (dsl5401C2D3.pool.t-online.hu [84.1.194.211])
	by yugo.frugalware.org (Postfix) with ESMTPA id 37E82446CCF;
	Mon, 10 Nov 2008 21:42:04 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 516A119DB14; Mon, 10 Nov 2008 21:43:04 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <95e56b46e30b41af31da86789625c93511f1faef.1226349595.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1226349595.git.vmiklos@frugalware.org>
References: <cover.1226349595.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100569>

This patch makes it possible to migrate a remote stored in a
$GIT_DIR/remotes/nick file to the configuration file format.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-remote.c  |   33 +++++++++++++++++++++++++++++++++
 t/t5505-remote.sh |   21 +++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 1ca6cdb..d9d0ba3 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -359,6 +359,36 @@ static int read_remote_branches(const char *refname,
 	return 0;
 }
 
+static int migrate_file(struct remote *remote)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+	char *path = NULL;
+
+	strbuf_addf(&buf, "remote.%s.url", remote->name);
+	for (i = 0; i < remote->url_nr; i++)
+		if (git_config_set_multivar(buf.buf, remote->url[i], "^$", 0))
+			return error("Could not append '%s' to '%s'",
+					remote->url[i], buf.buf);
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "remote.%s.push", remote->name);
+	for (i = 0; i < remote->push_refspec_nr; i++)
+		if (git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0))
+			return error("Could not append '%s' to '%s'",
+					remote->push_refspec[i], buf.buf);
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
+	for (i = 0; i < remote->fetch_refspec_nr; i++)
+		if (git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0))
+			return error("Could not append '%s' to '%s'",
+					remote->fetch_refspec[i], buf.buf);
+	if (remote->origin == REMOTE_REMOTES)
+		path = git_path("remotes/%s", remote->name);
+	if (path && unlink(path))
+		warning("failed to remove '%s'", path);
+	return 0;
+}
+
 static int mv(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -381,6 +411,9 @@ static int mv(int argc, const char **argv)
 	if (!oldremote)
 		die("No such remote: %s", rename.old);
 
+	if (!strcmp(rename.old, rename.new) && oldremote->origin != REMOTE_CONFIG)
+		return migrate_file(oldremote);
+
 	newremote = remote_get(rename.new);
 	if (newremote && (newremote->url_nr > 1 || newremote->fetch_refspec_nr))
 		die("remote %s already exists.", rename.new);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0c956ba..1567631 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -343,4 +343,25 @@ test_expect_success 'rename a remote' '
 	 test "$(git config branch.master.remote)" = "upstream")
 
 '
+
+cat > remotes_origin << EOF
+URL: $(pwd)/one
+Push: refs/heads/master:refs/heads/upstream
+Pull: refs/heads/master:refs/heads/origin
+EOF
+
+test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
+	git clone one five &&
+	origin_url=$(pwd)/one &&
+	(cd five &&
+	 git remote rm origin &&
+	 mkdir -p .git/remotes &&
+	 cat ../remotes_origin > .git/remotes/origin &&
+	 git remote rename origin origin &&
+	 ! test -f .git/remotes/origin &&
+	 test "$(git config remote.origin.url)" = "$origin_url" &&
+	 test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
+	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
+'
+
 test_done
-- 
1.6.0.2
