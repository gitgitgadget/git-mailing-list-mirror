From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 13:31:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 13:31:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoIju-0000fb-Hd
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 13:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWFHLbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 07:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWFHLbr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 07:31:47 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15548 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932264AbWFHLbr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 07:31:47 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 259BBD4B;
	Thu,  8 Jun 2006 13:31:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 1A1DDD0D;
	Thu,  8 Jun 2006 13:31:46 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id F13E2CB7;
	Thu,  8 Jun 2006 13:31:45 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Since there is a global config now, we need a way to access it
conveniently. Now you can say

	git repo-config --no-local alias.l "log --stat -M ORIG_HEAD.."

to set the alias globally (it will be stored in ~/.gitconfig).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 cache.h       |    1 +
 config.c      |   23 ++++++++++++++++++-----
 repo-config.c |    5 ++++-
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index d5d7fe4..14fe5c8 100644
--- a/cache.h
+++ b/cache.h
@@ -348,6 +348,7 @@ extern void packed_object_info_detail(st
 /* Dumb servers support */
 extern int update_server_info(int);
 
+extern int git_ignore_local_config;
 typedef int (*config_fn_t)(const char *, const char *);
 extern int git_default_config(const char *, const char *);
 extern int git_config_from_file(config_fn_t fn, const char *);
diff --git a/config.c b/config.c
index 0987943..33f9109 100644
--- a/config.c
+++ b/config.c
@@ -10,6 +10,7 @@ #include <regex.h>
 
 #define MAXNAME (256)
 
+int git_ignore_local_config = 0;
 static FILE *config_file;
 static const char *config_file_name;
 static int config_linenr;
@@ -327,7 +328,8 @@ int git_config(config_fn_t fn)
 			ret = 0;
 	}
 
-	ret += git_config_from_file(fn, git_path("config"));
+	if (!git_ignore_local_config)
+		ret += git_config_from_file(fn, git_path("config"));
 	return ret;
 }
 
@@ -501,10 +503,20 @@ int git_config_set_multivar(const char* 
 	int i, dot;
 	int fd = -1, in_fd;
 	int ret;
-	char* config_filename = strdup(git_path("config"));
-	char* lock_file = strdup(git_path("config.lock"));
+	char *config_filename, *lock_file;
 	const char* last_dot = strrchr(key, '.');
 
+	if (git_ignore_local_config) {
+		const char *home = getenv("HOME");
+		if (!home)
+			die("No home?");
+		config_filename = strdup(mkpath("%s/.gitconfig", home));
+		lock_file = strdup(mkpath("%s/.gitconfig.lock", home));
+	} else {
+		config_filename = strdup(git_path("config"));
+		lock_file = strdup(git_path("config.lock"));
+	}
+
 	/*
 	 * Since "key" actually contains the section name and the real
 	 * key name separated by a dot, we have to know where the dot is.
@@ -611,8 +623,9 @@ int git_config_set_multivar(const char* 
 		 * As a side effect, we make sure to transform only a valid
 		 * existing config file.
 		 */
-		if (git_config(store_aux)) {
-			fprintf(stderr, "invalid config file\n");
+		if (git_config_from_file(store_aux, config_filename)) {
+			fprintf(stderr, "invalid config file: %s\n",
+					config_filename);
 			free(store.key);
 			if (store.value_regex != NULL) {
 				regfree(store.value_regex);
diff --git a/repo-config.c b/repo-config.c
index 59c2bfb..8c0bb20 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -97,7 +97,8 @@ static int get_value(const char* key_, c
 
 	if (do_all && global)
 		git_config_from_file(show_config, global);
-	git_config_from_file(show_config, git_path("config"));
+	if (!git_ignore_local_config)
+		git_config_from_file(show_config, git_path("config"));
 	if (!do_all && !seen)
 		git_config_from_file(show_config, global);
 
@@ -125,6 +126,8 @@ int main(int argc, const char **argv)
 			type = T_BOOL;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
 			return git_config(show_all_config);
+		else if (!strcmp(argv[1], "--no-local"))
+			git_ignore_local_config = 1;
 		else
 			break;
 		argc--;
-- 
1.4.0.rc1.g2f47-dirty
