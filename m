From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] remote: fix "update [group...]"
Date: Tue, 4 Mar 2008 00:30:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803040029440.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 04 01:32:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWL5I-0001kn-6i
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 01:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758332AbYCDAbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 19:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968AbYCDAbg
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 19:31:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:39199 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759501AbYCDAbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 19:31:32 -0500
Received: (qmail invoked by alias); 04 Mar 2008 00:31:29 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp009) with SMTP; 04 Mar 2008 01:31:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wSQdJdCDwkchQ5FTYMgCjX6vHT6w7XlicAdxk+a
	Sop3qqUJJBnWrJ
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76005>


The rewrite in C inadvertently broke updating with remote groups: when you
pass parameters to "git remote update", it used to look up "remotes.<group>"
for every parameter, and interpret the value as a list of remotes to update.

Also, no parameter, or a single parameter "default" should update all
remotes that have not been marked with "skipDefaultUpdate".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I only realised the breakage today, sorry.

 builtin-remote.c  |   53 ++++++++++++++++++++++++++++++++------
 t/t5505-remote.sh |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 9 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index fc01bcc..4d2ca16 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -477,24 +477,59 @@ cleanup_states:
 	return result;
 }
 
-static int update_one(struct remote *remote, void *priv)
+static int get_one_remote_for_update(struct remote *remote, void *priv)
 {
+	struct path_list *list = priv;
 	if (!remote->skip_default_update)
-		return fetch_remote(remote->name);
+		path_list_append(xstrdup(remote->name), list);
+	return 0;
+}
+
+struct remote_group {
+	const char *name;
+	struct path_list *list;
+} remote_group;
+
+static int get_remote_group(const char *key, const char *value)
+{
+	if (!prefixcmp(key, "remotes.") &&
+			!strcmp(key + 8, remote_group.name)) {
+		char *space = strchr(value, ' ');
+		while (space) {
+			path_list_append(xstrndup(value, space - value),
+					remote_group.list);
+			value = space + 1;
+			space = strchr(value, ' ');
+		}
+		path_list_append(xstrdup(value), remote_group.list);
+	}
+
 	return 0;
 }
 
 static int update(int argc, const char **argv)
 {
-	int i;
+	int i, result = 0;
+	struct path_list list = { NULL, 0, 0, 0 };
 
-	if (argc < 2)
-		return for_each_remote(update_one, NULL);
+	if (argc < 2 || (argc == 2 && !strcmp(argv[1], "default")))
+		result = for_each_remote(get_one_remote_for_update, &list);
+	else {
+		remote_group.list = &list;
+		for (i = 1; i < argc; i++) {
+			remote_group.name = argv[i];
+			result = git_config(get_remote_group);
+		}
+	}
+	if (result)
+		return result;
 
-	for (i = 1; i < argc; i++)
-		if (fetch_remote(argv[i]))
-			return 1;
-	return 0;
+	for (i = 0; i < list.nr; i++)
+		result |= fetch_remote(list.items[i].path);
+	list.strdup_paths = 1;
+	path_list_clear(&list, 0);
+
+	return result;
 }
 
 static int get_one_entry(struct remote *remote, void *priv)
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0a25c8b..b9757c0 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -10,10 +10,12 @@ setup_repository () {
 	git init &&
 	>file &&
 	git add file &&
+	test_tick &&
 	git commit -m "Initial" &&
 	git checkout -b side &&
 	>elif &&
 	git add elif &&
+	test_tick &&
 	git commit -m "Second" &&
 	git checkout master
 	)
@@ -113,6 +115,7 @@ test_expect_success 'show' '
 	 git branch -d -r origin/master &&
 	 (cd ../one &&
 	  echo 1 > file &&
+	  test_tick &&
 	  git commit -m update file) &&
 	 git remote show origin > output &&
 	 git diff expect output)
@@ -144,4 +147,73 @@ test_expect_success 'add --mirror && prune' '
 	 git rev-parse --verify refs/heads/side)
 '
 
+cat > one/expect << EOF
+  apis/master
+  apis/side
+  drosophila/another
+  drosophila/master
+  drosophila/side
+EOF
+
+test_expect_success 'update' '
+
+	(cd one &&
+	 git remote add drosophila ../two &&
+	 git remote add apis ../mirror &&
+	 git remote update &&
+	 git branch -r > output &&
+	 git diff expect output)
+
+'
+
+cat > one/expect << EOF
+  drosophila/another
+  drosophila/master
+  drosophila/side
+  manduca/master
+  manduca/side
+  megaloprepus/master
+  megaloprepus/side
+EOF
+
+test_expect_success 'update with arguments' '
+
+	(cd one &&
+	 for b in $(git branch -r)
+	 do
+		git branch -r -d $b || break
+	 done &&
+	 git remote add manduca ../mirror &&
+	 git remote add megaloprepus ../mirror &&
+	 git config remotes.phobaeticus "drosophila megaloprepus" &&
+	 git config remotes.titanus manduca &&
+	 git remote update phobaeticus titanus &&
+	 git branch -r > output &&
+	 git diff expect output)
+
+'
+
+cat > one/expect << EOF
+  apis/master
+  apis/side
+  manduca/master
+  manduca/side
+  megaloprepus/master
+  megaloprepus/side
+EOF
+
+test_expect_success 'update default' '
+
+	(cd one &&
+	 for b in $(git branch -r)
+	 do
+		git branch -r -d $b || break
+	 done &&
+	 git config remote.drosophila.skipDefaultUpdate true &&
+	 git remote update default &&
+	 git branch -r > output &&
+	 git diff expect output)
+
+'
+
 test_done
-- 
1.5.4.3.542.g98d7c

