From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/4] git-remote rename: support remotes->config migration
Date: Wed, 12 Nov 2008 18:11:02 +0100
Message-ID: <d99804ad3579d4882e8241d9dcaee1b7dd6508af.1226508805.git.vmiklos@frugalware.org>
References: <cover.1226508805.git.vmiklos@frugalware.org>
 <95e56b46e30b41af31da86789625c93511f1faef.1226508805.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:12:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0JFs-00065i-ND
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbYKLRKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbYKLRKM
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:10:12 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:50006 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbYKLRKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:10:06 -0500
Received: from vmobile.example.net (dsl5401C37A.pool.t-online.hu [84.1.195.122])
	by yugo.frugalware.org (Postfix) with ESMTPA id 66BAB446CD0;
	Wed, 12 Nov 2008 18:10:03 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 9B1AC19DB14; Wed, 12 Nov 2008 18:11:04 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <95e56b46e30b41af31da86789625c93511f1faef.1226508805.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1226508805.git.vmiklos@frugalware.org>
References: <cover.1226508805.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100771>

This patch makes it possible to migrate a remote stored in a
$GIT_DIR/remotes/nick file to the configuration file format.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-remote.c  |   33 +++++++++++++++++++++++++++++++++
 t/t5505-remote.sh |   21 +++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 1ca6cdb..4fa64a2 100644
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
 
+	if (!strcmp(rename.old, rename.new) && oldremote->origin == REMOTE_REMOTES)
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
