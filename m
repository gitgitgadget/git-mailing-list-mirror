From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH RFC 7/8] config: add git_config_norepo
Date: Mon, 20 Jul 2009 19:49:54 +0200
Message-ID: <1248112195-3761-8-git-send-email-bonzini@gnu.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:51:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSx0z-0005yL-IJ
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 19:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbZGTRuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 13:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbZGTRuV
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 13:50:21 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56557 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbZGTRuS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 13:50:18 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSx0D-00033s-QU
	for git@vger.kernel.org; Mon, 20 Jul 2009 13:50:18 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123627>

This function will be needed to read the configuration in git-clone
before the new repository is created.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 cache.h  |    1 +
 config.c |   37 ++++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index a46bfe6..c349cd1 100644
--- a/cache.h
+++ b/cache.h
@@ -893,6 +893,7 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_tracking_config(const char *, const char *, struct tracking_config *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config_norepo(config_fn_t fn, void *);
 extern int git_config(config_fn_t fn, void *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
diff --git a/config.c b/config.c
index 37d95a4..d50a261 100644
--- a/config.c
+++ b/config.c
@@ -709,19 +709,14 @@ int git_config_global(void)
 	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
 }
 
-int git_config(config_fn_t fn, void *data)
+static int git_config_extra_repo(config_fn_t fn, void *data, int *found)
 {
-	int ret = 0, found = 0;
-	char *repo_config = NULL;
+	int ret = 0;
 	const char *home = NULL;
-
-	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
-	if (config_exclusive_filename)
-		return git_config_from_file(fn, config_exclusive_filename, data);
 	if (git_config_system() && !access(git_etc_gitconfig(), R_OK)) {
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
-		found += 1;
+		*found += 1;
 	}
 
 	home = getenv("HOME");
@@ -729,11 +724,35 @@ int git_config(config_fn_t fn, void *data)
 		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
 		if (!access(user_config, R_OK)) {
 			ret += git_config_from_file(fn, user_config, data);
-			found += 1;
+			*found += 1;
 		}
 		free(user_config);
 	}
+	return ret;
+}
+
+int git_config_norepo(config_fn_t fn, void *data)
+{
+	int ret, found = 0;
+
+	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
+	if (config_exclusive_filename)
+		return git_config_from_file(fn, config_exclusive_filename, data);
+	ret = git_config_extra_repo (fn, data, &found);
+	if (found == 0)
+		return -1;
+	return ret;
+}
 
+int git_config(config_fn_t fn, void *data)
+{
+	int ret, found = 0;
+	char *repo_config;
+
+	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
+	if (config_exclusive_filename)
+		return git_config_from_file(fn, config_exclusive_filename, data);
+	ret = git_config_extra_repo (fn, data, &found);
 	repo_config = git_pathdup("config");
 	if (!access(repo_config, R_OK)) {
 		ret += git_config_from_file(fn, repo_config, data);
-- 
1.6.2.5
