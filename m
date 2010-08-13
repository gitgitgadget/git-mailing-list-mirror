From: Ralf Ebert <info@ralfebert.de>
Subject: [PATCH/RFC v2] More readable 'Not a git repository' messages
Date: Fri, 13 Aug 2010 19:25:34 +0200
Message-ID: <i43v6e$q00$1@dough.gmane.org>
References: <i3pdkj$hut$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 19:26:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojy16-0005gs-F9
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 19:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761899Ab0HMRZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 13:25:49 -0400
Received: from lo.gmane.org ([80.91.229.12]:39463 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761896Ab0HMRZs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 13:25:48 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ojy0l-0005OY-AX
	for git@vger.kernel.org; Fri, 13 Aug 2010 19:25:43 +0200
Received: from port-92-198-61-236.static.qsc.de ([92.198.61.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 19:25:43 +0200
Received: from info by port-92-198-61-236.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 19:25:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: port-92-198-61-236.static.qsc.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <i3pdkj$hut$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153478>

* State the folder concerned with the operation
* GIT_DISCOVERY_ACROSS_FILESYSTEM warning goes first
* Supressed 'filesystem boundary' warning for $HOME (crypto home volumes
   are common, having a git repository at $HOME is uncommon)
* Improved wording of the messages

Signed-off-by: Ralf Ebert <info@ralfebert.de>
---
  setup.c |   12 ++++++++----
  1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 2769160..dc4f2da 100644
--- a/setup.c
+++ b/setup.c
@@ -431,7 +431,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
  				*nongit_ok = 1;
  				return NULL;
  			}
-			die("Not a git repository (or any of the parent directories): %s", 
DEFAULT_GIT_DIR_ENVIRONMENT);
+			die("%s is not in a git repository", cwd);
  		}
  		if (one_filesystem) {
  			if (stat("..", &buf)) {
@@ -445,9 +445,13 @@ const char *setup_git_directory_gently(int *nongit_ok)
  					*nongit_ok = 1;
  					return NULL;
  				}
-				cwd[offset] = '\0';
-				die("Not a git repository (or any parent up to mount parent %s)\n"
-				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM 
not set).", cwd);
+
+				const char *home = getenv("HOME");
+				if (home == NULL || strncmp(home, cwd, offset) != 0) {
+					warning("Stopped searching for repository at %.*s "
+							"as GIT_DISCOVERY_ACROSS_FILESYSTEM is not set", offset, cwd);
+				}
+				die("%s is not in a git repository", cwd);
  			}
  		}
  		if (chdir("..")) {
-- 
1.7.2.1.96.g07594.dirty
