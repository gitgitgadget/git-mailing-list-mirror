From: skimo@liacs.nl
Subject: [PATCH 17/22] entry.c: optionally checkout newly cloned submodules
Date: Thu, 24 May 2007 00:23:06 +0200
Message-ID: <11799589931860-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFu-0003VS-Sw
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757614AbXEWWY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759873AbXEWWYZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:24:25 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33773 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756786AbXEWWXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:42 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNLYD011604;
	Thu, 24 May 2007 00:23:26 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 3BB9B7DDAF; Thu, 24 May 2007 00:23:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48207>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 entry.c      |   23 ++++++++++++++++++++---
 submodules.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 submodules.h |    1 +
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/entry.c b/entry.c
index 7ba2241..f3e0c59 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "run-command.h"
+#include "submodules.h"
 
 static void create_directories(const char *path, const struct checkout *state)
 {
@@ -82,7 +83,7 @@ static int checkout_submodule(struct cache_entry *ce, const char *path, const st
 	int argc;
 	int err;
 
-	if (!state->submodules)
+	if (!state->submodules && !is_checkedout_submodule(ce->name))
 		return 0;
 
 	argc = 0;
@@ -101,10 +102,25 @@ static int checkout_submodule(struct cache_entry *ce, const char *path, const st
 	return 0;
 }
 
+static int write_submodule(struct cache_entry *ce, char *path, const struct checkout *state)
+{
+	if (mkdir(path, 0777) < 0)
+		return error("git-checkout-index: cannot create subproject directory %s", path);
+
+	if (!state->submodules)
+		return 0;
+
+	if (attach_submodule(ce->name))
+		return -1;
+
+	return checkout_submodule(ce, path, state);
+}
+
 static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
 {
 	int fd;
 	long wrote;
+	int err;
 
 	switch (ntohl(ce->ce_mode) & S_IFMT) {
 		char *buf, *new;
@@ -174,8 +190,9 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	case S_IFGITLINK:
 		if (to_tempfile)
 			return error("git-checkout-index: cannot create temporary subproject %s", path);
-		if (mkdir(path, 0777) < 0)
-			return error("git-checkout-index: cannot create subproject directory %s", path);
+		err = write_submodule(ce, path, state);
+		if (err)
+			return err;
 		break;
 	default:
 		return error("git-checkout-index: unknown file mode for %s", path);
diff --git a/submodules.c b/submodules.c
index 44c0f2c..325de33 100644
--- a/submodules.c
+++ b/submodules.c
@@ -209,3 +209,46 @@ int clone_submodule(const char *submodule)
 
 	return 0;
 }
+
+static const char *relativize_path(const char *path, const char *dest)
+{
+	static char relative_path[PATH_MAX];
+	int slashes;
+	const char *cp;
+	char *rp;
+
+	if (path[0] == '/')
+		return path;
+
+	for (slashes = 0, cp = strchr(dest, '/'); cp; cp = strchr(cp, '/')) {
+		++slashes;
+		while (*cp == '/')
+			++cp;
+	}
+	if (3 * slashes + strlen(path) + 1 > sizeof(relative_path))
+		die("path too long");
+
+	rp = relative_path;
+	while (slashes--) {
+		memcpy(rp, "../", 3);
+		rp += 3;
+	}
+	strcpy(rp, path);
+
+	return relative_path;
+}
+
+int attach_submodule(const char *submodule)
+{
+	struct stat st;
+	const char *submodule_dir, *dest;
+
+	submodule_dir = git_path("submodules/%s/.git", submodule);
+	if (lstat(submodule_dir, &st))
+		return error("submodule '%s' unavailable", submodule);
+
+	dest = mkpath("%s/.git", submodule);
+	submodule_dir = relativize_path(submodule_dir, dest);
+
+	return symlink(submodule_dir, dest);
+}
diff --git a/submodules.h b/submodules.h
index bf3f118..57432bb 100644
--- a/submodules.h
+++ b/submodules.h
@@ -3,5 +3,6 @@
 
 int is_checkedout_submodule(const char *path);
 int clone_submodule(const char *submodule);
+int attach_submodule(const char *submodule);
 
 #endif
-- 
1.5.2.784.g5532e
