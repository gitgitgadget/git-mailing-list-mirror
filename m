From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] git init: optionally allow a directory argument
Date: Sat, 25 Jul 2009 06:59:28 +0900
Message-ID: <20090725065928.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 23:59:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUSnj-0000wc-Dv
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 23:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbZGXV7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 17:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754770AbZGXV7a
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 17:59:30 -0400
Received: from karen.lavabit.com ([72.249.41.33]:58445 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763AbZGXV73 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 17:59:29 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 2259F11B7ED
	for <git@vger.kernel.org>; Fri, 24 Jul 2009 16:59:30 -0500 (CDT)
Received: from 8926.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id UU28O4IZR0WP
	for <git@vger.kernel.org>; Fri, 24 Jul 2009 16:59:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=cXjoMXxkuAkaHMcolnstS4SiNPyto4tsbpMNW44dL5NTDg0+xRbMairaWUZxoeMyLZd0d57YC9zajcxF0c+lFjxYch0omsIoZQrHU9LlR2/s2ix3R9+QByk70aW1pdN3A9Ni8xeC8kOtsTrJlDnl7PlfB0u3ZGaZ3s/8/NMSwPo=;
  h=From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123953>

When starting a new repository, I see my students often say

    % git init newrepo

and curse git.  They could say

    % mkdir newrepo; cd newrepo; git init

but allowing it as an obvious short-cut may be nicer.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

 Please be gentle; I don't write C very well.

 Documentation/git-init.txt |    5 ++++-
 builtin-init-db.c          |   37 +++++++++++++++++++++++++++++--------
 t/t0001-init.sh            |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 7151d12..f081b24 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -8,7 +8,7 @@ git-init - Create an empty git repository or reinitialize an existing one
 
 SYNOPSIS
 --------
-'git init' [-q | --quiet] [--bare] [--template=<template_directory>] [--shared[=<permissions>]]
+'git init' [-q | --quiet] [--bare] [--template=<template_directory>] [--shared[=<permissions>]] [directory]
 
 
 OPTIONS
@@ -74,6 +74,9 @@ By default, the configuration flag receive.denyNonFastForwards is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
 
+If you name a (possibly non-existent) directory at the end of the command
+line, the command is run inside the directory (possibly after creating it).
+
 --
 
 
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 4a56006..100db73 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -371,7 +371,7 @@ static int guess_repository_type(const char *git_dir)
 }
 
 static const char init_db_usage[] =
-"git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]]";
+"git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [directory]";
 
 /*
  * If you want to, you can share the DB area with any number of branches.
@@ -384,27 +384,48 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *git_dir;
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
+	int bare_given = 0;
 	int i;
 
 	for (i = 1; i < argc; i++, argv++) {
 		const char *arg = argv[1];
 		if (!prefixcmp(arg, "--template="))
 			template_dir = arg+11;
-		else if (!strcmp(arg, "--bare")) {
-			static char git_dir[PATH_MAX+1];
-			is_bare_repository_cfg = 1;
-			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
-						sizeof(git_dir)), 0);
-		} else if (!strcmp(arg, "--shared"))
+		else if (!strcmp(arg, "--bare"))
+			bare_given = is_bare_repository_cfg = 1;
+		else if (!strcmp(arg, "--shared"))
 			init_shared_repository = PERM_GROUP;
 		else if (!prefixcmp(arg, "--shared="))
 			init_shared_repository = git_config_perm("arg", arg+9);
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
 			flags |= INIT_DB_QUIET;
-		else
+		else if (arg[0] == '-')
 			usage(init_db_usage);
+		else
+			break;
 	}
 
+	if (i == argc - 1) {
+		int mkdir_tried = 0;
+	retry:
+		if (chdir(argv[1]) < 0) {
+			if (!mkdir_tried) {
+				if (mkdir(argv[1], 0777) < 0)
+					die_errno("cannot mkdir %s", argv[1]);
+				mkdir_tried = 1;
+				goto retry;
+			}
+			die_errno("cannot chdir to %s", argv[1]);
+		}
+	} else if (i < argc - 1) {
+		usage(init_db_usage);
+	}
+	if (bare_given == 1) {
+		static char git_dir[PATH_MAX+1];
+
+		setenv(GIT_DIR_ENVIRONMENT,
+			getcwd(git_dir, sizeof(git_dir)), 0);
+	}
 	if (init_shared_repository != -1)
 		shared_repository = init_shared_repository;
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e3d8464..0ded031 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -208,4 +208,38 @@ test_expect_success 'init rejects insanely long --template' '
 	)
 '
 
+test_expect_success 'init creates a new directory' '
+	rm -fr newdir &&
+	(
+		git init newdir &&
+		test -d newdir/.git/refs
+	)
+'
+
+test_expect_success 'init creates a new bare directory' '
+	rm -fr newdir &&
+	(
+		git init --bare newdir &&
+		test -d newdir/refs
+	)
+'
+
+test_expect_success 'init recreates a directory' '
+	rm -fr newdir &&
+	(
+		mkdir newdir &&
+		git init newdir &&
+		test -d newdir/.git/refs
+	)
+'
+
+test_expect_success 'init recreates a new bare directory' '
+	rm -fr newdir &&
+	(
+		mkdir newdir &&
+		git init --bare newdir &&
+		test -d newdir/refs
+	)
+'
+
 test_done

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
