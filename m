From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Make core.sharedRepository more generic
Date: Tue, 15 Apr 2008 12:13:26 +0300
Message-ID: <20080415091326.GA18100@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 11:14:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlhF2-0003wO-0D
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 11:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754AbYDOJN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 05:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755961AbYDOJN3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 05:13:29 -0400
Received: from zakalwe.fi ([80.83.5.154]:47927 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755675AbYDOJN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 05:13:28 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id B8C0B2C331; Tue, 15 Apr 2008 12:13:26 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79577>

git init --shared=0xxx, where '0xxx' is an octal number, will create
a repository with file modes set to '0xxx'. Users with a safe umask
value (0077) can use this option to force file modes. For example,
'0640' is a group-readable but not group-writable regardless of
user's umask value. Values compatible with old Git versions are written
as they were before, for compatibility reasons. That is, "1" for
"group" and "2" for "everybody".

"git config core.sharedRepository 0xxx" is also handled.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
This is version 5 of the generic shared mode patch.

Version 2 handles the directory x flags better than version 1.

Version 3 removes a warning for the o+w case, fixes a compatibility
problem with older Git's, and corrects some style issues.

Version 4 really fixes the o+w case.

Version 5 fixes backwards compatibility for old versions of Git.
PERM_GROUP and PERM_EVERYBODY are written in the old numeric format
when doing "git init --shared".

Btw, the current behavior (not introduced by this patch) of
"config core.sharedRepository group" writes string "group" to the 
repository, so it creates incompatible repositories. For completeness
sake, we would need some kind of hooks to git_config_set_multivar().
Actually, the current architecture bothers me, as there should be some 
common "convention"/"system" for handling compatibility values for all 
commands.

 Documentation/config.txt   |    7 ++++-
 Documentation/git-init.txt |    8 +++++-
 builtin-init-db.c          |   11 ++++++-
 cache.h                    |   16 +++++++++--
 path.c                     |   32 +++++++++++------------
 setup.c                    |   60 +++++++++++++++++++++++++++++++++----------
 6 files changed, 96 insertions(+), 38 deletions(-)

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
index 2854868..a76f5d3 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -400,9 +400,16 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		char buf[10];
 		/* We do not spell "group" and such, so that
 		 * the configuration can be read by older version
-		 * of git.
+		 * of git. Note, we use octal numbers for new share modes,
+		 * and compatibility values for PERM_GROUP and
+		 * PERM_EVERYBODY.
 		 */
-		sprintf(buf, "%d", shared_repository);
+		if (shared_repository == PERM_GROUP)
+			sprintf(buf, "%d", OLD_PERM_GROUP);
+		else if (shared_repository == PERM_EVERYBODY)
+			sprintf(buf, "%d", OLD_PERM_EVERYBODY);
+		else
+			sprintf(buf, "0%o", shared_repository);
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
index f4ed979..cfa0529 100644
--- a/path.c
+++ b/path.c
@@ -266,24 +266,22 @@ int adjust_shared_perm(const char *path)
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
+		/* Copy read bits to execute bits */
+		mode |= (shared_repository & 0444) >> 2;
+	}
+
 	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
 		return -2;
 	return 0;
diff --git a/setup.c b/setup.c
index 3d2d958..1b4fa6a 100644
--- a/setup.c
+++ b/setup.c
@@ -428,21 +428,53 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 int git_config_perm(const char *var, const char *value)
 {
-	if (value) {
-		int i;
-		if (!strcmp(value, "umask"))
-			return PERM_UMASK;
-		if (!strcmp(value, "group"))
-			return PERM_GROUP;
-		if (!strcmp(value, "all") ||
-		    !strcmp(value, "world") ||
-		    !strcmp(value, "everybody"))
-			return PERM_EVERYBODY;
-		i = atoi(value);
-		if (i > 1)
-			return i;
+	int i;
+	char *endptr;
+
+	if (value == NULL)
+		return PERM_GROUP;
+
+	if (!strcmp(value, "umask"))
+		return PERM_UMASK;
+	if (!strcmp(value, "group"))
+		return PERM_GROUP;
+	if (!strcmp(value, "all") ||
+	    !strcmp(value, "world") ||
+	    !strcmp(value, "everybody"))
+		return PERM_EVERYBODY;
+
+	/* Parse octal numbers */
+	i = strtol(value, &endptr, 8);
+
+	/* If not an octal number, maybe true/false? */
+	if (*endptr != 0)
+		return git_config_bool(var, value) ? PERM_GROUP : PERM_UMASK;
+
+	/*
+	 * Treat values 0, 1 and 2 as compatibility cases, otherwise it is
+	 * a chmod value.
+	 */
+	switch (i) {
+	case PERM_UMASK:               /* 0 */
+		return PERM_UMASK;
+	case OLD_PERM_GROUP:           /* 1 */
+		return PERM_GROUP;
+	case OLD_PERM_EVERYBODY:       /* 2 */
+		return PERM_EVERYBODY;
 	}
-	return git_config_bool(var, value);
+
+	/* A filemode value was given: 0xxx */
+
+	if ((i & 0600) != 0600)
+		die("Problem with core.sharedRepository filemode value "
+		    "(0%.3o).\nThe owner of files must always have "
+		    "read and write permissions.", i);
+
+	/*
+	 * Mask filemode value. Others can not get write permission.
+	 * x flags for directories are handled separately.
+	 */
+	return i & 0666;
 }
 
 int check_repository_format_version(const char *var, const char *value)
-- 
1.5.4.4
