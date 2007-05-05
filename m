From: Dana How <danahow@gmail.com>
Subject: [PATCH v3] Support ent:relative_path
Date: Fri, 04 May 2007 17:47:08 -0700
Message-ID: <463BD40C.6080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 02:47:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk8Qf-0000Yq-GP
	for gcvg-git@gmane.org; Sat, 05 May 2007 02:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423517AbXEEArN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 20:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423705AbXEEArN
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 20:47:13 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:16329 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423517AbXEEArM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 20:47:12 -0400
Received: by py-out-1112.google.com with SMTP id a29so817945pyi
        for <git@vger.kernel.org>; Fri, 04 May 2007 17:47:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=UhTd5Xgnv6nYoGI7CIAZX+5gG8vL6vMAHkfwZl7mGrITibJIK3FFVLfb/0KT6CX9wwKiDFGCHjhh5R1hrWBDtVSBUjgaGtUtOKDH57yia/kexwovS9JwoWmP+nqtf53NYScWMpUMgdRQbla/muyExuPrVfv2V01+qMA0ooivtRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=gW5csgNmrdbmVG6vAlDF8g75WpPQdWNzPP9NWwG8R+WPMx4slDv+hbeXo6h99h87iIFZaHgHoq0Wyd5XMnzuGrJ75q79Xs174fnFjbYcl7NE79AqWuZ6zSVmUWQY6/xABoqio/0VuW8dussql7RB2ttrAvWN2V+yRcCXAEO26cQ=
Received: by 10.35.94.7 with SMTP id w7mr6179371pyl.1178326031996;
        Fri, 04 May 2007 17:47:11 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 20sm16326992nzp.2007.05.04.17.47.10;
        Fri, 04 May 2007 17:47:11 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46232>


Most commands accept relative paths,  but this is
not true of arguments in ent:path format.  This
patch makes all of the following git-show commands
work in the git source tree (not just the first):
 % cd xdiff
 % git-show v1.5.2-rc0:xdiff/xemit.h
 % git-show v1.5.2-rc0:./xemit.h
 % git-show v1.5.2-rc0:../sha1_name.c

It also adds ent:?string as a synonym for ent:/string .
This makes the following changes possible later:
ent:/path is an absolute path and ent:path is relative.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 cache.h     |    1 +
 setup.c     |    5 +++-
 sha1_name.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 8e76152..53507d9 100644
--- a/cache.h
+++ b/cache.h
@@ -215,6 +215,7 @@ extern char *get_graft_file(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+extern const char *prefix_to_cwd;
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/setup.c b/setup.c
index a45ea83..46ae6e3 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,7 @@
 #include "cache.h"
 
+const char *prefix_to_cwd;
+
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
@@ -252,7 +254,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	cwd[len++] = '/';
 	cwd[len] = 0;
 	inside_git_dir = !prefixcmp(cwd + offset, ".git/");
-	return cwd + offset;
+	prefix_to_cwd = cwd + offset;
+	return prefix_to_cwd;
 }
 
 int git_config_perm(const char *var, const char *value)
diff --git a/sha1_name.c b/sha1_name.c
index 55f25a2..dd415c1 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -593,6 +593,67 @@ static int handle_one_ref(const char *path,
 }
 
 /*
+ * Future: nonzero to assume relative paths
+ */
+#define	ENT_COLON_ASSUME_RELATIVE	0
+
+/*
+ * Modify path into a full absolute path with no leading "/"
+ * and no "." or "..".  If we can't,
+ * leave input unaltered for client's error message.
+ */
+static void prepend_prefix(const char **cp, int *namelen)
+{
+	char *t, *t2;
+	const char *cp2 = *cp;
+	int type, namelen2 = *namelen;
+	static char fullpath[PATH_MAX];
+	int fixup = strstr(cp2, "/./") || strstr(cp2, "/../");
+	for (type = 4; --type > 0; )
+		if (namelen2 > type && !memcmp(cp2, "../" + 3 - type, type))
+			break;
+
+	/* handle simple cases else create absolute path */
+	fullpath[0] = 0;
+	if ((type == 0 && !ENT_COLON_ASSUME_RELATIVE) || type == 1) {
+		if (!fixup) goto done;
+	} else
+	if (prefix_to_cwd) {
+		namelen2 += strlen(prefix_to_cwd);
+		if (namelen2 >= PATH_MAX)
+			die("path too long");
+		strcpy(fullpath, prefix_to_cwd);
+		type = 0;
+	} else
+	if (type == 2) {
+		if (!fixup) goto done;
+	} else
+	if (type == 3)
+		return;	/* client will complain */
+	cp2 = strcat(fullpath, cp2);
+
+	while ((t = strstr(cp2, "/./")) != NULL)
+		memmove(t, t + 2, (namelen2 -= 2) - (t - cp2) + 1);
+
+	while ((t = strstr(cp2, "/../")) != NULL) {
+		if (t == cp2 || (t == cp2 + 1 && t[-1] == '.'))
+			return;	/* client will complain */
+		for (t2 = t; --t2 >= cp2 && *t2 != '/'; )
+			/* nothing */;
+		if (t2 < cp2) {
+			namelen2 -= t + 4 - cp2;
+			cp2 = t + 4;
+		} else {
+			memmove(t2, t + 3, namelen2 - (t + 3 - cp2) + 1);
+			namelen2 -= t + 3 - t2;
+		}
+	}
+
+done:	*cp = cp2 + type;
+	*namelen = namelen2 - type;
+}
+
+/*
  * This interprets names like ':/Initial revision of "git"' by searching
  * through history and returning the first commit whose message starts
  * with the given string.
@@ -647,6 +708,11 @@ int get_sha1(const char *name, unsigned char *sha1)
 	return get_sha1_with_mode(name, sha1, &unused);
 }
 
+/*
+ * Future: change to '?'
+ */
+#define	ENT_COLON_OLD_SEARCH	'/'
+
 int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 {
 	int ret, bracket_depth;
@@ -666,7 +732,8 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 		int stage = 0;
 		struct cache_entry *ce;
 		int pos;
-		if (namelen > 2 && name[1] == '/')
+		if (namelen > 2 &&
+		    (name[1] == ENT_COLON_OLD_SEARCH || name[1] == '?'))
 			return get_sha1_oneline(name + 2, sha1);
 		if (namelen < 3 ||
 		    name[2] != ':' ||
@@ -681,6 +748,7 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 			read_cache();
 		if (active_nr < 0)
 			return -1;
+		prepend_prefix(&cp, &namelen);
 		pos = cache_name_pos(cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
@@ -708,9 +776,11 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 	}
 	if (*cp == ':') {
 		unsigned char tree_sha1[20];
-		if (!get_sha1_1(name, cp-name, tree_sha1))
-			return get_tree_entry(tree_sha1, cp+1, sha1,
-					      mode);
+		if (!get_sha1_1(name, cp - name, tree_sha1)) {
+			namelen -= ++cp - name;
+			prepend_prefix(&cp, &namelen);
+			return get_tree_entry(tree_sha1, cp, sha1, mode);
+		}
 	}
 	return ret;
 }
-- 
1.5.2.rc0.787.g0014
