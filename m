From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 6/9] Allow add_path() to add non-existent directories to the path
Date: Mon, 21 Jul 2008 21:19:55 +0200
Message-ID: <1216667998-8879-7-git-send-email-johannes.sixt@telecom.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-3-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-4-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-5-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-6-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL0x2-00025p-FU
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 21:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbYGUTUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 15:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754222AbYGUTUV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 15:20:21 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:39825 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbYGUTUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 15:20:04 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 4D0EB33EC0;
	Mon, 21 Jul 2008 21:20:02 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.18.g6aef2
In-Reply-To: <1216667998-8879-6-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89390>

This function had used make_absolute_path(); but this function dies if
the directory that contains the entry whose relative path was supplied in
the argument does not exist. This is a problem if the argument is, for
example, "../libexec/git-core", and that "../libexec" does not exist.

Since the resolution of symbolic links is not required for elements in
PATH, we can fall back to using make_nonrelative_path(), which simply
prepends $PWD to the path.

We have to move make_nonrelative_path() alongside make_absolute_path() in
abspath.c so that git-shell can be linked. See 5b8e6f85f.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 abspath.c  |   36 ++++++++++++++++++++++++++++++++++++
 exec_cmd.c |    2 +-
 path.c     |   36 ------------------------------------
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/abspath.c b/abspath.c
index 4f95a95..0d56124 100644
--- a/abspath.c
+++ b/abspath.c
@@ -66,3 +66,39 @@ const char *make_absolute_path(const char *path)
 
 	return buf;
 }
+
+static const char *get_pwd_cwd(void)
+{
+	static char cwd[PATH_MAX + 1];
+	char *pwd;
+	struct stat cwd_stat, pwd_stat;
+	if (getcwd(cwd, PATH_MAX) == NULL)
+		return NULL;
+	pwd = getenv("PWD");
+	if (pwd && strcmp(pwd, cwd)) {
+		stat(cwd, &cwd_stat);
+		if (!stat(pwd, &pwd_stat) &&
+		    pwd_stat.st_dev == cwd_stat.st_dev &&
+		    pwd_stat.st_ino == cwd_stat.st_ino) {
+			strlcpy(cwd, pwd, PATH_MAX);
+		}
+	}
+	return cwd;
+}
+
+const char *make_nonrelative_path(const char *path)
+{
+	static char buf[PATH_MAX + 1];
+
+	if (is_absolute_path(path)) {
+		if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
+			die("Too long path: %.*s", 60, path);
+	} else {
+		const char *cwd = get_pwd_cwd();
+		if (!cwd)
+			die("Cannot determine the current working directory");
+		if (snprintf(buf, PATH_MAX, "%s/%s", cwd, path) >= PATH_MAX)
+			die("Too long path: %.*s", 60, path);
+	}
+	return buf;
+}
diff --git a/exec_cmd.c b/exec_cmd.c
index c236034..0ed768d 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -50,7 +50,7 @@ static void add_path(struct strbuf *out, const char *path)
 		if (is_absolute_path(path))
 			strbuf_addstr(out, path);
 		else
-			strbuf_addstr(out, make_absolute_path(path));
+			strbuf_addstr(out, make_nonrelative_path(path));
 
 		strbuf_addch(out, PATH_SEP);
 	}
diff --git a/path.c b/path.c
index 504eae0..9df447b 100644
--- a/path.c
+++ b/path.c
@@ -291,42 +291,6 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
-static const char *get_pwd_cwd(void)
-{
-	static char cwd[PATH_MAX + 1];
-	char *pwd;
-	struct stat cwd_stat, pwd_stat;
-	if (getcwd(cwd, PATH_MAX) == NULL)
-		return NULL;
-	pwd = getenv("PWD");
-	if (pwd && strcmp(pwd, cwd)) {
-		stat(cwd, &cwd_stat);
-		if (!stat(pwd, &pwd_stat) &&
-		    pwd_stat.st_dev == cwd_stat.st_dev &&
-		    pwd_stat.st_ino == cwd_stat.st_ino) {
-			strlcpy(cwd, pwd, PATH_MAX);
-		}
-	}
-	return cwd;
-}
-
-const char *make_nonrelative_path(const char *path)
-{
-	static char buf[PATH_MAX + 1];
-
-	if (is_absolute_path(path)) {
-		if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
-			die ("Too long path: %.*s", 60, path);
-	} else {
-		const char *cwd = get_pwd_cwd();
-		if (!cwd)
-			die("Cannot determine the current working directory");
-		if (snprintf(buf, PATH_MAX, "%s/%s", cwd, path) >= PATH_MAX)
-			die ("Too long path: %.*s", 60, path);
-	}
-	return buf;
-}
-
 const char *make_relative_path(const char *abs, const char *base)
 {
 	static char buf[PATH_MAX + 1];
-- 
1.6.0.rc0.18.g6aef2
