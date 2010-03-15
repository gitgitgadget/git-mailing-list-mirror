From: Lars Damerow <lars@pixar.com>
Subject: [PATCH] Add support for GIT_ONE_FILESYSTEM
Date: Mon, 15 Mar 2010 14:40:03 -0700
Message-ID: <20100315214003.GB11157@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 22:50:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrIAn-0003eJ-0r
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936877Ab0COVt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 17:49:59 -0400
Received: from cmx.pixar.com ([199.108.77.24]:1064 "EHLO cmx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932222Ab0COVt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:49:58 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2010 17:49:58 EDT
X-PixarMID: 1905224
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.49,645,1262592000"; 
   d="scan'208";a="1905224"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by cirrus.pixar.com with ESMTP; 15 Mar 2010 14:40:04 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2FLe3cr031801
	for <git@vger.kernel.org>; Mon, 15 Mar 2010 14:40:03 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2FLe33A031800
	for git@vger.kernel.org; Mon, 15 Mar 2010 14:40:03 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142262>

This patch makes git pay attention to the GIT_ONE_FILESYSTEM environment
variable. When that variable is set, git will stop searching for a
GIT_DIR when it attempts to cross a filesystem boundary.

When working in an environment with too many automount points to make
maintaining a GIT_CEILING_DIRECTORIES list enjoyable, GIT_ONE_FILESYSTEM
gives the option of turning all such attempts off with one setting.

Signed-off-by: Lars R. Damerow <lars@pixar.com>
---
 Documentation/git.txt |    3 +++
 setup.c               |   11 +++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

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
index 5716d90..63dc52e 100644
--- a/setup.c
+++ b/setup.c
@@ -323,6 +323,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *gitdirenv;
 	const char *gitfile_dir;
 	int len, offset, ceil_offset, root_len;
+	int current_device = 0;
+	struct stat buf;
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -390,6 +392,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 *   etc.
 	 */
 	offset = len = strlen(cwd);
+	if (stat(".", &buf))
+		die_errno("failed to stat '.'");
+	current_device = buf.st_dev;
 	for (;;) {
 		gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
 		if (gitfile_dir) {
@@ -422,6 +427,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			}
 			die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
 		}
+		if (getenv("GIT_ONE_FILESYSTEM") != NULL) {
+			if (stat("..", &buf))
+				die_errno("failed to stat '..'");
+			if (buf.st_dev != current_device)
+				die("refusing to cross filesystem boundary '%s/..'", cwd);
+		}
 		if (chdir(".."))
 			die_errno("Cannot change to '%s/..'", cwd);
 	}
-- 
1.6.5.2
