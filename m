From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 3/4] Server-side support for user-relative paths.
Date: Tue,  1 Nov 2005 23:59:21 +0100 (CET)
Message-ID: <20051101225921.3835C5BF73@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 02 00:00:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX56F-0003RJ-Dm
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 23:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVKAW7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 17:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVKAW7X
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 17:59:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:48876 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751395AbVKAW7W
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 17:59:22 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 666736BD14
	for <git@vger.kernel.org>; Tue,  1 Nov 2005 23:59:21 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 3835C5BF73; Tue,  1 Nov 2005 23:59:21 +0100 (CET)
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10964>

Remove the redundant code from {receive,upload}-pack.c in favour of the
library code in path.c (previous patch) with documentation of the changes
to the affected programs.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/pull-fetch-param.txt |   35 +++++++++++++++++++++++++++--------
 receive-pack.c                     |   13 ++-----------
 upload-pack.c                      |   13 ++-----------
 3 files changed, 31 insertions(+), 30 deletions(-)

applies-to: 17cf0474b857a396561f2def13ac6ac6b01e1e33
dd1ddd3d653b28bd57092f0e243efa545cd214d3
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index e8db9d7..33ee02e 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -1,16 +1,35 @@
 <repository>::
-	The "remote" repository to pull from.  One of the
-	following notations can be used to name the repository
-	to pull from:
+	The repository to pull/fetch from or push to.  The following
+	notations can be used to name the repository:
 +
 ===============================================================
-- Rsync URL:		rsync://remote.machine/path/to/repo.git/
-- HTTP(s) URL:		http://remote.machine/path/to/repo.git/
-- git URL:		git://remote.machine/path/to/repo.git/
-			or remote.machine:/path/to/repo.git/
-- Local directory:	/path/to/repo.git/
+- rsync://host.xz/path/to/repo.git/
+- http://host.xz/path/to/repo.git/
+- https://host.xz/path/to/repo.git/
+- git://host.xz/path/to/repo.git/
+- git://host.xz/~user/path/to/repo.git/
+- ssh://host.xz/path/to/repo.git/
+- ssh://host.xz/~user/path/to/repo.git/
 ===============================================================
 +
+	SSH Is the default transport protocol and also supports an
+	scp-like syntax.  Both syntaxes support username expansion,
+	as does the git-protocol. The following two are	identical
+	to the last two above:
++
+===============================================================
+- host.xz:/path/to/repo.git/
+- host.xz:~user/path/to/repo.git/
+===============================================================
++
+	To sync with a local directory, use:
++
+===============================================================
+- /path/to/repo.git/
+===============================================================
++
+Note that you can't push via HTTP or HTTPS.
++
 In addition to the above, as a short-hand, the name of a
 file in $GIT_DIR/remotes directory can be given; the
 named file should be in the following format:
diff --git a/receive-pack.c b/receive-pack.c
index 8f157bc..2c56018 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -265,18 +265,9 @@ int main(int argc, char **argv)
 	if (!dir)
 		usage(receive_pack_usage);
 
-	/* chdir to the directory. If that fails, try appending ".git" */
-	if (chdir(dir) < 0) {
-		if (chdir(mkpath("%s.git", dir)) < 0)
-			die("unable to cd to %s", dir);
-	}
-
-	/* If we have a ".git" directory, chdir to it */
-	chdir(".git");
-	putenv("GIT_DIR=.");
+	if(!is_git_repo(dir, 0))
+		die("'%s': unable to chdir or not a git archive", dir);
 
-	if (access("objects", X_OK) < 0 || access("refs/heads", X_OK) < 0)
-		die("%s doesn't appear to be a git directory", dir);
 	write_head_info();
 
 	/* EOF */
diff --git a/upload-pack.c b/upload-pack.c
index c5eff21..86e2a61 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -275,18 +275,9 @@ int main(int argc, char **argv)
 		usage(upload_pack_usage);
 	dir = argv[i];
 
-	/* chdir to the directory. If that fails, try appending ".git" */
-	if (chdir(dir) < 0) {
-		if (strict || chdir(mkpath("%s.git", dir)) < 0)
-			die("git-upload-pack unable to chdir to %s", dir);
-	}
-	if (!strict)
-		chdir(".git");
+	if(!is_git_repo(dir, strict))
+		die("'%s': unable to chdir or not a git archive", dir);
 
-	if (access("objects", X_OK) || access("refs", X_OK))
-		die("git-upload-pack: %s doesn't seem to be a git archive", dir);
-
-	putenv("GIT_DIR=.");
 	upload_pack();
 	return 0;
 }
---
0.99.9.GIT
