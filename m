From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Make core.sharedRepository more generic
Date: Sat, 12 Apr 2008 21:51:05 +0300
Message-ID: <20080412185105.GA14331@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 20:52:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkkpa-0002tc-Sm
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 20:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884AbYDLSvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 14:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755738AbYDLSvI
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 14:51:08 -0400
Received: from zakalwe.fi ([80.83.5.154]:40814 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755092AbYDLSvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 14:51:07 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id C87662C331; Sat, 12 Apr 2008 21:51:05 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79373>

git init --shared=0xxx, where '0xxx' is an octal number, will create
a repository with file modes set to '0xxx'. User's with a safe umask
value (0077) can use this option to force file modes. For example,
'0640' is a group-readable but not group-writable regardless of
user's umask value.

"git config core.sharedRepository 0xxx" is also handled.
---
 Documentation/config.txt   |    7 +++++-
 Documentation/git-init.txt |    8 ++++++-
 builtin-init-db.c          |    4 +-
 cache.h                    |   16 ++++++++++++--
 path.c                     |   38 ++++++++++++++++++++----------------
 setup.c                    |   45 ++++++++++++++++++++++++++++++++++++++++---
 6 files changed, 90 insertions(+), 28 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fe43b12..7a24f6e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -261,7 +261,12 @@ core.sharedRepository::
 	group-writable). When 'all' (or 'world' or 'everybody'), the
 	repository will be readable by all users, additionally to being
 	group-shareable. When 'umask' (or 'false'), git will use permissions
-	reported by umask(2). See linkgit:git-init[1]. False by default.
+	reported by umask(2). When '0xxx', where '0xxx' is an octal number,
+	files in the repository will have this mode value. '0xxx' will override
+	user's umask value, and thus, users with a safe umask (0077) can use
+	this option. Examples: '0660' is equivalent to 'group'. '0640' is a
+	repository that is group-readable but not group-writable.
+	See linkgit:git-init[1]. False by default.
 
 core.warnAmbiguousRefs::
 	If true, git will warn you if the ref name you passed it is ambiguous
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 62914da..b17ae84 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -31,7 +31,7 @@ structure, some suggested "exclude patterns", and copies of non-executing
 "hook" files.  The suggested patterns and hook files are all modifiable and
 extensible.
 
---shared[={false|true|umask|group|all|world|everybody}]::
+--shared[={false|true|umask|group|all|world|everybody|0xxx}]::
 
 Specify that the git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
@@ -52,6 +52,12 @@ is given:
  - 'all' (or 'world' or 'everybody'): Same as 'group', but make the repository
    readable by all users.
 
+ - '0xxx': '0xxx' is an octal number and each file will have mode '0xxx'
+   Any option except 'umask' can be set using this option. '0xxx' will
+   override users umask(2) value, and thus, users with a safe umask (0077)
+   can use this option. '0640' will create a repository which is group-readable
+   but not writable. '0660' is equivalent to 'group'.
+
 By default, the configuration flag receive.denyNonFastForwards is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 2854868..8c63295 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -400,9 +400,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		char buf[10];
 		/* We do not spell "group" and such, so that
 		 * the configuration can be read by older version
-		 * of git.
+		 * of git. Note, we use octal numbers.
 		 */
-		sprintf(buf, "%d", shared_repository);
+		sprintf(buf, "0%o", shared_repository);
 		git_config_set("core.sharedrepository", buf);
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
diff --git a/cache.h b/cache.h
index 2a1e7ec..f9c8d2b 100644
--- a/cache.h
+++ b/cache.h
@@ -474,10 +474,20 @@ static inline void hashclr(unsigned char *hash)
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
+/*
+ * NOTE NOTE NOTE!!
+ *
+ * PERM_UMASK, OLD_PERM_GROUP and OLD_PERM_EVERYBODY enumerations must
+ * not be changed. Old repositories have core.sharedrepository written in
+ * numeric format, and therefore these values are preserved for compatibility
+ * reasons.
+ */
 enum sharedrepo {
-	PERM_UMASK = 0,
-	PERM_GROUP,
-	PERM_EVERYBODY
+	PERM_UMASK          = 0,
+	OLD_PERM_GROUP      = 1,
+	OLD_PERM_EVERYBODY  = 2,
+	PERM_GROUP          = 0660,
+	PERM_EVERYBODY      = 0664,
 };
 int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
