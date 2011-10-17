From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2 2/2] daemon: report permission denied error to clients
Date: Mon, 17 Oct 2011 21:58:51 +0200
Message-ID: <20111017195850.GC29479@ecki>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <1318803076-4229-2-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 21:58:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFtKT-0006XN-Fu
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 21:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932Ab1JQT62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 15:58:28 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:55945 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752461Ab1JQT62 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 15:58:28 -0400
Received: from localhost (p5B22F233.dip.t-dialin.net [91.34.242.51])
	by bsmtp.bon.at (Postfix) with ESMTP id 357C22C4003;
	Mon, 17 Oct 2011 21:58:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318803076-4229-2-git-send-email-drizzd@aon.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183816>

If passed an inaccessible url, git daemon returns the
following error:

 $ git clone git://host/repo
 fatal: remote error: no such repository: /repo

In case of a permission denied error, return the following
instead:

 fatal: remote error: permission denied: /repo

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Compared to v1 of this patch, the calling convention of path_ok are
back to what they were previously. Now the only change is that it
sets errno.

 daemon.c              |   15 +++++++++++++--
 path.c                |   31 +++++++++++++++++++++----------
 t/t5570-git-daemon.sh |    2 +-
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/daemon.c b/daemon.c
index 72fb53a..2f7f84e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -120,12 +120,14 @@ static char *path_ok(char *directory)
 
 	if (daemon_avoid_alias(dir)) {
 		logerror("'%s': aliased", dir);
+		errno = 0;
 		return NULL;
 	}
 
 	if (*dir == '~') {
 		if (!user_path) {
 			logerror("'%s': User-path not allowed", dir);
+			errno = EACCES;
 			return NULL;
 		}
 		if (*user_path) {
@@ -158,6 +160,7 @@ static char *path_ok(char *directory)
 		if (*dir != '/') {
 			/* Allow only absolute */
 			logerror("'%s': Non-absolute path denied (interpolated-path active)", dir);
+			errno = EACCES;
 			return NULL;
 		}
 
@@ -173,6 +176,7 @@ static char *path_ok(char *directory)
 		if (*dir != '/') {
 			/* Allow only absolute */
 			logerror("'%s': Non-absolute path denied (base-path active)", dir);
+			errno = EACCES;
 			return NULL;
 		}
 		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
@@ -190,7 +194,9 @@ static char *path_ok(char *directory)
 	}
 
 	if (!path) {
+		int err = errno;
 		logerror("'%s' does not appear to be a git repository", dir);
+		errno = err;
 		return NULL;
 	}
 
@@ -221,6 +227,7 @@ static char *path_ok(char *directory)
 	}
 
 	logerror("'%s': not in whitelist", path);
+	errno = EACCES;
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
@@ -269,8 +276,12 @@ static int run_service(char *dir, struct daemon_service *service)
 		return daemon_error(dir, "service not enabled");
 	}
 
-	if (!(path = path_ok(dir)))
-		return daemon_error(dir, "no such repository");
+	if (!(path = path_ok(dir))) {
+		if (errno == EACCES)
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
