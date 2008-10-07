From: Jonathan del Strother <jon.delStrother@bestbefore.tv>
Subject: [PATCH/RFC] Add post-init hook
Date: Wed,  8 Oct 2008 00:10:33 +0100
Message-ID: <1223421033-22340-1-git-send-email-jon.delStrother@bestbefore.tv>
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 01:13:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnLk1-0003AV-Om
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 01:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbYJGXMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 19:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbYJGXMJ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 19:12:09 -0400
Received: from cumberland.bestbefore.tv ([82.165.41.205]:35828 "EHLO
	cumberland.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbYJGXMI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 19:12:08 -0400
Received: (qmail 29171 invoked from network); 8 Oct 2008 00:12:04 +0100
Received: from 87.115.25.164.plusnet.pcl-ag01.dyn.plus.net (HELO localhost.localdomain) (87.115.25.164)
  by cumberland.bestbefore.tv with SMTP; 8 Oct 2008 00:12:04 +0100
X-Mailer: git-send-email 1.6.0.2.454.g27632.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97754>

This adds a configuration variable 'init.post-init-file', to supply a path to a script that will be run following git-init (and thus also git-clone).

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---

I have a number of hooks that I have to install every time I create/clone a repository.  This patch adds a post-init hook that's perfect for setting up that sort of stuff.
It's my first git patch that does much C work (even if it was mostly a cut & paste job) - comments would be welcome.

 Documentation/config.txt   |    4 ++++
 Documentation/git-init.txt |    7 +++++++
 builtin-init-db.c          |   36 ++++++++++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bbe38cc..746d663 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -881,6 +881,10 @@ i18n.logOutputEncoding::
 	Character encoding the commit messages are converted to when
 	running 'git-log' and friends.
 
+init.post-init-file::
+	A path to a script to run on the initialization of any git
+	repository.
+
 instaweb.browser::
 	Specify the program that will be used to browse your working
 	repository in gitweb. See linkgit:git-instaweb[1].
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 71749c0..c6ab6c9 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -113,6 +113,13 @@ $ git add .     <2>
 <2> add all existing file to the index
 
 
+CONFIGURATION
+-------------
+
+The global configuration variable init.post-init-file can be used to specify
+a script to be run whenever a repository is created.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 8140c12..7a3d5c7 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "run-command.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -17,6 +18,37 @@
 #define TEST_FILEMODE 1
 #endif
 
+static const char* post_init_path;
+
+static int init_config(const char *var, const char *value, void *cb)
+{
+	if (!strcasecmp(var, "init.post-init-file")) {
+		return git_config_string(&post_init_path, var, value);
+	}
+	return git_default_config(var, value, cb);
+}
+
+
+static int post_init_hook()
+{
+	if (!post_init_path)
+		return 0;
+
+	struct child_process proc;
+	const char *argv[2];
+
+	if (access(post_init_path, X_OK) < 0)
+		return 0;
+
+	memset(&proc, 0, sizeof(proc));
+	argv[0] = post_init_path;
+	argv[1] = NULL;
+	proc.argv = argv;
+	proc.no_stdin = 1;
+	proc.stdout_to_stderr = 1;
+	return run_command(&proc);
+}
+
 static void safe_create_dir(const char *dir, int share)
 {
 	if (mkdir(dir, 0777) < 0) {
@@ -190,7 +222,7 @@ static int create_default_files(const char *template_path)
 	 */
 	copy_templates(template_path);
 
-	git_config(git_default_config, NULL);
+	git_config(init_config, NULL);
 
 	/*
 	 * We would have created the above under user's umask -- under
@@ -321,7 +353,7 @@ int init_db(const char *template_dir, unsigned int flags)
 		       shared_repository ? " shared" : "",
 		       get_git_dir());
 
-	return 0;
+	return post_init_hook();
 }
 
 static int guess_repository_type(const char *git_dir)
-- 
1.6.0.2.454.g27632.dirty
