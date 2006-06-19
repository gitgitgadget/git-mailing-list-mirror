From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Read configuration also from $HOME/.gitconfig
Date: Tue, 20 Jun 2006 01:48:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606200146490.26329@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jun 20 01:48:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsTTV-00061m-JY
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 01:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWFSXsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 19:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWFSXsG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 19:48:06 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:26846 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932537AbWFSXsF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 19:48:05 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id EF57E216B;
	Tue, 20 Jun 2006 01:48:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id E314A216E;
	Tue, 20 Jun 2006 01:48:03 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id BF0EA208F;
	Tue, 20 Jun 2006 01:48:03 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkiot@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22146>


This patch is based on Pasky's, with three notable differences:

- I did not yet update the documentation
- I named it .gitconfig, not .gitrc
- git-repo-config does not barf when a unique key is overridden locally

The last means that if you have something like

	[alias]
		l = log --stat -M

in ~/.gitconfig, and

	[alias]
		l = log --stat -M next..

in $GIT_DIR/config, then

	git-repo-config alias.l

returns only one value, namely the value from $GIT_DIR/config.

If you set the environment variable GIT_CONFIG, $HOME/.gitconfig is not
read, and neither $GIT_DIR/config, but $GIT_CONFIG instead.

If you set GIT_CONFIG_LOCAL instead, it is interpreted instead of
$GIT_DIR/config, but $HOME/.gitconfig is still read.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 config.c      |   34 +++++++++++++++++++++++++---------
 repo-config.c |   39 +++++++++++++++++++++++++++++++++------
 2 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/config.c b/config.c
index 69aa05f..edbe5ed 100644
--- a/config.c
+++ b/config.c
@@ -317,17 +317,33 @@ int git_config_from_file(config_fn_t fn,
 
 int git_config(config_fn_t fn)
 {
-	const char *filename = git_path("config");
-	/* Forward-compatibility cue: $GIT_CONFIG makes git read _only_
-	 * the given config file, $GIT_CONFIG_LOCAL will make it process
-	 * it in addition to the global config file, the same way it would
-	 * the per-repository config file otherwise. */
-	if (getenv("GIT_CONFIG")) {
-		filename = getenv("GIT_CONFIG");
-	} else if (getenv("GIT_CONFIG_LOCAL")) {
+	int ret = 0;
+	char *repo_config = NULL;
+	const char *home = NULL, *filename;
+
+	/* $GIT_CONFIG makes git read _only_ the given config file,
+	 * $GIT_CONFIG_LOCAL will make it process it in addition to the
+	 * global config file, the same way it would the per-repository
+	 * config file otherwise. */
+	filename = getenv("GIT_CONFIG");
+	if (!filename) {
+		home = getenv("HOME");
 		filename = getenv("GIT_CONFIG_LOCAL");
+		if (!filename)
+			filename = repo_config = strdup(git_path("config"));
 	}
-	return git_config_from_file(fn, filename);
+
+	if (home) {
+		const char *user_config = strdup(mkpath("%s/.gitconfig", home));
+		if (access(user_config, R_OK) > 0)
+			ret = git_config_from_file(fn, user_config);
+		free(user_config);
+	}
+
+	ret += git_config_from_file(fn, filename);
+	if (repo_config)
+		free(repo_config);
+	return ret;
 }
 
 /*
diff --git a/repo-config.c b/repo-config.c
index 08fc4cc..03f108f 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -64,7 +64,22 @@ static int show_config(const char* key_,
 
 static int get_value(const char* key_, const char* regex_)
 {
+	int ret = -1;
 	char *tl;
+	char *global = NULL, *repo_config = NULL;
+	const char *local;
+
+	local = getenv("GIT_CONFIG");
+	if (!local) {
+		const char *home = getenv("HOME");
+		local = getenv("GIT_CONFIG_LOCAL");
+		if (!local)
+			local = repo_config;
+		else
+			local = repo_config = strdup(git_path("config"));
+		if (home)
+			global = strdup(mkpath("%s/.gitconfig", home));
+	}
 
 	key = strdup(key_);
 	for (tl=key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
@@ -76,7 +91,7 @@ static int get_value(const char* key_, c
 		key_regexp = (regex_t*)malloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid key pattern: %s\n", key_);
-			return -1;
+			goto free_strings;
 		}
 	}
 
@@ -89,11 +104,16 @@ static int get_value(const char* key_, c
 		regexp = (regex_t*)malloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid pattern: %s\n", regex_);
-			return -1;
+			goto free_strings;
 		}
 	}
 
-	git_config(show_config);
+	if (do_all && global)
+		git_config_from_file(show_config, global);
+	git_config_from_file(show_config, local);
+	if (!do_all && !seen && global)
+		git_config_from_file(show_config, global);
+
 	free(key);
 	if (regexp) {
 		regfree(regexp);
@@ -101,9 +121,16 @@ static int get_value(const char* key_, c
 	}
 
 	if (do_all)
-		return !seen;
-
-	return (seen == 1) ? 0 : 1;
+		ret = !seen;
+	else
+		ret =  (seen == 1) ? 0 : 1;
+
+free_strings:
+	if (repo_config)
+		free(repo_config);
+	if (global)
+		free(global);
+	return ret;
 }
 
 int main(int argc, const char **argv)
-- 
1.4.0.g6685
