From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] properly keep track of current working directory
Date: Fri, 13 Apr 2012 01:11:36 +0200
Message-ID: <20120412231136.GA17585@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 01:12:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SITCE-0002Lt-LV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 01:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648Ab2DLXMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 19:12:54 -0400
Received: from smtpout15.highway.telekom.at ([195.3.96.90]:55046 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750916Ab2DLXMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 19:12:53 -0400
Received: (qmail 3529 invoked from network); 12 Apr 2012 23:12:50 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL506.highway.telekom.at
X-Spam-Level: 
Received: from p5b22dab5.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.218.181])
          (envelope-sender <drizzd@aon.at>)
          by smarthub80.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <gitster@pobox.com>; 12 Apr 2012 23:12:49 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195386>

Various failure modes in the repository detection code path currently
quote the wrong directory in their error message. The working directory
is changed iteratively to the parent directory until a git repository is
found. If the working directory cannot be changed to the parent
directory for some reason, the detection gives up and prints an error
message. THe error message should report the current working directory.

Instead of continually updating the 'cwd' variable, which is actually
used to remember the original working directory, the 'offset' variable
is used to keep track of the current working directory. At the point
where the affected error handling code is called, 'offset' already
points to the end of the parent of the working directory, rather than
the current working directory.

Fix this by explicitly using a variable 'offset_parent' and update
'offset' concurrently with the call to chdir.

In a similar fashion, the function get_device_or_die() would print the
original working directory in case of a failure, rather than the current
working directory. Fix this as well by making use of the 'offset'
variable.

Lastly, replace the phrase 'mount parent' with 'mount point'. The former
appears to be a typo.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 setup.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/setup.c b/setup.c
index 7a3618f..731851a 100644
--- a/setup.c
+++ b/setup.c
@@ -569,13 +569,15 @@ static const char *setup_nongit(const char *cwd, int *nongit_ok)
 	return NULL;
 }
 
-static dev_t get_device_or_die(const char *path, const char *prefix)
+static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_len)
 {
 	struct stat buf;
-	if (stat(path, &buf))
-		die_errno("failed to stat '%s%s%s'",
+	if (stat(path, &buf)) {
+		die_errno("failed to stat '%*s%s%s'",
+				prefix_len,
 				prefix ? prefix : "",
 				prefix ? "/" : "", path);
+	}
 	return buf.st_dev;
 }
 
@@ -589,7 +591,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv, *ret;
 	char *gitfile;
-	int len, offset, ceil_offset;
+	int len, offset, offset_parent, ceil_offset;
 	dev_t current_device = 0;
 	int one_filesystem = 1;
 
@@ -631,7 +633,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	 */
 	one_filesystem = !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0);
 	if (one_filesystem)
-		current_device = get_device_or_die(".", NULL);
+		current_device = get_device_or_die(".", NULL, 0);
 	for (;;) {
 		gitfile = (char*)read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
 		if (gitfile)
@@ -653,11 +655,12 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 		if (is_git_directory("."))
 			return setup_bare_git_dir(cwd, offset, len, nongit_ok);
 
-		while (--offset > ceil_offset && cwd[offset] != '/');
-		if (offset <= ceil_offset)
+		offset_parent = offset;
+		while (--offset_parent > ceil_offset && cwd[offset_parent] != '/');
+		if (offset_parent <= ceil_offset)
 			return setup_nongit(cwd, nongit_ok);
 		if (one_filesystem) {
-			dev_t parent_device = get_device_or_die("..", cwd);
+			dev_t parent_device = get_device_or_die("..", cwd, offset);
 			if (parent_device != current_device) {
 				if (nongit_ok) {
 					if (chdir(cwd))
@@ -666,7 +669,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 					return NULL;
 				}
 				cwd[offset] = '\0';
-				die("Not a git repository (or any parent up to mount parent %s)\n"
+				die("Not a git repository (or any parent up to mount point %s)\n"
 				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).", cwd);
 			}
 		}
@@ -674,6 +677,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 			cwd[offset] = '\0';
 			die_errno("Cannot change to '%s/..'", cwd);
 		}
+		offset = offset_parent;
 	}
 }
 
-- 
1.7.9.6
