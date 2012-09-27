From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] config: introduce GIT_GLOBAL_CONFIG to override ~/.gitconfig
Date: Thu, 27 Sep 2012 20:16:11 +0530
Message-ID: <1348757171-3223-1-git-send-email-artagnon@gmail.com>
References: <CALkWK0nYnyaoOsH_x8U96ADZT7VuP-pR36+RRcjTw39Kp1qCnw@mail.gmail.com>
Cc: David Aguilar <davvid@gmail.com>,
	Anurag Priyam <anurag08priyam@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 16:46:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THFMF-0005D1-63
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 16:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab2I0OqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 10:46:21 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59894 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab2I0OqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 10:46:20 -0400
Received: by padhz1 with SMTP id hz1so1404759pad.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bYzgRcDlKuXYEgykz9OOMMxH9O64m4yQMjUa14CTjjk=;
        b=wHiSKjP9/eMWnI9jWssOlmlJ8w0b5b+QRaPVhQtjdA7nJnkP09kFSkAHRI81K2rQoz
         VxDn3yg5ZDzTL3BW07ZT8HxtZOnRyrhyZGLscR21kC9Xm8i/ZvMkeFurZe3yLwqC4Adx
         Gs5sL/HhuNcL57x5no6ZsE29Zn5nhricCbg8vwzDOoh44aUgWAlMK0dopia4AvOz+n2x
         EhdNL3PfHCt6UYX6IG+wNsDBnD2kRARgwyH8FRZlQSjAwQze14sKzZf3eVzamFgK2bvU
         AWRKuTt4RLz9jok4d0Q5sdzDgeCJ5EPYdo5oEbrS/ajaMR85zpQWG62sE9EbhJxXjpQy
         ztxg==
Received: by 10.68.136.138 with SMTP id qa10mr12153092pbb.142.1348757180307;
        Thu, 27 Sep 2012 07:46:20 -0700 (PDT)
Received: from fran.broadband.vsnl.com ([59.164.64.166])
        by mx.google.com with ESMTPS id ky6sm3938270pbc.18.2012.09.27.07.46.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Sep 2012 07:46:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <CALkWK0nYnyaoOsH_x8U96ADZT7VuP-pR36+RRcjTw39Kp1qCnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206483>


Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-config.txt |    3 +++
 path.c                       |    5 +++++
 t/t1306-xdg-files.sh         |    8 ++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index eaea079..c8db03f 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -205,6 +205,9 @@ $GIT_DIR/config::
 	User-specific configuration file. Also called "global"
 	configuration file.
 
+$GIT_GLOBAL_CONFIG::
+	Overrides the path of the global configuration file.
+
 $XDG_CONFIG_HOME/git/config::
 	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
 	or empty, $HOME/.config/git/config will be used. Any single-valued
diff --git a/path.c b/path.c
index cbbdf7d..9b09cee 100644
--- a/path.c
+++ b/path.c
@@ -131,10 +131,15 @@ char *git_path(const char *fmt, ...)
 
 void home_config_paths(char **global, char **xdg, char *file)
 {
+	char *global_config = getenv("GIT_GLOBAL_CONFIG");
 	char *xdg_home = getenv("XDG_CONFIG_HOME");
 	char *home = getenv("HOME");
 	char *to_free = NULL;
 
+	if (global_config) {
+		*global = mkpathdup("%s", global_config);
+		return;
+	}
 	if (!home) {
 		if (global)
 			*global = NULL;
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 8b14ab1..5b0e08e 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -28,6 +28,14 @@ test_expect_success 'read config: xdg file exists and ~/.gitconfig exists' '
 	test_cmp expected actual
 '
 
+test_expect_success 'read config: $GIT_GLOBAL_CONFIG is set and ~/.gitconfig exists' '
+	>.gitconfig &&
+	echo "[alias]" >.gittestconfig &&
+	echo "	myalias = !echo in_gitconfig" >>.gittestconfig &&
+	echo in_gitconfig >expected &&
+	GIT_GLOBAL_CONFIG=~/.gittestconfig git myalias >actual &&
+	test_cmp expected actual
+'
 
 test_expect_success 'read with --get: xdg file exists and ~/.gitconfig doesn'\''t' '
 	rm .gitconfig &&
-- 
1.7.8.1.362.g5d6df.dirty
