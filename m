From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moving initialization of log_all_ref_updates
Date: Sun, 07 Jan 2007 01:54:32 -0800
Message-ID: <7v4pr32mcn.fsf@assigned-by-dhcp.cox.net>
References: <7vbqlb2nqe.fsf@assigned-by-dhcp.cox.net>
	<20070107093725.GB10351@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 10:55:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Uk4-0006aj-CS
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 10:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbXAGJyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 04:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbXAGJyg
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 04:54:36 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44967 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbXAGJyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 04:54:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070107095433.RKKS15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Sun, 7 Jan 2007 04:54:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 89uo1W0021kojtg0000000; Sun, 07 Jan 2007 04:54:48 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070107093725.GB10351@spearce.org> (Shawn O. Pearce's message
	of "Sun, 7 Jan 2007 04:37:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36146>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Do we want to consider having init-db/clone set core.bare based on
> what they are being asked to do?

Here is what I have as a follow-up patch to the one you are
responding to.

--

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 97fd82f..e78222f 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -252,9 +252,13 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
-	/* Enable logAllRefUpdates if a working tree is attached */
-	if (!is_bare_git_dir(git_dir))
+	if (is_bare_repository()) {
+		git_config_set("core.bare", "true");
+	}
+	else {
+		git_config_set("core.bare", "false");
 		git_config_set("core.logallrefupdates", "true");
+	}
 	return reinit;
 }
 
diff --git a/cache.h b/cache.h
index 36be64e..cff2569 100644
--- a/cache.h
+++ b/cache.h
@@ -127,7 +127,8 @@ extern int cache_errno;
 #define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 
-extern int is_bare_git_dir(const char *dir);
+extern int is_bare_repository_cfg;
+extern int is_bare_repository(void);
 extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
diff --git a/config.c b/config.c
index 5cbd130..20e6ecc 100644
--- a/config.c
+++ b/config.c
@@ -269,6 +269,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.bare")) {
+		is_bare_repository_cfg = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.ignorestat")) {
 		assume_unchanged = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 64245e7..54c22f8 100644
--- a/environment.c
+++ b/environment.c
@@ -15,6 +15,7 @@ int use_legacy_headers = 1;
 int trust_executable_bit = 1;
 int assume_unchanged;
 int prefer_symlink_refs;
+int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int repository_format_version;
@@ -53,9 +54,13 @@ static void setup_git_env(void)
 		git_graft_file = xstrdup(git_path("info/grafts"));
 }
 
-int is_bare_git_dir(const char *dir)
+int is_bare_repository(void)
 {
-	const char *s;
+	const char *dir, *s;
+	if (0 <= is_bare_repository_cfg)
+		return is_bare_repository_cfg;
+
+	dir = get_git_dir();
 	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		return 0;
 	s = strrchr(dir, '/');
diff --git a/refs.c b/refs.c
index b5eee11..499086b 100644
--- a/refs.c
+++ b/refs.c
@@ -924,7 +924,7 @@ static int log_ref_write(struct ref_lock *lock,
 	const char *committer;
 
 	if (log_all_ref_updates < 0)
-		log_all_ref_updates = !is_bare_git_dir(get_git_dir());
+		log_all_ref_updates = !is_bare_repository();
 
 	if (log_all_ref_updates &&
 	    (!strncmp(lock->ref_name, "refs/heads/", 11) ||
