From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v1 2/6] remove some memcpy() and strchr() calls inside
 create_directories()
Date: Mon, 26 Jan 2009 22:17:13 +0100
Message-ID: <1233004637-15112-3-git-send-email-barvik@broadpark.no>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 22:19:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYrE-0000UB-VP
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbZAZVR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbZAZVR1
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:17:27 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:62233 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbZAZVRY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:17:24 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE3003TOKGYXC90@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:22 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.144])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KE3001KZKGTUNC0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:22 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107282>

Remove the call to memcpy() and strchr() for each path component
tested, and instead add each path component as we go forward inside
the while-loop.

Impact: small optimisation

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---

OK, maybe I instead should have tried to merge the function
create_directories() with the safe_create_leading_directories() and
*_const() functions?  What do pepople think?


 entry.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/entry.c b/entry.c
index 05aa58d..c2404ea 100644
--- a/entry.c
+++ b/entry.c
@@ -2,15 +2,19 @@
 #include "blob.h"
 #include "dir.h"
 
-static void create_directories(const char *path, const struct checkout *state)
+static void
+create_directories(int path_len, const char *path, const struct checkout *state)
 {
-	int len = strlen(path);
-	char *buf = xmalloc(len + 1);
-	const char *slash = path;
-
-	while ((slash = strchr(slash+1, '/')) != NULL) {
-		len = slash - path;
-		memcpy(buf, path, len);
+	char *buf = xmalloc(path_len + 1);
+	int len = 0;
+
+	while (len < path_len) {
+		do {
+			buf[len] = path[len];
+			len++;
+		} while (len < path_len && path[len] != '/');
+		if (len >= path_len)
+			break;
 		buf[len] = 0;
 
 		/*
@@ -190,6 +194,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 
 	memcpy(path, state->base_dir, len);
 	strcpy(path + len, ce->name);
+	len += ce_namelen(ce);
 
 	if (!lstat(path, &st)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
@@ -218,6 +223,6 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 			return error("unable to unlink old '%s' (%s)", path, strerror(errno));
 	} else if (state->not_new)
 		return 0;
-	create_directories(path, state);
+	create_directories(len, path, state);
 	return write_entry(ce, path, state, 0);
 }
-- 
1.6.1.349.g99fa5
