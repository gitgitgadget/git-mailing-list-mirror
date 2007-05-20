From: skimo@liacs.nl
Subject: [PATCH 14/15] entry.c: optionall checkout newly cloned submodules
Date: Sun, 20 May 2007 20:04:47 +0200
Message-ID: <1179684290298-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppmt-0007La-OJ
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963AbXETSFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757177AbXETSFU
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:05:20 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37220 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757041AbXETSFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:05:04 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4smH007828;
	Sun, 20 May 2007 20:04:59 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 3EF947DDAD; Sun, 20 May 2007 20:04:50 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47872>

From: Sven Verdoolaege <skimo@kotnet.org>

---
 entry.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 8c70a47..24bf161 100644
--- a/entry.c
+++ b/entry.c
@@ -104,10 +104,63 @@ static int checkout_submodule(struct cache_entry *ce, const char *path, const st
 	return 0;
 }
 
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
+static int write_submodule(struct cache_entry *ce, char *path, const struct checkout *state)
+{
+	struct stat st;
+	const char *submodule_dir, *dest;
+
+	if (mkdir(path, 0777) < 0)
+		return error("git-checkout-index: cannot create subproject directory %s", path);
+
+	if (!state->submodules)
+		return 0;
+
+	submodule_dir = git_path("submodules/%s/.git", ce->name);
+	if (lstat(submodule_dir, &st))
+		return error("submodule '%s' unavailable", ce->name);
+
+	dest = mkpath("%s/.git", ce->name);
+	submodule_dir = relativize_path(submodule_dir, dest);
+
+	if (symlink(submodule_dir, dest))
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
@@ -177,8 +230,9 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	case S_IFDIRLNK:
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
-- 
1.5.2.rc3.815.g8fc2
