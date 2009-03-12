From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: [PATCH 2/2] Make Git respect changes to .gitattributes during checkout.
Date: Thu, 12 Mar 2009 10:36:15 +0100
Message-ID: <1236850575-27973-3-git-send-email-kristian.amlie@nokia.com>
References: <1233320413-28069-1-git-send-email-kristian.amlie@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: Kristian Amlie <kristian.amlie@nokia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 10:38:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhhMz-0004cN-3l
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 10:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbZCLJgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 05:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753581AbZCLJgt
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 05:36:49 -0400
Received: from hoat.troll.no ([62.70.27.150]:41188 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343AbZCLJgo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 05:36:44 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 5B0652116B;
	Thu, 12 Mar 2009 10:36:42 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 51D972114D;
	Thu, 12 Mar 2009 10:36:42 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n2C9agsk025996;
	Thu, 12 Mar 2009 10:36:42 +0100
Received: from axis.localdomain ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Thu, 12 Mar 2009 10:36:42 +0100 (CET)
Received: by axis.localdomain (Postfix, from userid 1000)
	id 3BF78361880E; Thu, 12 Mar 2009 10:36:40 +0100 (CET)
In-Reply-To: <1236850575-27973-2-git-send-email-kristian.amlie@nokia.com>
References: <1236850575-27973-1-git-send-email-kristian.amlie@nokia.com>
References: <1236850575-27973-2-git-send-email-kristian.amlie@nokia.com>
x-scalix-Hops: 1
X-Mailer: git-send-email 1.6.2.105.g16bc7.dirty
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113031>

We do this by popping off elements on the attribute stack, until we
reach the level where a new .gitattributes was checked out. The next
time someone calls git_checkattr(), it will reconstruct the
attributes from that point.
---
 attr.c  |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 attr.h  |    1 +
 entry.c |   23 ++++++++++++++++++++
 3 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/attr.c b/attr.c
index 17f6a4d..7deb51a 100644
--- a/attr.c
+++ b/attr.c
@@ -455,6 +455,23 @@ static void bootstrap_attr_stack(void)
 	}
 }
 
+static void pop_attr_stack(const char *path, int dirlen)
+{
+	struct attr_stack *elem;
+	while (attr_stack && attr_stack->origin) {
+		int namelen = strlen(attr_stack->origin);
+
+		elem = attr_stack;
+		if (namelen <= dirlen &&
+			!strncmp(elem->origin, path, namelen))
+			break;
+
+		debug_pop(elem);
+		attr_stack = elem->prev;
+		free_attr_elem(elem);
+	}
+}
+
 static void prepare_attr_stack(const char *path, int dirlen)
 {
 	struct attr_stack *elem, *info;
@@ -489,18 +506,7 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	 * Pop the ones from directories that are not the prefix of
 	 * the path we are checking.
 	 */
-	while (attr_stack && attr_stack->origin) {
-		int namelen = strlen(attr_stack->origin);
-
-		elem = attr_stack;
-		if (namelen <= dirlen &&
-		    !strncmp(elem->origin, path, namelen))
-			break;
-
-		debug_pop(elem);
-		attr_stack = elem->prev;
-		free_attr_elem(elem);
-	}
+	pop_attr_stack(path, dirlen);
 
 	/*
 	 * Read from parent directories and push them down
@@ -642,3 +648,45 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 
 	return 0;
 }
+
+void git_attr_invalidate_path(const char *path)
+{
+	int dirlen;
+	const char *cp;
+	struct attr_stack *info, *elem;
+
+	bootstrap_attr_stack();
+
+	/*
+	 * Pop the "info" one that is always at the top of the stack.
+	 */
+	info = attr_stack;
+	attr_stack = info->prev;
+
+	cp = strrchr(path, '/');
+	dirlen = cp ? cp - path : 0;
+	/* Pop everything up to, and including, path. */
+	pop_attr_stack(path, dirlen);
+
+	if (!strcmp(path, "") && attr_stack->origin && !strcmp(attr_stack->origin, "")) {
+		/* Special handling when the root attributes must be invalidated. */
+		elem = attr_stack;
+		debug_pop(elem);
+		attr_stack = elem->prev;
+		free_attr_elem(elem);
+
+		if (!is_bare_repository()) {
+			elem = read_attr(GITATTRIBUTES_FILE, 1);
+			elem->origin = strdup("");
+			elem->prev = attr_stack;
+			attr_stack = elem;
+			debug_push(elem);
+		}
+	}
+
+	/*
+	 * Finally push the "info" one at the top of the stack.
+	 */
+	info->prev = attr_stack;
+	attr_stack = info;
+}
diff --git a/attr.h b/attr.h
index f1c2038..8f4135b 100644
--- a/attr.h
+++ b/attr.h
@@ -30,5 +30,6 @@ struct git_attr_check {
 };
 
 int git_checkattr(const char *path, int, struct git_attr_check *);
+void git_attr_invalidate_path(const char *path);
 
 #endif /* ATTR_H */
diff --git a/entry.c b/entry.c
index 05aa58d..121c979 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "dir.h"
+#include "attr.h"
 
 static void create_directories(const char *path, const struct checkout *state)
 {
@@ -91,6 +92,9 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 {
 	int fd;
 	long wrote;
+	int gitattrlen;
+	int pathlen;
+	char *inv_path;
 
 	switch (ce->ce_mode & S_IFMT) {
 		char *new;
@@ -171,6 +175,25 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		return error("git checkout-index: unknown file mode for %s", path);
 	}
 
+	gitattrlen = strlen(GITATTRIBUTES_FILE);
+	pathlen = strlen(path);
+	if (!strncmp(path + pathlen - gitattrlen, GITATTRIBUTES_FILE, gitattrlen)) {
+		/* Invalidate attributes if a new .gitattributes file was checked out. */
+		inv_path = strrchr(path, '/');
+		if (!inv_path) {
+			pathlen = 0;
+			inv_path = xmalloc(1);
+			*inv_path = '\0';
+		} else {
+			pathlen = inv_path - path;
+			inv_path = xmalloc(pathlen + 1);
+			strncpy(inv_path, path, pathlen);
+			inv_path[pathlen] = '\0';
+		}
+		git_attr_invalidate_path(inv_path);
+		free(inv_path);
+	}
+
 	if (state->refresh_cache) {
 		struct stat st;
 		lstat(ce->name, &st);
-- 
1.6.2.105.g16bc7.dirty
