From: "Ralf Ebert" <ralf@ralfebert.de>
Subject: [PATCH] setup.c: Improve 'Not a git repository' messages
Date: Sun, 15 Aug 2010 04:55:21 +0200
Message-ID: <1281840921-1996-1-git-send-email-ralf@ralfebert.de>
References: <i43v6e$q00$1@dough.gmane.org>
Cc: Ralf Ebert <ralf@ralfebert.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 15 05:13:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkTf9-0005Ej-VX
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 05:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757929Ab0HODNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 23:13:16 -0400
Received: from wp057.webpack.hosteurope.de ([80.237.132.64]:34437 "EHLO
	wp057.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755694Ab0HODNP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 23:13:15 -0400
X-Greylist: delayed 1001 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Aug 2010 23:13:15 EDT
Received: from port-92-198-61-236.static.qsc.de ([92.198.61.236] helo=ralfebert.de); authenticated
	by wp057.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1OkTOi-0000C7-HK; Sun, 15 Aug 2010 04:56:33 +0200
Received: by ralfebert.de (sSMTP sendmail emulation); Sun, 15 Aug 2010 04:56:32 +0200
X-Mailer: git-send-email 1.7.2.1.96.gb740
In-Reply-To: <i43v6e$q00$1@dough.gmane.org>
X-bounce-key: webpack.hosteurope.de;ralf@ralfebert.de;1281841995;8b025570;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153594>

Changed message "Not a git repository (or any of the parent directories)"
to the more precise message "No <.git> repository in <path> or its parent
directories".

If a filesystem boundary is encountered with
GIT_DISCOVERY_ACROSS_FILESYSTEM not set, the warning now goes first.
The warning is suppressed when search was stopped at $HOME to not confuse
users using a crypto home volume (assuming that users having a repository
at /home or / know what they are doing).

Thanks to Duy, Jonathan, Sverre and Josh for commenting.

Signed-off-by: Ralf Ebert <ralf@ralfebert.de>
---
 setup.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 2769160..adabdd8 100644
--- a/setup.c
+++ b/setup.c
@@ -431,7 +431,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				*nongit_ok = 1;
 				return NULL;
 			}
-			die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
+			die("No %s repository in %s or its parent directories",
+				DEFAULT_GIT_DIR_ENVIRONMENT, cwd);
 		}
 		if (one_filesystem) {
 			if (stat("..", &buf)) {
@@ -445,9 +446,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
 					*nongit_ok = 1;
 					return NULL;
 				}
-				cwd[offset] = '\0';
-				die("Not a git repository (or any parent up to mount parent %s)\n"
-				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).", cwd);
+				const char *home = getenv("HOME");
+				if (home == NULL || strncmp(home, cwd, offset) != 0) {
+					warning("Stopped searching for %s at %.*s "
+						"as GIT_DISCOVERY_ACROSS_FILESYSTEM is not set",
+						DEFAULT_GIT_DIR_ENVIRONMENT, offset, cwd);
+				}
+				die("No %s repository in %s or its parent directories",
+					DEFAULT_GIT_DIR_ENVIRONMENT, cwd);
 			}
 		}
 		if (chdir("..")) {
-- 
1.7.2.1.96.gb740
