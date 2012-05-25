From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>
Subject: [PATCH 1/2] Add possibility to store configuration in ~/.config/git/config file
Date: Fri, 25 May 2012 21:47:18 +0200
Message-ID: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 22:09:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY0pW-0002Qm-N1
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 22:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758455Ab2EYUJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 16:09:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55671 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756085Ab2EYUJl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 16:09:41 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4PJdJIL009657
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2012 21:39:19 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4PJlMAu013898;
	Fri, 25 May 2012 21:47:22 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4PJlMZW011317;
	Fri, 25 May 2012 21:47:22 +0200
Received: (from nguyenhu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4PJlMnA011309;
	Fri, 25 May 2012 21:47:22 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 May 2012 21:39:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4PJdJIL009657
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: huynh-khoi-nguyen.nguyen@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1338579562.49675@ntU/9PXck11CVr1lyTpoFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198519>

git will store its configuration in ~/.config/git/config file if this file
exists and ~/.gitconfig file doesn't, otherwise git store its configuration
in ~/.gitconfig as usual
---
 builtin/config.c |   31 ++++++++++++++++++++++++++++---
 config.c         |   15 ++++++++++++++-
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 33c8820..dc890d5 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -171,8 +171,20 @@ static int get_value(const char *key_, const char *regex_)
 	if (!local) {
 		const char *home = getenv("HOME");
 		local = repo_config = git_pathdup("config");
-		if (home)
-			global = xstrdup(mkpath("%s/.gitconfig", home));
+		if (home) {
+			char gitconfig_path[PATH_MAX], config_path[PATH_MAX];
+			FILE *gitconfig_file, *config_file;
+
+			sprintf(gitconfig_path, "%s/.gitconfig", home);
+			sprintf(config_path, "%s/.config/git/config", home);
+			gitconfig_file = fopen(gitconfig_path, "r");
+			config_file = fopen(config_path, "r");
+
+			if (gitconfig_file==NULL && config_file!=NULL)
+				global = xstrdup(mkpath("%s/.config/git/config", home));
+			else
+				global = xstrdup(mkpath("%s/.gitconfig", home));
+		}
 		if (git_config_system())
 			system_wide = git_etc_gitconfig();
 	}
@@ -381,7 +393,20 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	if (use_global_config) {
 		char *home = getenv("HOME");
 		if (home) {
-			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
+			char gitconfig_path[PATH_MAX], config_path[PATH_MAX];
+			FILE *gitconfig_file, *config_file;
+			char *user_config;
+
+			sprintf(gitconfig_path, "%s/.gitconfig", home);
+			sprintf(config_path, "%s/.config/git/config", home);
+			gitconfig_file = fopen(gitconfig_path, "r");
+			config_file = fopen(config_path, "r");
+
+			if (gitconfig_file==NULL && config_file!=NULL)
+				user_config = xstrdup(mkpath("%s/.config/git/config", home));
+			else
+				user_config = xstrdup(mkpath("%s/.gitconfig", home));
+
 			given_config_file = user_config;
 		} else {
 			die("$HOME not set");
diff --git a/config.c b/config.c
index eeee986..998dbbc 100644
--- a/config.c
+++ b/config.c
@@ -962,7 +962,20 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	home = getenv("HOME");
 	if (home) {
 		char buf[PATH_MAX];
-		char *user_config = mksnpath(buf, sizeof(buf), "%s/.gitconfig", home);
+		char gitconfig_path[PATH_MAX], config_path[PATH_MAX];
+		FILE *gitconfig_file, *config_file;
+		char *user_config;
+
+		sprintf(gitconfig_path, "%s/.gitconfig", home);
+		sprintf(config_path, "%s/.config/git/config", home);
+		gitconfig_file = fopen(gitconfig_path, "r");
+		config_file = fopen(config_path, "r");
+
+		if (gitconfig_file==NULL && config_file!=NULL)
+			user_config = mksnpath(buf, sizeof(buf), "%s/.config/git/config", home);
+		else
+			user_config = mksnpath(buf, sizeof(buf), "%s/.gitconfig", home);
+
 		if (!access(user_config, R_OK)) {
 			ret += git_config_from_file(fn, user_config, data);
 			found += 1;
-- 
1.7.0.4
