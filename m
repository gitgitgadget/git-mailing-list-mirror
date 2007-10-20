From: Scott R Parish <srp@srparish.net>
Subject: [PATCH] If git is ran with a relative path, try building an
	absolute exec_path from it
Date: Fri, 19 Oct 2007 23:46:17 -0700
Message-ID: <20071020064617.GC2237@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 08:46:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij86W-0000Sf-6R
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762829AbXJTGqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762803AbXJTGqY
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:46:24 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:55785 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762660AbXJTGqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:46:24 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP quinn@srparish.net)
	id 1Ij86J-0007mp-7T
	for git@vger.kernel.org; Sat, 20 Oct 2007 01:46:23 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Fri, 19 Oct 2007 23:46:19 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61801>

 Signed-off-by: Scott R Parish <srp@srparish.net>

---
 git.c |   35 +++++++++++++++++++++++++++++++++--
 1 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 9eaca1d..d129ecc 100644
--- a/git.c
+++ b/git.c
@@ -28,6 +28,35 @@ static void prepend_to_path(const char *dir, int len)
 	free(path);
 }
 
+static char *rel_to_abs_exec_path(const char *cmd) {
+	int len, rc;
+	char *exec_path = xmalloc(PATH_MAX + 1);
+
+	if (!getcwd(exec_path, PATH_MAX)) {
+		fprintf(stderr, "git: cannot determine current directory: %s\n",
+			strerror(errno));
+		free(exec_path);
+		return NULL;
+	}
+	len = strlen(exec_path);
+
+	/* Trivial cleanup */
+	while (!prefixcmp(cmd, "./")) {
+		cmd += 2;
+		while (*cmd == '/')
+			cmd++;
+	}
+
+	rc = snprintf(exec_path + len, PATH_MAX - len, "/%s", cmd);
+	if (rc < 0 || rc >= PATH_MAX - len) {
+		fprintf(stderr, "git: command name given is too long.\n");
+		free(exec_path);
+		return NULL;
+	}
+
+	return exec_path;
+}
+
 static int handle_options(const char*** argv, int* argc, int* envchanged)
 {
 	int handled = 0;
@@ -409,13 +438,15 @@ int main(int argc, const char **argv)
 	/*
 	 * Take the basename of argv[0] as the command
 	 * name, and the dirname as the default exec_path
-	 * if it's an absolute path and we don't have
-	 * anything better.
+	 * if we don't have anything better.
 	 */
 	if (slash) {
 		*slash++ = 0;
 		if (*cmd == '/')
 			exec_path = cmd;
+		else
+			exec_path = rel_to_abs_exec_path(cmd);
+
 		cmd = slash;
 	}
 
-- 
1.5.3.GIT
