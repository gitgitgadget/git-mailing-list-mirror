From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git /objects directory created 755 by default?
Date: Wed, 21 Dec 2005 16:35:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 16:40:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep60d-0003ON-Q3
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 16:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVLUPfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 10:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVLUPfX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 10:35:23 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:63958 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932419AbVLUPfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 10:35:22 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DC7D013FCE5; Wed, 21 Dec 2005 16:35:18 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BF67B9E268; Wed, 21 Dec 2005 16:35:18 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AA2CF9E21B; Wed, 21 Dec 2005 16:35:18 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 61FC013FCDF; Wed, 21 Dec 2005 16:35:18 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13876>

Hi,

On Tue, 20 Dec 2005, Junio C Hamano wrote:

> 	[shell]
>         	umask = 0002

If you don't use git-shell, because the same machine is used for other 
purposes, it makes sense to introduce

	[core]
		umask = 0002

How about this:

---
[PATCH] Introduce core.umask

This makes it possible to setup a shared git repository by setting

	[core]
		umask = 0002

int the template config file.

This patch makes sure even git-init-db uses it.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 init-db.c |   21 ++++++++++++++-------
 setup.c   |    4 ++++
 2 files changed, 18 insertions(+), 7 deletions(-)

faa7d4b101211ac1993d73bb3d02e8a6d2c40734
diff --git a/init-db.c b/init-db.c
index 41576bd..26812ce 100644
--- a/init-db.c
+++ b/init-db.c
@@ -164,6 +164,7 @@ static void create_default_files(const c
 	unsigned char sha1[20];
 	struct stat st1;
 	char repo_version_string[10];
+	mode_t mask, mask2;
 
 	if (len > sizeof(path)-50)
 		die("insane git directory %s", git_dir);
@@ -172,6 +173,19 @@ static void create_default_files(const c
 	if (len && path[len-1] != '/')
 		path[len++] = '/';
 
+	/* First copy the templates -- we might have the default
+	 * config file there, in which case we would want to read
+	 * from it after installing.
+	 * The config file may contain a umask...
+	 */
+	path[len] = 0;
+	umask(mask = umask(0));
+	copy_templates(path, len, template_path);
+	if (mask != (mask2 = umask(mask))) {
+		umask(mask2);
+		chmod(path, 0777 & ~mask2);
+	}
+
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
@@ -182,13 +196,6 @@ static void create_default_files(const c
 	strcpy(path + len, "refs/tags");
 	safe_create_dir(path);
 
-	/* First copy the templates -- we might have the default
-	 * config file there, in which case we would want to read
-	 * from it after installing.
-	 */
-	path[len] = 0;
-	copy_templates(path, len, template_path);
-
 	git_config(git_default_config);
 
 	/*
diff --git a/setup.c b/setup.c
index d3556ed..4e4cb46 100644
--- a/setup.c
+++ b/setup.c
@@ -180,6 +180,10 @@ int check_repository_format_version(cons
 {
        if (strcmp(var, "core.repositoryformatversion") == 0)
                repository_format_version = git_config_int(var, value);
+
+       else if (!strcmp(var, "core.umask"))
+	       umask(git_config_int(var, value));
+
        return 0;
 }
 
-- 
1.0.0
