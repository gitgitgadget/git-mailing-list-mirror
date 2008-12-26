From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] daemon: cleanup: replace loop with if
Date: Fri, 26 Dec 2008 11:01:57 +0100
Message-ID: <1230285717.6728.40.camel@ubuntu.ubuntu-domain>
References: <1230284785.6728.26.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 11:03:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG9XQ-0002OC-Fa
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 11:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbYLZKCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 05:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbYLZKCA
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 05:02:00 -0500
Received: from india601.server4you.de ([85.25.151.105]:37599 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbYLZKCA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 05:02:00 -0500
Received: from [10.0.1.101] (p57B7E108.dip.t-dialin.net [87.183.225.8])
	by india601.server4you.de (Postfix) with ESMTPSA id 62F5C2F8003;
	Fri, 26 Dec 2008 11:01:58 +0100 (CET)
In-Reply-To: <1230284785.6728.26.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103928>

Replace a loop around an enter_repo() call, which was used to retry
a single time with a different parameter in case the first call fails,
with two calls and an if.  This is shorter and cleaner.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 daemon.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/daemon.c b/daemon.c
index 8c317be..4468fb9 100644
--- a/daemon.c
+++ b/daemon.c
@@ -150,7 +150,6 @@ static char *path_ok(char *directory)
 {
 	static char rpath[PATH_MAX];
 	static char interp_path[PATH_MAX];
-	int retried_path = 0;
 	char *path;
 	char *dir;
 
@@ -219,22 +218,15 @@ static char *path_ok(char *directory)
 		dir = rpath;
 	}
 
-	do {
-		path = enter_repo(dir, strict_paths);
-		if (path)
-			break;
-
+	path = enter_repo(dir, strict_paths);
+	if (!path && base_path && base_path_relaxed) {
 		/*
 		 * if we fail and base_path_relaxed is enabled, try without
 		 * prefixing the base path
 		 */
-		if (base_path && base_path_relaxed && !retried_path) {
-			dir = directory;
-			retried_path = 1;
-			continue;
-		}
-		break;
-	} while (1);
+		dir = directory;
+		path = enter_repo(dir, strict_paths);
+	}
 
 	if (!path) {
 		logerror("'%s': unable to chdir or not a git archive", dir);
-- 
1.6.1
