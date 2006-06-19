From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix setting config variables with an alternative GIT_CONFIG
Date: Tue, 20 Jun 2006 00:51:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606200050150.26329@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jun 20 00:52:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsSbD-0005P5-GI
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 00:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWFSWwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 18:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWFSWwA
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 18:52:00 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6324 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964964AbWFSWwA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 18:52:00 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id BB35B2060;
	Tue, 20 Jun 2006 00:51:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id AFBD0205E;
	Tue, 20 Jun 2006 00:51:58 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 9B6F81D7D;
	Tue, 20 Jun 2006 00:51:58 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22142>


When setting a config variable, git_config_set() ignored the variables
GIT_CONFIG and GIT_CONFIG_LOCAL. Now, when GIT_CONFIG_LOCAL is set, it
will write to that file. If not, GIT_CONFIG is checked, and only as a
fallback, the change is written to $GIT_DIR/config.

Add a test for it, and also future-proof the test for the upcoming
$HOME/.gitconfig support.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 config.c               |   15 ++++++++++++---
 t/Makefile             |    2 +-
 t/t1300-repo-config.sh |   24 ++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index d46eb6d..69aa05f 100644
--- a/config.c
+++ b/config.c
@@ -500,10 +500,19 @@ int git_config_set_multivar(const char* 
 	int i, dot;
 	int fd = -1, in_fd;
 	int ret;
-	char* config_filename = strdup(git_path("config"));
-	char* lock_file = strdup(git_path("config.lock"));
+	char* config_filename;
+	char* lock_file;
 	const char* last_dot = strrchr(key, '.');
 
+	config_filename = getenv("GIT_CONFIG_LOCAL");
+	if (!config_filename) {
+		config_filename = getenv("GIT_CONFIG");
+		if (!config_filename)
+			config_filename  = git_path("config");
+	}
+	config_filename = strdup(config_filename);
+	lock_file = strdup(mkpath("%s.lock", config_filename));
+
 	/*
 	 * Since "key" actually contains the section name and the real
 	 * key name separated by a dot, we have to know where the dot is.
@@ -610,7 +619,7 @@ int git_config_set_multivar(const char* 
 		 * As a side effect, we make sure to transform only a valid
 		 * existing config file.
 		 */
-		if (git_config(store_aux)) {
+		if (git_config_from_file(store_aux, config_filename)) {
 			fprintf(stderr, "invalid config file\n");
 			free(store.key);
 			if (store.value_regex != NULL) {
diff --git a/t/Makefile b/t/Makefile
index 5495985..632c55f 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -19,7 +19,7 @@ endif
 all: $(T) clean
 
 $(T):
-	@echo "*** $@ ***"; '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
 clean:
 	rm -fr trash
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 8260d57..0de2497 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -309,5 +309,29 @@ EOF
 
 test_expect_success 'new variable inserts into proper section' 'cmp .git/config expect'
 
+cat > other-config << EOF
+[ein]
+	bahn = strasse
+EOF
+
+cat > expect << EOF
+ein.bahn=strasse
+EOF
+
+GIT_CONFIG=other-config git-repo-config -l > output
+
+test_expect_success 'alternative GIT_CONFIG' 'cmp output expect'
+
+GIT_CONFIG=other-config git-repo-config anwohner.park ausweis
+
+cat > expect << EOF
+[ein]
+	bahn = strasse
+[anwohner]
+	park = ausweis
+EOF
+
+test_expect_success '--set in alternative GIT_CONFIG' 'cmp other-config expect'
+
 test_done
 
-- 
1.4.0.g275f-dirty
