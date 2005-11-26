From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] Repository format version check.
Date: Fri, 25 Nov 2005 17:15:09 -0800
Message-ID: <7viruggqg2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 26 02:16:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efof0-0004aa-BN
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 02:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVKZBPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 20:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVKZBPM
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 20:15:12 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:7568 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932311AbVKZBPL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 20:15:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126011442.VMFA3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 25 Nov 2005 20:14:42 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12761>

This adds the repository format version code, first done by
Martin Atukunda.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 cache.h       |    5 +++++
 environment.c |    1 +
 setup.c       |   16 ++++++++++++++++
 3 files changed, 22 insertions(+), 0 deletions(-)

applies-to: 31b3c7eeb719c61a19922f3e8bf5abd46b49b5bb
58fd7fb9718df942773862c9acd2358533c672d4
diff --git a/cache.h b/cache.h
index 6ac94c5..de53f41 100644
--- a/cache.h
+++ b/cache.h
@@ -182,6 +182,10 @@ extern int trust_executable_bit;
 extern int only_use_symrefs;
 extern int diff_rename_limit_default;
 
+#define GIT_REPO_VERSION 0
+extern int repository_format_version;
+extern int check_repository_format(void);
+
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
 #define OWNER_CHANGED	0x0004
@@ -388,6 +392,7 @@ extern int git_config_int(const char *, 
 extern int git_config_bool(const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
+extern int check_repository_format_version(const char *var, const char *value);
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/environment.c b/environment.c
index b5026f1..3f19473 100644
--- a/environment.c
+++ b/environment.c
@@ -13,6 +13,7 @@ char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
 int only_use_symrefs = 0;
+int repository_format_version = 0;
 
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
 	*git_graft_file;
diff --git a/setup.c b/setup.c
index ab3c778..0e2e3c8 100644
--- a/setup.c
+++ b/setup.c
@@ -154,6 +154,22 @@ static const char *setup_git_directory_1
 	return cwd + offset;
 }
 
+int check_repository_format_version(const char *var, const char *value)
+{
+       if (strcmp(var, "core.repositoryformatversion") == 0)
+               repository_format_version = git_config_int(var, value);
+       return 0;
+}
+
+int check_repository_format(void)
+{
+	git_config(check_repository_format_version);
+	if (GIT_REPO_VERSION < repository_format_version)
+		die ("Expected git repo version <= %d, found %d",
+		     GIT_REPO_VERSION, repository_format_version);
+	return 0;
+}
+
 const char *setup_git_directory(void)
 {
 	const char *retval = setup_git_directory_1();
---
0.99.9.GIT
