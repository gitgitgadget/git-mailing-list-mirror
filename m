From: Karl Chen <quarl@cs.berkeley.edu>
Subject: [PATCH] Support "core.excludesfile = ~/.gitignore"
Date: Thu, 21 Aug 2008 21:14:48 -0700
Message-ID: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 06:22:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWOAU-0004A2-Px
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 06:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbYHVEVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 00:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbYHVEVb
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 00:21:31 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:59413 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbYHVEVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 00:21:31 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Aug 2008 00:21:31 EDT
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 26B543441F; Thu, 21 Aug 2008 21:14:48 -0700 (PDT)
X-Quack-Archive: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93250>


I keep my rc files, including .gitconfig and my default gitignore
list under version control and like to have the same contents
everywhere.  Unfortunately my home directory is at different
locations on different systems.

I'd like to be able to put something like this in my ~/.gitconfig:

[core]
        excludesfile = ~/.gitignore

or
        excludesfile = $HOME/.gitignore

Another idea is to have a non-absolute path be interpreted
relative to the location of .gitconfig, i.e. $HOME, instead of the
current directory.  $GIT_DIR/info/excludes is already for
repository-specific excludes so no functionality would be lost.


Below is a sample patch that works for me.  We could also use
getpwuid(getuid()) instead of getenv("HOME") to be consistent with
user_path() but this is simpler and arguably more likely what the
user wants when it matters.


>From 6eb18f8ade791521bdad955e1da2b40399a426f0 Mon Sep 17 00:00:00 2001
From: Karl Chen <quarl@quarl.org>
Date: Thu, 21 Aug 2008 21:00:26 -0700
Subject: [PATCH] Support "core.excludesfile = ~/.gitignore"

The config variable core.excludesfile is parsed to substitute leading "~/"
with getenv("HOME").

Signed-off-by: Karl Chen <quarl@quarl.org>

---
 config.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 53f04a0..41061d2 100644
--- a/config.c
+++ b/config.c
@@ -334,6 +334,18 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+static char const *git_config_subst_userdir(char const *value) {
+	if (value[0] == '~' && value[1] == '/') {
+		const char *home = getenv("HOME");
+		char *userdir_excludes_file = malloc(strlen(home) + strlen(value)-1 + 1);
+		strcpy(userdir_excludes_file, home);
+		strcat(userdir_excludes_file, value+1);
+		return userdir_excludes_file;
+	} else {
+		return xstrdup(value);
+	}
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
@@ -456,8 +468,12 @@ static int git_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.editor"))
 		return git_config_string(&editor_program, var, value);
 
-	if (!strcmp(var, "core.excludesfile"))
-		return git_config_string(&excludes_file, var, value);
+	if (!strcmp(var, "core.excludesfile")) {
+		if (!value)
+			return config_error_nonbool(var);
+		excludes_file = git_config_subst_userdir(value);
+		return 0;
+	}
 
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
-- 
1.5.6.2
