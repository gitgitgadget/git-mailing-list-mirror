From: Sascha Cunz <Sascha-ML@babbelbox.org>
Subject: [RFC/PATCH] Use work tree to determine if it supports symlinks
Date: Fri, 27 Jul 2012 23:39:41 +0200
Message-ID: <17699041.7b2cBoDgE0@mephista>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 23:39:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SusGM-0008VX-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 23:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab2G0Vjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 17:39:54 -0400
Received: from babbelbox.org ([83.133.105.186]:57521 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab2G0Vjx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 17:39:53 -0400
Received: (qmail 6446 invoked from network); 27 Jul 2012 21:40:05 -0000
Received: from unknown (HELO mephista.localnet) (Sascha@Babbelbox.org@89.204.130.192)
  by babbelbox.org with ESMTPA; 27 Jul 2012 21:40:05 -0000
User-Agent: KMail/4.8.4 (Linux/3.4.4-gentoo; KDE/4.8.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202379>

>From 3f449e719b924929f1f8ca9b5eff83f17bc64c60 Mon Sep 17 00:00:00 2001
From: Sascha Cunz <Sascha@BabbelBox.org>
Date: Fri, 27 Jul 2012 22:54:56 +0200
Subject: [PATCH] Use work tree to determine if it supports symlinks

When creating a new repository, we check some capabilities of the
underlying file system(s). We check the file system for its case
sensitivity and the ability to create symbolic links.

Before this patch the .git-dir was used for this check, while the
comments in code clearly state to test on the work tree.

This patch teaches the tests for symbolic links and utf8 precomposion
to use the work tree instead of the .git directory.

Signed-off-by: Sascha Cunz <Sascha@BabbelBox.org>
---
 builtin/init-db.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

In recent discussion[1] on libgit2, we found this little inconsistency
and it's not exactly clear, whether the git implementation or documentation
should be followed.

I left out to change the case-insensitive check. If you think, this patch
is useful at all (I actually have a hard time to find a real world use
case), i would reroll it with that change included. I think in this case,
the probe_utf8_pathname_composition might be refactored: We don't have a
file in the work tree yet => we must create one, test its accessibility
with a different name and finally unlink it. That's more or less what
probe_utf8_pathname_composition does.

SaCu

[1] https://github.com/libgit2/libgit2/pull/844#issuecomment-7311677

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 244fb7f..2f988ad 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -273,6 +273,23 @@ static int create_default_files(const char *template_path)
 	}
 
 	if (!reinit) {
+		const char *work_tree = get_git_work_tree();
+
+		/* Check if the filesystem is case-insensitive */
+		path[len] = 0;
+		strcpy(path + len, "CoNfIg");
+		if (!access(path, F_OK))
+			git_config_set("core.ignorecase", "true");
+
+		/* Point 'path' to the work tree */
+		len = strlen(work_tree);
+		if (len > sizeof(path)-8)
+			die(_("insane working directory %s"), work_tree);
+
+		memcpy(path, work_tree, len);
+		if (len && path[len-1] != '/')
+			path[len++] = '/';
+
 		/* Check if symlink is supported in the work tree */
 		path[len] = 0;
 		strcpy(path + len, "tXXXXXX");
@@ -285,11 +302,6 @@ static int create_default_files(const char *template_path)
 		else
 			git_config_set("core.symlinks", "false");
 
-		/* Check if the filesystem is case-insensitive */
-		path[len] = 0;
-		strcpy(path + len, "CoNfIg");
-		if (!access(path, F_OK))
-			git_config_set("core.ignorecase", "true");
 		probe_utf8_pathname_composition(path, len);
 	}
 
-- 
1.7.12.rc0.23.g3f449e7
