From: Heikki Orsila <shd@modeemi.fi>
Subject: [PATCH] Add core.sharedRepository == read-only-group
Date: Wed, 9 Apr 2008 22:37:19 +0300
Message-ID: <20080409193719.GB24451@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 21:49:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjgI1-0007Yq-6J
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 21:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbYDITsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 15:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754229AbYDITsQ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 15:48:16 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:56015 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980AbYDITsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 15:48:16 -0400
X-Greylist: delayed 622 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Apr 2008 15:48:15 EDT
Received: from amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70])
	by mail.cs.tut.fi (Postfix) with ESMTP id E2D687062
	for <git@vger.kernel.org>; Wed,  9 Apr 2008 22:37:50 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70]) (amavisd-maia, port 10024)
 with ESMTP id 08606-14 for <git@vger.kernel.org>;
 Wed,  9 Apr 2008 22:37:50 +0300 (EEST)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 5B5297060
	for <git@vger.kernel.org>; Wed,  9 Apr 2008 22:37:50 +0300 (EEST)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id 3C49F22202
	for <git@vger.kernel.org>; Wed,  9 Apr 2008 22:37:20 +0300 (EEST)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id E3FCE501AB; Wed,  9 Apr 2008 22:37:19 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79125>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

The attached patch adds a new permission mode for core.sharedRepository. 

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="0001-Add-core.sharedRepository-read-only-group.patch"

>From bbfa25faa17bb67e98107edabae114d833f1b838 Mon Sep 17 00:00:00 2001
From: Heikki Orsila <heikki.orsila@iki.fi>
Date: Wed, 9 Apr 2008 22:29:34 +0300
Subject: [PATCH] Add core.sharedRepository == read-only-group

core.sharedRepository == read-only-group allows setting Git repository
files group readable when the default umask of the user masks off group
reading. This can be useful for people with protective umasks (0077).

Note, PERM_READONLY_GROUP is added to the last position in
"enum sharedrepo" to avoid problems with old Git repositories, because
git init --shared stores numbers instead of symbolic names.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 Documentation/config.txt   |    5 +++--
 Documentation/git-init.txt |    5 ++++-
 cache.h                    |    3 ++-
 path.c                     |   33 +++++++++++++++++++--------------
 setup.c                    |    2 ++
 5 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fe43b12..6330b63 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -258,8 +258,9 @@ core.repositoryFormatVersion::
 core.sharedRepository::
 	When 'group' (or 'true'), the repository is made shareable between
 	several users in a group (making sure all the files and objects are
-	group-writable). When 'all' (or 'world' or 'everybody'), the
-	repository will be readable by all users, additionally to being
+	group-writable). When 'read-only-group', the repository is made
+	readable for users in a group. When 'all' (or 'world' or 'everybody'),
+	the repository will be readable by all users, additionally to being
 	group-shareable. When 'umask' (or 'false'), git will use permissions
 	reported by umask(2). See linkgit:git-init[1]. False by default.
 
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 62914da..e0613f9 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -31,7 +31,7 @@ structure, some suggested "exclude patterns", and copies of non-executing
 "hook" files.  The suggested patterns and hook files are all modifiable and
 extensible.
 
---shared[={false|true|umask|group|all|world|everybody}]::
+--shared[={false|true|umask|group|read-only-group|all|world|everybody}]::
 
 Specify that the git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
@@ -49,6 +49,9 @@ is given:
  - 'group' (or 'true'): Make the repository group-writable, (and g+sx, since
    the git group may be not the primary group of all users).
 
+ - 'read-only-group': Make the repository group-readable (and g+sx for
+   directories)
+
  - 'all' (or 'world' or 'everybody'): Same as 'group', but make the repository
    readable by all users.
 
diff --git a/cache.h b/cache.h
index 2a1e7ec..37f5e4a 100644
--- a/cache.h
+++ b/cache.h
@@ -477,7 +477,8 @@ int git_mkstemp(char *path, size_t n, const char *template);
 enum sharedrepo {
 	PERM_UMASK = 0,
 	PERM_GROUP,
-	PERM_EVERYBODY
+	PERM_EVERYBODY,
+	PERM_READONLY_GROUP,
 };
 int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
diff --git a/path.c b/path.c
index f4ed979..d3d68b8 100644
--- a/path.c
+++ b/path.c
@@ -266,22 +266,27 @@ int adjust_shared_perm(const char *path)
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
+	if (mode & S_IRUSR) {
+		if (shared_repository == PERM_GROUP ||
+		    shared_repository == PERM_READONLY_GROUP) {
+			mode |= S_IRGRP;
+		} else if (shared_repository == PERM_EVERYBODY) {
+			mode |= S_IRGRP | S_IROTH;
+		}
+	}
+
+	if ((mode & S_IWUSR) && shared_repository != PERM_READONLY_GROUP)
 		mode |= S_IWGRP;
 
-	if (mode & S_IXUSR)
-		mode |= (shared_repository == PERM_GROUP
-			 ? S_IXGRP
-			 : (shared_repository == PERM_EVERYBODY
-			    ? (S_IXGRP|S_IXOTH)
-			    : 0));
+	if (mode & S_IXUSR) {
+		if (shared_repository == PERM_GROUP ||
+		    shared_repository == PERM_READONLY_GROUP) {
+			mode |= S_IXGRP;
+		} else if (shared_repository == PERM_EVERYBODY) {
+			mode |= S_IXGRP | S_IXOTH;
+		}
+	}
+
 	if (S_ISDIR(mode))
 		mode |= FORCE_DIR_SET_GID;
 	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
diff --git a/setup.c b/setup.c
index 3d2d958..f5d05dc 100644
--- a/setup.c
+++ b/setup.c
@@ -434,6 +434,8 @@ int git_config_perm(const char *var, const char *value)
 			return PERM_UMASK;
 		if (!strcmp(value, "group"))
 			return PERM_GROUP;
+		if (!strcmp(value, "read-only-group"))
+			return PERM_READONLY_GROUP;
 		if (!strcmp(value, "all") ||
 		    !strcmp(value, "world") ||
 		    !strcmp(value, "everybody"))
-- 
1.5.4.4


--HcAYCG3uE/tztfnV--
