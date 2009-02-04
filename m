From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v3 5/9] create_directories(): remove some memcpy() and
 strchr() calls
Date: Wed, 04 Feb 2009 13:52:50 +0100
Message-ID: <4e4df31abdedfdb7cdca587491acf2849074d19c.1233751281.git.barvik@broadpark.no>
References: <cover.1233751281.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 13:55:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUhHS-0006OR-Hs
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 13:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379AbZBDMxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 07:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757369AbZBDMxP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 07:53:15 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:45423 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756170AbZBDMxK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 07:53:10 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEJ003JAL4HHW70@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 13:53:05 +0100 (CET)
Received: from localhost.localdomain ([80.203.29.216])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KEJ004C6L47S210@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 13:53:05 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1233751281.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108355>

Remove the call to memcpy() and strchr() for each path component
tested, and instead add each path component as we go forward inside
the while-loop.

Impact: small optimisation

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 entry.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/entry.c b/entry.c
index bb6bdb9..cc8f0c6 100644
--- a/entry.c
+++ b/entry.c
@@ -2,15 +2,19 @@
 #include "blob.h"
 #include "dir.h"
 
-static void create_directories(const char *path, const struct checkout *state)
+static void create_directories(const char *path, int path_len,
+			       const struct checkout *state)
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
+	create_directories(path, len, state);
 	return write_entry(ce, path, state, 0);
 }
-- 
1.6.1.349.g99fa5
