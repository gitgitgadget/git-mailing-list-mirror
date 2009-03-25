From: Johan Herland <johan@herland.net>
Subject: [PATCH/RFC 3/7] Introduce core.restrictedRepository for restricting
 repository permissions
Date: Wed, 25 Mar 2009 22:39:16 +0100
Message-ID: <200903252239.16594.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
 <200903252236.03010.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:41:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmaqG-0006bY-B5
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbZCYVjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbZCYVjW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:39:22 -0400
Received: from mx.getmail.no ([84.208.15.66]:37243 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752145AbZCYVjV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 17:39:21 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH30098T05I9300@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:39:18 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH3002H705G1700@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:39:18 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.25.212528
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <200903252236.03010.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114674>

core.sharedRepository is only used to loosen/expand permissions (beyond the
user's umask). In order to tighten/restrict permissions (stricter than the
umask), we add a new configuration variable that serves as an additional
mask on the permissions of created files and directories.

The new config variable - core.restrictedRepository - can be set to an octal
number, interpreted as an additional mask to be applied to the permissions
of created files and directories. It can also be set to "umask" (or "false",
equivalent to "0000", i.e. no more restrictive than the user's umask), "user"
(or "true", equivalent to "0077", i.e. dropping read- and write-permissions
for group and others), or "group" (equivalent to "0007", i.e. dropping read-
and write-permissions for others). If set with no value, it defaults to
"user" (the most secure/restricted state).

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/config.txt |   26 ++++++++++++++++++++++++++
 cache.h                  |    7 +++++++
 environment.c            |    1 +
 path.c                   |   14 ++++++++------
 setup.c                  |   36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5befd5..0f2dd5c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -305,8 +305,34 @@ core.sharedRepository::
 	example, if umask is 0022, setting 'group' (or '0660') will not make
 	the repository non world-readable (the actual mode value will in fact
 	be '0664').
+	See "core.restrictedRepository" for how to restrict repository access
+	below/within the umask.
 	See linkgit:git-init[1]. False by default.
 
+core.restrictedRepository::
+	When 'user' (or 'true'), the repository is made inaccessible to
+	anybody but the user owning the repository. When 'group', repository
+	access is restricted to the members of the repository's group.
+	When 'umask' (or 'false'), git will use permissions reported by
+	umask(2). When '0xxx', where '0xxx' is an octal number, files in the
+	repository will the specified mode bits masked off. '0xxx' will
+	override a more lenient umask value, and thus, users with a loose
+	umask (e.g. 0022) can use this option to further restrict the
+	repository permissions.
+	Examples: '0007' is equivalent to 'group'. '0077' is a repository
+	that is only accessible to the repository owner.
+	Note: Even when not set to 'umask' (or 'false') this option is still
+	combined with the umask to produce the actual mask value. For
+	example, if umask is 0077, setting 'group' (or '0007') will not make
+	the repository group-accessible (the calculated mode mask will in
+	fact be '0077', restricting access to the repository owner only).
+	See "core.sharedRepository" for how to loosen repository access
+	beyond the umask.
+	Example: To set up a group-shared repository that is inaccessible to
+	all non-members, set both "core.sharedRepository" and
+	"core.restrictedRepository" to "group".
+	False by default.
+
 core.warnAmbiguousRefs::
 	If true, git will warn you if the ref name you passed it is ambiguous
 	and might match multiple refs in the .git/refs/ tree. True by default.
diff --git a/cache.h b/cache.h
index 9cf5a13..4730f33 100644
--- a/cache.h
+++ b/cache.h
@@ -508,6 +508,7 @@ extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
+extern int restricted_repository;
 extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
 extern int core_compression_level;
@@ -622,7 +623,13 @@ enum sharedrepo {
 	PERM_GROUP          = 0660,
 	PERM_EVERYBODY      = 0664,
 };
+enum restrictedrepo {
+	PERM_MASK_UMASK     = 0000,
+	PERM_MASK_GROUP     = 0007,
+	PERM_MASK_USER      = 0077,
+};
 int git_config_perm(const char *var, const char *value);
+int git_config_perm_mask(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
diff --git a/environment.c b/environment.c
index 4696885..9591710 100644
--- a/environment.c
+++ b/environment.c
@@ -25,6 +25,7 @@ int repository_format_version;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
+int restricted_repository = PERM_MASK_UMASK;
 const char *apply_default_whitespace;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
diff --git a/path.c b/path.c
index 28e50d3..093c87c 100644
--- a/path.c
+++ b/path.c
@@ -316,25 +316,27 @@ int adjust_shared_perm(const char *path)
 	struct stat st;
 	int mode;
 
-	if (!shared_repository)
+	if (!shared_repository && !restricted_repository)
 		return 0;
 	if (lstat(path, &st) < 0)
 		return -1;
 	mode = st.st_mode;
 
-	int tweak = shared_repository;
 	if (!(mode & S_IWUSR))
-		tweak &= ~0222;
-	mode |= tweak;
+		restricted_repository |= 0222;
+
+	/* add shared_repository and subtract restricted_repository */
+	mode |= shared_repository;
+	mode &= ~restricted_repository;
 
 	if (S_ISDIR(mode)) {
 		mode |= FORCE_DIR_SET_GID;
 
 		/* Copy read bits to execute bits */
-		mode |= (shared_repository & 0444) >> 2;
+		mode |= (mode & 0444) >> 2;
 	}
 
-	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
+	if (st.st_mode != mode && chmod(path, mode) < 0)
 		return -2;
 	return 0;
 }
diff --git a/setup.c b/setup.c
index 6c2deda..97685d4 100644
--- a/setup.c
+++ b/setup.c
@@ -459,12 +459,48 @@ int git_config_perm(const char *var, const char *value)
 	return i & 0666;
 }
 
+int git_config_perm_mask(const char *var, const char *value)
+{
+	int i;
+	char *endptr;
+
+	if (value == NULL)
+		return PERM_MASK_USER;
+
+	if (!strcmp(value, "umask"))
+		return PERM_MASK_UMASK;
+	if (!strcmp(value, "group"))
+		return PERM_MASK_GROUP;
+	if (!strcmp(value, "user"))
+		return PERM_MASK_USER;
+
+	/* Parse octal numbers */
+	i = strtol(value, &endptr, 8);
+
+	/* If not an octal number, maybe true/false? */
+	if (*endptr != 0)
+		return git_config_bool(var, value) ? PERM_MASK_USER :
+			PERM_MASK_UMASK;
+
+	/* A filemode mask value was given: 0xxx */
+
+	if (i & 0700)
+		die("Problem with core.restrictedRepository filemode mask "
+		    "value (0%.3o).\nThe owner of files must always have "
+		    "read and write permissions.", i);
+
+	/* Mask filemode mask value. Should only affect r/w/x flags for g/o */
+	return i & 0077;
+}
+
 int check_repository_format_version(const char *var, const char *value, void *cb)
 {
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		repository_format_version = git_config_int(var, value);
 	else if (strcmp(var, "core.sharedrepository") == 0)
 		shared_repository = git_config_perm(var, value);
+	else if (strcmp(var, "core.restrictedrepository") == 0)
+		restricted_repository = git_config_perm_mask(var, value);
 	else if (strcmp(var, "core.bare") == 0) {
 		is_bare_repository_cfg = git_config_bool(var, value);
 		if (is_bare_repository_cfg == 1)
-- 
1.6.2.1.473.g92672
