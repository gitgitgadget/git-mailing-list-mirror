From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] allow suppressing of global and system config
Date: Wed, 6 Feb 2008 05:11:18 -0500
Message-ID: <20080206101118.GA1123@coredump.intra.peff.net>
References: <20080206092753.GA32264@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:11:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMhFy-0007rP-HO
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760978AbYBFKLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 05:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760675AbYBFKLW
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 05:11:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2724 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760915AbYBFKLV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 05:11:21 -0500
Received: (qmail 27745 invoked by uid 111); 6 Feb 2008 10:11:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 06 Feb 2008 05:11:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2008 05:11:18 -0500
Content-Disposition: inline
In-Reply-To: <20080206092753.GA32264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72788>

The GIT_CONFIG_NOGLOBAL and GIT_CONFIG_NOSYSTEM environment
variables are magic undocumented switches that can be used
to ensure a totally clean environment. This is necessary for
running reliable tests, since those config files may contain
settings that change the outcome of tests.

Signed-off-by: Jeff King <peff@peff.net>
---
You can see that the config file lookup is more or less duplicated in
config.c and in builtin-config.c. I tried to keep the patch minimal, but
it's possible that those can be refactored into a single lookup point.

 builtin-config.c |    5 +++--
 cache.h          |    3 +++
 config.c         |   20 ++++++++++++++++++--
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index e4a12e3..404bb44 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -79,9 +79,10 @@ static int get_value(const char* key_, const char* regex_)
 		local = getenv(CONFIG_LOCAL_ENVIRONMENT);
 		if (!local)
 			local = repo_config = xstrdup(git_path("config"));
-		if (home)
+		if (git_config_global() && home)
 			global = xstrdup(mkpath("%s/.gitconfig", home));
-		system_wide = git_etc_gitconfig();
+		if (git_config_system())
+			system_wide = git_etc_gitconfig();
 	}
 
 	key = xstrdup(key_);
diff --git a/cache.h b/cache.h
index 549f4bb..af74e20 100644
--- a/cache.h
+++ b/cache.h
@@ -589,6 +589,9 @@ extern int git_config_set_multivar(const char *, const char *, const char *, int
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value);
+extern int git_env_bool(const char *, int);
+extern int git_config_system(void);
+extern int git_config_global(void);
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/config.c b/config.c
index 498259e..2f85e9d 100644
--- a/config.c
+++ b/config.c
@@ -492,6 +492,22 @@ const char *git_etc_gitconfig(void)
 	return system_wide;
 }
 
+int git_env_bool(const char *k, int def)
+{
+	const char *v = getenv(k);
+	return v ? git_config_bool(k, v) : def;
+}
+
+int git_config_system(void)
+{
+	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
+}
+
+int git_config_global(void)
+{
+	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
+}
+
 int git_config(config_fn_t fn)
 {
 	int ret = 0;
@@ -504,7 +520,7 @@ int git_config(config_fn_t fn)
 	 * config file otherwise. */
 	filename = getenv(CONFIG_ENVIRONMENT);
 	if (!filename) {
-		if (!access(git_etc_gitconfig(), R_OK))
+		if (git_config_system() && !access(git_etc_gitconfig(), R_OK))
 			ret += git_config_from_file(fn, git_etc_gitconfig());
 		home = getenv("HOME");
 		filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
@@ -512,7 +528,7 @@ int git_config(config_fn_t fn)
 			filename = repo_config = xstrdup(git_path("config"));
 	}
 
-	if (home) {
+	if (git_config_global() && home) {
 		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
 		if (!access(user_config, R_OK))
 			ret = git_config_from_file(fn, user_config);
-- 
1.5.4.25.g251c56-dirty
