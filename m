From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Read configuration also from ~/.gitconfig
Date: Thu, 8 Jun 2006 13:31:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606081330380.11910@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 13:31:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoIjN-0000bP-7F
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 13:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWFHLbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 07:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWFHLbO
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 07:31:14 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:63122 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932280AbWFHLbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 07:31:14 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id E47143A6C;
	Thu,  8 Jun 2006 13:31:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id D8B9D3A6B;
	Thu,  8 Jun 2006 13:31:12 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id C69861EC0;
	Thu,  8 Jun 2006 13:31:12 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21478>


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

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 config.c               |   13 ++++++++++++-
 repo-config.c          |    9 ++++++++-
 t/t1300-repo-config.sh |    3 ++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 2ae6153..0987943 100644
--- a/config.c
+++ b/config.c
@@ -317,7 +317,18 @@ int git_config_from_file(config_fn_t fn,
 
 int git_config(config_fn_t fn)
 {
-	return git_config_from_file(fn, git_path("config"));
+	int ret = 0;
+	const char *home = getenv("HOME");
+
+	if (home) {
+		ret = git_config_from_file(fn, mkpath("%s/.gitconfig", home));
+		/* ignore if global config does not exist */
+		if (ret < 0)
+			ret = 0;
+	}
+
+	ret += git_config_from_file(fn, git_path("config"));
+	return ret;
 }
 
 /*
diff --git a/repo-config.c b/repo-config.c
index 08fc4cc..59c2bfb 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -65,6 +65,8 @@ static int show_config(const char* key_,
 static int get_value(const char* key_, const char* regex_)
 {
 	char *tl;
+	const char *home = getenv("HOME");
+	const char *global =  (home ? mkpath("%s/.gitconfig", home) : NULL);
 
 	key = strdup(key_);
 	for (tl=key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
@@ -93,7 +95,12 @@ static int get_value(const char* key_, c
 		}
 	}
 
-	git_config(show_config);
+	if (do_all && global)
+		git_config_from_file(show_config, global);
+	git_config_from_file(show_config, git_path("config"));
+	if (!do_all && !seen)
+		git_config_from_file(show_config, global);
+
 	free(key);
 	if (regexp) {
 		regfree(regexp);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 8260d57..ce36c50 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -254,8 +254,9 @@ nextsection.nonewline=wow2 for me
 version.1.2.3eX.alpha=beta
 EOF
 
+# "HOME=." is there to avoid reading ~/.gitconfig
 test_expect_success 'working --list' \
-	'git-repo-config --list > output && cmp output expect'
+	'HOME=. git-repo-config --list > output && cmp output expect'
 
 cat > expect << EOF
 beta.noindent sillyValue
-- 
1.4.0.rc1.g2f47-dirty
