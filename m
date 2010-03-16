From: "Lars R. Damerow" <lars@pixar.com>
Subject: [PATCH 2/2] Add support for GIT_ONE_FILESYSTEM
Date: Tue, 16 Mar 2010 15:05:01 -0700
Message-ID: <1268777101-22122-3-git-send-email-lars@pixar.com>
References: <1268777101-22122-1-git-send-email-lars@pixar.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 23:06:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nresw-00059Q-AQ
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 23:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897Ab0CPWFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 18:05:05 -0400
Received: from cmx.pixar.com ([199.108.77.24]:42163 "EHLO cmx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204Ab0CPWFE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 18:05:04 -0400
X-PixarMID: 1931193
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.49,652,1262592000"; 
   d="scan'208";a="1931193"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by cirrus.pixar.com with ESMTP; 16 Mar 2010 15:05:03 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2GM53IP022166
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 15:05:03 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2GM53do022165
	for git@vger.kernel.org; Tue, 16 Mar 2010 15:05:03 -0700
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1268777101-22122-1-git-send-email-lars@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142354>

This patch makes git pay attention to the GIT_ONE_FILESYSTEM environment
variable. When that variable is set, git will stop searching for a
GIT_DIR when it attempts to cross a filesystem boundary.

When working in an environment with too many automount points to make
maintaining a GIT_CEILING_DIRECTORIES list enjoyable, GIT_ONE_FILESYSTEM
gives the option of turning all such attempts off with one setting.

Signed-off-by: Lars R. Damerow <lars@pixar.com>
---
 Documentation/git.txt |    3 +++
 setup.c               |   17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletions(-)

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
index 5716d90..d40e2e6 100644
--- a/setup.c
+++ b/setup.c
@@ -319,10 +319,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
-	static char cwd[PATH_MAX+1];
+	static char cwd[PATH_MAX+1], err_cwd[PATH_MAX+1];
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
@@ -422,6 +429,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			}
 			die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
 		}
+		if (one_filesystem) {
+			if (stat("..", &buf))
+				die_errno("failed to stat '%s/..'", getcwd(err_cwd, sizeof(err_cwd)-1));
+			if (buf.st_dev != current_device)
+				die("Not a git repository (or any parent up to %s/..)\n"
+					"Stopping at filesystem boundary since GIT_ONE_FILESYSTEM is set.",
+					getcwd(err_cwd, sizeof(err_cwd)-1));
+		}
 		if (chdir(".."))
 			die_errno("Cannot change to '%s/..'", cwd);
 	}
-- 
1.6.5.2
