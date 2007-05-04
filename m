From: Dana How <danahow@gmail.com>
Subject: [PATCH] Support ent:relative_path
Date: Fri, 04 May 2007 00:18:41 -0700
Message-ID: <463ADE51.2030108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 09:18:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjs46-0007Et-Qm
	for gcvg-git@gmane.org; Fri, 04 May 2007 09:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbXEDHSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 03:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbXEDHSu
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 03:18:50 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:50556 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286AbXEDHSt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 03:18:49 -0400
Received: by py-out-1112.google.com with SMTP id a29so616818pyi
        for <git@vger.kernel.org>; Fri, 04 May 2007 00:18:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Tffmk6+iGKjAUEMPxIf23KSyuemgv/l4wTjmVo/r64JIhI32hyfdxR2RG8ufMbFld7zmNU4jnf9p7rKCajJTeuHNI3ewRObs4kVHXp8wmsEMUIqkbaqFaZKn8+ROsws4w0soo88NZio4YlWc/OAG2jDvopNaVDnh6V84/bLXIvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=p98SXNuADAUA1d3g1A9aNUO4Fa6oOQsfHmx2Bgk0CFZX4otkrWwpNunUH0MMqSp7OSFdrcjRUPMKJ2trxwtDTcfLb/QvYkTLHUTHGCdYTYyA63ZceF3vy1k8zwDLdpR2CU2xK4HZPG7yW5TURqIR3cPYtICGqnQkE8WB2XfIOws=
Received: by 10.65.210.18 with SMTP id m18mr5251385qbq.1178263128218;
        Fri, 04 May 2007 00:18:48 -0700 (PDT)
Received: from ?192.168.5.42? ( [64.186.171.227])
        by mx.google.com with ESMTP id 39sm8495073nzk.2007.05.04.00.18.45;
        Fri, 04 May 2007 00:18:46 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46136>


Most commands accept relative paths,  but this is
not true of arguments in ent:path format.  This
patch makes all 3 of the following git-show commands
work in the git source tree (not just the first):
 % cd xdiff
 % git-show v1.5.2-rc0:xdiff/xemit.h
 % git-show v1.5.2-rc0:./xemit.h
 % git-config --bool core.relativepaths yes
 % git-show v1.5.2-rc0:xemit.h

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 cache.h       |    2 ++
 config.c      |    5 +++++
 environment.c |    1 +
 setup.c       |    5 ++++-
 sha1_name.c   |   27 ++++++++++++++++++++++++---
 5 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 8e76152..fc3fcb1 100644
--- a/cache.h
+++ b/cache.h
@@ -215,6 +215,7 @@ extern char *get_graft_file(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+extern const char *prefix_to_cwd;
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
@@ -276,6 +277,7 @@ extern int delete_ref(const char *, const unsigned char *sha1);
 extern int use_legacy_headers;
 extern int trust_executable_bit;
 extern int has_symlinks;
+extern int assume_relative_paths;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
diff --git a/config.c b/config.c
index 70d1055..7525965 100644
--- a/config.c
+++ b/config.c
@@ -279,6 +279,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.relativepaths")) {
+		assume_relative_paths = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.ignorestat")) {
 		assume_unchanged = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 2231659..f1b867d 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@ char git_default_name[MAX_GITNAME];
 int use_legacy_headers = 1;
 int trust_executable_bit = 1;
 int has_symlinks = 1;
+int assume_relative_paths;
 int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
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
index 55f25a2..0b9e92c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -592,6 +592,24 @@ static int handle_one_ref(const char *path,
 	return 0;
 }
 
+static void prepend_prefix(const char **cp, int *namelen)
+{
+	static char fullpath[PATH_MAX];
+	if (*namelen > 2 && !memcmp(*cp, "./", 2)) {
+		*cp += 2;
+		*namelen -= 2;
+	} else
+	if (!assume_relative_paths || !prefix_to_cwd)
+		return;
+
+	*namelen += strlen(prefix_to_cwd);
+	if (*namelen >= PATH_MAX)
+		die("path too long");
+	strcpy(fullpath, prefix_to_cwd);
+	strcat(fullpath, *cp);
+	*cp = fullpath;
+}
+
 /*
  * This interprets names like ':/Initial revision of "git"' by searching
  * through history and returning the first commit whose message starts
@@ -681,6 +699,7 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 			read_cache();
 		if (active_nr < 0)
 			return -1;
+		prepend_prefix(&cp, &namelen);
 		pos = cache_name_pos(cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
@@ -708,9 +727,11 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
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
