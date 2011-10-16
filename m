From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/2] daemon: report permission denied error to clients
Date: Mon, 17 Oct 2011 00:11:16 +0200
Message-ID: <1318803076-4229-2-git-send-email-drizzd@aon.at>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 00:11:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFYv2-0007JF-T1
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 00:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab1JPWKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 18:10:53 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:56928 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751902Ab1JPWKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 18:10:52 -0400
Received: from localhost (p5B22DCC2.dip.t-dialin.net [91.34.220.194])
	by bsmtp.bon.at (Postfix) with ESMTP id F13B51000F;
	Mon, 17 Oct 2011 00:09:29 +0200 (CEST)
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1318803076-4229-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183739>

If passed an inaccessible url, git daemon returns the
following error:

 $ git clone git://host/repo
 fatal: remote error: no such repository: /repo

In case of a permission denied error, return the following
instead:

 fatal: remote error: permission denied: /repo

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 daemon.c              |   32 +++++++++++++++++++++-----------
 path.c                |   31 +++++++++++++++++++++----------
 t/t5570-git-daemon.sh |    2 +-
 3 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/daemon.c b/daemon.c
index 72fb53a..1442b5b 100644
--- a/daemon.c
+++ b/daemon.c
@@ -109,7 +109,7 @@ static void NORETURN daemon_die(const char *err, va_list params)
 	exit(1);
 }
 
-static char *path_ok(char *directory)
+static int path_ok(char *directory, const char **return_path)
 {
 	static char rpath[PATH_MAX];
 	static char interp_path[PATH_MAX];
@@ -120,13 +120,13 @@ static char *path_ok(char *directory)
 
 	if (daemon_avoid_alias(dir)) {
 		logerror("'%s': aliased", dir);
-		return NULL;
+		return -1;
 	}
 
 	if (*dir == '~') {
 		if (!user_path) {
 			logerror("'%s': User-path not allowed", dir);
-			return NULL;
+			return EACCES;
 		}
 		if (*user_path) {
 			/* Got either "~alice" or "~alice/foo";
@@ -158,7 +158,7 @@ static char *path_ok(char *directory)
 		if (*dir != '/') {
 			/* Allow only absolute */
 			logerror("'%s': Non-absolute path denied (interpolated-path active)", dir);
-			return NULL;
+			return EACCES;
 		}
 
 		strbuf_expand(&expanded_path, interpolated_path,
@@ -173,7 +173,7 @@ static char *path_ok(char *directory)
 		if (*dir != '/') {
 			/* Allow only absolute */
 			logerror("'%s': Non-absolute path denied (base-path active)", dir);
-			return NULL;
+			return EACCES;
 		}
 		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
 		dir = rpath;
@@ -190,10 +190,14 @@ static char *path_ok(char *directory)
 	}
 
 	if (!path) {
+		int ret = -1;
+		if (errno == EACCES)
+		       ret = EACCES;
 		logerror("'%s' does not appear to be a git repository", dir);
-		return NULL;
+		return ret;
 	}
 
+	*return_path = path;
 	if ( ok_paths && *ok_paths ) {
 		char **pp;
 		int pathlen = strlen(path);
@@ -211,17 +215,17 @@ static char *path_ok(char *directory)
 			    !memcmp(*pp, path, len) &&
 			    (path[len] == '\0' ||
 			     (!strict_paths && path[len] == '/')))
-				return path;
+				return 0;
 		}
 	}
 	else {
 		/* be backwards compatible */
 		if (!strict_paths)
-			return path;
+			return 0;
 	}
 
 	logerror("'%s': not in whitelist", path);
-	return NULL;		/* Fallthrough. Deny by default */
+	return EACCES;		/* Fallthrough. Deny by default */
 }
 
 typedef int (*daemon_service_fn)(void);
@@ -258,6 +262,7 @@ static int daemon_error(const char *dir, const char *msg)
 
 static int run_service(char *dir, struct daemon_service *service)
 {
+	int err;
 	const char *path;
 	int enabled = service->enabled;
 
@@ -269,8 +274,13 @@ static int run_service(char *dir, struct daemon_service *service)
 		return daemon_error(dir, "service not enabled");
 	}
 
-	if (!(path = path_ok(dir)))
-		return daemon_error(dir, "no such repository");
+	err = path_ok(dir, &path);
+	if (err) {
+		if (err == EACCES)
+			return daemon_error(dir, "permission denied");
+		else
+			return daemon_error(dir, "no such repository");
+	}
 
 	/*
 	 * Security on the cheap.
diff --git a/path.c b/path.c
index 6f3f5d5..227d8d7 100644
--- a/path.c
+++ b/path.c
@@ -288,6 +288,7 @@ char *enter_repo(char *path, int strict)
 	static char used_path[PATH_MAX];
 	static char validated_path[PATH_MAX];
 
+	errno = 0;
 	if (!path)
 		return NULL;
 
@@ -301,12 +302,15 @@ char *enter_repo(char *path, int strict)
 			path[len-1] = 0;
 			len--;
 		}
-		if (PATH_MAX <= len)
+		if (PATH_MAX <= len) {
+			errno = ENAMETOOLONG;
 			return NULL;
+		}
 		if (path[0] == '~') {
 			char *newpath = expand_user_path(path);
 			if (!newpath || (PATH_MAX - 10 < strlen(newpath))) {
 				free(newpath);
+				errno = 0;
 				return NULL;
 			}
 			/*
@@ -319,9 +323,10 @@ char *enter_repo(char *path, int strict)
 			strcpy(validated_path, path);
 			path = used_path;
 		}
-		else if (PATH_MAX - 10 < len)
+		else if (PATH_MAX - 10 < len) {
+			errno = ENAMETOOLONG;
 			return NULL;
-		else {
+		} else {
 			path = strcpy(used_path, path);
 			strcpy(validated_path, path);
 		}
@@ -331,23 +336,29 @@ char *enter_repo(char *path, int strict)
 			if (!access(path, F_OK)) {
 				strcat(validated_path, suffix[i]);
 				break;
+			} else if (errno == EACCES) {
+				return NULL;
 			}
 		}
-		if (!suffix[i] || chdir(path))
+		if (!suffix[i])
+			return NULL;
+		if (chdir(path))
 			return NULL;
 		path = validated_path;
 	}
 	else if (chdir(path))
 		return NULL;
 
-	if (access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
-	    validate_headref("HEAD") == 0) {
-		set_git_dir(".");
-		check_repository_format();
-		return path;
+	if (access("objects", X_OK) || access("refs", X_OK))
+		return NULL;
+	if (validate_headref("HEAD")) {
+		errno = 0;
+		return NULL;
 	}
 
-	return NULL;
+	set_git_dir(".");
+	check_repository_format();
+	return path;
 }
 
 int set_shared_perm(const char *path, int mode)
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index aa5771a..e6482eb 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -141,7 +141,7 @@ start_daemon --informative-errors
 
 test_expect_success 'clone non-existent' "test_remote_error    clone nowhere.git 'no such repository'"
 test_expect_success 'push disabled'      "test_remote_error    push  repo.git    'service not enabled'"
-test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    'no such repository'"
+test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    'permission denied'"
 test_expect_success 'not exported'       "test_remote_error -n fetch repo.git    'repository not exported'"
 
 stop_daemon
-- 
1.7.7
