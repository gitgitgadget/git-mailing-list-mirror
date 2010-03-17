From: "Lars R. Damerow" <lars@pixar.com>
Subject: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Wed, 17 Mar 2010 12:55:53 -0700
Message-ID: <1268855753-25840-4-git-send-email-lars@pixar.com>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 21:06:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrzVB-0006Kx-T1
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 21:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349Ab0CQUFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 16:05:55 -0400
Received: from emx.pixar.com ([199.108.77.30]:38351 "EHLO emx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423Ab0CQUFy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 16:05:54 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2010 16:05:54 EDT
X-PixarMID: 1607698
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.51,261,1267430400"; 
   d="scan'208";a="1607698"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by iris.pixar.com with ESMTP; 17 Mar 2010 12:56:05 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2HJu4tw025899
	for <git@vger.kernel.org>; Wed, 17 Mar 2010 12:56:04 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2HJu4uN025898
	for git@vger.kernel.org; Wed, 17 Mar 2010 12:56:04 -0700
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1268855753-25840-1-git-send-email-lars@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142434>

This patch makes git pay attention to the GIT_ONE_FILESYSTEM environment
variable. When that variable is set, git will stop searching for a
GIT_DIR when it attempts to cross a filesystem boundary.

When working in an environment with too many automount points to make
maintaining a GIT_CEILING_DIRECTORIES list enjoyable, GIT_ONE_FILESYSTEM
gives the option of turning all such attempts off with one setting.

Signed-off-by: Lars R. Damerow <lars@pixar.com>
---
 Documentation/git.txt |    3 +++
 setup.c               |   24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 35c0c79..dbb590f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -529,6 +529,9 @@ git so take care if using Cogito etc.
 	a GIT_DIR set on the command line or in the environment.
 	(Useful for excluding slow-loading network directories.)
 
+'GIT_ONE_FILESYSTEM'::
+	Stop at filesystem boundaries when looking for .git or objects.
+
 git Commits
 ~~~~~~~~~~~
 'GIT_AUTHOR_NAME'::
diff --git a/setup.c b/setup.c
index f0b56b9..ef23e79 100644
--- a/setup.c
+++ b/setup.c
@@ -323,6 +323,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *gitdirenv;
 	const char *gitfile_dir;
 	int len, offset, ceil_offset, root_len;
+	int current_device = 0, one_filesystem = 0;
+	struct stat buf;
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -390,6 +392,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 *   etc.
 	 */
 	offset = len = strlen(cwd);
+	if ((one_filesystem = git_env_bool("GIT_ONE_FILESYSTEM", 0))) {
+		if (stat(".", &buf))
+			die_errno("failed to stat '.'");
+		current_device = buf.st_dev;
+	}
 	for (;;) {
 		gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
 		if (gitfile_dir) {
@@ -422,6 +429,23 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			}
 			die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
 		}
+		if (one_filesystem) {
+			if (stat("..", &buf)) {
+				cwd[offset] = '\0';
+				die_errno("failed to stat '%s/..'", cwd);
+			}
+			if (buf.st_dev != current_device) {
+				if (nongit_ok) {
+					if (chdir(cwd))
+						die_errno("Cannot come back to cwd");
+					*nongit_ok = 1;
+					return NULL;
+				}
+				cwd[offset] = '\0';
+				die("Not a git repository (or any parent up to mount parent %s)\n"
+					"Stopping at filesystem boundary since GIT_ONE_FILESYSTEM is set.", cwd);
+			}
+		}
 		if (chdir("..")) {
 			cwd[offset] = '\0';
 			die_errno("Cannot change to '%s/..'", cwd);
-- 
1.6.5.2
