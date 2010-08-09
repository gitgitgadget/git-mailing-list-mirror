From: Ralf Ebert <info@ralfebert.de>
Subject: [PATCH] More readable 'Not a git repository' messages
Date: Mon, 09 Aug 2010 19:24:35 +0200
Message-ID: <i3pdkj$hut$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 19:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiW5i-00053h-Vb
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 19:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab0HIRYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 13:24:46 -0400
Received: from lo.gmane.org ([80.91.229.12]:51013 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab0HIRYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 13:24:45 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OiW5b-00051X-Rx
	for git@vger.kernel.org; Mon, 09 Aug 2010 19:24:43 +0200
Received: from port-92-198-61-236.static.qsc.de ([92.198.61.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 19:24:43 +0200
Received: from info by port-92-198-61-236.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 19:24:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: port-92-198-61-236.static.qsc.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152990>

Stating the folder concerned with the operation and wording the
messages differently make them slightly more readable.

old: Not a git repository (or any of the parent directories): .git
new: Not in a git repository: /home/bob/somefolder

old: Not a git repository (or any parent up to mount parent /home/bob)
old: Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM 
not set).
new: Not in a git repository: /home/bob/somefolder
new: (stopped searching at /home because GIT_DISCOVERY_ACROSS_FILESYSTEM 
is not set)

Signed-off-by: Ralf Ebert <info@ralfebert.de>
---
  setup.c |   11 +++++++----
  1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 2769160..e27fbf1 100644
--- a/setup.c
+++ b/setup.c
@@ -321,6 +321,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
  {
  	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
  	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
+	char cwd_orig[PATH_MAX];
  	static char cwd[PATH_MAX+1];
  	const char *gitdirenv;
  	const char *gitfile_dir;
@@ -376,8 +377,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
  		die("Not a git repository: '%s'", gitdirenv);
  	}
  -	if (!getcwd(cwd, sizeof(cwd)-1))
+	if (!getcwd(cwd_orig, sizeof(cwd_orig)))
  		die_errno("Unable to read current working directory");
+	strcpy(cwd, cwd_orig);
   	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
  	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
@@ -431,7 +433,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
  				*nongit_ok = 1;
  				return NULL;
  			}
-			die("Not a git repository (or any of the parent directories): %s", 
DEFAULT_GIT_DIR_ENVIRONMENT);
+			die("Not in a git repository: %s", cwd_orig);
  		}
  		if (one_filesystem) {
  			if (stat("..", &buf)) {
@@ -446,8 +448,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
  					return NULL;
  				}
  				cwd[offset] = '\0';
-				die("Not a git repository (or any parent up to mount parent %s)\n"
-				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM 
not set).", cwd);
+				die("Not in a git repository: %s\n"
+				"(stopped searching at %s because "
+				"GIT_DISCOVERY_ACROSS_FILESYSTEM is not set)", cwd_orig, cwd);
  			}
  		}
  		if (chdir("..")) {
-- 
1.7.2.1.44.g721e7.dirty
