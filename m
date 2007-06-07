From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: [PATCH 1/2] Add an option to quiet git-init.
Date: Thu,  7 Jun 2007 07:50:29 -0500
Message-ID: <11812206303473-git-send-email-jeff@ocjtech.us>
Cc: Git Mailing List <git@vger.kernel.org>,
	"Jeffrey C. Ollie" <jeff@ocjtech.us>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 14:49:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwHQv-0007Gg-Ax
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 14:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbXFGMtb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 08:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756483AbXFGMtb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 08:49:31 -0400
Received: from homer.isunet.net ([63.175.164.9]:33094 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbXFGMt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 08:49:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id ADBA738835D;
	Thu,  7 Jun 2007 06:58:16 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 29456-03; Thu,  7 Jun 2007 06:58:15 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 96F5A388364;
	Thu,  7 Jun 2007 06:58:15 -0500 (CDT)
Received: from [161.210.6.122] (helo=lt21223.campus.dmacc.edu)
	by max1.ocjtech.us with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1HwHQj-0002CB-Ux; Thu, 07 Jun 2007 07:49:34 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by lt21223.campus.dmacc.edu with esmtp (Exim 4.63)
	(envelope-from <jeff@ocjtech.us>)
	id 1HwHRe-0001Og-PN; Thu, 07 Jun 2007 07:50:30 -0500
X-Mailer: git-send-email 1.5.2.GIT
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49366>

git-init lacks an option to suppress non-error and non-warning output -
this patch adds one.

Signed-off-by: Jeffrey C. Ollie <jeff@ocjtech.us>
---
 Documentation/git-init-db.txt |    2 +-
 Documentation/git-init.txt    |    6 +++++-
 builtin-init-db.c             |   14 +++++++++-----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 5412135..64e7fc1 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -8,7 +8,7 @@ git-init-db - Creates an empty git repository
 
 SYNOPSIS
 --------
-'git-init-db' [--template=<template_directory>] [--shared[=<permissions>]]
+'git-init-db' [-q | --quiet] [--template=<template_directory>] [--shared[=<permissions>]]
 
 
 DESCRIPTION
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 1b64d3a..b5d17ee 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -8,7 +8,7 @@ git-init - Create an empty git repository or reinitialize an existing one
 
 SYNOPSIS
 --------
-'git-init' [--template=<template_directory>] [--shared[=<permissions>]]
+'git-init' [-q | --quiet] [--template=<template_directory>] [--shared[=<permissions>]]
 
 
 OPTIONS
@@ -16,6 +16,10 @@ OPTIONS
 
 --
 
+-q, \--quiet::
+
+Only print error and warning messages, all other output will be suppressed.
+
 --template=<template_directory>::
 
 Provide the directory from which templates will be used.  The default template
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 4df9fd0..68b2a1e 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -265,7 +265,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 }
 
 static const char init_db_usage[] =
-"git-init [--template=<template-directory>] [--shared]";
+"git-init [-q | --quiet] [--template=<template-directory>] [--shared]";
 
 /*
  * If you want to, you can share the DB area with any number of branches.
@@ -280,6 +280,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *template_dir = NULL;
 	char *path;
 	int len, i, reinit;
+	int quiet = 0;
 
 	for (i = 1; i < argc; i++, argv++) {
 		const char *arg = argv[1];
@@ -289,6 +290,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			shared_repository = PERM_GROUP;
 		else if (!prefixcmp(arg, "--shared="))
 			shared_repository = git_config_perm("arg", arg+9);
+		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
+		        quiet = 1;
 		else
 			usage(init_db_usage);
 	}
@@ -335,10 +338,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
-	printf("%s%s Git repository in %s/\n",
-		reinit ? "Reinitialized existing" : "Initialized empty",
-		shared_repository ? " shared" : "",
-		git_dir);
+	if (!quiet)
+		printf("%s%s Git repository in %s/\n",
+		       reinit ? "Reinitialized existing" : "Initialized empty",
+		       shared_repository ? " shared" : "",
+		       git_dir);
 
 	return 0;
 }
-- 
1.5.2.GIT
