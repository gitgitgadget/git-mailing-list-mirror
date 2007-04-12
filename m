From: Geert Bosch <bosch@gnat.com>
Subject: [PATCH] create_directories: simplify and avoid repeated copying
Date: Thu, 12 Apr 2007 16:29:10 -0400
Message-ID: <20070414013003.B0B4C2F1DC3@geert-boschs-computer.local>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 03:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcX64-00046n-S5
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 03:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbXDNBaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 21:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754168AbXDNBaE
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 21:30:04 -0400
Received: from nile.gnat.com ([205.232.38.5]:36217 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754167AbXDNBaD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 21:30:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 0C81148CCA1
	for <git@vger.kernel.org>; Fri, 13 Apr 2007 21:30:02 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 25900-01-4 for <git@vger.kernel.org>;
 Fri, 13 Apr 2007 21:30:01 -0400 (EDT)
Received: from geert-boschs-computer.local (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id BBC2C48CC23
	for <git@vger.kernel.org>; Fri, 13 Apr 2007 21:30:01 -0400 (EDT)
Received: by geert-boschs-computer.local (Postfix, from userid 4190)
	id B0B4C2F1DC3; Fri, 13 Apr 2007 21:30:03 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44441>

Signed-off-by: Geert Bosch <bosch@gnat.com>
---
I needed to change the logic of this function a bit for
doing some local hacks^Wmodifications and thought it might
be a slight improvement/simplification.
No change in functionality and passed 'make test'.

 entry.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/entry.c b/entry.c
index d72f811..f966c59 100644
--- a/entry.c
+++ b/entry.c
@@ -3,24 +3,19 @@
 
 static void create_directories(const char *path, struct checkout *state)
 {
-	int len = strlen(path);
-	char *buf = xmalloc(len + 1);
-	const char *slash = path;
+	char *buf = xstrdup(path);
+	char *slash = buf;
 
 	while ((slash = strchr(slash+1, '/')) != NULL) {
-		len = slash - path;
-		memcpy(buf, path, len);
-		buf[len] = 0;
+		*slash = 0;
 		if (mkdir(buf, 0777)) {
-			if (errno == EEXIST) {
-				struct stat st;
-				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
-					continue;
-				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
-					continue; /* ok */
-			}
-			die("cannot create directory at %s", buf);
+			struct stat st;
+			int force = (slash - buf) > state->base_dir_len && state->force;
+			if (errno != EEXIST || ((!force || unlink(buf) || mkdir(buf, 0777)) &&
+			    (stat(buf, &st) || !S_ISDIR(st.st_mode))))
+				die("cannot create directory at %s", buf);
 		}
+		*slash='/';
 	}
 	free(buf);
 }
-- 
1.5.1