diff --git a/path.c b/path.c
index f4ed979..79bfe82 100644
--- a/path.c
+++ b/path.c
@@ -266,24 +266,28 @@ int adjust_shared_perm(const char *path)
 	if (lstat(path, &st) < 0)
 		return -1;
 	mode = st.st_mode;
-	if (mode & S_IRUSR)
-		mode |= (shared_repository == PERM_GROUP
-			 ? S_IRGRP
-			 : (shared_repository == PERM_EVERYBODY
-			    ? (S_IRGRP|S_IROTH)
-			    : 0));
-
-	if (mode & S_IWUSR)
-		mode |= S_IWGRP;
-
-	if (mode & S_IXUSR)
-		mode |= (shared_repository == PERM_GROUP
-			 ? S_IXGRP
-			 : (shared_repository == PERM_EVERYBODY
-			    ? (S_IXGRP|S_IXOTH)
-			    : 0));
-	if (S_ISDIR(mode))
+
+	if (shared_repository) {
+		mode = (mode & ~0777) | shared_repository;
+	} else {
+		/* Preserve old PERM_UMASK behaviour */
+		if (mode & S_IWUSR)
+			mode |= S_IWGRP;
+	}
+
+	if (S_ISDIR(mode)) {
 		mode |= FORCE_DIR_SET_GID;
+
+		/*
+		 * The x flag for directories is determined from rw flags of
+		 * user, group and others. Having a directory with +rw but
+		 * -x does not make sense for Git repositories.
+		 */
+		mode |= (shared_repository & 0600) ? S_IXUSR : 0;
+		mode |= (shared_repository & 0060) ? S_IXGRP : 0;
+		mode |= (shared_repository & 0006) ? S_IXOTH : 0;
+	}
+
 	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
 		return -2;
 	return 0;
diff --git a/setup.c b/setup.c
index 3d2d958..0905509 100644
--- a/setup.c
+++ b/setup.c
@@ -430,6 +430,8 @@ int git_config_perm(const char *var, const char *value)
 {
 	if (value) {
 		int i;
+		char *endptr;
+
 		if (!strcmp(value, "umask"))
 			return PERM_UMASK;
 		if (!strcmp(value, "group"))
@@ -438,11 +440,46 @@ int git_config_perm(const char *var, const char *value)
 		    !strcmp(value, "world") ||
 		    !strcmp(value, "everybody"))
 			return PERM_EVERYBODY;
-		i = atoi(value);
-		if (i > 1)
-			return i;
+
+		/* Parse octal numbers */
+		i = strtol(value, &endptr, 8);
+		if (*endptr != 0) {
+			/* Not an octal number. Maybe true/false? */
+			if (git_config_bool(var, value))
+				return PERM_GROUP;
+			else
+				return PERM_UMASK;
+		}
+
+		/* Handle compatibility cases */
+		switch (i) {
+		case PERM_UMASK:               /* 0 */
+			return PERM_UMASK;
+		case OLD_PERM_GROUP:           /* 1 */
+			return PERM_GROUP;
+		case OLD_PERM_EVERYBODY:       /* 2 */
+			return PERM_EVERYBODY;
+		}
+
+		/* A filemode value was given: 0xxx */
+
+		if ((i & 0600) != 0600)
+			die("Problem with core.sharedRepository filemode value"
+			    " (0%.3o).\nThe owner of files must always have "
+			    "read and write permissions.", i);
+
+		if (i & 0002)
+			warning("core.sharedRepository filemode (0%.3o) is a "
+				"security threat.\nMasking off write "
+				"permission for others\n", i);
+
+		/*
+                 * Mask filemode value. Others can not get write permission.
+		 * x flags for directories are handled separately.
+                 */
+		return i & 0664;
 	}
-	return git_config_bool(var, value);
+	return PERM_GROUP;
 }
 
 int check_repository_format_version(const char *var, const char *value)
-- 
1.5.4.4
