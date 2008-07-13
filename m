From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Allow add_path() to add non-existent directories to the path
Date: Sun, 13 Jul 2008 22:31:23 +0200
Message-ID: <1215981083-10815-6-git-send-email-johannes.sixt@telecom.at>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org>
 <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-2-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-3-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-4-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-5-git-send-email-johannes.sixt@telecom.at>
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 22:32:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI8Fa-0005ZO-6a
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 22:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbYGMUbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 16:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755406AbYGMUbf
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 16:31:35 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:37026 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbYGMUb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 16:31:29 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 9F8DD34AB1;
	Sun, 13 Jul 2008 22:31:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.300.ga3a9
In-Reply-To: <1215981083-10815-5-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88333>

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
index 4f95a95..99ee1af 100644
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
+			die ("Too long path: %.*s", 60, path);
+	} else {
+		const char *cwd = get_pwd_cwd();
+		if (!cwd)
+			die("Cannot determine the current working directory");
+		if (snprintf(buf, PATH_MAX, "%s/%s", cwd, path) >= PATH_MAX)
+			die ("Too long path: %.*s", 60, path);
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
index 5983255..16c1d01 100644
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
1.5.6.2.300.ga3a9
