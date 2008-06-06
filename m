From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Use nonrelative paths instead of absolute paths for cloned
 repositories
Date: Thu, 5 Jun 2008 23:15:19 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806052244300.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Greg KH <greg@kroah.com>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 05:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4SRJ-0002sg-Oj
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 05:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbYFFDPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 23:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbYFFDPV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 23:15:21 -0400
Received: from iabervon.org ([66.92.72.58]:46846 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbYFFDPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 23:15:20 -0400
Received: (qmail 25779 invoked by uid 1000); 6 Jun 2008 03:15:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jun 2008 03:15:19 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84014>

Particularly for the "alternates" file, if one will be created, we
want a path that doesn't depend on the current directory, but we want
to retain any symlinks in the path as given and any in the user's view
of the current directory when the path was given.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Lightly tested; I haven't put together a test cases for the problem that 
started this, though.

 builtin-clone.c |    4 ++--
 cache.h         |    1 +
 path.c          |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index f4accbe..7190952 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -76,7 +76,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 		path = mkpath("%s%s", repo, suffix[i]);
 		if (!stat(path, &st) && S_ISDIR(st.st_mode)) {
 			*is_bundle = 0;
-			return xstrdup(make_absolute_path(path));
+			return xstrdup(make_nonrelative_path(path));
 		}
 	}
 
@@ -85,7 +85,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 		path = mkpath("%s%s", repo, bundle_suffix[i]);
 		if (!stat(path, &st) && S_ISREG(st.st_mode)) {
 			*is_bundle = 1;
-			return xstrdup(make_absolute_path(path));
+			return xstrdup(make_nonrelative_path(path));
 		}
 	}
 
diff --git a/cache.h b/cache.h
index 092a997..0a63c0e 100644
--- a/cache.h
+++ b/cache.h
@@ -524,6 +524,7 @@ static inline int is_absolute_path(const char *path)
 	return path[0] == '/';
 }
 const char *make_absolute_path(const char *path);
+const char *make_nonrelative_path(const char *path);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index b7c24a2..60b55ae 100644
--- a/path.c
+++ b/path.c
@@ -291,6 +291,40 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
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
+	if (path[0] == '/') {
+		if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
+			die ("Too long path: %.*s", 60, path);
+	} else {
+		const char *cwd = get_pwd_cwd();
+		if (!cwd || snprintf(buf, PATH_MAX, "%s/%s", cwd, path) > PATH_MAX)
+			die ("Too long path: %.*s", 60, path);
+	}
+	return buf;
+}
+
 /* We allow "recursive" symbolic links. Only within reason, though. */
 #define MAXDEPTH 5
 
-- 
1.5.4.3.610.gea6cd
