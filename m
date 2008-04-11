From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Add two core.sharedRepository options: group-readable and world-readable
Date: Fri, 11 Apr 2008 17:09:16 +0300
Message-ID: <20080411140916.GA30667@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 16:32:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkKIS-0003vY-J1
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 16:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760212AbYDKOaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 10:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760204AbYDKOaz
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 10:30:55 -0400
Received: from zakalwe.fi ([80.83.5.154]:38187 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760173AbYDKOay (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 10:30:54 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id E88752C333; Fri, 11 Apr 2008 17:09:16 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79274>

* 'group-readable': Make the repository group-readable (and g+sx for
  directories), even if the user's umask forbids it.

* 'world-readable': Make the repository readable for anyone, including
  the group (implies group-readable), even if the user's umask forbids
  it.

* Add a warning to cache.h that "enum sharedrepo" item order should
  not be changed because it would break backwards compatibility.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 Documentation/config.txt   |   13 ++++++++---
 Documentation/git-init.txt |    8 ++++++-
 cache.h                    |    6 ++++-
 path.c                     |   48 +++++++++++++++++++++++++++++--------------
 setup.c                    |    4 +++
 5 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fe43b12..ee13b2b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -258,10 +258,15 @@ core.repositoryFormatVersion::
 core.sharedRepository::
 	When 'group' (or 'true'), the repository is made shareable between
 	several users in a group (making sure all the files and objects are
-	group-writable). When 'all' (or 'world' or 'everybody'), the
-	repository will be readable by all users, additionally to being
-	group-shareable. When 'umask' (or 'false'), git will use permissions
-	reported by umask(2). See linkgit:git-init[1]. False by default.
+	group-writable). When 'group-readable', the repository will be
+	readable, but not writable, for users in the same group, even if the
+	user's umask forbids it. When 'all' (or 'world' or 'everybody'),
+	the repository will be readable by all users, additionally to being
+	group-shareable. When 'world-readable', the repository will be
+	readable for anyone, even if the user's umask forbids it. This option
+	implies 'group-readable'. When 'umask' (or 'false'), git will use
+	permissions reported by umask(2). See linkgit:git-init[1].
+	False by default.
 
 core.warnAmbiguousRefs::
 	If true, git will warn you if the ref name you passed it is ambiguous
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 62914da..6bbc09c 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -31,7 +31,7 @@ structure, some suggested "exclude patterns", and copies of non-executing
 "hook" files.  The suggested patterns and hook files are all modifiable and
 extensible.
 
---shared[={false|true|umask|group|all|world|everybody}]::
+--shared[={false|true|umask|group|group-readable|all|world|world-readable|everybody}]::
 
 Specify that the git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
@@ -49,6 +49,12 @@ is given:
  - 'group' (or 'true'): Make the repository group-writable, (and g+sx, since
    the git group may be not the primary group of all users).
 
+ - 'group-readable': Make the repository group-readable (and g+sx for
+   directories), even if the user's umask forbids it.
+
+ - 'world-readable': Make the repository readable for anyone, including
+   the group (implies group-readable), even if the user's umask forbids it.
+
  - 'all' (or 'world' or 'everybody'): Same as 'group', but make the repository
    readable by all users.
 
diff --git a/cache.h b/cache.h
index 2a1e7ec..4af6d62 100644
--- a/cache.h
+++ b/cache.h
@@ -474,10 +474,14 @@ static inline void hashclr(unsigned char *hash)
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
+/* Warning: enum sharedrepo item order should not be changed since it will
+ * break backwards compatibility. */
 enum sharedrepo {
 	PERM_UMASK = 0,
 	PERM_GROUP,
-	PERM_EVERYBODY
+	PERM_EVERYBODY,
+	PERM_GROUP_READABLE,
+	PERM_WORLD_READABLE,
 };
 int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
diff --git a/path.c b/path.c
index f4ed979..b900f62 100644
--- a/path.c
+++ b/path.c
@@ -266,22 +266,38 @@ int adjust_shared_perm(const char *path)
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
+
+	/* PERM_GROUP_READABLE:   g+r
+	 * PERM_GROUP:            g+rw
+	 * PERM_WORLD_READABLE:   g+r,  o+r
+	 * PERM_EVERYBODY:        g+rw, o+r
+	 */
+	if (mode & S_IRUSR) {
+		if (shared_repository == PERM_GROUP ||
+		    shared_repository == PERM_GROUP_READABLE) {
+			mode |= S_IRGRP;
+		} else if (shared_repository == PERM_EVERYBODY ||
+			   shared_repository == PERM_WORLD_READABLE) {
+			mode |= S_IRGRP | S_IROTH;
+		}
+	}
+
+	if (mode & S_IWUSR) {
+		if (shared_repository != PERM_GROUP_READABLE &&
+		    shared_repository != PERM_WORLD_READABLE)
+			mode |= S_IWGRP;
+	}
+
+	if (mode & S_IXUSR) {
+		if (shared_repository == PERM_GROUP ||
+		    shared_repository == PERM_GROUP_READABLE) {
+			mode |= S_IXGRP;
+		} else if (shared_repository == PERM_EVERYBODY ||
+			   shared_repository == PERM_WORLD_READABLE) {
+			mode |= S_IXGRP | S_IXOTH;
+		}
+	}
+
 	if (S_ISDIR(mode))
 		mode |= FORCE_DIR_SET_GID;
 	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
diff --git a/setup.c b/setup.c
index 3d2d958..a33ae9d 100644
--- a/setup.c
+++ b/setup.c
@@ -434,10 +434,14 @@ int git_config_perm(const char *var, const char *value)
 			return PERM_UMASK;
 		if (!strcmp(value, "group"))
 			return PERM_GROUP;
+		if (!strcmp(value, "group-readable"))
+			return PERM_GROUP_READABLE;
 		if (!strcmp(value, "all") ||
 		    !strcmp(value, "world") ||
 		    !strcmp(value, "everybody"))
 			return PERM_EVERYBODY;
+		if (!strcmp(value, "world-readable"))
+			return PERM_WORLD_READABLE;
 		i = atoi(value);
 		if (i > 1)
 			return i;
-- 
1.5.4.4
